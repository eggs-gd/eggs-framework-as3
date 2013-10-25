package gd.eggs.mvc.controller
{

	import flash.events.EventDispatcher;

	import gd.eggs.observer.IObservable;
	import gd.eggs.observer.IObserver;
	import gd.eggs.observer.Notification;
	import gd.eggs.observer.Observer;
	import gd.eggs.util.IInitialize;


	/**
	 * Базовый кла�?�? контроллера
	 * @author Dukobpa3
	 */
	public class BaseController extends EventDispatcher implements IObserver, IObservable, IInitialize
	{

		private var _isInited:Boolean;

		/**
		 * Синглтон об�?ервера
		 */
		private var obs:Observer;

		public function BaseController()
		{
			obs = Observer.getInstance();
			obs.registerObserver(this as IObserver);
		}

		/**
		 * Подпи�?ка на нужные оповещени�?
		 * @return
		 */
		public function listNotifications():Array
		{
			return [];
		}

		/**
		 * Обработка оповещени�? note
		 * @param    note
		 */
		public function update(note:Notification):void
		{

		}

		/**
		 * Отправка оповещени�? note
		 * @param    note
		 */
		public function sendNotification(note:Notification):void
		{
			note.target = this;
			obs.notifyObservers(note);
		}


		public function init():void
		{
			_isInited = true;
		}

		public function destroy():void
		{
			_isInited = false;
		}

		public function get isInited():Boolean
		{
			return _isInited;
		}
	}

}