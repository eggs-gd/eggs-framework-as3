package gd.eggs.net.protocol.core
{
	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class CommandDict 
	{
		/** Синглтон */
		private static var _instance:CommandDict;


		
		/** Здаровое хранилище данных */
		private var _listById:Object; // {id:CommandDictItem}
		private var _listByName:Object; // {name:CommandDictItem}
		
		public function CommandDict() 
		{
			if (_instance) throw new Error("instance CommandDictionary was initialized");
			
			_listById = new Object();
			_listByName = new Object();
		}
		
		/**
		 * Синглтон, выдает инстанс словаря команд
		 * @return
		 */
		public static function getInstance():CommandDict
		{
			if (!_instance) _instance = new CommandDict();
			
			return _instance;
		}
		
		/**
		 * Добавить новый итем с соответствующими параметрами
		 * Регистрируем в двух словарях для быстрого доступа по имени либо по иду.
		 * @param	id
		 * @param	name
		 * @param	dataToClient
		 * @param	dataToServer
		 * @param	parseCallback
		 */
		public function addItem(id:int, name:String, dataToClient:Class, dataToServer:Class, parseCallback:Function):void
		{
			var cmdItem:CommandDictItem = new CommandDictItem(id, name, parseCallback, dataToClient, dataToServer);
			_listById[id] = cmdItem;
			_listByName[name] = cmdItem;
		}
		
		/**
		 * Ищет команду по иду
		 * @param	id
		 * @return
		 */
		public function getItemById(id:int):CommandDictItem
		{
			return _listById[id];
		}
		
		/**
		 * ищет команду по имени (работает медленнее чем по иду)
		 * @param	name
		 * @return
		 */
		public function getItemByName(name:String):CommandDictItem
		{
			return _listByName[name];
		}
	}

}