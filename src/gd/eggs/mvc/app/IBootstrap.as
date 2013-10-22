package gd.eggs.mvc.app
{

	import gd.eggs.mvc.controller.BaseController;


	/**
	 * @author Dukobpa3
	 */
	public interface IBootstrap
	{
		//=========================================================================
		//	VARIABLES
		//=========================================================================

		function get appController():BaseController;

		//=========================================================================
		//	METHODS
		//=========================================================================

		function registerModels():void;

		function registerViews():void;

		function registerNotifications():void;

		function registerControllers():void;
	}

}
