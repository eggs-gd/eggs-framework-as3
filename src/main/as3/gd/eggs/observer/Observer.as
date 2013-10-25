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
﻿package gd.eggs.observer
{
	/**
	 * ...
	 * @author Jewelz
	 */
	public class Observer
	{
		//единственный экземпляр класса
		private static var _instance:Observer = null;


		//массив по ключу Notifications.name всех нотификаций и подписанных на них обсерверов
		private var notifications:Object = {};

		public function Observer()
		{
			if (_instance)
			{
				throw new Error("Use 'getInstance()' to get instance of class");
			}
		}

		/**
		 * Получение экземпляра класса
		 * @return
		 */
		public static function getInstance():Observer
		{
			if (_instance == null)
			{
				_instance = new Observer();
			}
			return _instance;
		}

		/**
		 * Регистрация нового обсервера
		 * @param    value
		 */
		public function registerObserver(value:IObserver):void
		{
			var list:/*String*/Array = value.listNotifications();
			var i:int;
			var length:int = list.length;
			var noteName:String;
			var obses:Array;
			for (i = 0; i < length; i++)
			{
				noteName = list[i];
				obses = notifications[noteName];
				if (!obses)
				{
					obses = [];
					notifications[noteName] = obses;
				}
				obses.push(value);
			}
		}

		/**
		 * Оповещение всех обсерверов, подписанных на note.name
		 * @param    note
		 */
		public function notifyObservers(note:Notification):void
		{
			var obses:Array = notifications[note.name];
			if (obses)
			{
				var i:int;
				var length:int = obses.length;
				var obs:IObserver;
				for (i = 0; i < length; i++)
				{
					obs = obses[i] as IObserver;
					obs.update(note);
				}
			}
		}

	}

}