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
﻿package gd.eggs.mvc.view
{
	import flash.events.Event;


	/**
	 * Базовый класс события, отсылаемого представлением
	 * @author Dukobpa3
	 */
	public class ViewEvent extends Event
	{
		/**
		 * Основное событие изменения модели
		 * тип события указывается в subType
		 */
		public static const CHANGE:String = "viewChange";

		private var _subType:String;
		private var _data:Object;

		/**
		 * Создает новое событие вьюхи
		 * @param    type - тип (восновном ViewEvent.CHANGE)
		 * @param    subType - подтип - можно указывать любой удобный.
		 * @param    data - данные передаваемые с событием.
		 * @param    bubbles
		 * @param    cancelable
		 */
		public function ViewEvent(type:String, subType:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_subType = subType;
			_data = data;

			super(type, bubbles, cancelable);
		}

		/**
		 * Тип события от представления
		 */
		public function get subType():String
		{ return _subType; }

		/**
		 * Данные отправляемые вместе с событием
		 */
		public function get data():Object
		{ return _data;}

	}

}