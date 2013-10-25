package gd.eggs.mvc.model
{


	import flash.utils.Dictionary;

	import gd.eggs.util.Validate;


	/**
	 * Базовый класс модели.
	 * Умеет рассылать событие о изменениях update(type:String = "default").
	 * метод принимает строковый параметр подтипа события изменения.
	 * по этому параметру можно во вью ориентироваться и дифференциировать куски рендера,
	 * чтобы не производить весь рендер каждый апдейт.
	 * @author Dukobpa3
	 */
	public class BaseModel
	{
		public static const DEFAULT_CHANGE:String = "default";

		private var _callbacks:Dictionary; // {object:{type:[callback]}}

		public function BaseModel()
		{
			_callbacks = new Dictionary();
		}

		/**
		 * Добавляем коллбек на изменения в модели.
		 * Есть зарезервированное имя события, которое дернет дефолтный рендер вьюхи.
		 * Так же можно подписаться вьюхой несколькими коллбеками на разные события,
		 * чтобы не перерисовывать всю вью если изменилось одно значение.
		 * @param type
		 * @param callback
		 */
		public function addCallback(object:*, type:String, callback:Function):void
		{
			if (!_callbacks[object]) _callbacks[object] = {};
			if (!_callbacks[object].hasOwnProperty(type)) _callbacks[object][type] = [];

			if (_callbacks[object][type].indexOf(callback) == -1) _callbacks[object][type].push(callback);
		}

		/**
		 * Удаляет ранее добавленный коллбек.
		 * @param type
		 * @param callback
		 */
		public function removeCallback(object:*, type:String = "all", callback:Function = null):void
		{
			if (!Validate.isNull(object)) return;
			if (type == "all")
			{
				delete _callbacks[object];
			}
			else
			{
				if (!_callbacks[object].hasOwnProperty(type)) return;
				if (!Validate.isNull(callback))
				{
					delete _callbacks[object][type];
				}
				else if (_callbacks[object][type].indexOf(callback) != -1)
				{
					_callbacks[object][type].splice(_callbacks[object][type].indexOf(callback), 1);
				}

				if (_callbacks[object][type].length == 0)
				{
					delete _callbacks[object][type];
				}
			}
		}

		/**
		 * Модель рассылает событие, об обновлении
		 */
		public function refresh():void
		{
			update();
		}

		/**
		 * При каждом изменении св-ва, необходимого для перерисовки в представлении, необходимо вызывать метод
		 * @param    type строковый параметр обозначающий участок в котором произошли изменения.
		 *          Если BaseModel.DEFAULT_CHANGE("default") - то рендериться будет вся вью.
		 */
		protected function update(type:String = "default"):void
		{
			var callbacks:Array;
			var func:Function;

			var objects:Array = [];
			var object:Object;

			// Шлем именованые ивенты
			for (object in _callbacks)
			{
				objects.push(object);
				callbacks = _callbacks[object][type] as Array;
				if (!callbacks) return;

				for each (func in callbacks) func();
			}

			// Вдогонку шлем дефолтные
			if (type == DEFAULT_CHANGE) return;

			for (object in _callbacks)
			{
				if (objects.indexOf(object) != -1) return;

				callbacks = _callbacks[object][DEFAULT_CHANGE] as Array;
				if (!callbacks) return;

				for each (func in callbacks) func();
			}

		}

	}

}