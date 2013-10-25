﻿package gd.eggs.animationcache
{
	import flash.events.EventDispatcher;


	/**
	 * Кла�?�? кеширует векторные анимации в ра�?тр.
	 */
	public class AnimationCache extends EventDispatcher
	{
		public var replaceExisting:Boolean = false;

		private var animations:Object = {};

		private static var instance:AnimationCache;

		//=====================================================================
		// CONSTRUCTOR
		//=====================================================================
		public function AnimationCache()
		{
			if (instance) throw(new Error("AnimationCache is a Singleton. Don't Instantiate!"));
			instance = this;
		}

		//=====================================================================
		// PUBLIC
		//=====================================================================
		/**
		 * Выдает ин�?тан�? библиотеки
		 * @return
		 */
		public static function getInstance():AnimationCache
		{
			return instance ? instance : new AnimationCache();
		}

		/**
		 * Кеширует анимацию �? заданным именем кла�?�?а мувика и �?кейлом
		 * (ра�?тровые тайлы будут уже указанного размера)
		 * @param    id
		 * @param    scaleX
		 * @param    scaleY
		 * @return
		 */
		public function cacheAnimation(id:String, scaleX:Number, scaleY:Number):Animation
		{
			// TODO придумать что-то чтобы можно было кешировать одну и ту же анимацию �? разными �?кейлами
			var animation:Animation;
			if (!animations[id] || replaceExisting)
			{
				animation = new Animation();
				animation.buildCacheFromLibrary(id, scaleX, scaleY);
				animations[id] = animation;
			}
			else
			{
				animation = animations[id]
			}

			return animation;
		}

		/**
		 * Выдает копию анимации из библиотеки �? указанным именем
		 * @param    id
		 * @return
		 */
		public function getAnimation(id:String):Animation
		{
			if (!animations[id])
			{
				trace("MISSING ANIMATION :" + id);
				return null;
			}

			var animation:Animation = new Animation();
			animation.frames = animations[id].frames;
			animation.clip = animations[id].clip;
			animation.gotoAndPlay(1);

			return animation;
		}

		/**
		 * Кеширует �?пи�?ок анимаций пакетом
		 * @param    list �?пи�?ок анимаций в формате XML.
		 *    <data>
		 *        <anim name="className" scaleX="0.5" scaleY="0.5" />
		 *    </data>
		 */
		public function addToBulkCache(list:XML):void
		{
			for each(var anim:XML in list.anim)
			{
				cacheAnimation(anim.@name, parseFloat(anim.@scaleX) || 1, parseFloat(anim.@scaleY) || 1);
				//TODO добавить ди�?патчи �?обытий о прогре�?�?е при групповой загрузке
			}
		}
	}
}

