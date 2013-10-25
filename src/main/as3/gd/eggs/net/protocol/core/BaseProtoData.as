package gd.eggs.net.protocol.core
{
	
	import flash.utils.ByteArray;


	import flash.utils.Endian;

	import org.serialization.bson.BSON;
	
	/**
	 * ...
	 * @author Dukobpa3
	 */
	public dynamic class BaseProtoData
	{
		protected namespace protocol = "protocol";
		
		public function BaseProtoData()
		{
			
		}
		
		public function readBSON(buffer:ByteArray):void
		{
			buffer.position = 0;
			fromObject(BSON.decode(buffer))
		}
		
		public function writeBSON():ByteArray
		{
			var result:ByteArray = new ByteArray();
			result.endian = Endian.LITTLE_ENDIAN;
			
			result.writeBytes(BSON.encode(toObject()));
			
			result.position = 0;
			
			return result;
		}
		
		public function fromObject(data:Object  = null):BaseProtoData
		{
			use namespace protocol;
			for (var key:String in data)
			{
				try
				{
					this["_" + key] = data[key];
				}
				catch (error:Object)
				{
					throw new Error("fromObject() error: " + error + ", wrong key:" + key);
				}
			}
			
			return this
		}
		
		public function toObject():Object
		{
			throw new Error("toObject() error: not implemented");
			//return this;
		}
		
		//public function get id():int { return _id; }
		
	}
}