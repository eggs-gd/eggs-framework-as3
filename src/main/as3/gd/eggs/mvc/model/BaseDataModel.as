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
﻿package gd.eggs.mvc.model
{


	/**
	 * Базовая модель данных. От этого класса наследуется главная модель
	 * так же все ветки и параметры которые должны автообновляться от сервера
	 * должны наследоваться от этого класса. Все данные которые автообновляются
	 * можно будет достать из этой части модели геттером data.
	 * так же рекомендуется добавить все необходимые геттеры в каждом потомке
	 * дабы избежать лишней точки в имени параметра.
	 *
	 * Все известные параметры в приходящих с сервера данных должны быть добавлены в _data в конструкторе:
	 *        _data.someParam = new SomeClass(); //SomeClass - Это либо что-то из базовых типов, либо очередной потомок BaseDataModel
	 *
	 * так же при необходимости следует оверрайдить метод: updateNoKey(key:Object, data:Object) - этот метод занимается заполнением данных
	 * имени которых не нашел в _data.
	 *
	 * @author Dukobpa3
	 */
	public class BaseDataModel extends BaseModel
	{
		/** Объект для данных сервера */
		protected var _data:Object;

		/**
		 * Конструктор. Тут инициалируется композиция с объектов-контенйером для автообновляемых данных.
		 * так же нужно в констркуторе указывать инициализацию всех нужных параметров нуждающихся в автообновляении и вставлять их в этот объект.
		 * Имена параметров должны в точности совпадать с серверными.
		 */
		public function BaseDataModel()
		{
			super();
			_data = {};
		}

		//-----------------------------
		//	PRIVATE
		//-----------------------------
		/**
		 * Пропихивает данные полученные с сервера по веткам моделей.
		 * @param    data
		 */
		protected function updateData(data:Object):void
		{
			for (var key:String in data) // проходим по каждому ключу данных
			{
				if (_data.hasOwnProperty(key)) // если в дате есть такой ключ
				{
					if (_data[key] is BaseDataModel) // и если этот ключ является BaseDataModel
					{
						_data[key].updateData.call(this, data[key]) // значит в нем должен быть метод автоапдейта. Запускаем его
					}
					else
					{
						_data[key] = data[key]; // Иначе данные принимаем за базовый тип и просто приравниваем
					}
				}
				else // если же такого ключа нету
				{
					updateNoKey(key, data[key]); // то запускаем функцию занимающуюся обновлением без ключей.
				}

				update(key); // Кричим во вьюху что изменили параметр.
			}
		}

		/**
		 * Оверрайдим там где надо.
		 * @param    key
		 * @param    data
		 */
		protected function updateNoKey(key:String, data:Object):void
		{
			trace(key);
			_data[key] = data;
		}

		//=============================
		//	ACCESSORS
		//=============================

		/**
		 * Возвращает основной контейнер с автообновляемыми данными
		 */
		public function get data():Object
		{ return _data; }

	}

}