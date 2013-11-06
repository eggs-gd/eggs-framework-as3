package gd.eggs.mvc.app
{

	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;

	import gd.eggs.mvc.view.BaseView;
	import gd.eggs.util.Validate;


	/**
	 * Класс для управления вьюхами приложения. Поддерживает несколько слоев.
	 * Слои сортируются снаружи. Вьюхи сортируются здесь, каждая в пределах своего контейнера-слоя
	 */
	public class ViewManager
	{
		private static var _scopes:Object = {}; //:Map<EnumValue, DisplayObjectContainer> = new Map();
		private static var _views:Object = {}; //:Map<EnumValue, AView> = new Map();
		private static var _scopeByView:Dictionary = new Dictionary(); // {view:scope}

		/**
		 * Добавить слой
		 * @param scope     имя слоя
		 * @param container ссылка на слой-контейнер
		 */
		public static function addScope(scope:String, container:DisplayObjectContainer):void
		{
			if (Validate.isNull(scope)) throw new Error("scope is null");
			if (Validate.isNull(container)) throw new Error("container is null");
			if (_scopes.hasOwnProperty(scope)) throw new Error("_scopes.exists(scope), scope: " + scope);

			_scopes[scope] = container;
		}

		/**
		 * Добавить вью в указанный слой
		 * @param scope     Имя слоя
		 * @param viewName  Имя вью
		 * @param view      Ссылка на вью
		 */
		public static function addView(scope:String, viewName:String, view:BaseView):void
		{
			if (Validate.isNull(scope)) throw new Error("scope is null");
			if (Validate.isNull(viewName)) throw new Error("viewName is null");
			if (Validate.isNull(view)) throw new Error("view is null");
			if (_views.hasOwnProperty(viewName)) throw new Error("_views.exists(viewName), viewName: " + viewName);
			if (!_scopes.hasOwnProperty(scope)) throw new Error("!_scopes.exists(scope), scope: " + scope);

			_views[viewName] = view;
			_scopes[scope].addChild(view);
			_scopeByView[view] = _scopes[scope];
			view.hide();
		}

		/**
		 * Выдает ссылку на вью по имени
		 * @param viewName  Имя вью
		 * @return  Ссылка на вью
		 */
		public static function getView(viewName:String):BaseView
		{
			if (Validate.isNull(viewName)) throw new Error("viewName is null");
			if (!_views.hasOwnProperty(viewName)) throw new Error("!_views.exists(viewName), viewName: " + viewName);

			return _views[viewName];
		}

		/**
		 * Отобразить вью с указанным именем.
		 * При отображении выносит вью на передний план в пределах контейнера.
		 * @param viewName  Имя вьюхи
		 */
		public static function show(viewName:String):void
		{
			if (Validate.isNull(viewName)) throw new Error("viewName is null");
			if (!_views.hasOwnProperty(viewName)) throw new Error("!_views.exists(viewName), viewName: " + viewName);

			var view:BaseView = _views[viewName];

			_scopeByView[view].addChild(view);
			view.show();
		}

		/**
		 * Прячет указанную вью
		 * @param viewName  Имя вьюхи
		 */
		public static function hide(viewName:String):void
		{
			if (Validate.isNull(viewName)) throw new Error("viewName is null");
			if (!_views.hasOwnProperty(viewName)) throw new Error("!_views.exists(viewName), viewName: " + viewName);

			_views[viewName].hide();
		}

		/**
		 * Прячет все вьюхи
		 */
		public static function hideAll():void
		{
			for each (var it:BaseView in _views) it.hide();
		}

	}

}