package gd.eggs.assetsfactory
{
	import flash.events.Event;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class FactoryEvent extends Event
	{
		public static const COMPLETE:String = "complete";
		public static const PROGRESS:String = "progress";

		public static const ITEM_ERROR:String = "itemError";

		public static const ITEM_COMPLETE:String = "itemComplete";


		public function FactoryEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

	}

}