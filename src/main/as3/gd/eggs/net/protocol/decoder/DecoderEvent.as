package gd.eggs.net.protocol.decoder
{
	import flash.events.Event;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class DecoderEvent extends Event
	{

		private var _data:Object;

		public function DecoderEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}

		public override function clone():Event
		{
			return new DecoderEvent(type, bubbles, cancelable);
		}

		public override function toString():String
		{
			return formatToString("DecoderEvent", "type", "bubbles", "cancelable", "eventPhase");
		}

		public function get data():Object { return _data; }

	}

}