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
	public class CommandDictItem
	{
		private var _id:int;


		private var _name:String;
		private var _parseCallBack:Function;
		private var _dataToClient:Class;
		private var _dataToServer:Class;

		/**
		 *
		 * @param    id
		 * @param    name
		 * @param    callback функция которая вызовется при получении месаджа
		 * @param    dataToClient
		 * @param    dataToServer
		 */
		public function CommandDictItem(id:int, name:String, callback:Function, dataToClient:Class = null, dataToServer:Class = null)
		{
			_id = id;
			_name = name;
			_parseCallBack = callback;
			_dataToClient = dataToClient;
			_dataToServer = dataToServer;
		}

		/**
		 * ИД команды в базе
		 */
		public function get id():int
		{
			return _id;
		}

		/**
		 * Имя команды
		 */
		public function get name():String
		{
			return _name;
		}

		/**
		 * Тип данных пересылаемых клиенту
		 */
		public function get dataToClient():Class
		{
			return _dataToClient;
		}

		/**
		 * Тип данных пересылаемых серверу
		 */
		public function get dataToServer():Class
		{
			return _dataToServer;
		}

		/**
		 * Функция которая дернется при получении соответствующей команды
		 */
		public function get callBack():Function
		{
			return _parseCallBack;
		}

	}

}