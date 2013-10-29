package gd.eggs.mvc.controller
{

	import gd.eggs.observer.IObservable;
	import gd.eggs.observer.IObserver;
	import gd.eggs.observer.Notification;
	import gd.eggs.observer.Observer;
	import gd.eggs.util.IInitialize;


	/**
	 * Базовый класс контроллера. Умеет слушать и слать нотификации в обсервер.
	 * @author Dukobpa3
	 */
	public class BaseController implements IObserver, IObservable, IInitialize
	{

		private var _isInited:Boolean;

		/**
		 * Синглтон обсервера
		 */
		private var obs:Observer;

		public function BaseController()
		{
			obs = Observer.getInstance();
			obs.registerObserver(this as IObserver);
		}

		/**
		 * @inheritDoc
		 */
		public function listNotifications():Array
		{
			return [];
		}

		/**
		 * @inheritDoc
		 */
		public function update(note:Notification):void
		{

		}

		/**
		 * @inheritDoc
		 */
		public function sendNotification(note:Notification):void
		{
			note.target = this;
			obs.notifyObservers(note);
		}

		/**
		 * @inheritDoc
		 */
		public function init():void
		{
			_isInited = true;
		}

		/**
		 * @inheritDoc
		 */
		public function destroy():void
		{
			_isInited = false;
		}

		/**
		 * @inheritDoc
		 */
		public function get isInited():Boolean
		{
			return _isInited;
		}
	}

}