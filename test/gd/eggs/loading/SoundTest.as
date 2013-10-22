package gd.eggs.loading
{
	import gd.eggs.loading.BulkLoader;
	import gd.eggs.loading.BulkProgressEvent;
	import gd.eggs.loading.utils.mp3.Mp3Sound;
	
	import flash.display.Sprite;
	
	import flash.events.Event;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	
	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class SoundTest extends Sprite 
	{
		private var bulkLoader:BulkLoader;
		private var sharedObject:SharedObject;
		
		//private var loader:Mp3Sound = new Mp3Sound();
		
		private var added:Boolean = false;
		
		public function SoundTest():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			trace("getting local size");
			
			bulkLoader = BulkLoader.getLoader("mainLoader");
			sharedObject = BulkLoader.sharedObject;
			trace("local size is: ", sharedObject.size);
			
			var url:String = "mp3/song.mp3";
			bulkLoader.add(url, { type: "sound", shared:true} );
			
			bulkLoader.addEventListener(BulkProgressEvent.COMPLETE, onAllLoaded);
			bulkLoader.start();
			
			//var req:URLRequest = new URLRequest("mp3/song.mp3");
			//var loader:Mp3Sound = new Mp3Sound();
			//
			//loader.addEventListener(Event.COMPLETE, soundLoadComplete)
			//loader.load(req);
			
		}
		
		private function onAllLoaded(e:BulkProgressEvent):void 
		{
			trace("bulkLoader.bytesTotal: ", bulkLoader.bytesTotal)
			
			trace("local size after load is: ", sharedObject.size);
			
			accessDemo();
		}
		
		private function accessDemo():void 
		{
			var sound:Sound = bulkLoader.getSound("mp3/song.mp3");
			
			var soundSh:SoundChannel = sound.play();
			
			trace(sound);
			//this.addChild(swf);
		}
		
	}
	
}