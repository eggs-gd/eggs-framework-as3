package gd.eggs.mvc.view
{
	import gd.eggs.observer.IObservable;
	import gd.eggs.observer.Notification;
	import gd.eggs.observer.Observer;


	/**
	 * Класс медиатора.
	 * Умеет регистрировать в себе вьюхи, подписываться на их изменения.
	 * Пересылать эти изменения в виде нотификаций в обсервер.
	 * В идеале не должен содержать логики и работы с моделями.
	 * @author Dukobpa3
	 */
	public class BaseMediator implements IObservable
	{
		//=====================================================================
		//	CONSTANTS
		//=====================================================================

		//=====================================================================
		//	PARAMETERS
		//=====================================================================
		private var _views:Vector.<BaseView>;

		//=====================================================================
		//	CONSTRUCTOR, INIT
		//=====================================================================
		public function BaseMediator()
		{
			_views = new Vector.<BaseView>();
		}

		//=====================================================================
		//	PUBLIC
		//=====================================================================
		/**
		 * @inheritDoc
		 */
		public function sendNotification(note:Notification):void
		{
			note.target = this;
			Observer.getInstance().notifyObservers(note);
		}

		/**
		 * Добавляет в свой скоуп вью, подписывается на нее.
		 * @param view ссылка на вью.
		 */
		public function injectView(view:BaseView):void
		{
			_views.push(view);
			view.addEventListener(ViewEvent.CHANGE, onViewChange);
		}

		//=====================================================================
		//	PRIVATE
		//=====================================================================

		//=====================================================================
		//	HANDLERS
		//=====================================================================
		/**
		 * Обработка событий от вью. Метод обязан быть переопределен в наследниках.
		 * @param event
		 */
		protected function onViewChange(event:ViewEvent):void
		{
			throw new Error("need To override");
		}

		//=====================================================================
		//	ACCESSORS
		//=====================================================================
	}

}