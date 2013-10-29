package gd.eggs.customanim
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	import gd.eggs.util.GlobalTimer;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class AnimationManager extends EventDispatcher
	{
		//=====================================================================
		//      CONSTANTS
		//=====================================================================

		//=====================================================================
		//      PARAMETERS
		//=====================================================================
		private static var _instance:AnimationManager;

		private static var _globalTimer:GlobalTimer = GlobalTimer.getInstance();

		private static var _activeItems:Vector.<AnimationParams> = new Vector.<AnimationParams>();
		private static var _activeQueues:Vector.<AnimationQueueParams> = new Vector.<AnimationQueueParams>();

		private static var _itemsById:Dictionary = new Dictionary();

		private static var _pause:Boolean;
		//=====================================================================
		//      CONSTRUCTOR, INIT
		//=====================================================================
		public function AnimationManager()
		{

		}

		//=====================================================================
		//      PUBLIC
		//=====================================================================
		//-----------------------------
		//      Single anim
		//-----------------------------
		public static function startAnimation(params:AnimationParams, id:Object):void
		{
			if (_itemsById[id])
			{
				_activeItems.splice(_activeItems.indexOf(params), 1);
				delete _itemsById[id];
			}

			params.mc.stop();
			_activeItems.push(params);
			_itemsById[id] = params;

			_globalTimer.addFrameCallback(frameUpdate);
		}

		public static function stopAnimation(id:Object):void
		{
			var params:AnimationParams = _itemsById[id];
			if (!params) return;

			params.mc.stop();

			_activeItems.splice(_activeItems.indexOf(params), 1);
			delete _itemsById[id];

			if (!_activeItems.length && _activeQueues.length) _globalTimer.removeFrameCallback(frameUpdate);
		}

		//-----------------------------
		//      Queue anim
		//-----------------------------
		public static function startQueue(params:AnimationQueueParams, id:String):void
		{
			if (_itemsById[id])
			{
				_activeQueues.splice(_activeQueues.indexOf(params), 1);
				delete _itemsById[id];
			}

			_activeQueues.push(params);
			_itemsById[id] = params;
			_globalTimer.addFrameCallback(frameUpdate);
		}

		public static function stopQueue(id:String):void
		{
			var params:AnimationQueueParams = _itemsById[id];

			_activeQueues.splice(_activeQueues.indexOf(params), 1);
			delete _itemsById[id];

			if (!_activeItems.length && !_activeQueues.length) _globalTimer.removeFrameCallback(frameUpdate);
		}

		//-----------------------------
		//      All
		//-----------------------------
		public static function pauseAll():void
		{
			_pause = true;
			_globalTimer.removeFrameCallback(frameUpdate);
			for each(var param:AnimationParams in _activeItems)
			{
				param.mc.stop();
			}
		}

		public static function resumeAll():void
		{
			_globalTimer.addFrameCallback(frameUpdate);
			_pause = false;
		}

		//=====================================================================
		//      PRIVATE
		//=====================================================================
		private static function frameUpdate(date:int):void
		{
			for each (var params:AnimationParams in _activeItems)
			{
				params.play(date);

				// если анимация доиграла до конца
				if (params.ended) stopAnimation(params);
			}

			for each (var queue:AnimationQueueParams in _activeQueues)
			{
				// предполагается что очередь всегда зациклена и без пауз
				// потому не выебуемся
				queue.play(date);
			}
		}

		//=====================================================================
		//      HANDLERS
		//=====================================================================

		//=====================================================================
		//      ACCESSORS
		//=====================================================================
	}

}