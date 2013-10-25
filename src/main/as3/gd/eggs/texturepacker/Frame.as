/**
 * Licensed under the MIT License
 *
 * Copyright (c) 2013 earwiGGames team
 * http://eggs.gd/
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
﻿package gd.eggs.texturepacker
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

		/** прямоугольник на общем листе */
		public function get rect():Rectangle
		{ return _rect; }

		//public function get width():Number { return _bmd.width; }
		//public function get height():Number { return _bmd.height; }

		//=============================
		//	UTILLS
		//=============================
	}

}