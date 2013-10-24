package gd.eggs.mvc.view
{
	import gd.eggs.mvc.model.BaseModel;

	import flash.display.Sprite;
	import flash.events.Event;


	[Event(name="viewChange", type="gd.eggs.mvc.view.ViewEvent")]

	/**
	 * Базовый класс-представление
	 * При создании или установке модели добавляет коллбек по-умолчанию
	 * При удалении модели или дестрое - удаляет его.
	 * @author Dukobpa3
	 */
	public class BaseView extends Sprite
	{
		/** Данные для отображения */
		protected var _model:BaseModel;
		
		/**
		 * Конструктор
		 * @param	model модель (можно не указывать)
		 * @param	update отрисовывать ли сразу при создании
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
		 * Устанавливает модель
		 * @param	model модель
		 * @param	update нужно ли рендерить сразу после установки
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
		 * Отписывается от модели и обнуляет ссылку
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
		 * Вызывает перерисовку вьюхи в следующем кадре
		 */
		public function invalidate():void
		{
			if (!hasEventListener(Event.ENTER_FRAME))
			{
				addEventListener(Event.ENTER_FRAME, onNextFrame);
			}
		}
		
		/**
		 * Вызывает перерисовку вьюхи немедленно
		 */
		public function invalidateNow():void
		{
			render();
		}
		
		//=====================================================================
		//		PRIVATE
		//=====================================================================
		
		/**
		 * Обработка события изменения модели
		 * Вызов отложенной перерисовки
		 */
		private function onModelChange():void
		{
			if (!hasEventListener(Event.ENTER_FRAME))
			{
				addEventListener(Event.ENTER_FRAME, onNextFrame);
			}
		}
		
		/**
		 * обрабатываем событие модели о изменении оной. 
		 * Так же очищаем массив изменений модели после рендера.
		 * @param	e
		 */
		private function onNextFrame(e:Event):void 
		{
			removeEventListener(Event.ENTER_FRAME, onNextFrame);
			render();
		}
		
		/**
		 * Наследуемый метод обработки данных модели (перерисовка компонента)
		 */
		protected function render():void 
		{
			
		}

	}

}