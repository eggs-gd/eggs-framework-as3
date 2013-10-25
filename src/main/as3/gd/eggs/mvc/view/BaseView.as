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
	import flash.display.Sprite;
	import flash.events.Event;

	import gd.eggs.mvc.model.BaseModel;


	[Event(name="viewChange", type="gd.eggs.mvc.view.ViewEvent")]

	/**
	 * Базовый класс-представление
	 * При создании или установке модели добавляет коллбек по-умолчанию
	 * При удалении модели или дестрое - удаляет его.
	 * @author Dukobpa3
	 */ public class BaseView extends Sprite
	{
		/** Данные для отображения */
		protected var _model:BaseModel;

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

	}

}