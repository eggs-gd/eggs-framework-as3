package gd.eggs.hint
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Dictionary;
	import flash.utils.Timer;


	/**
	 * Статический класс хинта. Можно навесить на любой интеракив обжект, поддерживает скины.
	 * Авторесайзится под контент.
	 * Косяков нету:)
	 * Не нравится что каждый раз пересоздается таймер, поидее можно просто стопать ресетать и стартовать заново. Потом перепишу.
	 * пример использования:
	 * Hint.init(_hintContainer, new hint_bg());
	 * Hint.addItem(_client, '<font face="Myriad Pro" size="20"><p align="center"><b>Some text</b></p></font>');
	 * Hint.addItem(_client2, new AnimationMcFromLibrary());
	 * @author Dukobpa3
	 */
	public class Hint
	{
		//=====================================================================
		//	PARAMETERS
		//=====================================================================
		private static var _host:DisplayObjectContainer; // контейнер всей системы

		//-----------------------------
		//	Graphics
		//-----------------------------
		private static var _hint:Sprite; // контейнер всего хинта
		private static var _hintBgCont:Sprite; // Добавлялся для удобного управления балуном и стрелочкой, пока не буду выпиливать.
		private static var _bg:DisplayObject; // Бек, любой дисплейобжект который умеет ресайзиться.
		private static var _dataCont:Sprite; // контейнер контента
		private static var _hintFld:TextField; // текстовое поле для текстовых хинтов

		//-----------------------------
		//	System
		//-----------------------------
		private static var _items:Dictionary; // регистратор хинтов {item:hintData}
		private static var _timer:Timer; // таймер задержки показа
		private static var _currentItem:InteractiveObject; // Текущий отображаемый хинт, нужно фиксировать для адекватной работы с мышой
		private static var _currentHint:Object; // текущий отображаемый хинт { delay:delay, data:data, move:move } - опять же для мыши

		//=====================================================================
		//	CONSTRUCTOR, INIT
		//=====================================================================
		/**
		 * Статик класс, конструктора нима:)
		 * До первого использования нужно юзать инит.
		 */
		public function Hint()
		{
			throw new Error("Static class");
		}

		//=====================================================================
		//	PUBLIC
		//=====================================================================
		/**
		 * инициализация
		 * @param    host слой хинта. Самый верхний в системе
		 * @param    bg бек
		 */
		public static function init(host:DisplayObjectContainer, bg:DisplayObject, embedFonts:Boolean = true):void
		{
			_host = host;

			_items = new Dictionary();

			_hint = new Sprite();
			_hint.mouseChildren = _hint.mouseEnabled = false;

			_bg = bg;
			_hintBgCont = new Sprite();
			_hintBgCont.addChild(_bg);

			_hintFld = new TextField();
			_hintFld.mouseEnabled = false;
			_hintFld.autoSize = TextFieldAutoSize.LEFT;
			_hintFld.multiline = true;
			_hintFld.wordWrap = true;
			_hintFld.embedFonts = embedFonts;

			_dataCont = new Sprite();
			//_dataCont.x = _dataCont.y = 10;

			_hint.addChild(_hintBgCont);
			_hint.addChild(_dataCont);
		}

		/**
		 * Реги�?трируем хинт в системе.
		 * @param    item объект на котором должен появляться хинт (после регистрации его можно двигать, хинт поймет и будет рисоваться правильно в новых координатах)
		 * @param    data строка либо DisplayObject контента хинта.
		 * @param    delay задержка в секундах до появления хинта после наведения мыши
		 * @param    move двигать ли хинт при перемещении мышки над объектом. Если фолс то появится в точке наведения и пропадет когда убрал мышь.
		 */
		public static function addItem(item:InteractiveObject, data:Object, delay:Number = 0.2, move:Boolean = true):void
		{
			_items[item] = { delay: delay, data: data, move: move };
			item.addEventListener(MouseEvent.ROLL_OVER, onItemOver);
			item.addEventListener(MouseEvent.ROLL_OUT, onItemOut);
			item.addEventListener(MouseEvent.CLICK, onItemClick);
		}

		/**
		 * Удаляет хинт. Ваш КЭП.
		 * @param    item
		 */
		public static function removeItem(item:InteractiveObject):void
		{
			if (_items[item]) delete _items[item];
			item.removeEventListener(MouseEvent.ROLL_OVER, onItemOver);
			item.removeEventListener(MouseEvent.ROLL_OUT, onItemOut);
			item.removeEventListener(MouseEvent.CLICK, onItemClick);
			item.removeEventListener(MouseEvent.MOUSE_MOVE, onItemMove);
		}

		//=====================================================================
		//	PRIVATE
		//=====================================================================
		/**
		 * Обновляет яодержимое хинта
		 */
		private static function updateHint():void
		{
			while (_dataCont.numChildren) _dataCont.removeChildAt(0);
			if (!_currentHint) return;

			if (_currentHint.data is String)
			{
				_hintFld.text = "";
				_dataCont.addChild(_hintFld);
				_hintFld.width = 160;
				_hintFld.htmlText = _currentHint.data as String;

				_bg.width = int(_hintFld.width) + 20;
				_bg.height = int(_hintFld.height) + 20;
			}
			else if (_currentHint.data is DisplayObject)
			{
				var DO:DisplayObject = _currentHint.data as DisplayObject;
				_dataCont.addChild(DO);

				_bg.width = int(DO.width) + 20;
				_bg.height = int(DO.height) + 20;
			}
			else
			{
				throw new Error("�?е поддерживаемый тип данных, и�?пользуйте String или DisplayObject");
			}
		}

		/**
		 * Обновляет позицию хинта
		 */
		private static function setPosition():void
		{
			_hint.x = int(_host.mouseX - _hint.width * 0.5);
			_hint.y = int(_host.mouseY - _hint.height - 4);

			var stage:Stage = _host.stage;
			if (!stage) return;

			if (stage.mouseX - _hint.width * 0.5 < 0) // е�?ли вылазит влево за екран
			{
				_hint.x = 5;
			}
			else if (stage.mouseX + _hint.width * 0.5 > stage.stageWidth) // е�?ли вылазит вправо за екран
			{
				_hint.x = int(stage.stageWidth - _hint.width - 5);
			}

			if (stage.mouseY - _hint.height < 0) // е�?ли вылазит наверх
			{
				_hint.y = 5;
			}
		}

		//=====================================================================
		//	HANDLERS
		//=====================================================================
		/**
		 * При клике на итем - прячем хинт
		 * @param    e
		 */
		private static function onItemClick(e:MouseEvent):void
		{
			if (_currentItem)
			{
				_currentItem.removeEventListener(MouseEvent.MOUSE_MOVE, onItemMove);
				_currentItem = null;
			}

			if (_timer)
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerOver);
				_timer.reset();
				_timer = null;
			}

			if (_host.contains(_hint)) _host.removeChild(_hint);
		}

		/**
		 * Обновление по движению мышки над итемом. Двигает хинт за мышкой.
		 * @param    e
		 */
		private static function onItemMove(e:MouseEvent):void
		{
			setPosition();
		}

		/**
		 * Убираем хинт когда мышка ушла с итема.
		 * @param    e
		 */
		private static function onItemOut(e:MouseEvent):void
		{
			var item:InteractiveObject = e.currentTarget as InteractiveObject;
			if (item == _currentItem)
			{
				_currentItem = null;
				_currentHint = null;
			}

			item.removeEventListener(MouseEvent.MOUSE_MOVE, onItemMove);
			if (_timer)
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerOver);
				_timer.reset();
				_timer = null;
			}

			if (_host.contains(_hint)) _host.removeChild(_hint);
		}

		/**
		 * Запускаем тамйер когда мышка навелась на итем.
		 * @param    e
		 */
		private static function onItemOver(e:MouseEvent):void
		{
			_currentItem = e.currentTarget as InteractiveObject;
			_currentHint = _items[_currentItem];

			_timer = new Timer(_currentHint.delay * 1000, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerOver);
			_timer.start();
		}

		/**
		 * Рисуем хинт по истечении таймера.
		 * @param    e
		 */
		private static function onTimerOver(e:TimerEvent):void
		{
			if (_timer)
			{
				_timer.reset();
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerOver);
				_timer = null;
			}

			if (!_currentItem) return;

			_host.addChild(_hint);

			if (_currentHint && _currentHint.move) _currentItem.addEventListener(MouseEvent.MOUSE_MOVE, onItemMove);

			updateHint();
			setPosition();
		}

		//=====================================================================
		//	ACCESSORS
		//=====================================================================

	}

}