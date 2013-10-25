package gd.eggs.observer
{
	/**
	 * ...
	 * @author Jewelz
	 */
	public class Observer
	{
		//един�?твенный �?кземпл�?р кла�?�?а
		private static var _instance:Observer = null;


		//ма�?�?ив по ключу Notifications.name в�?ех нотификаций и подпи�?анных на них об�?ерверов
		private var notifications:Object = {};

		public function Observer()
		{
			if (_instance)
			{
				throw new Error("Use 'getInstance()' to get instance of class");
			}
		}

		/**
		 * Получение �?кземпл�?ра кла�?�?а
		 * @return
		 */
		public static function getInstance():Observer
		{
			if (_instance == null)
			{
				_instance = new Observer();
			}
			return _instance;
		}

		/**
		 * Реги�?траци�? нового об�?ервера
		 * @param    value
		 */
		public function registerObserver(value:IObserver):void
		{
			var list:/*String*/Array = value.listNotifications();
			var i:int;
			var length:int = list.length;
			var noteName:String;
			var obses:Array;
			for (i = 0; i < length; i++)
			{
				noteName = list[i];
				obses = notifications[noteName];
				if (!obses)
				{
					obses = [];
					notifications[noteName] = obses;
				}
				obses.push(value);
			}
		}

		/**
		 * Оповещение в�?ех об�?ерверов, подпи�?анных на note.name
		 * @param    note
		 */
		public function notifyObservers(note:Notification):void
		{
			var obses:Array = notifications[note.name];
			if (obses)
			{
				var i:int;
				var length:int = obses.length;
				var obs:IObserver;
				for (i = 0; i < length; i++)
				{
					obs = obses[i] as IObserver;
					obs.update(note);
				}
			}
		}

	}

}