package gd.eggs.observer
{
	/**
	 * ...
	 * @author Jewelz
	 */
	public interface IObservable
	{
		/**
		 * Отправл�?ет нотификацию в�?ем об�?ерверам, подпи�?анным на данный Notification.name
		 * @param    note
		 */
		function sendNotification(note:Notification):void;


	}

}