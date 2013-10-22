package gd.eggs.util
{
	import aze.motion.eaze;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;

	/**
	 * ...
	 * @author Dukobpa3
	 */
	[Event(name="complete", type="flash.events.Event")]
	public class CooldownAnim extends Sprite
	{
		//=====================================================================
		//	CONSTANTS
		//=====================================================================

		//=====================================================================
		//	PARAMETERS
		//=====================================================================
		//private var _angle:Number;
		private var _shape:Shape;
		private var _start:Point;
		private var _point:Point;
		private var _tf:TextField;
		private var _timer:int;
		private var _radius:int;
		
		//=====================================================================
		//	CONSTRUCTOR, INIT
		//=====================================================================
		public function CooldownAnim(radius:int)
		{
			_radius = radius;
			_start = new Point(0, -radius);
			_point = new Point();
			_shape = new Shape();
			_shape.visible = false;
			
			addChild(_shape);
			
			_tf = new TextField();
			addChild(_tf);
			
			this.mouseChildren = this.mouseEnabled = false;
		}

		//=====================================================================
		//	PUBLIC
		//=====================================================================
		public function play(time:int):void
		{
			_shape.visible = true;
			_point.x = 0;
			_point.y = -_radius;
			_shape.graphics.clear();
			//_shape.graphics.lineStyle(4, 0x000000, 0.3);
			_shape.graphics.beginFill(0x000000, 0.8);
			_shape.graphics.moveTo(0, 0);
			_shape.graphics.lineTo(_start.x, _start.y);
			eaze(_point)
				.to(time, 
					{ x: [ _radius, _radius, -_radius, -_radius, 0], 
					y: [ -_radius, _radius, _radius, -_radius, -_radius] })
				.onUpdate(animUpdate)
				.onComplete(animComplete);

			timer = time;
			eaze(this).to(time, { timer:0 } );
		}
		
		//=====================================================================
		//	PRIVATE
		//=====================================================================
		private function animUpdate():void
		{
			_shape.graphics.lineTo(_point.x, _point.y);
			_shape.graphics.lineTo(0, 0);
			_shape.graphics.lineTo(_point.x, _point.y);

			_tf.text = timer.toString();
		}

		private function animComplete():void
		{
			_shape.visible = false;
			_tf.visible = false;
			dispatchEvent(new Event(Event.COMPLETE))
		}
		//=====================================================================
		//	HANDLERS
		//=====================================================================

		//=====================================================================
		//	ACCESSORS
		//=====================================================================
		public function get animNow():Boolean { return _shape.visible; }

		public function get timer():int { return _timer; }

		public function set timer(value:int):void { _timer = value; }
	}

}