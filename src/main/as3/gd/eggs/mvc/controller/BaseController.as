package gd.eggs.mvc.controller
{

	import flash.events.EventDispatcher;

	import gd.eggs.util.IInitialize;


	/**
	 * Базовый класс контроллера. Умеет слушать и слать нотификации в обсервер.
	 * @author Dukobpa3
	 */
	public class BaseController implements IInitialize
	{
		/**
		 * Шина для передачи данных между контроллерами.
		 * Обсервер, но через EventDispatcher
		 * В каждом конкретном контроллере подписываемся на ивенты с этой шины и всё.
		 */
		protected static var _noteBus:EventDispatcher;

		private var _isInited:Boolean;


		public function BaseController()
		{
			_noteBus = _noteBus || new EventDispatcher();
		}

		/**
		 *
		 * @param type
		 * @param data
		 */
		protected function sendNotification(type:String, data:Object = null):void
		{
			_noteBus.dispatchEvent(new Notification(type, data, this));
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
		public function get isInited():Boolean { return _isInited; }
	}

}