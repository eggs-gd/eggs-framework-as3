package gd.eggs.net.protocol.decoder
{
	import flash.events.IEventDispatcher;
	import flash.events.DataEvent;
	
	/**
	 * ...
	 * @author Dukobpa3
	 */
	[Event(name = "invalid data type", type = "flash.events.DataEvent")];
	[Event(name = "invalid package size", type = "flash.events.DataEvent")];
	[Event(name = "receiving header", type = "flash.events.DataEvent")];
	[Event(name = "in progress", type = "flash.events.DataEvent")];
	[Event(name = "done", type = "flash.events.DataEvent")];
	
	public interface IMessageDecoder extends IEventDispatcher
	{
		//=====================================================================
		//	PUBLIC
		//=====================================================================
		/**
		 * Парсит "нечто" которое может быть чем-то внятным, или же байтарреем
		 * @param	command "нечто", которе мы получили с сервера
		 */
		function parse(message:Object):void
		
		/**
		 * пакует внутреннее "нечто" в серверное
		 * @param	data
		 * @return
		 */
		function pack(data:Object):Object
	}
}