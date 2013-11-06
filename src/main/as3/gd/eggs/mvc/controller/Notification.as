/**
 * Created by Dukobpa3 on 11/6/13.
 */
package gd.eggs.mvc.controller
{
	import flash.events.Event;


	public class Notification extends Event
	{
		public static const UPDATE:String = "notificationUpdate";

		private var _data:Object;
		private var _sender:BaseController;

		public function Notification(type:String, data:Object, sender:BaseController = null)
		{
			_sender = sender;
			_data = data;

			super(type, false, false);
		}

		public override function clone():Event
		{
			return new Notification(type, data, sender);
		}

		public override function toString():String
		{
			return formatToString("Notification", "type", "data", "bubbles", "cancelable", "eventPhase");
		}

		public function get data():Object { return _data; }

		public function get sender():BaseController { return _sender; }
		public function set sender(value:BaseController):void { _sender = value; }
	}
}
