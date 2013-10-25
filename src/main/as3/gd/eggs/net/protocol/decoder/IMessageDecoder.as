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
﻿package gd.eggs.net.protocol.decoder
{
	import flash.events.IEventDispatcher;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	[Event(name="invalid data type", type="flash.events.DataEvent")];
	[Event(name="invalid package size", type="flash.events.DataEvent")];
	[Event(name="receiving header", type="flash.events.DataEvent")];
	[Event(name="in progress", type="flash.events.DataEvent")];
	[Event(name="done", type="flash.events.DataEvent")];

	public interface IMessageDecoder extends IEventDispatcher
	{
		//=====================================================================
		//	PUBLIC
		//=====================================================================
		/**
		 * Парсит "нечто" которое может быть чем-то внятным, или же байтарреем
		 * @param    command "нечто", которе мы получили с сервера
		 */
		function parse(message:Object):void

		/**
		 * пакует внутреннее "нечто" в серверное
		 * @param    data
		 * @return
		 */
		function pack(data:Object):Object
	}
}