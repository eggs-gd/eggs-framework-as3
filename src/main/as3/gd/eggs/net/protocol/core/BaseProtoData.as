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

	import flash.utils.ByteArray;
	import flash.utils.Endian;

	import org.serialization.bson.BSON;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public dynamic class BaseProtoData
	{
		protected namespace protocol = "protocol";

		public function BaseProtoData()
		{

		}

		public function readBSON(buffer:ByteArray):void
		{
			buffer.position = 0;
			fromObject(BSON.decode(buffer))
		}

		public function writeBSON():ByteArray
		{
			var result:ByteArray = new ByteArray();
			result.endian = Endian.LITTLE_ENDIAN;

			result.writeBytes(BSON.encode(toObject()));

			result.position = 0;

			return result;
		}

		public function fromObject(data:Object = null):BaseProtoData
		{
			use namespace protocol;

			for (var key:String in data)
			{
				try
				{
					this["_" + key] = data[key];
				}
				catch (error:Object)
				{
					throw new Error("fromObject() error: " + error + ", wrong key:" + key);
				}
			}

			return this
		}

		public function toObject():Object
		{
			throw new Error("toObject() error: not implemented");
			//return this;
		}

		//public function get id():int { return _id; }

	}
}