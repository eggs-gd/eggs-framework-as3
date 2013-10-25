package gd.eggs.observer
{
	/**
	 * Тело нотификации для отправки обсервером
	 * @author Jewelz
	 */
	public class Notification 
	{
		
		public function Notification(name:String, body:Object = null)
		{
			this.name = name;


			this.body = body;
		}
		
		public var name:String;
		public var body:Object;
		public var target:Object;
		
	}

}