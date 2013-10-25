package gd.eggs.assetsfactory.items
{
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;


	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class ItemLoaderContext
	{
		//=====================================================================
		//		CONSTANTS
		//=====================================================================

		//=====================================================================
		//		PARAMETERS
		//=====================================================================
		/**
		 * Дл�? лоадера звука
		 */
		private var _bufferTime:Number;

		/**
		 * Дл�? лоадера графики
		 */
		private var _applicationDomain:ApplicationDomain;
		private var _securityDomain:SecurityDomain;

		/**
		 * Универ�?альное
		 */
		private var _checkPolicyFile:Boolean;

		//=====================================================================
		//		CONSTRUCTOR, INIT
		//=====================================================================
		/**
		 * Универ�?альный лоадер контек�?т, параметры в�?е очевидны.
		 * @param    checkPolicy
		 * @param    appDomain
		 * @param    secDomain
		 * @param    bufferTime
		 */
		public function ItemLoaderContext(checkPolicy:Boolean = false, appDomain:ApplicationDomain = null, secDomain:SecurityDomain = null, bufferTime:Number = 1000)
		{
			_checkPolicyFile = checkPolicy;
			_applicationDomain = appDomain;
			_securityDomain = secDomain;
			_bufferTime = bufferTime;
		}

		//=====================================================================
		//		PUBLIC
		//=====================================================================

		//=====================================================================
		//		PRIVATE
		//=====================================================================

		//=====================================================================
		//		ACCESSORS
		//=====================================================================

		public function get bufferTime():Number { return _bufferTime; }

		public function set bufferTime(value:Number):void { _bufferTime = value; }

		public function get applicationDomain():ApplicationDomain { return _applicationDomain; }

		public function set applicationDomain(value:ApplicationDomain):void { _applicationDomain = value; }

		public function get securityDomain():SecurityDomain { return _securityDomain; }

		public function set securityDomain(value:SecurityDomain):void { _securityDomain = value; }

		public function get checkPolicyFile():Boolean { return _checkPolicyFile; }

		public function set checkPolicyFile(value:Boolean):void { _checkPolicyFile = value; }
	}

}