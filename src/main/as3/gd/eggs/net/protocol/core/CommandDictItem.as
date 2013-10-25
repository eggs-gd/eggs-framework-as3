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
		 * @param    callback функция которая вызовется при получении месаджа
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
		 * Имя команды
		 */
		public function get name():String
		{
			return _name;
		}

		/**
		 * Тип данных пересылаемых клиенту
		 */
		public function get dataToClient():Class
		{
			return _dataToClient;
		}

		/**
		 * Тип данных пересылаемых серверу
		 */
		public function get dataToServer():Class
		{
			return _dataToServer;
		}

		/**
		 * Функция которая дернется при получении соответствующей команды
		 */
		public function get callBack():Function
		{
			return _parseCallBack;
		}

	}

}