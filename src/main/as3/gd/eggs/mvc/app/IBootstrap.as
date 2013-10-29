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

		/** Далее нотификации в обсервер (пришло из хакса, с текущей схемой не нужен) */
		function registerNotifications():void;

		/** В последнюю очередь регистрируются контроллеры */
		function registerControllers():void;
	}

}
