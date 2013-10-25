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
﻿package gd.eggs.mvc.app
{

	import gd.eggs.mvc.model.BaseModel;
	import gd.eggs.util.Validate;


	/**
	 * @author Dukobpa3
	 */
	public class ModelManager
	{

		private static var _models:Object = {}; //<string, BaseModel> = new Map();

		public static function addModel(modelName:String, model:BaseModel):void
		{
			if (Validate.isNull(modelName)) throw new Error("modelName is null");
			if (Validate.isNull(model)) throw new Error("model is null");
			if (_models.hasOwnProperty(modelName)) throw new Error("_models.exists(modelName), modelName: " + modelName);

			_models[modelName] = model;
		}

		public static function getModel(modelName:String):BaseModel
		{
			if (Validate.isNull(modelName)) throw new Error("modelName is null");
			if (!_models.hasOwnProperty(modelName)) throw new Error("!_models.exists(modelName), modelName: " + modelName);

			return _models[modelName];
		}
	}

}