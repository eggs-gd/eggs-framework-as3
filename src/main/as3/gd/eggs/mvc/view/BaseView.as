package gd.eggs.mvc.view
{
	import flash.display.Sprite;
	import flash.events.Event;

	import gd.eggs.mvc.model.BaseModel;
	import gd.eggs.util.IInitialize;


	[Event(name="viewChange", type="gd.eggs.mvc.view.ViewEvent")]

	/**
	 * Базовый класс-представление
	 * При создании или установке модели добавляет коллбек по-умолчанию
	 * При удалении модели или дестрое - удаляет его.
	 * Остальные подписки следует добавить в инит и дестрой
	 * @author Dukobpa3
	 */
	public class BaseView extends Sprite implements IInitialize
	{
		/** Данные для отображения */
		protected var _model:BaseModel;

		private var _inited:Boolean;

		/**
		 * Конструктор
		 * @param    model модель (можно не указывать)
		 * @param    update отрисовывать ли сразу при создании
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

		/**
		 * Отображает вью.
		 * Реализация по-умолчанию просто visible = true;
		 * Для более эффектного появления на екране слудет переопредлить.
		 */
		public function show():void
		{
			this.visible = true;
		}

		/**
		 * Скрывает вью.
		 * Реализация по-умолчанию просто visible = false;
		 * Для более эффектного появления на екране слудет переопредлить.
		 */
		public function hide():void
		{
			this.visible = false;
		}

		/**
		 * Устанавливает модель
		 * @param    model модель
		 * @param    update нужно ли рендерить сразу после установки
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
		 * @inheritDoc
		 */
		public function init():void
		{
			_inited = true;
		}

		/**
		 * @inheritDoc
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

			_inited = false;
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
		 * @param    e
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

		/**
		 * @inheritDoc
		 */
		public function get isInited():Boolean { return _inited; }


	}

}