package gd.eggs.customanim
{

	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class AnimationQueueParams
	{

		//=====================================================================
		//      CONSTANTS
		//=====================================================================

		//=====================================================================
		//      PARAMETERS
		//=====================================================================
		private var _animations:Vector.<AnimationParams>;
		private var _currAnim:int;
		//=====================================================================
		//      CONSTRUCTOR, INIT
		//=====================================================================
		public function AnimationQueueParams()
		{
			_currAnim = -1;
			_animations = new Vector.<AnimationParams>();
		}

		//=====================================================================
		//      PUBLIC
		//=====================================================================
		public function addAnimation(anim:AnimationParams):void
		{
			_animations.push(anim);
		}

		public function play(date:int):void
		{
			if (_currAnim == -1) _currAnim = 0;

			_animations[_currAnim].play(date);
			if (!_animations[_currAnim].mc.visible) _animations[_currAnim].mc.visible = true;

			if (_animations[_currAnim].ended)
			{
				_animations[_currAnim].reset();
				_animations[_currAnim].mc.visible = false;

				_currAnim++;
				if (_currAnim >= _animations.length - 1) _currAnim = 0;

				_animations[_currAnim].mc.visible = true;
			}
		}

		public function isEqual(params:AnimationQueueParams):Boolean
		{
			//var result:Boolean = true;
			//
			//for (var i:int = 0 ; i <  item:AnimationParams in _animations)
			//{
			//
			//}
			return false;
		}

		//=====================================================================
		//      PRIVATE
		//=====================================================================

		//=====================================================================
		//      HANDLERS
		//=====================================================================

		//=====================================================================
		//      ACCESSORS
		//=====================================================================
	}

}