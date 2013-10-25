package gd.eggs.mvc.view
{
	import flash.events.Event;


	/**
	 * Базовый кла�?�? �?обыти�?, от�?ылаемого пред�?тавлением
	 * @author Dukobpa3
	 */
	public class ViewEvent extends Event
	{
		/**
		 * О�?новное �?обытие изменени�? модели
		 * тип �?обыти�? указывает�?�? в subType
		 */
		public static const CHANGE:String = "viewChange";

		private var _subType:String;
		private var _data:Object;

		/**
		 * Создает новое �?обытие вьюхи
		 * @param    type - тип (во�?новном ViewEvent.CHANGE)
		 * @param    subType - подтип - можно указывать любой удобный.
		 * @param    data - данные передаваемые �? �?обытием.
		 * @param    bubbles
		 * @param    cancelable
		 */
		public function ViewEvent(type:String, subType:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_subType = subType;
			_data = data;

			super(type, bubbles, cancelable);
		}

		/**
		 * Тип �?обыти�? от пред�?тавлени�?
		 */
		public function get subType():String
		{ return _subType; }

		/**
		 * Данные отправл�?емые вме�?те �? �?обытием
		 */
		public function get data():Object
		{ return _data;}

	}

}