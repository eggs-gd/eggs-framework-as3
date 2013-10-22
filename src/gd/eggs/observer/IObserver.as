package gd.eggs.observer
{
	/**
	 * ...
	 * @author Jewelz
	 */
	public interface IObserver 
	{
		/**
		 * Вызывается при получении нотификации
		 * @param	note
		 */
		function update(note:Notification):void;
		
		/**
		 * Задает список нотификаций, которые должны обрабатываться в данном обсервере
		 * @return
		 */
		function listNotifications():/*String*/Array;
	}

}