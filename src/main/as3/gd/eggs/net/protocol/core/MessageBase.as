package gd.eggs.net.protocol.core
{
	import flash.utils.ByteArray;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class MessageBase
	{
		public var format:int;
		public var commandId:int;
		public var status:int;
		public var data:ByteArray;

		public function MessageBase()
		{

		}

	}

}