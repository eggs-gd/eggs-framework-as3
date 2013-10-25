package gd.eggs.loading
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.SharedObject;


	/**
	 * Тут игрался с инициализацие шаредОбжекта, ничего интересного
	 * @author Dukobpa3
	 */
	public class BaseTest extends Sprite
	{

		private var bulkLoader:BulkLoader;
		private var so:SharedObject;


		public function BaseTest():void
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point


			trace("getting local size");

			//var sharedObject:SharedObject = SharedObject.getLocal("/addictedCompany/" + BulkLoader.APP_NAME + "/loading", "/");
			//sharedObject.clear();

			//bulkLoader = new BulkLoader("mainLoader", BulkLoader.DEFAULT_NUM_CONNECTIONS, true);
			bulkLoader = BulkLoader.getLoader("mainLoader");
			so = BulkLoader.sharedObject;
			trace("local size is: ", so.size);

			trace("cleared local size is: ", so.size);

			for (var i:int = 1; i < 11; i++)
			{
				var url:String = "img/big-" + String(i) + ".jpg";
				bulkLoader.add(url, {type: "binary"});
			}

			bulkLoader.addEventListener(BulkProgressEvent.COMPLETE, onAllLoaded);
			bulkLoader.start();

		}


		private function onAllLoaded(e:BulkProgressEvent):void
		{
			trace("bulkLoader.bytesTotal: ", bulkLoader.bytesTotal)
			//so.data.bulkLoader = bulkLoader;
			//so.flush();
			trace("local size after load is: ", so.size);

		}

	}

}