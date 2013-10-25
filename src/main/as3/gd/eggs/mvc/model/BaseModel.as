package gd.eggs.mvc.model
{


	import flash.utils.Dictionary;

	import gd.eggs.util.Validate;


	/**
	 * Базовый кла�?�? модели.
	 * Умеет ра�?�?ылать �?обытие о изменени�?х update(type:String = "default").
	 * метод принимает �?троковый параметр подтипа �?обыти�? изменени�?.
	 * по �?тому параметру можно во вью ориентировать�?�? и дифференциировать ку�?ки рендера,
	 * чтобы не производить ве�?ь рендер каждый апдейт.
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
		 * Добавл�?ем коллбек на изменени�? в модели.
		 * Е�?ть зарезервированное им�? �?обыти�?, которое дернет дефолтный рендер вьюхи.
		 * Так же можно подпи�?ать�?�? вьюхой не�?колькими коллбеками на разные �?обыти�?,
		 * чтобы не перери�?овывать в�?ю вью е�?ли изменило�?ь одно значение.
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
		 * Удал�?ет ранее добавленный коллбек.
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
		 * Модель ра�?�?ылает �?обытие, об обновлении
		 */
		public function refresh():void
		{
			update();
		}

		/**
		 * При каждом изменении �?в-ва, необходимого дл�? перери�?овки в пред�?тавлении, необходимо вызывать метод
		 * @param    type �?троковый параметр обозначающий уча�?ток в котором произошли изменени�?.
		 *          Е�?ли BaseModel.DEFAULT_CHANGE("default") - то рендерить�?�? будет в�?�? вью.
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