package gd.eggs.texturepacker
{
	
	import flash.geom.Rectangle;

	/**
	 * Класс кучкует тайлы на один лист, размещая их компактно.
	 * @author Dukobpa3
	 */
	public class AtlasNode
	{
		//=============================
		//	PARAMETERS
		//=============================
		/** Чилды ноды - две дочерних ноды, впринципе можно сделать и не массивом а просто нода1 и нода2 */
		private var _childs:Vector.<AtlasNode>;
		/** Картинка ноды */
		private var _data:Object;
		
		/** Прямоугольник ноды */
		private var _rect:Rectangle;
		
		//=============================
		//	CONSTRUCTOR, INIT
		//=============================
		/**
		 * Конструктор ноды, принимает параметры прямоугольника в который надо впихуевать картинку
		 * Дефолтные значения нужны для корневых нод. Создаем лист максимального размера и начинаем его заполнять.
		 * @param	x
		 * @param	y
		 * @param	width
		 * @param	height
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
		 * Вставляет в атлас "нечто" которое должно иметь width и height
		 * Вполне себе может обойтись даже Rectangle'ом или каким-то {width:xxx, height:xxx}
		 * Интерфейс запилить не выйдет, так что сорри
		 * Подошел бы IBitmapDrawable, но в нем нету ширины и высоты
		 * @param	data
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
				//TODO сделать адекватные ерроры
				if (this._data) return null; // если тут уже есть картинка - нафиг
				
				if (width > _rect.width || height > _rect.height) return null; // если картинка не влазит в доступные размеры - нафиг
				
				if (width == _rect.width && height == _rect.height) // Если картинка впихивается в упор в оставшееся место впихиваем ее
				{
					this._data = data;
					return this;
					//TODO запилить "закрытие" листа
					// но маловероятно что картинка прям так красиво впишется
					// потому надо придумать какие-то зазоры минимальные которые можно проигнорить
				}
				
				var dw:Number = _rect.width - width;
				var dh:Number = _rect.height - height;
				
				// обрабатываем оба варианта слита (высокий узкий прямоуголник/широкий низкий)
				// и пушатся две ноды с соответствующими настройками
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
				
				// всовываем в нулевую ноду
				return _childs[0].insert(data);
			}
			
		}
		
		//=============================
		//	ACCESSORS
		//=============================
		/** Прямоугольник тайла */
		public function get rect():Rectangle { return _rect; }
		
		/** "Картинка" тайла, которая может быть нихера не картинкой, 
		 * если вдруг захотим просто расположить прямоугольники к примеру */
		public function get data():Object { return _data; }
		
		/** Ширина/высота для окончательной упаковки листа */
		public function get width():Number { return _rect.width; }
		public function get height():Number { return _rect.height; }
		
	}
}