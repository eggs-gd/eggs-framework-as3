package gd.eggs.util
{

	/**
	 * @author SlavaRa
	 */
	public interface IInitialize
	{
		function get isInited():Boolean;


		function init():void;

		function destroy():void;
	}

}