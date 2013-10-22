package gd.eggs.mvc.controller
{

	import gd.eggs.observer.IObservable;
	import gd.eggs.observer.IObserver;
	import gd.eggs.observer.Notification;
	import gd.eggs.observer.Observer;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;

	/**
	 * Базовый класс контроллера
	 * @author Dukobpa3
	 */
	public class BaseController extends EventDispatcher implements IObserver, IObservable
	{
		
		/**
		 * Ссылка на родительский контейнер
		 */
		protected var _host:DisplayObjectContainer;
		
		/**
		 * Синглтон обсервера
		 */
		private var obs:Observer;
		
		public function BaseController(host:DisplayObjectContainer) 
		{
			_host = host;
			
			obs = Observer.getInstance();
			obs.registerObserver(this as IObserver);
		}
		
		/**
		 * Подписка на нужные оповещения
		 * @return
		 */
		public function listNotifications():Array
		{
			return [];
		}
		
		/**
		 * Обработка оповещения note
		 * @param	note
		 */
		public function update(note:Notification):void
		{
			
		}
		
		/**
		 * Отправка оповещения note
		 * @param	note
		 */
		public function sendNotification(note:Notification):void
		{
			note.target = this;
			obs.notifyObservers(note);
		}
		
	}

}