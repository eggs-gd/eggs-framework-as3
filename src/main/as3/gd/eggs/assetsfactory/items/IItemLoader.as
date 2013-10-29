package gd.eggs.assetsfactory.items
{
	import flash.net.URLRequest;
	import flash.utils.ByteArray;


	/**
	 * Интерфей�? кла�?�?а лоадера �?лемента.
	 * В�?е уникальные лоадеры(дл�? картинок, дл�? звука, дл�? байтов, тек�?та) его имплементируют.
	 * @author Dukobpa3
	 */


	/**
	 * Отправл�?ет�?�? по�?ле декодировани�? в�?ех полученных данных
	 * и размещени�? их в �?вой�?тве data объекта
	 */
	[Event(name="complete", type="gd.eggs.assetsfactory.items.ItemEvent")]

	/**
	 * Отправл�?ет�?�?, е�?ли вызов метода ItemLoader.load()
	 * инициирует попытку до�?тупа к данным по протоколу HTTP.
	 */
	[Event(name="httpStatus", type="gd.eggs.assetsfactory.items.ItemEvent")]

	/**
	 * Отправл�?ет�?�?, е�?ли вызов метода ItemLoader.load()
	 * приводит к неу�?транимой ошибке, прекращающей загрузку.
	 */
	[Event(name="ioError", type="gd.eggs.assetsfactory.items.ItemEvent")]

	/**
	 * Отправл�?ет�?�?, когда операци�? загрузки начинает�?�? по�?ле вызова метода ItemLoader.load().
	 */
	[Event(name="open", type="gd.eggs.assetsfactory.items.ItemEvent")]

	/**
	 * Передает�?�? объектом ItemLoader каждый раз, когда загруженный объект
	 * удал�?ет�?�? �? помощью метода unload() объекта ItemLoader,
	 * а также когда выполн�?ет�?�? повторна�? загрузка тем же объектом LoadingItem,
	 * и перед началом загрузки удал�?ет�?�? и�?ходное �?одержимое.
	 */
	[Event(name="unload", type="gd.eggs.assetsfactory.items.ItemEvent")]

	/**
	 * Отправл�?ет�?�? в �?лучае получени�? данных в ходе операции загрузки.
	 */
	[Event(name="progress", type="gd.eggs.assetsfactory.items.ItemEvent")]

	/**
	 * Отправл�?ет�?�?, е�?ли путем вызова метода ItemLoader.load()
	 * предпринимает�?�? попытка загрузить данные �? �?ервера,
	 * ра�?положенного за пределами изолированной �?реды.
	 */
	[Event(name="securityError", type="gd.eggs.assetsfactory.items.ItemEvent")]


	public interface IItemLoader
	{
		//=============================
		// Functions
		//=============================
		/**
		 * загружает переданный URLRequest в объект лоадера
		 * @param    request
		 * @param    context - переколбасить под что-то универсальное
		 */
		function load(request:URLRequest, context:ItemLoaderContext = null):void;

		/**
		 * Загружает переданные байты, декодирует, помещает в свойство content объекта
		 * @param    bytes
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