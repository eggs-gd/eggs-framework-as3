package gd.eggs.net.protocol.decoder
{
	import gd.eggs.net.protocol.core.MessageBase;


	import gd.eggs.net.protocol.core.ProtocolTypes;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
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
		 * Парсит полученные данные
		 * @param	command
		 * @return Статус результата выполнения
		 */
		public function parse(command:Object):void
		{
			//Cc.logch("-- connector", "parse: " + JSON.stringify(command))
			if ((command == null) ||  !(command is ByteArray))
			{
				dispatchEvent(new DecoderEvent(ParseStatus.INVALID_DATA_TYPE));
			}
			
			var bytes:ByteArray = command as ByteArray;
			bytes.position = 0;
			bytes.endian = Endian.LITTLE_ENDIAN;
			
			//Cc.logch("-- decoder", "parse: " + String(bytes.length));
			
			_buffer.position = _buffer.length; // передвигаем курсор в конец
			_buffer.writeBytes(bytes); // дописываем в буфер то что получили
			bytes.clear(); // очищаем то что получили
			_buffer.position = 0;
			
			if (_size == SIZE_NONE) // если размер не считали
			{
				if (_buffer.length < 4) // если в буфере не достаточно байтов для получения длины
				{
					_buffer.position = 0; // сдвигаем курсор в началао и выходим из обработки
					dispatchEvent(new DecoderEvent(ParseStatus.RECEIVING_HEADER));
					return;
				}
				_size = _buffer.readInt(); // если байтов для получения длины хватает - читаем ее
			}
			else
			{
				_buffer.position = 4;
			}
			
			if (_buffer.bytesAvailable < _size) // если от курсора до конца меньше байт чем указано в длине
			{
				dispatchEvent(new DecoderEvent(ParseStatus.IN_PROGRESS)); // ждем еще данных
				return;
			}
			else // иначе читаем пакет
			{
				var data:ByteArray = new ByteArray();
				data.endian = Endian.LITTLE_ENDIAN;
				data.writeBytes(_buffer, _buffer.position, _size);// всунем хвост буффера в данные
				//Cc.logch("-- connector", "parsePackage: " + String(_size));
				
				_buffer.position += _size;
				
				_size = SIZE_NONE;
				
				parsePackage(data); // парсим данные
				data.clear(); // дальше обнуляем, воспользуемся повторно в качестве нового месаджа
				
				if (_buffer.bytesAvailable)
				{
					data.writeBytes(_buffer, _buffer.position);  // всунем в данные хвост буффера
					data.position = 0;
					_buffer.clear(); // очистим буффер (в след цикле хвост в него допишется)
					//Cc.logch("-- decoder", "2 parsePackage: " + String(data.length));
					parse(data);
				}
				_buffer.clear(); // очистим буффер (в след цикле хвост в него допишется)
			}	
		}
		
		/**
		 * Получает месадж, делает из него байтарей
		 * @param	msg is MessageBase
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
			
			if(msg.data != null){
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
			msg.status =  packageData.readByte();
			
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