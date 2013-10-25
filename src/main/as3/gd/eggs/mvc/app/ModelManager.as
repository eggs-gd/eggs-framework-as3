package gd.eggs.mvc.app
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