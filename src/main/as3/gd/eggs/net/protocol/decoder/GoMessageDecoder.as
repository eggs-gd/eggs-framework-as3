package gd.eggs.net.protocol.decoder
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	import gd.eggs.net.protocol.core.MessageBase;
	import gd.eggs.net.protocol.core.ProtocolTypes;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class GoMessageDecoder extends EventDispatcher implements IMessageDecoder
	{

		//=====================================================================
		//	CONSTANTS
		//=====================================================================
		private const SIZE_NONE:int = -1;
		//=====================================================================
		//	PARAMETERS
		//=====================================================================
		private var _buffer:ByteArray;
		private var _size:int = SIZE_NONE;

		//=====================================================================
		//	CONSTRUCTOR, INIT
		//=====================================================================
		public function GoMessageDecoder()
		{
			_buffer = new ByteArray();
			_buffer.endian = Endian.LITTLE_ENDIAN;
		}

		//=====================================================================
		//	PUBLIC
		//=====================================================================
		/**
		 * Пар�?ит полученные данные
		 * @param    command
		 * @return Стату�? результата выполнени�?
		 */
		public function parse(command:Object):void
		{
			//Cc.logch("-- connector", "parse: " + JSON.stringify(command))
			if ((command == null) || !(command is ByteArray))
			{
				dispatchEvent(new DecoderEvent(ParseStatus.INVALID_DATA_TYPE));
			}

			var bytes:ByteArray = command as ByteArray;
			bytes.position = 0;
			bytes.endian = Endian.LITTLE_ENDIAN;

			//Cc.logch("-- decoder", "parse: " + String(bytes.length));

			_buffer.position = _buffer.length; // передвигаем кур�?ор в конец
			_buffer.writeBytes(bytes); // допи�?ываем в буфер то что получили
			bytes.clear(); // очищаем то что получили
			_buffer.position = 0;

			if (_size == SIZE_NONE) // е�?ли размер не �?читали
			{
				if (_buffer.length < 4) // е�?ли в буфере не до�?таточно байтов дл�? получени�? длины
				{
					_buffer.position = 0; // �?двигаем кур�?ор в началао и выходим из обработки
					dispatchEvent(new DecoderEvent(ParseStatus.RECEIVING_HEADER));
					return;
				}
				_size = _buffer.readInt(); // е�?ли байтов дл�? получени�? длины хватает - читаем ее
			}
			else
			{
				_buffer.position = 4;
			}

			if (_buffer.bytesAvailable < _size) // е�?ли от кур�?ора до конца меньше байт чем указано в длине
			{
				dispatchEvent(new DecoderEvent(ParseStatus.IN_PROGRESS)); // ждем еще данных
				return;
			}
			else // иначе читаем пакет
			{
				var data:ByteArray = new ByteArray();
				data.endian = Endian.LITTLE_ENDIAN;
				data.writeBytes(_buffer, _buffer.position, _size);// в�?унем хво�?т буффера в данные
				//Cc.logch("-- connector", "parsePackage: " + String(_size));

				_buffer.position += _size;

				_size = SIZE_NONE;

				parsePackage(data); // пар�?им данные
				data.clear(); // дальше обнул�?ем, во�?пользуем�?�? повторно в каче�?тве нового ме�?аджа

				if (_buffer.bytesAvailable)
				{
					data.writeBytes(_buffer, _buffer.position);  // в�?унем в данные хво�?т буффера
					data.position = 0;
					_buffer.clear(); // очи�?тим буффер (в �?лед цикле хво�?т в него допишет�?�?)
					//Cc.logch("-- decoder", "2 parsePackage: " + String(data.length));
					parse(data);
				}
				_buffer.clear(); // очи�?тим буффер (в �?лед цикле хво�?т в него допишет�?�?)
			}
		}

		/**
		 * Получает ме�?адж, делает из него байтарей
		 * @param    msg is MessageBase
		 * @return ByteArray
		 */
		public function pack(data:Object):Object
		{
			var msg:MessageBase = data as MessageBase;

			var buffer:ByteArray = new ByteArray();
			buffer.endian = Endian.LITTLE_ENDIAN;

			var packageData:ByteArray = new ByteArray();
			packageData.endian = Endian.LITTLE_ENDIAN;

			packageData.writeInt(ProtocolTypes.BSON);
			packageData.writeInt(msg.commandId);
			packageData.writeByte(msg.status);

			if (msg.data != null)
			{
				msg.data.position = 0;
				packageData.writeBytes(msg.data);
			}

			buffer.writeInt(packageData.length);
			buffer.writeBytes(packageData);

			return buffer;
		}

		//=====================================================================
		//	PRIVATE
		//=====================================================================
		private function parsePackage(packageData:ByteArray):void
		{
			//Cc.logch("-- connector", "parsePackage: " + JSON.stringify(packageData))
			packageData.position = 0;

			if (packageData.bytesAvailable < 5)
			{
				dispatchEvent(new DecoderEvent(ParseStatus.INVALID_PACKAGE_SIZE));
			}

			var msg:MessageBase = new MessageBase();
			msg.format = packageData.readInt();
			msg.commandId = packageData.readInt();
			msg.status = packageData.readByte();

			var commandData:ByteArray = new ByteArray();
			commandData.endian = Endian.LITTLE_ENDIAN;

			packageData.readBytes(commandData);

			msg.data = commandData;
			dispatchEvent(new DecoderEvent(ParseStatus.DONE, msg));
		}

		//=====================================================================
		//	HANDLERS
		//=====================================================================

		//=====================================================================
		//	ACCESSORS
		//=====================================================================
	}

}