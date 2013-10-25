//***************************************************************************
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