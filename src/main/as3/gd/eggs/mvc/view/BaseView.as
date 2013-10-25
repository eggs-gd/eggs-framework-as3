package gd.eggs.mvc.view
{
	import flash.display.Sprite;
	import flash.events.Event;

	import gd.eggs.mvc.model.BaseModel;


	[Event(name="viewChange", type="gd.eggs.mvc.view.ViewEvent")]

	/**
	 * Базовый кла�?�?-пред�?тавление
	 * При �?оздании или у�?тановке модели добавл�?ет коллбек по-умолчанию
	 * При удалении модели или де�?трое - удал�?ет его.
	 * @author Dukobpa3
	 */ public class BaseView extends Sprite
	{
		/** Данные дл�? отображени�? */
		protected var _model:BaseModel;

		/**
		 * Кон�?труктор
		 * @param    model модель (можно не указывать)
		 * @param    update отри�?овывать ли �?разу при �?оздании
		 */
		public function BaseView(model:BaseModel = null, update:Boolean = true)
		{
			if (model)
			{
				_model = model;
				_model.addCallback(this, BaseModel.DEFAULT_CHANGE, onModelChange);
				if (update) _model.refresh();
			}
		}

		public function show():void
		{
			this.visible = true;
		}

		public function hide():void
		{
			this.visible = false;
		}

		/**
		 * У�?танавливает модель
		 * @param    model модель
		 * @param    update нужно ли рендерить �?разу по�?ле у�?тановки
		 */
		public function setModel(model:BaseModel, update:Boolean = true):void
		{
			if (_model)
			{
				_model.removeCallback(this);
				_model = null;
			}

			_model = model;
			_model.addCallback(this, BaseModel.DEFAULT_CHANGE, onModelChange);
			if (update) _model.refresh();
		}

		/**
		 * Отпи�?ывает�?�? от модели и обнул�?ет �?�?ылку
		 */
		public function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, onNextFrame);
			if (_model)
			{
				_model.removeCallback(this);
				_model = null;
			}
		}

		/**
		 * Вызывает перери�?овку вьюхи в �?ледующем кадре
		 */
		public function invalidate():void
		{
			if (!hasEventListener(Event.ENTER_FRAME))
			{
				addEventListener(Event.ENTER_FRAME, onNextFrame);
			}
		}

		/**
		 * Вызывает перери�?овку вьюхи немедленно
		 */
		public function invalidateNow():void
		{
			render();
		}

		//=====================================================================
		//		PRIVATE
		//=====================================================================

		/**
		 * Обработка �?обыти�? изменени�? модели
		 * Вызов отложенной перери�?овки
		 */
		private function onModelChange():void
		{
			if (!hasEventListener(Event.ENTER_FRAME))
			{
				addEventListener(Event.ENTER_FRAME, onNextFrame);
			}
		}

		/**
		 * обрабатываем �?обытие модели о изменении оной.
		 * Так же очищаем ма�?�?ив изменений модели по�?ле рендера.
		 * @param    e
		 */
		private function onNextFrame(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onNextFrame);
			render();
		}

		/**
		 * �?а�?ледуемый метод обработки данных модели (перери�?овка компонента)
		 */
		protected function render():void
		{

		}

	}

}