package gd.eggs.net.connect
{

	/**
	 * ...
	 * @author Dukobpa3
	 */
	public interface IServerConnect
	{
		/**
		 * Инициализирует �?пи�?ок до�?тупных конфигов (по дефолту �?разу подключает�?�?)
		 * @param    config
		 */
		function init(config:ServerConnectConfig):void

		/**
		 * Отправл�?ет команду на �?ервер
		 * @param    data �?об�?твенно данные
		 */
		function send(data:Object):void

	}

}