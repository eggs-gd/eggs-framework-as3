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
﻿package gd.eggs.net.protocol.core
{
	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class CommandDict
	{
		/** Синглтон */
		private static var _instance:CommandDict;


		/** Здаровое хранилище данных */
		private var _listById:Object; // {id:CommandDictItem}
		private var _listByName:Object; // {name:CommandDictItem}

		public function CommandDict()
		{
			if (_instance) throw new Error("instance CommandDictionary was initialized");

			_listById = new Object();
			_listByName = new Object();
		}

		/**
		 * Синглтон, выдает инстанс словаря команд
		 * @return
		 */
		public static function getInstance():CommandDict
		{
			if (!_instance) _instance = new CommandDict();

			return _instance;
		}

		/**
		 * Добавить новый итем с соответствующими параметрами
		 * Регистрируем в двух словарях для быстрого доступа по имени либо по иду.
		 * @param    id
		 * @param    name
		 * @param    dataToClient
		 * @param    dataToServer
		 * @param    parseCallback
		 */
		public function addItem(id:int, name:String, dataToClient:Class, dataToServer:Class, parseCallback:Function):void
		{
			var cmdItem:CommandDictItem = new CommandDictItem(id, name, parseCallback, dataToClient, dataToServer);
			_listById[id] = cmdItem;
			_listByName[name] = cmdItem;
		}

		/**
		 * Ищет команду по иду
		 * @param    id
		 * @return
		 */
		public function getItemById(id:int):CommandDictItem
		{
			return _listById[id];
		}

		/**
		 * ищет команду по имени (работает медленнее чем по иду)
		 * @param    name
		 * @return
		 */
		public function getItemByName(name:String):CommandDictItem
		{
			return _listByName[name];
		}
	}

}