package gd.eggs.util
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class GlobalTimer
	{
		//=====================================================================
		//      CONSTANTS
		//=====================================================================

		//=====================================================================
		//      PARAMETERS
		//=====================================================================
		private static var _instance:GlobalTimer;

		//-----------------------------
		//      Enterfrtame
		//-----------------------------
		private var _visualBus:Sprite;

		//-----------------------------
		//      Timer
		//-----------------------------
		private var _currentDate:Date;
		private var _timer:Timer;
		private var _synced:Boolean;

		//-----------------------------
		//      Callbacks
		//-----------------------------
		private var _timerCallBacks:Vector.<Function>;
		private var _frameCallBacks:Vector.<Function>;
		//=====================================================================
		//      CONSTRUCTOR, INIT
		//=====================================================================
		public function GlobalTimer()
		{
			if (_instance) throw new Error("singleton");

			_timer = new Timer(1000);
			_timerCallBacks = new Vector.<Function>();

			_visualBus = new Sprite();
			_frameCallBacks = new Vector.<Function>();
		}

		public static function getInstance():GlobalTimer
		{
			if (!_instance) _instance = new GlobalTimer();
			return _instance;
		}

		//=====================================================================
		//      PUBLIC
		//=====================================================================
		public static function updateDate(date:Date):void
		{
			if (!_instance._timer.hasEventListener(TimerEvent.TIMER))
			{
				_instance._timer.addEventListener(TimerEvent.TIMER, _instance.onTimer);
			}

			_instance._currentDate = date;
			_instance._timer.reset();
			_instance._timer.start();

			_instance._synced = true;
		}

		/**
		 * Добавить коллбек ентерфрейма
		 * @param       func function onTimer(date:Date):void {} // коллбек принимает текущую дату getTimer().
		 */
		public function addFrameCallback(func:Function):void
		{
			if (_frameCallBacks.indexOf(func) == -1)
			{
				_frameCallBacks.push(func);
			}

			if (!_visualBus.hasEventListener(Event.ENTER_FRAME))
			{
				// если не подписаны - подписаться на ентерфейм
				_visualBus.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}

		/**
		 * Убрать коллбек энтерфрейма
		 * @param       func
		 */
		public function removeFrameCallback(func:Function):void
		{
			if (_frameCallBacks.indexOf(func) != -1)
			{
				_frameCallBacks.splice(_frameCallBacks.indexOf(func), 1);
			}
			if (!_frameCallBacks.length && _visualBus.hasEventListener(Event.ENTER_FRAME))
			{
				_visualBus.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}

		/**
		 * Добавить коллбек таймера
		 * @param       func function onTimer(unixtime:int):void {} // коллбек принимает текущую дату сервера.
		 *              // текущую, которая установлена в таймере, а не в системеДля синхронизации с сервером.
		 */
		public function addTimerCallback(func:Function):void
		{
			if (_timerCallBacks.indexOf(func) == -1)
			{
				_timerCallBacks.push(func);
			}

			if (_synced && !_timer.hasEventListener(TimerEvent.TIMER))
			{
				_timer.addEventListener(TimerEvent.TIMER, onTimer);
				_timer.start();
			}
		}

		/**
		 * Убрать коллбек таймера
		 * @param       func
		 */
		public function removeTimerCallback(func:Function):void
		{
			if (_timerCallBacks.indexOf(func) != -1)
			{
				_timerCallBacks.splice(_timerCallBacks.indexOf(func), 1);
			}
			if (!_timerCallBacks.length && _timer.hasEventListener(TimerEvent.TIMER))
			{
				_timer.removeEventListener(TimerEvent.TIMER, onTimer);
				_timer.stop();
			}
		}

		//=====================================================================
		//      PRIVATE
		//=====================================================================

		//=====================================================================
		//      HANDLERS
		//=====================================================================
		private function onTimer(event:TimerEvent):void
		{
			if(!_currentDate)return;
			_currentDate.seconds ++;

			for (var i:int = 0 ; i < _timerCallBacks.length ; i ++)
			{
				_timerCallBacks[i](_currentDate);
			}
		}

		private function onEnterFrame(event:Event):void
		{
			for (var i:int = 0 ; i < _frameCallBacks.length ; i ++)
			{
				_frameCallBacks[i](getTimer());
			}
		}
		//=====================================================================
		//      ACCESSORS
		//=====================================================================
		public function get currentDate():Date { return _currentDate; }
	}

}