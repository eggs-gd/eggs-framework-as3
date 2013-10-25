package gd.eggs.texturepacker
{
	import flash.display.BitmapData;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class BmdAtlas
	{
		//=============================
		//	PARAMETERS
		//=============================
		private var _bmd:BitmapData;
		private var _map:XML;
		//=============================
		//	CONSTRUCTOR, INIT
		//=============================
		public function BmdAtlas(bmd:BitmapData, map:XML)
		{
			_bmd = bmd;
			_map = map;
		}

		//=============================
		//	ACCESSORS
		//=============================
		/**
		 * Ли�?т битмапдаты тек�?туры
		 */
		public function get bmd():BitmapData
		{ return _bmd; }

		/**
		 * ХМЛ карта тайлов �?абтек�?тур
		 */
		public function get map():XML
		{ return _map; }
	}

}