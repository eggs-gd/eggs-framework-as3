package gd.eggs.loading
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.SharedObject;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class TransparentTest extends Sprite
	{
		private var bulkLoader:BulkLoader;
		private var sharedObject:SharedObject;

		private var added:Boolean = false;

		public function TransparentTest():void
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


			//[Embed(source='../../bin/img/closer_over.png')]
			var url:String = "img/closer_over.png";
			bulkLoader.add(url, {type: "image", shared: true});

			bulkLoader.addEventListener(BulkProgressEvent.COMPLETE, onAllLoaded);
			bulkLoader.start();

		}

		private function onAllLoaded(e:BulkProgressEvent):void
		{
			trace("bulkLoader.bytesTotal: ", bulkLoader.bytesTotal)
			//so.data.bulkLoader = bulkLoader;
			//so.flush();
			if (!added)
			{
				var bmp:Bitmap = bulkLoader.items[0].content;
				addChild(bmp);
				added = true;
			}
			trace("local size after load is: ", sharedObject.size);


		}

	}

}