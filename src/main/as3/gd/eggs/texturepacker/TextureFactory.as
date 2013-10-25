package gd.eggs.texturepacker
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;


	/**
	 * Фабрика тек�?тур. Кеширует новую тек�?туру из мувиклипа, потом ее же может выдать по запро�?у.
	 * Поддерживает групповое кеширование из хмл �?пи�?ка.
	 * @author Dukobpa3
	 */
	public class TextureFactory
	{
		//=============================
		//	PARAMETERS
		//{============================
		/** Един�?твенный �?кземпл�?р */
		private static var _instance:TextureFactory;

		/** Ма�?�?ив ли�?тов */
		private var _textures:Vector.<BitmapData> = new Vector.<BitmapData>();

		/** Словарь атла�?ов */
		private var _atlases:Object = { }; // {<animName>:BmdAtlas}

		/** Индек�? текущего неазполненного ли�?та тайлов */
		private var _currenSheet:int;
		/** Текуща�? ра�?кладка тайлов */
		private var _currentTiles:Array;
		/** Текущие тайлы */
		private var _currentImages:Array;
		/** Стартовый тайл текущей обрабатываемой анимации */
		private var _currentTile:int;
		/** Текуща�? нода */
		private var _currentNode:AtlasNode;
		//}
		//=============================
		//	CONSTRUCTOR, INIT
		//{============================
		/** Кон�?труктор. Синглтон, так что нефиг его дергать. */
		public function TextureFactory()
		{
			if (_instance) throw(new Error("TextureFactory is a Singleton. Don't Instantiate!"));
			_instance = this;

			_textures.push(new BitmapData(2048, 2048, true, 0x000000));
			_currenSheet = 0;
			_currentTiles = [];
			_currentImages = [];
			_currentNode = new AtlasNode();
		}

		/**
		 * Выдает екземпл�?р "фабрики тек�?тур"
		 * @return
		 */
		public static function getInstance():TextureFactory
		{
			return _instance ? _instance : new TextureFactory();
		}

		//}
		//=============================
		//	PUBLIC
		//{============================
		/**
		 * Создает тек�?турный атла�? из мувика в библиотеке (getChildByName()) и его же (атла�?) и возвращает
		 * �?втоматом �?кейлит до указанных размеров и �?охран�?ет уже �? измененными размерами
		 * @param    id им�? кла�?�?а мувика
		 * @param    scaleX
		 * @param    scaleY
		 * @return
		 */
		public function createTextureAtlas(id:String, scaleX:Number = 1, scaleY:Number = 1):Boolean
		{
			if (!_atlases[id])
				_atlases[id] = createTextureAtlasFromLibrary(id, scaleX, scaleY);

			return true;//getTextureAtlas(id);
		}

		/**
		 * Выдает тек�?турный атла�? из кеша
		 * @param    id им�? кла�?�?а мувика из библиотеки
		 * @return
		 */
		public function getTextureAtlas(id:String):TextureAtlas
		{
			if (!_atlases[id])
			{
				trace("MISSING TEXTURE: " + id);
				return null;
			}

			var texture:Texture = Texture.fromBitmapData(_atlases[id].bmd)
			var textureAtlas:TextureAtlas = new TextureAtlas(texture, _atlases[id].map);

			return textureAtlas;
		}

		/**
		 * Кеширует �?пи�?ок анимаций пакетом
		 * @param    list �?пи�?ок анимаций в формате XML.
		 *    <data>
		 *        <anim name="className" scaleX="0.5" scaleY="0.5" />
		 *    </data>
		 */
		public function bulkCreateAtlases(list:XML):void
		{
			for each(var anim:XML in list.anim)
			{
				createTextureAtlas(anim.@name, parseFloat(anim.@scaleX), parseFloat(anim.@scaleY));
				//TODO добавить ди�?патчи �?обытий о прогре�?�?е при групповой загрузке
			}
		}

		//}
		//=====================================================================
		// PRIVATE
		//=====================================================================
		/**
		 * Делает атла�? из кла�?�?а загруженной флешки
		 * @param    params
		 */
		private function createTextureAtlasFromLibrary(id:String, scaleX:Number, scaleY:Number):BmdAtlas
		{
			var clip:MovieClip = new (getDefinitionByName(id) as Class)();

			var framesArr:Array = drawTilesFromLibrary(clip, scaleX, scaleY);
			var finRect:Rectangle = framesArr.shift(); // в �?тарлинге у мувика у вех кадров одинаковый ректангл должен быть.

			_currentTile = _currentTiles.length;

			if (!pushTilesToSheet(framesArr))
			{
				_textures.push(new BitmapData(2048, 2048, true, 0x000000));
				_currenSheet++;
				_currentTiles = [];
				_currentImages = [];
				_currentTile = 0;
				_currentNode = new AtlasNode();

				pushTilesToSheet(framesArr)
			}

			drawTilesToSheet()

			var xmlMap:XML = <AtlasMap />
			xmlMap.@name = String(id);

			for (var i:int = 0; i < framesArr.length; i++)
			{
				var frame:Rectangle = framesArr[i].rect;
				var rect:Rectangle = _currentTiles[i + _currentTile].rect;

				var tileXml:XML = <SubTexture />

				tileXml.@name = String(id + '_' + toFixedString(String(i), 4));
				tileXml.@x = rect.x;
				tileXml.@y = rect.y;
				tileXml.@width = rect.width;
				tileXml.@height = rect.height;

				tileXml.@frameX = -frame.x;
				tileXml.@frameY = -frame.y;
				tileXml.@frameWidth = finRect.width;
				tileXml.@frameHeight = finRect.height;

				xmlMap.appendChild(tileXml);
			}

			var bmdAtlas:BmdAtlas = new BmdAtlas(_textures[_currenSheet], xmlMap);

			return bmdAtlas;
		}

		/**
		 * Создает ма�?�?ив ра�?тровых тайлов из анимации
		 * первым �?лементом ма�?�?ива идет ректангл анимашки
		 * (о�?обенно�?ть starling.display.MovieClip - в�?е фреймы �?того мувика должны быть одинакового размера)
		 * @param    clip
		 * @param    scaleX
		 * @param    scaleY
		 * @return
		 */
		private function drawTilesFromLibrary(clip:MovieClip, scaleX:Number, scaleY:Number):Array
		{
			var finRect:Rectangle = new Rectangle();
			var rect:Rectangle;
			var offset:int;
			var framesArr:Array = [finRect] // первым �?лементом пихаю ректангл, о�?тальные фремы. 
			//в ректангле мак�?имальные границы мувика по в�?ем кадрам.
			var frame:Frame;

			clip.scaleX = scaleX;
			clip.scaleY = scaleY;

			clip.gotoAndStop(1)

			for (var i:int = 0; i < clip.totalFrames; i++)
			{
				rect = clip.getBounds(clip);

				rect.x = rect.x * scaleX - 1;
				rect.y = rect.y * scaleY - 1;
				rect.width = rect.width * scaleX + 2;
				rect.height = rect.height * scaleY + 2;


				frame = new Frame(new BitmapData(rect.width, rect.height, true, 0x000000), rect);
				var m:Matrix = new Matrix();
				m.scale(scaleX, scaleY);
				m.translate(-rect.x, -rect.y);
				frame.data.draw(clip, m, null, null, null, true);

				if (rect.width > finRect.width) finRect.width = rect.width;
				if (rect.height > finRect.height) finRect.height = rect.height;

				framesArr.push(frame);
				_currentImages.push(frame);

				clip.nextFrame();
				makeAllChildrenNextFrame(clip);
			}

			return framesArr;
		}

		/**
		 * Проходит по в�?ем дет�?м и прокручивает на кадр �? указанным номером,
		 * нужно в проце�?�?е кешировани�?. Утилитна�? функци�?.
		 * @param    m
		 * @param    f
		 */
		private function makeAllChildrenNextFrame(m:MovieClip):void
		{
			for (var i:int = 0; i < m.numChildren; i++)
			{
				var c:* = m.getChildAt(i);
				if (c is MovieClip)
				{
					makeAllChildrenNextFrame(c);
					c.nextFrame();
				}
			}
		}

		/**
		 * Ра�?пихивает ма�?�?ив тайлов по ли�?ту
		 * @param    tiles
		 * @return
		 */
		private function pushTilesToSheet(tiles:Array, node:AtlasNode = null, nodesArr:Array = null):Boolean
		{
			node = node || _currentNode;
			nodesArr = nodesArr || _currentTiles;

			for (var i:int = 0; i < tiles.length; i++)
			{
				// пытаем�?�? в�?тавить картинку в атла�?
				var n:AtlasNode = node.insert(tiles[i].data || tiles[i]);
				if (n) // нам �?то удало�?ь
				{
					nodesArr.push(n); // �?охран�?ем обла�?ть в финальный ма�?�?ив
				}
				else // не влазит на текущий ли�?т
				{
					return false;
				}
			}

			return true;
		}

		/**
		 * Отри�?овывает �?убтек�?туры текущего тек�?турного атла�?а в ли�?т
		 */
		private function drawTilesToSheet():void
		{
			//Теперь нам о�?тало�?ь только отри�?овать в�?е картинки из _currentTiles[x].data в координаты _currentTiles[x].rect.
			var bmd:BitmapData = _textures[_currenSheet];
			bmd.lock();

			for (var i:int = _currentTile; i < _currentTiles.length; i++)
			{
				var m:Matrix = new Matrix();
				m.translate(_currentTiles[i].rect.x, _currentTiles[i].rect.y);
				bmd.draw(_currentTiles[i].data, m, null, null, null, true);
			}

			bmd.unlock();
		}

		/**
		 * Утилитка дл�? формировани�? �?троки из инта
		 * дополн�?ет нул�?ми вначало до указанного кол-ва знаков
		 * @param    str
		 * @param    num
		 * @return
		 */
		public static function toFixedString(str:String, num:int):String
		{
			while (str.length < num) str = "0" + str;

			return str;
		}

		/** Дл�? те�?та, потом убрать */
		public function get textures():Vector.<BitmapData>
		{ return _textures; }

	}
}

