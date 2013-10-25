package gd.eggs.assetsfactory
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	import gd.eggs.assetsfactory.items.ItemLoader;


	//=========================================================================
	//
	//			EVENTS
	//
	//=========================================================================
	/**
	 * Отправл�?ет�?�? по�?ле декодировани�? в�?ех полученных данных
	 * и размещени�? их в �?вой�?тве data объекта
	 */
	[Event(name="complete", type="gd.eggs.assetsfactory.FactoryEvent")]

	/**
	 * Отправл�?ет�?�? в �?лучае получени�? данных в ходе операции загрузки.
	 */
	[Event(name="progress", type="gd.eggs.assetsfactory.FactoryEvent")]

	/**
	 * Отправл�?ет�?�? в �?лучае возникновени�? ошибки в проце�?�?е загрузки.
	 */
	[Event(name="itemError", type="gd.eggs.assetsfactory.FactoryEvent")]

	/**
	 * Отправл�?ет�?�? по�?ле получени�? и декодировани�? данных в каком-то из ItemLoader.
	 */
	[Event(name="itemComplete", type="gd.eggs.assetsfactory.FactoryEvent")]

	/**
	 * ...
	 * @author Dukobpa3
	 */ public class AssetsFactory extends EventDispatcher
	{
		//=====================================================================
		//		CONSTANTS
		//=====================================================================
		/** Дефолтное количе�?тво одновременных закачек */
		public static const DEFAULT_NUM_CONNECTIONS:int = 5;

		//=====================================================================
		//		PRIVATE
		//=====================================================================
		/** Колличе�?тво одновременных закачек */
		private var _maxConnections:int;

		/** Спи�?ок лоадеров которые надо загрузить */
		private var _loadingQueue:Vector.<ItemLoader>;

		/** Спи�?ок активных на текущий момент лоадеров */
		private var _activeItems:Vector.<ItemLoader>;

		/** �?тату�? загрузки: загружает�?�?, пауза, отменено. */
		private var _state:String;

		/** Словарь контента */
		private var _contents:Dictionary;

		//=====================================================================
		//		CONSTRUCTOR, INIT
		//=====================================================================
		public function AssetsFactory()
		{
			_loadingQueue = new Vector.<ItemLoader>();
			_activeItems = new Vector.<ItemLoader>();
		}

		//=====================================================================
		//		PUBLIC
		//=====================================================================
		//-----------------------------
		//	Функции управлени�? итемами
		//-----------------------------
		/**
		 * ДОбавл�?ет итем в очередь
		 * и запу�?кает загрузку очереди, е�?ли она еще не запущена
		 * @param    url урл который надо загрузить
		 * @param    key ключ по которому можно будет до�?тать итем из базы, е�?ли не указан то �?тавит�?�? урл
		 * @return
		 */
		public function add(url:String, key:Object = null):ItemLoader
		{
			var loader:ItemLoader = new ItemLoader();

			key = key ? key : url;
			_contents[key] = loader;

			_loadingQueue.push(loader)

			if (_activeItems.length < _maxConnections)
			{
				_activeItems.push(loader)
				loadNext();
			}

			return loader;
		}

		//-----------------------------
		//	Функции управлени�? контентом
		//-----------------------------
		/**
		 * Выдает загруженный контент
		 * @param    key ключ по которому объект зареги�?трирован в базе
		 * @param    type тип к которому нужно попытать�?�? перека�?товать объект
		 * @return
		 */
		public function getContent(key:Object, type:Class):Object
		{
			var result:Object = _contents[key];
			return result as type;
		}

		//-----------------------------
		//	Функции управлени�? загрузкой
		//-----------------------------
		public function start():void
		{
			loadNext();
		}

		public function pause():void
		{

		}

		public function resume():void
		{

		}

		//=====================================================================
		//		PRIVATE
		//=====================================================================

		private function loadNext():void
		{

		}

		//=====================================================================
		//		ACCESSORS
		//=====================================================================

	}

}