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
﻿package gd.eggs.assetsfactory
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	import gd.eggs.assetsfactory.items.ItemLoader;


	//=========================================================================
	//
	//			EVENTS
	//
	//=========================================================================
	/**
	 * Отправляется после декодирования всех полученных данных
	 * и размещения их в свойстве data объекта
	 */
	[Event(name="complete", type="gd.eggs.assetsfactory.FactoryEvent")]

	/**
	 * Отправляется в случае получения данных в ходе операции загрузки.
	 */
	[Event(name="progress", type="gd.eggs.assetsfactory.FactoryEvent")]

	/**
	 * Отправляется в случае возникновения ошибки в процессе загрузки.
	 */
	[Event(name="itemError", type="gd.eggs.assetsfactory.FactoryEvent")]

	/**
	 * Отправляется после получения и декодирования данных в каком-то из ItemLoader.
	 */
	[Event(name="itemComplete", type="gd.eggs.assetsfactory.FactoryEvent")]

	/**
	 * ...
	 * @author Dukobpa3
	 */ public class AssetsFactory extends EventDispatcher
	{
		//=====================================================================
		//		CONSTANTS
		//=====================================================================
		/** Дефолтное количество одновременных закачек */
		public static const DEFAULT_NUM_CONNECTIONS:int = 5;

		//=====================================================================
		//		PRIVATE
		//=====================================================================
		/** Колличество одновременных закачек */
		private var _maxConnections:int;

		/** Список лоадеров которые надо загрузить */
		private var _loadingQueue:Vector.<ItemLoader>;

		/** Список активных на текущий момент лоадеров */
		private var _activeItems:Vector.<ItemLoader>;

		/** статус загрузки: загружается, пауза, отменено. */
		private var _state:String;

		/** Словарь контента */
		private var _contents:Dictionary;

		//=====================================================================
		//		CONSTRUCTOR, INIT
		//=====================================================================
		public function AssetsFactory()
		{
			_loadingQueue = new Vector.<ItemLoader>();
			_activeItems = new Vector.<ItemLoader>();
		}

		//=====================================================================
		//		PUBLIC
		//=====================================================================
		//-----------------------------
		//	Функции управления итемами
		//-----------------------------
		/**
		 * ДОбавляет итем в очередь
		 * и запускает загрузку очереди, если она еще не запущена
		 * @param    url урл который надо загрузить
		 * @param    key ключ по которому можно будет достать итем из базы, если не указан то ставится урл
		 * @return
		 */
		public function add(url:String, key:Object = null):ItemLoader
		{
			var loader:ItemLoader = new ItemLoader();

			key = key ? key : url;
			_contents[key] = loader;

			_loadingQueue.push(loader)

			if (_activeItems.length < _maxConnections)
			{
				_activeItems.push(loader)
				loadNext();
			}

			return loader;
		}

		//-----------------------------
		//	Функции управления контентом
		//-----------------------------
		/**
		 * Выдает загруженный контент
		 * @param    key ключ по которому объект зарегистрирован в базе
		 * @param    type тип к которому нужно попытаться перекастовать объект
		 * @return
		 */
		public function getContent(key:Object, type:Class):Object
		{
			var result:Object = _contents[key];
			return result as type;
		}

		//-----------------------------
		//	Функции управления загрузкой
		//-----------------------------
		public function start():void
		{
			loadNext();
		}

		public function pause():void
		{

		}

		public function resume():void
		{

		}

		//=====================================================================
		//		PRIVATE
		//=====================================================================

		private function loadNext():void
		{

		}

		//=====================================================================
		//		ACCESSORS
		//=====================================================================

	}

}