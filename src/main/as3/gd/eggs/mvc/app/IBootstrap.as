package gd.eggs.mvc.app
{

	/**
	 * Интерфейс инициализатора приложения
	 */
	public interface IBootstrap
	{
		//=========================================================================
		//	METHODS
		//=========================================================================
		/** Сначала регистрируем все модели */
		function registerModels():void;

		/** Далее вьюхи */
		function registerViews():void;

		/** В последнюю очередь регистрируются контроллеры */
		function registerControllers():void;
	}

}
