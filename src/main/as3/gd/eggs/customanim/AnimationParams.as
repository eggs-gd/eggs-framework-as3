package gd.eggs.customanim
{
	import flash.display.MovieClip;
	import flash.utils.setTimeout;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class AnimationParams
	{
		//=====================================================================
		//      CONSTANTS
		//=====================================================================

		//=====================================================================
		//      PARAMETERS
		//=====================================================================
		private var _mc:MovieClip;
		private var _loop:Boolean;
		private var _loopCount:int;
		private var _loopDelay:int;
		private var _frameRate:int;

		private var _prevTime:int;
		private var _delta:int;

		private var _frameTime:int;

		private var _pause:Boolean;
		private var _justReseted:Boolean;

		private var _currentLoop:int;

		private var _ended:Boolean;
		//=====================================================================
		//      CONSTRUCTOR, INIT
		//=====================================================================
		/**
		 * Добавляет анимацию.
		 * @param    mc - ссылка на клип
		 * @param    loop - Нужно ли зацикливание анимации.
		 * @param    loopCount - Количество повторений за один цикл
		 * @param    loopDelay - Интервал между циклами повторений
		 * @param    frameRate - Скорость анимации
		 */
		public function AnimationParams(mc:MovieClip, loop:Boolean = true, loopCount:int = 1, loopDelay:int = -1, frameRate:int = 18)
		{
			_mc = mc;
			_loop = loop;
			_loopCount = loopCount;
			_loopDelay = loopDelay;
			_frameRate = frameRate;

			_frameTime = 1000 / frameRate;

			reset();
		}

		//=====================================================================
		//      PUBLIC
		//=====================================================================
		public function play(date:int):void
		{
			if (_prevTime == -1)
			{
				_prevTime = date;
			}

			if (_pause) return;

			_delta += date - _prevTime;
			_prevTime = date;

			while (_delta > _frameTime)
			{
				if (mc.currentFrame == mc.totalFrames)
				{
					mc.gotoAndStop(1);
					_currentLoop++;
				}
				mc.nextFrame();
				_delta -= _frameTime;
			}

			if (_currentLoop >= _loopCount)
			{
				pause = true;
				if (_loopDelay != -1) setTimeout(unPause, _loopDelay);
				else _ended = true;
			}
		}

		public function reset():void
		{
			_currentLoop = 0;
			_prevTime = -1;
			_delta = 0;
			_justReseted = false;
			_pause = false;
			_ended = false;
		}

		public function isEqual(params:AnimationParams):Boolean
		{
			var result:Boolean =
					(
							_mc == params._mc
									&& _loop == params._loop
									&& _loopCount == params._loopCount
									&& _loopDelay == params._loopDelay
									&& _frameRate == params._frameRate
							);
			return result;
		}

		//=====================================================================
		//      PRIVATE
		//=====================================================================
		private function unPause():void
		{
			pause = false;
		}

		//=====================================================================
		//      HANDLERS
		//=====================================================================

		//=====================================================================
		//      ACCESSORS
		//=====================================================================
		public function get mc():MovieClip { return _mc; }

		public function get pause():Boolean { return _pause; }

		public function set pause(value:Boolean):void {
			_justReseted = (_pause == true && value == false);

			if (_justReseted) reset();

			_pause = value;
		}

		public function get ended():Boolean { return _ended; }
	}

}