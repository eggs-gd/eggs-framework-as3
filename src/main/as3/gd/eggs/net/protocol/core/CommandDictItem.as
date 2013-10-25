package gd.eggs.net.protocol.core
{
	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class CommandDictItem
	{
		private var _id:int;


		private var _name:String;
		private var _parseCallBack:Function;
		private var _dataToClient:Class;
		private var _dataToServer:Class;

		/**
		 *
		 * @param    id
		 * @param    name
		 * @param    callback функци�? котора�? вызовет�?�? при получении ме�?аджа
		 * @param    dataToClient
		 * @param    dataToServer
		 */
		public function CommandDictItem(id:int, name:String, callback:Function, dataToClient:Class = null, dataToServer:Class = null)
		{
			_id = id;
			_name = name;
			_parseCallBack = callback;
			_dataToClient = dataToClient;
			_dataToServer = dataToServer;
		}

		/**
		 * ИД команды в базе
		 */
		public function get id():int
		{
			return _id;
		}

		/**
		 * Им�? команды
		 */
		public function get name():String
		{
			return _name;
		}

		/**
		 * Тип данных пере�?ылаемых клиенту
		 */
		public function get dataToClient():Class
		{
			return _dataToClient;
		}

		/**
		 * Тип данных пере�?ылаемых �?ерверу
		 */
		public function get dataToServer():Class
		{
			return _dataToServer;
		}

		/**
		 * Функци�? котора�? дернет�?�? при получении �?оответ�?твующей команды
		 */
		public function get callBack():Function
		{
			return _parseCallBack;
		}

	}

}