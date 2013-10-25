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
﻿package gd.eggs.mvc.app
{

	import flash.display.DisplayObjectContainer;

	import gd.eggs.mvc.view.BaseView;
	import gd.eggs.util.Validate;


	/**
	 * @author Dukobpa3
	 */
	public class ViewManager
	{
		private static var _scopes:Object = {}; //:Map<EnumValue, DisplayObjectContainer> = new Map();
		private static var _views:Object = {}; //:Map<EnumValue, AView> = new Map();

		public static function addScope(scope:String, container:DisplayObjectContainer):void
		{
			if (Validate.isNull(scope)) throw new Error("scope is null");
			if (Validate.isNull(container)) throw new Error("container is null");
			if (_scopes.hasOwnProperty(scope)) throw new Error("_scopes.exists(scope), scope: " + scope);

			_scopes[scope] = container;
		}

		public static function addView(scope:String, viewName:String, view:BaseView):void
		{
			if (Validate.isNull(scope)) throw new Error("scope is null");
			if (Validate.isNull(viewName)) throw new Error("viewName is null");
			if (Validate.isNull(view)) throw new Error("view is null");
			if (_views.hasOwnProperty(viewName)) throw new Error("_views.exists(viewName), viewName: " + viewName);
			if (!_scopes.hasOwnProperty(scope)) throw new Error("!_scopes.exists(scope), scope: " + scope);

			_views[viewName] = view;
			_scopes[scope].addChild(view);
			view.hide();
		}

		public static function getView(viewName:String):BaseView
		{
			if (Validate.isNull(viewName)) throw new Error("viewName is null");
			if (!_views.hasOwnProperty(viewName)) throw new Error("!_views.exists(viewName), viewName: " + viewName);

			return _views[viewName];
		}

		public static function show(viewName:String):void
		{
			if (Validate.isNull(viewName)) throw new Error("viewName is null");
			if (!_views.hasOwnProperty(viewName)) throw new Error("!_views.exists(viewName), viewName: " + viewName);

			_views[viewName].show();
		}

		public static function hide(viewName:String):void
		{
			if (Validate.isNull(viewName)) throw new Error("viewName is null");
			if (!_views.hasOwnProperty(viewName)) throw new Error("!_views.exists(viewName), viewName: " + viewName);

			_views[viewName].hide();
		}

		public static function hideAll():void
		{
			for each (var it:BaseView in _views) it.hide();
		}

	}

}