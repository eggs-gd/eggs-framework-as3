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
﻿package gd.eggs.util
{
	import aze.motion.eaze;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	[Event(name="complete", type="flash.events.Event")]
	public class CooldownAnimRect extends Sprite
	{
		//=====================================================================
		//	CONSTANTS
		//=====================================================================

		//=====================================================================
		//	PARAMETERS
		//=====================================================================
		private var _rect:Rectangle;
		private var _shape:Shape;
		private var _tf:TextField;
		private var _timer:int;

		//=====================================================================
		//	CONSTRUCTOR, INIT
		//=====================================================================
		public function CooldownAnimRect(rect:Rectangle)
		{
			_rect = rect;

			_shape = new Shape();
			_shape.visible = false;

			_shape.graphics.beginFill(0x000000, 0.8);
			_shape.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);

			addChild(_shape);

			_tf = new TextField();
			addChild(_tf);

			this.mouseChildren = this.mouseEnabled = false;
		}

		//=====================================================================
		//	PUBLIC
		//=====================================================================
		public function play(time:int):void
		{
			_shape.visible = true;
			eaze(_shape).to(time, { height: 0}).onUpdate(animUpdate).onComplete(animComplete);

			timer = time;
			eaze(this).to(time, { timer: 0 });
		}

		public function pause():void
		{
			eaze(_shape).killTweens();
			eaze(this).killTweens();
		}

		public function resume():void
		{
			eaze(_shape).to(timer, { height: 0}).onUpdate(animUpdate).onComplete(animComplete);

			eaze(this).to(timer, { timer: 0 });
		}

		//=====================================================================
		//	PRIVATE
		//=====================================================================
		private function animUpdate():void
		{
			_tf.text = timer.toString();
		}

		private function animComplete():void
		{
			_shape.visible = false;
			_tf.visible = false;
			_shape.height = _rect.height;
			dispatchEvent(new Event(Event.COMPLETE))
		}

		//=====================================================================
		//	HANDLERS
		//=====================================================================

		//=====================================================================
		//	ACCESSORS
		//=====================================================================
		public function get animNow():Boolean { return _shape.visible; }

		public function get timer():int { return _timer; }

		public function set timer(value:int):void { _timer = value; }
	}

}