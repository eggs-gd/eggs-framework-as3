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
	public class ReadTest extends Sprite
	{
		private var bulkLoader:BulkLoader;
		private var sharedObject:SharedObject;

		private var added:Boolean = false;

		public function ReadTest():void
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


			for (var i:int = 1; i < 21; i++)
			{
				var url:String = "img/small-" + String(i) + ".jpg";
				bulkLoader.add(url, { type: "image", shared: true });
			}
			// в цикле подписываться ломает, потом хз куда все картинки деевать, 
			// подписываюсь на одну картинку только
			bulkLoader.get("img/small-3.jpg").addEventListener(Event.COMPLETE, itemListenerDemo)

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
			var img1:Bitmap = bulkLoader.contents["img/small-1.jpg"];
			var img2:Bitmap = bulkLoader.get("img/small-2.jpg").content;

			img1.scaleX = img1.scaleY = 0.3;
			addChild(img1);

			img2.scaleX = img2.scaleY = 0.3;
			addChild(img2);
			img2.x = 300;

		}

		private function itemListenerDemo(event:Event):void
		{
			//removeEventListener(Event, itemListenerDemo);
			var img3:Bitmap = event.target.loader.content;

			img3.scaleX = img3.scaleY = 0.3;
			addChild(img3);
			img3.x = 500;
		}

	}

}