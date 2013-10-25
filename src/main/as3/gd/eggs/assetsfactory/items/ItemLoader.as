package gd.eggs.assetsfactory.items
{
	import flash.net.URLRequest;
	import flash.utils.ByteArray;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class ItemLoader implements IItemLoader
	{

		private var _content:Object;
		private var _byteContent:ByteArray;
		private var _dataFormat:String;
		private var _contentLoaderInfo:ItemLoaderInfo;

		public function ItemLoader()
		{

		}

		/* INTERFACE gd.addictedcompany.assetsfactory.items.IItemLoader */
		//=====================================================================
		//	FUNCTIONS
		//=====================================================================
		public function load(request:URLRequest, context:ItemLoaderContext = null):void
		{

		}

		public function loadBytes(bytes:ByteArray):void
		{

		}

		public function unload():void
		{

		}

		public function close():void
		{

		}

		//=====================================================================
		//	ACCESSORS
		//=====================================================================
		public function get content():Object { return _content; }

		public function get byteContent():ByteArray { return _byteContent; }

		public function get dataFormat():String { return _dataFormat; }

		public function get contentLoaderInfo():ItemLoaderInfo { return _contentLoaderInfo; }

	}

}