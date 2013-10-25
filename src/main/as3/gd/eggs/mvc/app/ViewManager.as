package gd.eggs.mvc.app
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