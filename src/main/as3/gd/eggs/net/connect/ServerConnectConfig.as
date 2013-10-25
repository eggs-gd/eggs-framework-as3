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
	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class ServerConnectConfig
	{

		//=====================================================================
		//	CONSTANTS
		//=====================================================================

		//=====================================================================
		//	PARAMETERS
		//=====================================================================
		private var _type:String;

		private var _timeout:int;
		private var _connectTime:int;
		private var _host:String;
		private var _port:int;
		//=====================================================================
		//	CONSTRUCTOR, INIT
		//=====================================================================
		public function ServerConnectConfig(type:String, timeout:int, connectTime:int, host:String, port:int)
		{
			_type = type;
			_timeout = timeout;
			_connectTime = connectTime;
			_host = host;
			_port = port;
		}

		//=====================================================================
		//	PUBLIC
		//=====================================================================

		//=====================================================================
		//	PRIVATE
		//=====================================================================

		//=====================================================================
		//	HANDLERS
		//=====================================================================

		//=====================================================================
		//	ACCESSORS
		//=====================================================================
		public function get timeout():int { return _timeout; }

		public function get connectTime():int { return _connectTime; }

		public function get host():String { return _host; }

		public function get port():int { return _port; }

		public function get type():String { return _type; }
	}

}