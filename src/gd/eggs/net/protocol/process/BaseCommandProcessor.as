package gd.eggs.net.protocol.process
{
	import gd.eggs.net.protocol.core.BaseCommandSet;
	import gd.eggs.observer.IObservable;
	import gd.eggs.observer.Notification;
	import gd.eggs.observer.Observer;
	import flash.utils.describeType;
	

	/**
	 * ...
	 * @author Dukobpa3
	 */
	public class BaseCommandProcessor implements IObservable 
	{
		//=====================================================================
		//	CONSTANTS
		//=====================================================================
		
		//=====================================================================
		//	PARAMETERS
		//=====================================================================
		
		protected namespace process = "process";
		
		/** Синглтон обсервера */
		private var _obs:Observer = Observer.getInstance();
		
		/** CommandSets */
		protected var _sets:Array;
		
		//=====================================================================
		//	CONSTRUCTOR, INIT
		//=====================================================================
		public function BaseCommandProcessor(ext:BaseCommandProcessor) 
		{
			use namespace process;
			
			for each(var commandSet:BaseCommandSet in _sets)
			{
				var description:XML = describeType(commandSet);
				var setName:String = description.@name;
				setName = setName.split("::")[1];
				
				for each(var node:XML in description.variable)
				{
					if (node.@type == "Function")
					{
						var linkName:String = node.@name;
						var callbackName:String = "proc" 
							+ setName.substr(0, 1).toUpperCase() + setName.substr(1) 
							+ linkName.substr(0, 1).toUpperCase() + linkName.substr(1);
							
						commandSet[linkName] = ext[callbackName];
					}
				}
				
				commandSet.init();
			}
		}
		
		public function sendNotification(note:Notification):void 
		{
			note.target = this;
			_obs.notifyObservers(note);
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
	}

}