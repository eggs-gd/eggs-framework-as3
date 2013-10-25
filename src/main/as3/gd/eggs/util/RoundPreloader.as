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
﻿/*

 The MIT License,

 Copyright (c) 2011. silin (http://silin.su#AS3)

 */
package  gd.eggs.util
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;


	/**
	 * кружочки по радиусу, по таймеру меняем альфу по кругу
	 * @author silin
	 */
	public class RoundPreloader extends Sprite
	{
		private var _list:Array = [];
		private var _age:int = 0;
		private var _timer:Timer = new Timer(80);
		private var _label:TextField = new TextField();

		/**
		 * constructor
		 * @param    size        размер основоного кргуга
		 * @param    color        цвет
		 * @param    alpha        альфа
		 * @param    delay        задержка перестановки альфы кружков
		 */
		public function RoundPreloader(size:int = 100, color:int = 0x808080, alpha:Number = 0.8, delay:int = 80)
		{
			_timer.delay = delay;
			var r:int = size / 2;
			var r1:int = Math.floor(size * Math.PI / 16) - 1;

			var fmt:TextFormat = new TextFormat("_sans", 1.25 * r1, color, true);
			_label.defaultTextFormat = fmt;
			_label.selectable = false;
			_label.autoSize = TextFieldAutoSize.LEFT;
			_label.filters = [new BlurFilter(0, 0)];
			_label.alpha = alpha;
			addChild(_label);

			for (var i:int = 0; i < 8; i++)
			{
				var u:Shape = new Shape();
				u.graphics.beginFill(color, alpha);
				u.graphics.drawCircle(0, 0, r1);
				u.x = r * Math.cos(i * Math.PI / 4);
				u.y = r * Math.sin(i * Math.PI / 4);
				addChild(u);
				_list.push(u);
			}

			//blendMode = BlendMode.INVERT;
		}

		public function start():void
		{
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
		}

		public function stop():void
		{
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			_timer.stop();
		}

		private function onTimer(evnt:TimerEvent):void
		{
			_age++;
			for (var i:int = 0; i < 8; i++)
			{
				var u:Shape = _list[i];
				var indx:int = (_age - i) % 8;
				u.alpha = 1 - 0.08 * indx;
			}
			evnt.updateAfterEvent();
		}

		/**
		 * надпись (по центру)
		 */
		public function get label():String
		{ return _label.text; }

		public function set label(value:String):void
		{
			_label.text = value;
			_label.x = -_label.width / 2;
			_label.y = -_label.height / 2;
		}

	}

}
