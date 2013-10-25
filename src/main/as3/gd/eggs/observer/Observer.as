package gd.eggs.observer
{
	/**
	 * ...
	 * @author Jewelz
	 */
	public class Observer
	{
		//единственный экземпляр класса
		private static var _instance:Observer = null;


		//массив по ключу Notifications.name всех нотификаций и подписанных на них обсерверов
		private var notifications:Object = {};

		public function Observer()
		{
			if (_instance)
			{
				throw new Error("Use 'getInstance()' to get instance of class");
			}
		}

		/**
		 * Получение экземпляра класса
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
		 * Регистрация нового обсервера
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
		 * Оповещение всех обсерверов, подписанных на note.name
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