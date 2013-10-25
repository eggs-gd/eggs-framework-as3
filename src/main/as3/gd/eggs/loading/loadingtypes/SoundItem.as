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

	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	import gd.eggs.loading.BulkLoader;
	import gd.eggs.loading.utils.mp3.Mp3Sound;


	/** @private */
	public class SoundItem extends LoadingItem
	{
		public var loader:Mp3Sound;

		public function SoundItem(url:URLRequest, type:String, uid:String)
		{
			specificAvailableProps = [BulkLoader.CONTEXT];
			super(url, type, uid);
		}

		override public function _parseOptions(props:Object):Array
		{
			_context = props[BulkLoader.CONTEXT] || null;

			return super._parseOptions(props);
		}

		override public function load():void
		{
			super.load();
			loader = new Mp3Sound();
			loader.addEventListener(ProgressEvent.PROGRESS, onProgressHandler, false, 0, true);
			loader.addEventListener(Event.COMPLETE, onCompleteHandler, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler, false, 0, true);
			loader.addEventListener(Event.OPEN, onStartedHandler, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, super.onSecurityErrorHandler, false, 0, true);


			if (shared && BulkLoader.sharedObject.data.hasOwnProperty("contents") && BulkLoader.sharedObject.data.contents[url.url])
			{
				trace("adding content from SO");
				_fromSO = true;
				_byteContent = BulkLoader.sharedObject.data.contents[url.url] as ByteArray;
				loader.loadBytes(_byteContent, _context);
			}
			else
			{
				// TODO: test for security error thown.
				_fromSO = false;
				try
				{
					loader.load(url, _context);
				}
				catch (e:SecurityError)
				{
					onSecurityErrorHandler(_createErrorEvent(e));
				}
			}

		}

		override public function onStartedHandler(evt:Event):void
		{
			_content = loader.content;
			super.onStartedHandler(evt);
		}

		override public function onErrorHandler(evt:ErrorEvent):void
		{
			super.onErrorHandler(evt);
		}

		override public function onCompleteHandler(evt:Event):void
		{
			try
			{
				// of no crossdomain has allowed this operation, this might
				// raise a security error

				trace("completed: ", url.url);
				if (!_fromSO)
				{
					_byteContent = loader.byteContent;
				}
				_content = loader.content;
				super.onCompleteHandler(evt);
			}
			catch (e:SecurityError)
			{
				// we can still use the Loader object (no dice for accessing it as data
				// though. Oh boy:
				_content = loader;
				super.onCompleteHandler(evt);
				// I am really unsure whether I should throw this event
				// it would be nice, but simply delegating the error handling to user's code
				// seems cleaner (and it also mimics the Standar API behaviour on this respect)
				//onSecurityErrorHandler(e);
			}

			super.onCompleteHandler(evt);
		}

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
		}

		override public function cleanListeners():void
		{
			if (loader)
			{
				loader.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler, false);
				loader.removeEventListener(Event.COMPLETE, onCompleteHandler, false);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler, false);
				loader.removeEventListener(BulkLoader.OPEN, onStartedHandler, false);
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, super.onSecurityErrorHandler, false);
			}

		}

		override public function isStreamable():Boolean
		{
			return false;
		}

		override public function isSound():Boolean
		{
			return true;
		}

		override public function destroy():void
		{
			cleanListeners();
			stop();
			_content = null;
			loader = null;
		}
	}
}
