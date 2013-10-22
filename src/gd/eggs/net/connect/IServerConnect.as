package gd.eggs.net.connect
{
	
	/**
	 * ...
	 * @author Dukobpa3
	 */
	public interface IServerConnect 
	{
		/**
		 * Инициализирует список доступных конфигов (по дефолту сразу подключается)
		 * @param	config
		 */
		function init(config:ServerConnectConfig):void
		
		/**
		 * Отправляет команду на сервер
		 * @param	data собственно данные
		 */
		function send(data:Object):void
		
	}
	
}