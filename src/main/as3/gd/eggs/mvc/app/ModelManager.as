package gd.eggs.mvc.app
{

	import gd.eggs.mvc.model.BaseModel;
	import gd.eggs.util.Validate;


	/**
	 * Класс-холдер моделей. Дает удобный синглтоновый доступ к моделям.
	 */
	public class ModelManager
	{

		private static var _models:Object = {}; //<string, BaseModel> = new Map();

		/**
		 * Добавить модель в список
		 * @param modelName ключ-имя модели, по которому ее потом можно будет достать
		 * @param model     ссылка на модель
		 */
		public static function addModel(modelName:String, model:BaseModel):void
		{
			if (Validate.isNull(modelName)) throw new Error("modelName is null");
			if (Validate.isNull(model)) throw new Error("model is null");
			if (_models.hasOwnProperty(modelName)) throw new Error("_models.exists(modelName), modelName: " + modelName);

			_models[modelName] = model;
		}

		/**
		 * Выдает единственный екземпляр модели
		 * @param modelName имя интересующей модели
		 * @return
		 */
		public static function getModel(modelName:String):BaseModel
		{
			if (Validate.isNull(modelName)) throw new Error("modelName is null");
			if (!_models.hasOwnProperty(modelName)) throw new Error("!_models.exists(modelName), modelName: " + modelName);

			return _models[modelName];
		}
	}

}