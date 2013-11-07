package gd.eggs.animationcache
{


	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;


	public class Animation extends Sprite
	{
		private var _bitmap:Bitmap;
		private var _clip:MovieClip;
		private var _frames:Vector.<AnimationFrame>;
		private var _currentFrame:Number = 1;
		private var _playing:Boolean = false;

		private var _id:String;
		private var _scaleX:Number;
		private var _scaleY:Number;

		//=====================================================================
		// CONSTRUCTOR
		//=====================================================================
		public function Animation()
		{
			_bitmap = new Bitmap(null, "auto", true);
			_bitmap.smoothing = true;
			addChild(_bitmap);
			_frames = new Vector.<AnimationFrame>();
		}

		//=====================================================================
		// CONSTRUCTOR
		//=====================================================================
		/**
		 * Делает анимаци из класса загруженной флешки
		 * @param scaleX
		 * @param scaleY
		 * @param name
		 */
		public function buildCacheFromLibrary(name:String = "", scaleX:Number = 1, scaleY:Number = 1):void
		{
			_id = name;
			_scaleX = scaleX;
			_scaleY = scaleY;

			var cl:Class = getDefinitionByName(_id) as Class;
			// Возможно лучше выкидывать ошибку, но тогда нет смысла в проверке, так как ошибка и так будет.
			// С таким подходом мы просто получим пустую анимашку без кадров. Снаружи можно будет проверить.
			if (!cl) return;

			_clip = new cl();
			_clip.gotoAndStop(1);

			var r:Rectangle;

			for (var i:int = 0; i < _clip.totalFrames; i++)
			{
				r = _clip.getBounds(_clip);

				var bitmapData:BitmapData = new BitmapData(r.width, r.height, true, 0x000000);
				var m:Matrix = new Matrix();
				m.scale(_scaleX, _scaleY);
				m.translate(Math.ceil(-r.x + 1), Math.ceil(-r.y + 1));
				bitmapData.draw(_clip, m, null, null, null, true);

				_frames.push(new AnimationFrame(bitmapData, r.x, r.y));

				makeAllChildrenNextFrame(_clip);
			}
		}

		/**
		 * Проигрывает анимацию циклически
		 */
		public function play():void
		{
			_playing = true;
			addEventListener(Event.ENTER_FRAME, enterFrame, false, 0, true);
		}

		/**
		 * Стоп анимации
		 */
		public function stop():void
		{
			_playing = false;
			removeEventListener(Event.ENTER_FRAME, enterFrame)
		}

		/**
		 * Переход к кадру и остановка
		 * @param    frame
		 */
		public function gotoAndStop(frame:int):void
		{
			goto(frame);
			stop();
		}

		/**
		 * Переход к кадру и проигрывание
		 * @param    frame
		 */
		public function gotoAndPlay(frame:int):void
		{
			goto(frame);
			play();
		}

		/**
		 * Переход к случайному кадру и проигрывание
		 */
		public function gotoAndPlayRandomFrame():void
		{
			gotoAndPlay(int(Math.random() * totalFrames));
		}

		/**
		 * Переход на след кадр
		 */
		public function nextFrame():void
		{
			goto(_currentFrame + 1);
		}

		/**
		 * Переход на предыдущий кадр
		 */
		public function prevFrame():void
		{
			goto(_currentFrame - 1);
		}

		/**
		 * Перезаполняет содержимое кеша заново.
		 */
		public function update():void
		{
			stop();
			_frames = new Vector.<AnimationFrame>();
			buildCacheFromLibrary();
		}

		//=====================================================================
		// PRIVATE
		//=====================================================================
		/**
		 * Переход к кадру
		 * @param    num
		 */
		private function goto(num:int):void
		{
			if (num > totalFrames) num = num % totalFrames;
			if (!frame) num = totalFrames;

			_currentFrame = num;

			var frame:AnimationFrame = _frames[_currentFrame - 1];
			_bitmap.bitmapData = frame.bitmapData;
			_bitmap.smoothing = true;

			_bitmap.x = frame.x;
			_bitmap.y = frame.y;
		}

		/**
		 * Проходит по всем детям и прокручивает на кадр с указанным номером,
		 * нужно в процессе кеширования. Утилитная функция.
		 * @param    m
		 */
		private function makeAllChildrenNextFrame(m:MovieClip):void
		{
			m.nextFrame();

			for (var i:int = 0; i < m.numChildren; i++)
			{
				var c:* = m.getChildAt(i);
				if (c is MovieClip)
				{
					makeAllChildrenNextFrame(c);
				}
			}
		}

		//=====================================================================
		// HANDLERS
		//=====================================================================
		/**
		 * Без комментариев (;
		 * @param    e
		 */
		private function enterFrame(e:Event = null):void
		{
			nextFrame();

			if (_currentFrame >= totalFrames)
			{
				dispatchEvent(new Event(Event.COMPLETE))
			}
		}

		//=====================================================================
		// ACCESSORS
		//=====================================================================
		/** Проигрывается ли флешка в данный момент */
		public function get playing():Boolean { return _playing; }

		/** Полное кол-во кадров */
		public function get totalFrames():int { return _frames.length; }

		/** Текущий кадр */
		public function get currentFrame():int { return _currentFrame; }

		/** Масив(вектор) фреймов, нужен для клонирования */
		internal function get frames():Vector.<AnimationFrame> { return _frames; }

		internal function set frames(value:Vector.<AnimationFrame>):void { _frames = value; }

		/** исходный мувиклип, нужен для клонирования */
		internal function get clip():MovieClip { return _clip; }
		internal function set clip(value:MovieClip):void { _clip = value; }


	}
}
