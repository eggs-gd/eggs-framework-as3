package gd.eggs.loading
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	
	/**
	 * Тут пробовал диспатчить фейковое событие. Мануально пихаю данные в лоадер.
	 * Поидее надо больше данных туда запихать чтоб аналитика не похерилась, 
	 * типа вес, скорость загрузки и в таком духе. Погляжу что там LoadingItem в статы пишет
	 * @author Dukobpa3
	 */
	public class SharedItemTest extends Sprite 
	{
		
		public function SharedItemTest():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var loader:URLLoader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.BINARY;
            loader.addEventListener(ProgressEvent.PROGRESS, onProgressHandler, false, 0, true);
            loader.addEventListener(Event.COMPLETE, 		onCompleteHandler, false, 0, true);
            loader.addEventListener(IOErrorEvent.IO_ERROR, 	onErrorHandler, false, 0, true);
            loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatusHandler, false, 0, true);
            loader.addEventListener(Event.OPEN, 			onStartedHandler, false, 0, true);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler, false, 0, true);
            
			loader.data = "ахуенчик, тест прошел";
			loader.dispatchEvent(new Event(Event.COMPLETE, true, false));
			
		}
		
		private function onSecurityErrorHandler(event:SecurityErrorEvent):void 
		{
			//removeEventListener(SecurityErrorEvent, onSecurityErrorHandler);
			
		}
		
		private function onStartedHandler(event:Event):void 
		{
			//removeEventListener(Event, onStartedHandler);
			
		}
		
		private function onHttpStatusHandler(event:HTTPStatusEvent):void 
		{
			//removeEventListener(HTTPStatusEvent, onHttpStatusHandler);
			
		}
		
		private function onErrorHandler(event:IOErrorEvent):void 
		{
			//removeEventListener(IOErrorEvent, onErrorHandler);
			
		}
		
		private function onCompleteHandler(event:Event):void 
		{
			//removeEventListener(Event, onCompleteHandler);
			trace("fake good: ", event.target.data);
		}
		
		private function onProgressHandler(event:ProgressEvent):void 
		{
			//removeEventListener(ProgressEvent, onProgressHandler);
			
		}
		
	}
	
}