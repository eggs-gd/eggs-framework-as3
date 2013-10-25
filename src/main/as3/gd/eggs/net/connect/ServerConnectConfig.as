package gd.eggs.net.connect
{
	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class ServerConnectConfig
	{

		//=====================================================================
		//	CONSTANTS
		//=====================================================================

		//=====================================================================
		//	PARAMETERS
		//=====================================================================
		private var _type:String;

		private var _timeout:int;
		private var _connectTime:int;
		private var _host:String;
		private var _port:int;
		//=====================================================================
		//	CONSTRUCTOR, INIT
		//=====================================================================
		public function ServerConnectConfig(type:String, timeout:int, connectTime:int, host:String, port:int)
		{
			_type = type;
			_timeout = timeout;
			_connectTime = connectTime;
			_host = host;
			_port = port;
		}

		//=====================================================================
		//	PUBLIC
		//=====================================================================

		//=====================================================================
		//	PRIVATE
		//=====================================================================

		//=====================================================================
		//	HANDLERS
		//=====================================================================

		//=====================================================================
		//	ACCESSORS
		//=====================================================================
		public function get timeout():int { return _timeout; }

		public function get connectTime():int { return _connectTime; }

		public function get host():String { return _host; }

		public function get port():int { return _port; }

		public function get type():String { return _type; }
	}

}