package gd.eggs.assetsfactory.items
{
	import gd.eggs.assetsfactory.items.ItemEvent;
	import flash.net.URLRequest;
	
	import flash.utils.ByteArray;
	
	/**
	 * Интерфейс класса лоадера элемента. 
	 * Все уникальные лоадеры(для картинок, для звука, для байтов, текста) его имплементируют.
	 * @author Dukobpa3
	 */
	
	
	/**
	 * Отправляется после декодирования всех полученных данных 
	 * и размещения их в свойстве data объекта
	 */
	[Event(name = "complete", type="gd.eggs.assetsfactory.items.ItemEvent")]
	
	/**
	 * Отправляется, если вызов метода ItemLoader.load() 
	 * инициирует попытку доступа к данным по протоколу HTTP.
	 */
	[Event(name = "httpStatus", type="gd.eggs.assetsfactory.items.ItemEvent")]
 	
	/**
	 * Отправляется, если вызов метода ItemLoader.load() 
	 * приводит к неустранимой ошибке, прекращающей загрузку.
	 */
	[Event(name = "ioError", type="gd.eggs.assetsfactory.items.ItemEvent")]
	
	/**
	 * Отправляется, когда операция загрузки начинается после вызова метода ItemLoader.load().
	 */
	[Event(name = "open", type="gd.eggs.assetsfactory.items.ItemEvent")]
	
	/**
	 * Передается объектом ItemLoader каждый раз, когда загруженный объект 
	 * удаляется с помощью метода unload() объекта ItemLoader, 
	 * а также когда выполняется повторная загрузка тем же объектом LoadingItem, 
	 * и перед началом загрузки удаляется исходное содержимое.
	 */
	[Event(name = "unload", type="gd.eggs.assetsfactory.items.ItemEvent")]
	
	/**
	 * Отправляется в случае получения данных в ходе операции загрузки.
	 */
	[Event(name = "progress", type="gd.eggs.assetsfactory.items.ItemEvent")]
 	
	/**
	 * Отправляется, если путем вызова метода ItemLoader.load() 
	 * предпринимается попытка загрузить данные с сервера, 
	 * расположенного за пределами изолированной среды.
	 */
	[Event(name = "securityError", type="gd.eggs.assetsfactory.items.ItemEvent")]
	

	
	public interface IItemLoader
	{
		//=============================
		// Functions
		//=============================
		/**
		 * загружает переданный URLRequest в объект лоадера
		 * @param	request
		 * @param	context - переколбасить под что-то универсальное
		 */
		function load(request:URLRequest, context:ItemLoaderContext = null):void;
		
		/**
		 * Загружает переданные байты, декодирует, помещает в свойство content объекта
		 * @param	bytes
		 */
		function loadBytes(bytes:ByteArray):void;
		
		/**
		 * Удаляет загруженный ранее объект. Обнуляет параметры content, byteContent
		 */
		function unload():void;
		
		/**
		 * Останавливает текущую активную загрузку.
		 */
		function close():void;
		
		//=============================
		// Getters Setters
		//=============================
		/**
		 * Возвращает ссылку на загруженные данные в удобоваримом формате
		 */
		function get content():Object
		
		/**
		 * возвращает ссылку на контент в байтовых данных
		 */
		function get byteContent():ByteArray
		
		/**
		 * указывает вид загружаемого контента
		 */
		function get dataFormat():String
		
		/**
		 * Объекты LoaderInfo совместно используются объектом Loader 
		 * и загруженным объектом содержимого. 
		 * Объект LoaderInfo предоставляет сведения о процессе загрузки 
		 * и статистику по загружаемому файлу.
		 * 
		 * События, связанные с загрузкой, отправляются объектом LoaderInfo, 
		 * на который ссылается свойство contentLoaderInfo объекта Loader. 
		 * Свойство contentLoaderInfo задается для действительного объекта LoaderInfo, 
		 * даже если содержимое еще не загружено, чтобы можно было добавить 
		 * прослушивателей событий объекта перед загрузкой.
		 */
		function get contentLoaderInfo():ItemLoaderInfo
	}
	
}