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
	import gd.eggs.observer.IObservable;
	import gd.eggs.observer.Notification;
	import gd.eggs.observer.Observer;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class BaseMediator implements IObservable
	{
		//=====================================================================
		//	CONSTANTS
		//=====================================================================

		//=====================================================================
		//	PARAMETERS
		//=====================================================================
		private var _views:Vector.<BaseView>;
		//=====================================================================
		//	CONSTRUCTOR, INIT
		//=====================================================================
		public function BaseMediator()
		{
			_views = new Vector.<BaseView>();
		}

		//=====================================================================
		//	PUBLIC
		//=====================================================================
		public function sendNotification(note:Notification):void
		{
			note.target = this;
			Observer.getInstance().notifyObservers(note);
		}

		public function injectView(view:BaseView):void
		{
			_views.push(view);
			view.addEventListener(ViewEvent.CHANGE, onViewChange);
		}

		//=====================================================================
		//	PRIVATE
		//=====================================================================

		//=====================================================================
		//	HANDLERS
		//=====================================================================
		protected function onViewChange(event:ViewEvent):void
		{
			throw new Error("need To override");
		}

		//=====================================================================
		//	ACCESSORS
		//=====================================================================
	}

}