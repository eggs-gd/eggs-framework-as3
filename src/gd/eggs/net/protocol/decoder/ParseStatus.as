package gd.eggs.net.protocol.decoder
{
	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class ParseStatus 
	{
		// errors
		public static const INVALID_DATA_TYPE:String = "invalid data type";
		public static const INVALID_PACKAGE_SIZE:String = "invalid package size";
		
		// status
		public static const IN_PROGRESS:String = "in progress";
		public static const RECEIVING_HEADER:String = "receiving header";
		
		public static const DONE:String = "done";
		
	}

}