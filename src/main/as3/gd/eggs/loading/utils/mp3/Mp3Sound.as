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
﻿//***************************************************************************
//
//                                         COPYRIGHT
//
//***************************************************************************

package gd.eggs.loading.utils.mp3
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class Mp3Sound extends EventDispatcher
	{
		//*********************************************************************
		//
		//                                         PARAMETERS
		//
		//*********************************************************************
		//-----------------------------
		//		PRIVATE
		//-----------------------------
		private var _mp3Parser:MP3Parser;

		private var _byteContent:ByteArray;

		private var _loader:URLLoader;
		private var _sound:Sound;
		private var _loaderContext:SoundLoaderContext;

		//*********************************************************************
		//
		//                                         FUNCTIONS
		//
		//*********************************************************************

		//-----------------------------
		//		CONSTRUCTOR, INIT
		//-----------------------------
		public function Mp3Sound()
		{
			_loader = new URLLoader();
			_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus)
			_loader.addEventListener(Event.COMPLETE, onURLLoadComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onURLLoadError);
			_loader.addEventListener(ProgressEvent.PROGRESS, onURLProgress)
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onURLSecurityError)
			_loader.dataFormat = URLLoaderDataFormat.BINARY;

			_mp3Parser = new MP3Parser();
			_mp3Parser.addEventListener(MP3SoundEvent.COMPLETE, onParseComplete)
		}

		//-----------------------------
		//		PUBLIC
		//-----------------------------
		public function load(request:URLRequest, context:SoundLoaderContext = null):void
		{
			_loaderContext = context;
			//commObject.url = request.url;
			_loader.load(request);
		}

		public function loadBytes(bytes:ByteArray, context:SoundLoaderContext = null):void
		{
			_loaderContext = context;
			_byteContent = bytes;
			_mp3Parser.parse(bytes);
		}

		public function close():void
		{

		}

		//-----------------------------
		//		PRIVATE
		//-----------------------------


		//-----------------------------
		//		HANDLERS
		//-----------------------------
		private function onHttpStatus(event:HTTPStatusEvent):void
		{
			//removeEventListener(HTTPStatusEvent, onHttpStatus);

		}

		private function onURLLoadComplete(event:Event):void
		{
			//removeEventListener(Event, onURLLoadComplete);
			_byteContent = event.target.data as ByteArray
			_mp3Parser.parse(event.target.data as ByteArray);
		}

		private function onURLLoadError(event:IOErrorEvent):void
		{
			//removeEventListener(IOErrorEvent, onURLLoadError);

		}

		private function onURLProgress(event:ProgressEvent):void
		{
			//removeEventListener(ProgressEvent, onURLProgress);

		}

		private function onURLSecurityError(event:SecurityErrorEvent):void
		{
			//removeEventListener(SecurityErrorEvent, onURLSecurityError);

		}

		private function onParseComplete(event:MP3SoundEvent):void
		{
			//removeEventListener(MP3SoundEvent, onParseComplete);
			_sound = event.sound as Sound;

			dispatchEvent(new Event(Event.COMPLETE, true));
		}


		//-----------------------------
		//		GETTERS/SETTERS
		//-----------------------------
		public function get content():Sound
		{
			return _sound;
		}

		public function get byteContent():ByteArray
		{
			return _byteContent;
		}


		//-----------------------------
		//		UTILLS
		//-----------------------------
	}

}