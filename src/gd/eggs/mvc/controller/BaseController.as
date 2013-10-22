package gd.eggs.mvc.controller
{

	import gd.eggs.observer.IObservable;
	import gd.eggs.observer.IObserver;
	import gd.eggs.observer.Notification;
	import gd.eggs.observer.Observer;

	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;

	import gd.eggs.util.IInitialize;


	/**
	 * Базовый класс контроллера
	 * @author Dukobpa3
	 */
	public class BaseController extends EventDispatcher implements IObserver, IObservable, IInitialize
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
		 * Подписка на нужные оповещения
		 * @return
		 */
		public function listNotifications():Array
		{
			return [];
		}

		/**
		 * Обработка оповещения note
		 * @param    note
		 */
		public function update(note:Notification):void
		{

		}

		/**
		 * Отправка оповещения note
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