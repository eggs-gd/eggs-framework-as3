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
		 * Отправл�?ет�?�? при у�?пешном у�?тановлении �?оединени�? �? �?ервером
		 */
		public static const LOG:String = "log";

		/**
		 * Отправл�?ет�?�? при у�?пешном у�?тановлении �?оединени�? �? �?ервером
		 */
		public static const CONNECTED:String = "connected";

		/**
		 * Отправл�?ет�?�? при ошибке у�?тановлени�? �?оединени�?
		 */
		public static const CONNECT_ERROR:String = "connectError";

		/**
		 * Отправл�?ет�?�? при закрытии �?оединени�?
		 */
		public static const CLOSE:String = "closeConnection";

		/**
		 * Отправл�?ет�?�? при попытке у�?тановлени�? подключени�? к �?ерверу
		 */
		public static const CONNECT_ATTEMPT:String = "connectAttempt";

		/**
		 * Отправл�?ет�?�? при отправлении запро�?а на �?ервер
		 */
		public static const SEND_DATA:String = "sendData";

		/**
		 * Отправл�?ет�?�? при получении ответа от �?ервера
		 */
		public static const RECEIVE_DATA:String = "receiveData";

		private var _data:Object;

		public function ConnectionEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_data = data;
			super(type, bubbles, cancelable);
		}

		/**
		 * Полученные данные от �?ервера
		 */
		public function get data():Object
		{ return _data; }

	}

}