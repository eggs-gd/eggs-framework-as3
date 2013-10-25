package gd.eggs.net
{
	import gd.eggs.mvc.controller.BaseController;
	import gd.eggs.net.connect.ConnectionEvent;
	import gd.eggs.net.connect.ServerConnectConfig;
	import gd.eggs.net.connect.SocketConnect;
	import gd.eggs.net.protocol.core.BaseProtoData;
	import gd.eggs.net.protocol.core.CommandDict;
	import gd.eggs.net.protocol.core.CommandDictItem;
	import gd.eggs.net.protocol.core.ErrorData;
	import gd.eggs.net.protocol.core.MessageBase;
	import gd.eggs.net.protocol.decoder.DecoderEvent;
	import gd.eggs.net.protocol.decoder.IMessageDecoder;
	import gd.eggs.net.protocol.decoder.ParseStatus;
	import gd.eggs.observer.Notification;


	/**
	 * ...
	 * @author Dukobpa3
	 */
		// TODO: Возможно�?ти контроллера не и�?пользуют�?�?, перепилить под нечто другое, придумать генер�?щий�?�? одминкой �?ендер
	public class ServerController extends BaseController
	{
		public static var SERVER_CONNECTED:String = "serverConnected";
		public static var SERVER_DISCONNECTED:String = "serverDisconnected";
		public static var SERVER_SEND_COMMAND:String = "serverSendCommand";

		/** Соб�?твенно коннектор
		 * TODO: перепилить под не�?колько коннекторов, ща�? похуй, рботаем тока �? �?окетом */
		private var _connection:SocketConnect;

		/**
		 * 1. При отправке пакует нечто адекватное в неведомую �?ерверную хуйню(ByteArray, String),
		 * 2. При получении ра�?паковывает неведомую �?ерверную хуйню в нечто адекватное
		 * контроллер не знает ни первый ни второй формат,
		 * Коннектор �?оответ�?твенно тоже
		 */
		private var _decoder:IMessageDecoder;

		/** Словарь �?ерверных команд */
		private var _commandDict:CommandDict;

		/** Очередь �?ообщений */
		private var _msgPool:Vector.<MessageBase>;

		public function ServerController(decoder:IMessageDecoder)
		{
			super();

			_connection = new SocketConnect();
			_msgPool = new Vector.<MessageBase>();

			_commandDict = CommandDict.getInstance();
			_decoder = decoder;
			_decoder.addEventListener(ParseStatus.INVALID_DATA_TYPE, onDecoderError);
			_decoder.addEventListener(ParseStatus.INVALID_PACKAGE_SIZE, onDecoderError);
			_decoder.addEventListener(ParseStatus.RECEIVING_HEADER, onDecoderProgress);
			_decoder.addEventListener(ParseStatus.IN_PROGRESS, onDecoderProgress);
			_decoder.addEventListener(ParseStatus.DONE, onDecoderData);

			_connection.addEventListener(ConnectionEvent.CONNECT_ATTEMPT, onConnectAttempt);
			_connection.addEventListener(ConnectionEvent.CONNECT_ERROR, onConnectError);
			_connection.addEventListener(ConnectionEvent.CONNECTED, onConnected);
			_connection.addEventListener(ConnectionEvent.SEND_DATA, onSendData);
			_connection.addEventListener(ConnectionEvent.RECEIVE_DATA, onReceiveData);
			_connection.addEventListener(ConnectionEvent.CLOSE, onClose);

			_connection.addEventListener(ConnectionEvent.LOG, onLog);
		}

		/**
		 * Подпи�?ка на нужные оповещени�?
		 * @return
		 */
		override public function listNotifications():Array
		{
			return [
				SERVER_SEND_COMMAND, ];
		}

		/**
		 * Обработка оповещени�? note
		 * @param    note
		 */
		override public function update(note:Notification):void
		{
			switch (note.name)
			{
				case SERVER_SEND_COMMAND:
					addMessage(note.body);
					break;
			}
		}

		//-----------------------------
		//	CONNECT
		//-----------------------------
		/**
		 * Инициализируем подключение, подпи�?ываем�?�? на �?обыти�? подключени�?
		 */
		public function connect(connectConfig:ServerConnectConfig):void
		{
			_connection.init(connectConfig);
		}

		//=====================================================================
		//		PRIVATE
		//=====================================================================
		private function addMessage(body:Object):void
		{
			var msg:MessageBase = new MessageBase(); // пу�?той ме�?адж

			var id:int = body["id"];
			var name:String = body["name"];
			var params:Object = body["params"];

			var cmdDictItem:CommandDictItem;
			if (id)
			{
				cmdDictItem = _commandDict.getItemById(id); // получили нужный тип из �?ловар�?
			}
			else if (name && name != "")
			{
				cmdDictItem = _commandDict.getItemByName(name); // получили нужный тип из �?ловар�?
			}
			else
			{
				cmdDictItem = _commandDict.getItemById(0);
			}

			var typedItem:BaseProtoData = new cmdDictItem.dataToServer(); // �?оздали пу�?той ин�?тан�? нужного типа

			msg.commandId = cmdDictItem.id;
			msg.data = typedItem.fromObject(params).writeBSON(); // заполнили реальными данными

			_msgPool.push(msg);

			if (_msgPool.length == 1) sendMessage();
		}

		private function sendMessage():void
		{
			var msg:MessageBase = _msgPool.shift();

			//Cc.logch("-- sending", "sendMessage", JSON.stringify(msg));

			_connection.send(_decoder.pack(msg));

			if (_msgPool.length)
			{
				//setTimeout(sendMessage, 100);
				sendMessage();
			}
		}

		private function processMsg(msg:MessageBase):void
		{
			var cmdDictItem:CommandDictItem = _commandDict.getItemById(msg.commandId); // получили нужный тип из �?ловар�?
			var typedItem:BaseProtoData = new cmdDictItem.dataToClient(); // �?оздали пу�?той ин�?тан�? нужного типа;

			if (!cmdDictItem) // дефолтный обработчик
			{
				cmdDictItem = _commandDict.getItemById(0);
			}

			if (msg.status)
			{
				typedItem.readBSON(msg.data); // заполнили реальными данными
				var dataStr:String = JSON.stringify(typedItem.toObject());
			}
			else
			{
				var errorObject:ErrorData = new ErrorData();
				errorObject.readBSON(msg.data);
			}
			cmdDictItem.callBack(msg.status, typedItem); // выполнили коллбек �? типизированными данными
		}

		//=====================================================================
		//		HANDLERS
		//=====================================================================
		private function onConnectAttempt(event:ConnectionEvent):void
		{

		}

		private function onConnectError(event:ConnectionEvent):void
		{

		}

		private function onConnected(event:ConnectionEvent):void
		{
			sendNotification(new Notification(SERVER_CONNECTED));
		}

		private function onSendData(event:ConnectionEvent):void
		{
			//Cc.logch("-- connector", "onSendData: " + JSON.stringify(e.data))
		}

		/**
		 * Обработка получени�? данных �? �?ервера.
		 * получем �?обытие. Внутри него е�?ть полученные данные.
		 * далее �?мотрим е�?ть ли ошибки. е�?ли е�?ть, то обрабатываем и ретурн.
		 * е�?ли нету ошибок �?мотрим команду. �?екоторые команды требуют отправки дополнительных нотификаций.
		 * �?о нотификации �?разу не отправл�?ем а добавл�?ем в ма�?�?ив.
		 * �?екоторые команды требуют уникального пар�?инга. В таком �?лучаем �?тавим ключ needUpdate = false, чтобы �?тандартный пар�?ер не запу�?кал�?�?
		 * Далее пар�?им �?тандартным пар�?ером.
		 * Потом когда ра�?пар�?или полученные данные - отправл�?ем нотификации из �?пи�?ка.
		 * @param    e
		 */
		private function onReceiveData(event:ConnectionEvent):void
		{
			//Cc.logch("-- connector", "onReceiveData: " + JSON.stringify(e.data));

			if (!_decoder) return;

			_decoder.parse(event.data);
		}

		private function onClose(event:ConnectionEvent):void
		{
			sendNotification(new Notification(SERVER_DISCONNECTED));
		}

		private function onLog(event:ConnectionEvent):void
		{
			//Cc.logch("-- connector", JSON.stringify(e.data));
		}

		private function onDecoderError(event:DecoderEvent):void
		{

		}

		private function onDecoderProgress(event:DecoderEvent):void
		{

		}

		private function onDecoderData(event:DecoderEvent):void
		{
			// removeEventListener(Event, onDecoderData);
			if (event.data) processMsg(event.data as MessageBase);
		}

		//=====================================================================
		//		ACCESSORS
		//=====================================================================
	}

}