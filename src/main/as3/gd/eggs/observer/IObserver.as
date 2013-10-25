package gd.eggs.observer
{
	/**
	 * ...
	 * @author Jewelz
	 */
	public interface IObserver
	{
		/**
		 * Вызывает�?�? при получении нотификации
		 * @param    note
		 */
		function update(note:Notification):void;


		/**
		 * Задает �?пи�?ок нотификаций, которые должны обрабатывать�?�? в данном об�?ервере
		 * @return
		 */
		function listNotifications():/*String*/Array;
	}

}