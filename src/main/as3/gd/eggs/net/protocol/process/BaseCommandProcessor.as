/**
 * Licensed under the MIT License
 *
 * Copyright (c) 2013 earwiGGames team
 * http://eggs.gd/
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
﻿package gd.eggs.net.protocol.process
{
	import flash.utils.describeType;

	import gd.eggs.net.protocol.core.BaseCommandSet;
	import gd.eggs.observer.IObservable;
	import gd.eggs.observer.Notification;
	import gd.eggs.observer.Observer;


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
						var callbackName:String = "proc" + setName.substr(0, 1).toUpperCase() + setName.substr(1) + linkName.substr(0, 1).toUpperCase() + linkName.substr(1);

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