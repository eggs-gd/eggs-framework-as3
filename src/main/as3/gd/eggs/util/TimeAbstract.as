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
﻿package gd.eggs.util
{
	/**
	 * ...
	 * @author Jewelz
	 */
	public class TimeAbstract
	{

		public static function getAbstractTextFormat(unixTime:int):String
		{
			var format:String = '';


			var days:int = int(unixTime / 86400);
			var hours:int = int((unixTime - days * 86400) / 3600);
			var mins:int = int((unixTime - days * 86400 - hours * 3600) / 60);
			var secs:int = unixTime - days * 86400 - hours * 3600 - mins * 60;

			if (days)
			{
				format += days.toString();
				format += "d ";
			}
			if (hours)
			{
				//if (hours < 10) format += "0";
				format += hours.toString();
				format += "h ";
			}
			if (mins && !days)
			{
				//if (mins < 10) format += "0";
				format += mins.toString();
				format += "m ";
			}
			if (secs && !days)
			{
				//if (secs < 10) format += "0";
				format += secs.toString();
				format += "s ";
			}

			return format;
		}

	}

}