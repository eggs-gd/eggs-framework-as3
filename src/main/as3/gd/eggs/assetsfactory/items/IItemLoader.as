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
		 * @param    context - переколба�?ить под что-то универ�?альное
		 */
		function load(request:URLRequest, context:ItemLoaderContext = null):void;

		/**
		 * Загружает переданные байты, декодирует, помещает в �?вой�?тво content объекта
		 * @param    bytes
		 */
		function loadBytes(bytes:ByteArray):void;

		/**
		 * Удал�?ет загруженный ранее объект. Обнул�?ет параметры content, byteContent
		 */
		function unload():void;

		/**
		 * О�?танавливает текущую активную загрузку.
		 */
		function close():void;

		//=============================
		// Getters Setters
		//=============================
		/**
		 * Возвращает �?�?ылку на загруженные данные в удобоваримом формате
		 */
		function get content():Object

		/**
		 * возвращает �?�?ылку на контент в байтовых данных
		 */
		function get byteContent():ByteArray

		/**
		 * указывает вид загружаемого контента
		 */
		function get dataFormat():String

		/**
		 * Объекты LoaderInfo �?овме�?тно и�?пользуют�?�? объектом Loader
		 * и загруженным объектом �?одержимого.
		 * Объект LoaderInfo предо�?тавл�?ет �?ведени�? о проце�?�?е загрузки
		 * и �?тати�?тику по загружаемому файлу.
		 *
		 * Событи�?, �?в�?занные �? загрузкой, отправл�?ют�?�? объектом LoaderInfo,
		 * на который �?�?ылает�?�? �?вой�?тво contentLoaderInfo объекта Loader.
		 * Свой�?тво contentLoaderInfo задает�?�? дл�? дей�?твительного объекта LoaderInfo,
		 * даже е�?ли �?одержимое еще не загружено, чтобы можно было добавить
		 * про�?лушивателей �?обытий объекта перед загрузкой.
		 */
		function get contentLoaderInfo():ItemLoaderInfo
	}

}