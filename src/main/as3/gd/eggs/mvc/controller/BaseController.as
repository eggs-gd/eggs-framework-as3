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
﻿package gd.eggs.mvc.controller
{

	import flash.events.EventDispatcher;

	import gd.eggs.observer.IObservable;
	import gd.eggs.observer.IObserver;
	import gd.eggs.observer.Notification;
	import gd.eggs.observer.Observer;
	import gd.eggs.util.IInitialize;


	/**
	 * Базовый класс контроллера
	 * @author Dukobpa3
	 */
	public class BaseController extends EventDispatcher implements IObserver, IObservable, IInitialize
	{

		private var _isInited:Boolean;

		/**
		 * Синглтон обсервера
		 */
		private var obs:Observer;

		public function BaseController()
		{
			obs = Observer.getInstance();
			obs.registerObserver(this as IObserver);
		}

		/**
		 * Подписка на нужные оповещения
		 * @return
		 */
		public function listNotifications():Array
		{
			return [];
		}

		/**
		 * Обработка оповещения note
		 * @param    note
		 */
		public function update(note:Notification):void
		{

		}

		/**
		 * Отправка оповещения note
		 * @param    note
		 */
		public function sendNotification(note:Notification):void
		{
			note.target = this;
			obs.notifyObservers(note);
		}


		public function init():void
		{
			_isInited = true;
		}

		public function destroy():void
		{
			_isInited = false;
		}

		public function get isInited():Boolean
		{
			return _isInited;
		}
	}

}