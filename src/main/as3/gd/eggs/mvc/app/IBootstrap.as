package gd.eggs.mvc.app
{

	/**
	 * @author Dukobpa3
	 */
	public interface IBootstrap
	{
		//=========================================================================
		//	METHODS
		//=========================================================================

		function registerModels():void;

		function registerViews():void;

		function registerNotifications():void;

		function registerControllers():void;
	}

}
