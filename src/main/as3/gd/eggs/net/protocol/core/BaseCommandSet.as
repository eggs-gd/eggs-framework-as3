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
	public class BaseCommandSet
	{
		//=====================================================================
		//	CONSTANTS
		//=====================================================================

		//=====================================================================
		//	PARAMETERS
		//=====================================================================
		protected var _commandDict:CommandDict = CommandDict.getInstance();


		//=====================================================================
		//	CONSTRUCTOR, INIT
		//=====================================================================
		public function BaseCommandSet()
		{
			/** Первым делом добавим дефолтный обработчик */
			_commandDict.addItem(0, "default", BaseProtoData, BaseProtoData, procDefaultData);

		}

		//=====================================================================
		//	PUBLIC
		//=====================================================================
		//-----------------------------
		//	Обработка незарегистрированных команд
		//-----------------------------
		public function init():void
		{
			throw new Error("abstract method, need to override");
		}

		public function procDefaultData(data:Object):void
		{
			throw new Error("Unspecified command, need to override default parser");
		}

		//=====================================================================
		//	PRIVATE
		//=====================================================================

		//=====================================================================
		//	HANDLERS
		//=====================================================================

		//=====================================================================
		//	ACCESSORS
		//=====================================================================
	}

}