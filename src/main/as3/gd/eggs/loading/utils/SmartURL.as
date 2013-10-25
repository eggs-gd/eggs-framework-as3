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
﻿package gd.eggs.loading.utils
{
	/**
	 * A simple data holder to normalize an URI components.
	 **/
	public class SmartURL
	{
		public var rawString:String;


		public var protocol:String;
		public var port:int;
		public var host:String;
		public var path:String;
		public var queryString:String;
		public var queryObject:Object;
		public var queryLength:int = 0;
		public var fileName:String;

		public function SmartURL(rawString:String)
		{
			this.rawString = rawString;
			var URL_RE:RegExp = /((?P<protocol>[a-zA-Z]+: \/\/)   (?P<host>[^:\/]*) (:(?P<port>\d+))?)?  (?P<path>[^?]*)? ((?P<query>.*))? /x;
			var match:* = URL_RE.exec(rawString);
			if (match)
			{
				protocol = Boolean(match.protocol) ? match.protocol : "http://";
				protocol = protocol.substr(0, protocol.indexOf("://"));
				host = match.host || null;
				port = match.port ? int(match.port) : 80;
				path = match.path;
				fileName = path.substring(path.lastIndexOf("/"), path.lastIndexOf("."));
				queryString = match.query;
				if (queryString)
				{
					queryObject = {};
					queryString = queryString.substr(1);
					var value:String;
					var varName:String;
					for each (var pair:String in queryString.split("&"))
					{
						varName = pair.split("=")[0];
						value = pair.split("=")[1];
						queryObject[varName] = value;
						queryLength++;
					}
				}
			}
			else
			{
				trace("no match")
			}
		}

		/** If called as t<code>oString(true)</code> will output a verbose version of this URL.
		 **/
		public function toString(...rest):String
		{
			if (rest.length > 0 && rest[0] == true)
			{
				return "[URL] rawString :" + rawString + ", protocol: " + protocol + ", port: " + port + ", host: " + host + ", path: " + path + ". queryLength: " + queryLength;
			}
			return rawString;
		}
	}
}
