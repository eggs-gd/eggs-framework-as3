package gd.eggs.texturepacker
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	internal class Frame
	{

		//=============================
		//	CONSTANTS
		//=============================

		//=============================
		//	PARAMETERS
		//=============================
		private var _bmd:BitmapData;
		private var _rect:Rectangle;
		//=============================
		//	CONSTRUCTOR, INIT
		//=============================
		public function Frame(bmd:BitmapData, rect:Rectangle)
		{
			_bmd = bmd;
			_rect = rect;
		}

		//=============================
		//	PUBLIC
		//=============================
		public function destroy():void
		{
			_bmd.dispose();
		}

		//=============================
		//	PRIVATE
		//=============================

		//=============================
		//	HANDLERS
		//=============================

		//=============================
		//	ACCESSORS
		//=============================
		/** Битмапдата фрейма */
		public function get data():BitmapData
		{ return _bmd; }

		/** пр�?моугольник на общем ли�?те */
		public function get rect():Rectangle
		{ return _rect; }

		//public function get width():Number { return _bmd.width; }
		//public function get height():Number { return _bmd.height; }

		//=============================
		//	UTILLS
		//=============================
	}

}