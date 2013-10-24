package gd.eggs.loading
{
	import gd.eggs.loading.BulkLoader;
	import gd.eggs.loading.BulkProgressEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import gd.eggs.loading.utils.display.Loader;
	
	import flash.display.Sprite;
	
	import flash.events.Event;
	
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class SwfTest extends Sprite 
	{
		private var bulkLoader:BulkLoader;
		private var sharedObject:SharedObject;
		
		private var added:Boolean = false;
		
		public function SwfTest():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			trace("getting local size");
			
			//sharedObject = SharedObject.getLocal("/addictedCompany/" + BulkLoader.APP_NAME + "/loading", "/");
			//sharedObject.clear();
			//trace("cleared local size is: ", sharedObject.size);
			
			//bulkLoader = new BulkLoader("mainLoader", BulkLoader.DEFAULT_NUM_CONNECTIONS, true);
			bulkLoader = BulkLoader.getLoader("mainLoader");
			sharedObject = BulkLoader.sharedObject;
			trace("local size is: ", sharedObject.size);
			
			var url:String = "swf/As3Radio.swf";
			var _context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			bulkLoader.add(url, { type: "movieclip", shared:true, context:_context } );
			
			bulkLoader.addEventListener(BulkProgressEvent.COMPLETE, onAllLoaded);
			bulkLoader.start();
			
		}
		
		private function onAllLoaded(e:BulkProgressEvent):void 
		{
			trace("bulkLoader.bytesTotal: ", bulkLoader.bytesTotal)
			//so.data.bulkLoader = bulkLoader;
			//so.flush();
			
			trace("local size after load is: ", sharedObject.size);
			
			accessDemo();
		}
		
		private function accessDemo():void 
		{
			//var swf:MovieClip = bulkLoader.getMovieClip("swf/As3Radio.swf");
			//
			//this.addChild(swf);
			
			var cl:Class = getDefinitionByName('radio_mc') as Class;
			var swf:Sprite = new cl() as Sprite;
			
			this.addChild(swf);
		}
		
	}
	
}