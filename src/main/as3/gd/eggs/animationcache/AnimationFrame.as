package gd.eggs.animationcache
{
	import flash.display.BitmapData;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class AnimationFrame
	{

		private var _bitmapData:BitmapData;
		private var _x:int;
		private var _y:int;

		public function AnimationFrame(bmpd:BitmapData, x:int, y:int)
		{
			_bitmapData = bmpd;
			_x = x;
			_y = y;
		}

		internal function get bitmapData():BitmapData
		{
			return _bitmapData;
		}

		internal function get x():int
		{
			return _x;
		}

		internal function get y():int
		{
			return _y;
		}

	}

}