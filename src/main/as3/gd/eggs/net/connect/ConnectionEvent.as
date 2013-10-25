package gd.eggs.net.connect
{
	import flash.events.Event;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class ConnectionEvent extends Event
	{

		/**
		 * Отправляется при успешном установлении соединения с сервером
		 */
		public static const LOG:String = "log";

		/**
		 * Отправляется при успешном установлении соединения с сервером
		 */
		public static const CONNECTED:String = "connected";

		/**
		 * Отправляется при ошибке установления соединения
		 */
		public static const CONNECT_ERROR:String = "connectError";

		/**
		 * Отправляется при закрытии соединения
		 */
		public static const CLOSE:String = "closeConnection";

		/**
		 * Отправляется при попытке установления подключения к серверу
		 */
		public static const CONNECT_ATTEMPT:String = "connectAttempt";

		/**
		 * Отправляется при отправлении запроса на сервер
		 */
		public static const SEND_DATA:String = "sendData";

		/**
		 * Отправляется при получении ответа от сервера
		 */
		public static const RECEIVE_DATA:String = "receiveData";

		private var _data:Object;

		public function ConnectionEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_data = data;
			super(type, bubbles, cancelable);
		}

		/**
		 * Полученные данные от сервера
		 */
		public function get data():Object
		{ return _data; }

	}

}