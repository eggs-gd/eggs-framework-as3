package gd.eggs.mvc.view
{
	import gd.eggs.observer.IObservable;
	import gd.eggs.observer.Notification;
	import gd.eggs.observer.Observer;
	

	/**
	 * ...
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
		public function sendNotification(note:Notification):void 
		{
			note.target = this;
			Observer.getInstance().notifyObservers(note);
		}
		
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
		protected function onViewChange(event:ViewEvent):void 
		{
			throw new Error("need To override");
		}
		//=====================================================================
		//	ACCESSORS
		//=====================================================================
	}

}