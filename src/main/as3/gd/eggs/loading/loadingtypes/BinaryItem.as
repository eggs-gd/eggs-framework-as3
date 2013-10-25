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
﻿package gd.eggs.loading.loadingtypes
{

	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;

	import gd.eggs.loading.BulkLoader;


	/** @private */
	public class BinaryItem extends LoadingItem
	{
		public var loader:URLLoader;

		public function BinaryItem(url:URLRequest, type:String, uid:String)
		{
			super(url, type, uid);
		}

		override public function _parseOptions(props:Object):Array
		{
			return super._parseOptions(props);
		}

		override public function load():void
		{
			super.load();
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(ProgressEvent.PROGRESS, onProgressHandler, false, 0, true);
			loader.addEventListener(Event.COMPLETE, onCompleteHandler, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler, false, 0, true);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, super.onHttpStatusHandler, false, 0, true);
			loader.addEventListener(Event.OPEN, onStartedHandler, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, super.onSecurityErrorHandler, false, 0, true);

			if (shared && BulkLoader.sharedObject.data.hasOwnProperty("contents") && BulkLoader.sharedObject.data.contents[url.url])
			{
				trace("adding bynary content from SO");
				_fromSO = true;
				_byteContent = BulkLoader.sharedObject.data.contents[url.url] as ByteArray;
				_byteContent.position = 0;

				loader.data = _byteContent;

				loader.dispatchEvent(new Event(Event.OPEN, true, false));
				loader.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, true, false, _byteContent.length, _byteContent.length));
				loader.dispatchEvent(new Event(Event.COMPLETE, true, false));

				return;
			}
			else
			{
				_fromSO = false;
				// TODO: test for security error thown.
				try
				{
					loader.load(url);
				}
				catch (e:SecurityError)
				{
					onSecurityErrorHandler(_createErrorEvent(e));
				}
			}

		};

		override public function onErrorHandler(evt:ErrorEvent):void
		{
			super.onErrorHandler(evt);
		}

		override public function onStartedHandler(evt:Event):void
		{
			super.onStartedHandler(evt);
		};

		override public function onCompleteHandler(evt:Event):void
		{
			// _content = new ByteArray(loader.data);
			try
			{
				_content = loader.data;
				if (!_fromSO)
				{
					_byteContent = _content;
				}
			}
			catch (e:Error)
			{
				_content = null;
				status = STATUS_ERROR;
				dispatchEvent(_createErrorEvent(e));
			}
			super.onCompleteHandler(evt);
		};

		override public function stop():void
		{
			try
			{
				if (loader)
				{
					loader.close();
				}
			}
			catch (e:Error)
			{

			}

			super.stop();
		};

		override public function cleanListeners():void
		{
			if (loader)
			{
				loader.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler, false);
				loader.removeEventListener(Event.COMPLETE, onCompleteHandler, false);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler, false);
				loader.removeEventListener(BulkLoader.OPEN, onStartedHandler, false);
				loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, super.onHttpStatusHandler, false);
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, super.onSecurityErrorHandler, false);
			}
		}

		override public function destroy():void
		{
			stop();
			cleanListeners();
			_content = null;
			loader = null;
		}
	}
}
