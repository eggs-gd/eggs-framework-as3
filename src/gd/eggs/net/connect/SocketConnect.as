package gd.eggs.net.connect
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.OutputProgressEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.Timer;

	/**
	 * ...
	 * @author Dukobpa3
	 */
	
	[Event(name = "connected", type="gd.eggs.net.connect.ConnectionEvent")]
	[Event(name = "closeConnection", type="gd.eggs.net.connect.ConnectionEvent")]
	[Event(name = "connectAttempt", type="gd.eggs.net.connect.ConnectionEvent")]
	[Event(name = "sendData", type="gd.eggs.net.connect.ConnectionEvent")]
	[Event(name = "receiveData", type="gd.eggs.net.connect.ConnectionEvent")]
	[Event(name = "connectError", type="gd.eggs.net.connect.ConnectionEvent")]
	
	[Event(name = "log", type = "flash.events.DataEvent")]
	
	public class SocketConnect extends EventDispatcher implements IServerConnect
	{
		public static const LOG:String = "log";
		
		private var _socket:Socket;
		
		/** текущий коннект */
		private var _config:ServerConnectConfig;
		
		/** данные готовые для использования */
		private var _data:Object;
		
		/** Таймер попыток соединения */
		private var _attemptsTimeout:Timer;
		
		/** Еще один таймер */
		private var _connectTimeout:Timer;
		
		private var _connected:Boolean;
		
		//=====================================================================
		//		CONSTRUCTOR, INIT
		//=====================================================================
		public function SocketConnect() 
		{
			
		}
		
		//=====================================================================
		//		PUBLIC
		//=====================================================================
		
		/* INTERFACE connect.IServerSend */
		
		public function init(config:ServerConnectConfig):void 
		{
			addLog("socketInit: ", data);
			_config = config;
			_connectTimeout = new Timer(_config.timeout);
			connectSocket();
		}
		
		/**
		 * Отправляет данные на сервер
		 * @param	data данные
		 */
		public function send(data:Object):void 
		{
			addLog("socketSend: ", data);
			
			try 
			{
				if (data is String)
				{
					_socket.writeUTFBytes(data as String);
					_socket.flush();
					dispatchEvent(new ConnectionEvent(ConnectionEvent.SEND_DATA, data));
				}
				if (data is ByteArray)
				{
					(data as ByteArray).position = 0;
					_socket.writeBytes(data as ByteArray);
					_socket.flush();
					dispatchEvent(new ConnectionEvent(ConnectionEvent.SEND_DATA, data));
				}
			} 
			catch (e:Error)
			{
				addLog("socket.write Error: ", e.message);
			}
			
			resetConnectionTimer();
		}
		
		//=====================================================================
		//		PRIVATE
		//=====================================================================
		/**
		 * Создание подключения по socket
		 */
		private function connectSocket():void 
		{
			addLog("connectSocket: ", _config.host, _config.port);
			
			_socket = new Socket();
			_socket.addEventListener(Event.CLOSE, onSocketClose);
			_socket.addEventListener(Event.CONNECT, onSocketConnect);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onSocketIOError);
			_socket.addEventListener(OutputProgressEvent.OUTPUT_PROGRESS, onSocketOutputData);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSocketSecurityError);
			
			/*
			close - Отправляется, когда сервер закрывает подключение к сокету.	Socket
			connect - Отправляется после установления сетевого подключения.	Socket
			ioError - Отправляется, когда происходит ошибка ввода-вывода, приводящая к сбою операции отправки или загрузки.	Socket
			outputProgress - Передается при перемещении данных сокетом из буфера записи на уровень сетевого транспорта	Socket
			securityError - Отправляется, если метод Socket.connect() предпринимает попытку подключиться к серверу, который запрещен изолированной средой безопасности вызывающего приложения, или к порту с номером меньше 1024, когда нет файла политики сокетов, разрешающего такое подключение.	Socket
			socketData - Отправляется, когда сокет получает данные.
			*/
			
			_socket.connect(_config.host, _config.port);
			
			_attemptsTimeout = new Timer(_config.timeout * 1000, 1);
			_attemptsTimeout.addEventListener(TimerEvent.TIMER_COMPLETE, onSocketConnectTimeout);
			_attemptsTimeout.start();
		}
		
		/**
		 * Перезапуск таймера подключения
		 */
		private function resetConnectionTimer():void
		{
			addLog("resetConnectionTimer, delay:", (_config.connectTime * 1000));
			
			_connectTimeout.reset();
			_connectTimeout.delay = _config.connectTime * 1000;
			_connectTimeout.repeatCount = 1;
			_connectTimeout.start();
		}
		
		private function addLog(...rest):void 
		{
			//string = "-- " + string;
			//rest.unshift(this);
			dispatchEvent(new ConnectionEvent(SocketConnect.LOG, rest, true, false));
		}
		//=====================================================================
		//		EVENTS
		//=====================================================================
		private function onSocketData(e:ProgressEvent):void 
		{
			addLog("onSocketData: ", e );
			
			var bytes:ByteArray = new ByteArray();
			bytes.endian = Endian.LITTLE_ENDIAN;
			_socket.readBytes(bytes);
			
			dispatchEvent(new ConnectionEvent(ConnectionEvent.RECEIVE_DATA, bytes));
			
		}
		
		private function onSocketOutputData(e:OutputProgressEvent):void 
		{
			addLog("onSocketOutputData: ", e);
		}
		
		private function onSocketClose(e:Event):void 
		{
			addLog("onSocketClose: ", e);
			dispatchEvent(new ConnectionEvent(ConnectionEvent.CLOSE));
		}
		
		private function onSocketConnect(e:Event):void 
		{
			addLog("onSocketConnect: ", e);
			_connected = true;
			dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTED));
			
			_attemptsTimeout.stop();
		}
		
		private function onSocketIOError(e:IOErrorEvent):void 
		{
			addLog("onSocketIOError: ", e);
		}
		
		private function onSocketSecurityError(e:SecurityErrorEvent):void 
		{
			addLog("onSocketSecurityError: ", e);
		}
		
		private function onSocketConnectTimeout(e:TimerEvent):void 
		{
			addLog("onSocketConnectTimeout: ", e);
			if (_socket && _connected && _socket.connected)
			{
				_socket.close();
				onSocketClose(null);
			}
		}
		
		//=====================================================================
		//		ACCESSORS
		//=====================================================================
		public function get data():Object { return _data; }
		
		public function get config():ServerConnectConfig { return _config; }
	}

}