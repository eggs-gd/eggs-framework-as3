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
﻿package gd.eggs.assetsfactory.items
{
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class ItemLoaderContext
	{
		//=====================================================================
		//		CONSTANTS
		//=====================================================================

		//=====================================================================
		//		PARAMETERS
		//=====================================================================
		/**
		 * Для лоадера звука
		 */
		private var _bufferTime:Number;

		/**
		 * Для лоадера графики
		 */
		private var _applicationDomain:ApplicationDomain;
		private var _securityDomain:SecurityDomain;

		/**
		 * Универсальное
		 */
		private var _checkPolicyFile:Boolean;

		//=====================================================================
		//		CONSTRUCTOR, INIT
		//=====================================================================
		/**
		 * Универсальный лоадер контекст, параметры все очевидны.
		 * @param    checkPolicy
		 * @param    appDomain
		 * @param    secDomain
		 * @param    bufferTime
		 */
		public function ItemLoaderContext(checkPolicy:Boolean = false, appDomain:ApplicationDomain = null, secDomain:SecurityDomain = null, bufferTime:Number = 1000)
		{
			_checkPolicyFile = checkPolicy;
			_applicationDomain = appDomain;
			_securityDomain = secDomain;
			_bufferTime = bufferTime;
		}

		//=====================================================================
		//		PUBLIC
		//=====================================================================

		//=====================================================================
		//		PRIVATE
		//=====================================================================

		//=====================================================================
		//		ACCESSORS
		//=====================================================================

		public function get bufferTime():Number { return _bufferTime; }

		public function set bufferTime(value:Number):void { _bufferTime = value; }

		public function get applicationDomain():ApplicationDomain { return _applicationDomain; }

		public function set applicationDomain(value:ApplicationDomain):void { _applicationDomain = value; }

		public function get securityDomain():SecurityDomain { return _securityDomain; }

		public function set securityDomain(value:SecurityDomain):void { _securityDomain = value; }

		public function get checkPolicyFile():Boolean { return _checkPolicyFile; }

		public function set checkPolicyFile(value:Boolean):void { _checkPolicyFile = value; }
	}

}