package gd.eggs.util
{
	/**
	 * ...
	 * @author Jewelz
	 */
	public class TimeAbstract
	{
		
		public static function getAbstractTextFormat(unixTime:int):String
		{
			var format:String = '';
			
			var days:int = int(unixTime / 86400);
			var hours:int = int((unixTime - days * 86400) / 3600);
			var mins:int = int((unixTime - days * 86400 - hours * 3600) / 60);
			var secs:int = unixTime - days * 86400 - hours * 3600 - mins * 60;
			
			if (days)
			{
				format += days.toString();
				format += "d ";
			}
			if (hours)
			{
				//if (hours < 10) format += "0";
				format += hours.toString();
				format += "h ";
			}
			if (mins && !days)
			{
				//if (mins < 10) format += "0";
				format += mins.toString();
				format += "m ";
			}
			if (secs && !days)
			{
				//if (secs < 10) format += "0";
				format += secs.toString();
				format += "s ";
			}
			
			return format;
		}
		
	}

}