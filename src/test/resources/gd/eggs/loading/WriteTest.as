package gd.eggs.loading
{
	import gd.eggs.loading.BulkLoader;


	import gd.eggs.loading.BulkProgressEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class WriteTest extends Sprite 
	{
		private var bulkLoader:BulkLoader;
		private var sharedObject:SharedObject;
		
		public function WriteTest():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			trace("getting local size");
			
			sharedObject = SharedObject.getLocal("/addictedCompany/" + BulkLoader.APP_NAME + "/loading", "/");
			sharedObject.clear();
			trace("cleared local size is: ", sharedObject.size);
			
			//bulkLoader = new BulkLoader("mainLoader", BulkLoader.DEFAULT_NUM_CONNECTIONS, true);
			bulkLoader = BulkLoader.getLoader("mainLoader");
			sharedObject = BulkLoader.sharedObject;
			trace("local size is: ", sharedObject.size);
			
			
			
			for (var i:int = 1 ; i < 11 ; i ++ )
			{
				var url:String = "img/big-" + String(i) + ".jpg";
				bulkLoader.add(url, {type: "image", shared:true});
			}
			
			bulkLoader.addEventListener(BulkProgressEvent.COMPLETE, onAllLoaded);
			bulkLoader.start();
			
		}
		
		private function onAllLoaded(e:BulkProgressEvent):void 
		{
			trace("bulkLoader.bytesTotal: ", bulkLoader.bytesTotal)
			//so.data.bulkLoader = bulkLoader;
			//so.flush();
			trace("local size after load is: ", sharedObject.size);
			
		}
		
	}
	
}