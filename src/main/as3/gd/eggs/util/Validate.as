package gd.eggs.util
{

	/**
	 * @author SlavaRa
	 */
	public class Validate
	{
		public static function isNull(d:*):Boolean
		{
			return d == null;


		}

		public static function isNotNull(d:*):Boolean
		{
			return d != null;
		}

		public static function stringIsNullOrEmpty(s:String):Boolean
		{
			return (s == null) || (s.length == 0);
		}

		public static function stringIsNotEmpty(s:String):Boolean
		{
			return (s != null) && (s.length > 0);
		}

	}

}