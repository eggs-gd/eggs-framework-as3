package gd.eggs.texturepacker
{

	import flash.geom.Rectangle;


	/**
	 * Кла�?�? кучкует тайлы на один ли�?т, размеща�? их компактно.
	 * @author Dukobpa3
	 */
	public class AtlasNode
	{
		//=============================
		//	PARAMETERS
		//=============================
		/** Чилды ноды - две дочерних ноды, впринципе можно �?делать и не ма�?�?ивом а про�?то нода1 и нода2 */
		private var _childs:Vector.<AtlasNode>;
		/** Картинка ноды */
		private var _data:Object;

		/** Пр�?моугольник ноды */
		private var _rect:Rectangle;

		//=============================
		//	CONSTRUCTOR, INIT
		//=============================
		/**
		 * Кон�?труктор ноды, принимает параметры пр�?моугольника в который надо впихуевать картинку
		 * Дефолтные значени�? нужны дл�? корневых нод. Создаем ли�?т мак�?имального размера и начинаем его заполн�?ть.
		 * @param    x
		 * @param    y
		 * @param    width
		 * @param    height
		 */
		public function AtlasNode(x:Number = 0, y:Number = 0, width:Number = 1024, height:Number = 1024)
		{
			_childs = new Vector.<AtlasNode>();
			_rect = new Rectangle(x, y, width, height);
			_data = null;
		}

		//=============================
		//	PUBLIC
		//=============================
		/**
		 * В�?тавл�?ет в атла�? "нечто" которое должно иметь width и height
		 * Вполне �?ебе может обойти�?ь даже Rectangle'ом или каким-то {width:xxx, height:xxx}
		 * Интерфей�? запилить не выйдет, так что �?орри
		 * Подошел бы IBitmapDrawable, но в нем нету ширины и вы�?оты
		 * @param    data
		 * @return
		 */
		public function insert(data:Object):AtlasNode
		{
			var width:Number = data.width;
			var height:Number = data.height;

			if (_childs.length > 0)
			{
				var newNode:AtlasNode = _childs[0].insert(data);
				if (newNode) return newNode;

				return _childs[1].insert(data);
			}
			else
			{
				//TODO �?делать адекватные ерроры
				if (this._data) return null; // е�?ли тут уже е�?ть картинка - нафиг

				if (width > _rect.width || height > _rect.height) return null; // е�?ли картинка не влазит в до�?тупные размеры - нафиг

				if (width == _rect.width && height == _rect.height) // Е�?ли картинка впихивает�?�? в упор в о�?тавшее�?�? ме�?то впихиваем ее
				{
					this._data = data;
					return this;
					//TODO запилить "закрытие" ли�?та
					// но маловеро�?тно что картинка пр�?м так кра�?иво впишет�?�?
					// потому надо придумать какие-то зазоры минимальные которые можно проигнорить
				}

				var dw:Number = _rect.width - width;
				var dh:Number = _rect.height - height;

				// обрабатываем оба варианта �?лита (вы�?окий узкий пр�?моуголник/широкий низкий)
				// и пушат�?�? две ноды �? �?оответ�?твующими на�?тройками
				if (dw > dh)
				{
					_childs.push(new AtlasNode(_rect.left, _rect.top, width, _rect.height));
					_childs.push(new AtlasNode(_rect.left + width, _rect.top, _rect.width - width, _rect.height));
				}
				else
				{
					_childs.push(new AtlasNode(_rect.left, _rect.top, _rect.width, height));
					_childs.push(new AtlasNode(_rect.left, _rect.top + height, _rect.width, _rect.height - height));
				}

				// в�?овываем в нулевую ноду
				return _childs[0].insert(data);
			}

		}

		//=============================
		//	ACCESSORS
		//=============================
		/** Пр�?моугольник тайла */
		public function get rect():Rectangle
		{ return _rect; }

		/** "Картинка" тайла, котора�? может быть нихера не картинкой,
		 * е�?ли вдруг захотим про�?то ра�?положить пр�?моугольники к примеру */
		public function get data():Object
		{ return _data; }

		/** Ширина/вы�?ота дл�? окончательной упаковки ли�?та */
		public function get width():Number
		{ return _rect.width; }

		public function get height():Number { return _rect.height; }

	}
}