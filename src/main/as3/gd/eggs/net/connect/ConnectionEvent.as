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
﻿package gd.eggs.net.connect
{
	import flash.events.Event;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class ConnectionEvent extends Event
	{

		/**
		 * Отправляется при успешном установлении соединения с сервером
		 */
		public static const LOG:String = "log";

		/**
		 * Отправляется при успешном установлении соединения с сервером
		 */
		public static const CONNECTED:String = "connected";

		/**
		 * Отправляется при ошибке установления соединения
		 */
		public static const CONNECT_ERROR:String = "connectError";

		/**
		 * Отправляется при закрытии соединения
		 */
		public static const CLOSE:String = "closeConnection";

		/**
		 * Отправляется при попытке установления подключения к серверу
		 */
		public static const CONNECT_ATTEMPT:String = "connectAttempt";

		/**
		 * Отправляется при отправлении запроса на сервер
		 */
		public static const SEND_DATA:String = "sendData";

		/**
		 * Отправляется при получении ответа от сервера
		 */
		public static const RECEIVE_DATA:String = "receiveData";

		private var _data:Object;

		public function ConnectionEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_data = data;
			super(type, bubbles, cancelable);
		}

		/**
		 * Полученные данные от сервера
		 */
		public function get data():Object
		{ return _data; }

	}

}