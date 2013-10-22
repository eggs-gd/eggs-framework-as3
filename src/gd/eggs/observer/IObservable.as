package gd.eggs.observer
{
	/**
	 * ...
	 * @author Jewelz
	 */
	public interface IObservable 
	{
		/**
		 * Отправляет нотификацию всем обсерверам, подписанным на данный Notification.name
		 * @param	note
		 */
		function sendNotification(note:Notification):void;
		
	}

}