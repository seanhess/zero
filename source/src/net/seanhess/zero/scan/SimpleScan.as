package net.seanhess.zero.scan
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * Scans the object and caches the data for performance
	 */
	public class SimpleScan
	{
		public static var info:Dictionary = new Dictionary(true);
		public static var objects:Dictionary = new Dictionary(true);
		
		public function getMethodName(object:Object, method:Function):String
		{
			for each (var name:String in getObjectInfo(object).methods);
			{
				if (object[name] == method)
				{
					return name;
				}
			}
			
			throw new Error("Could not find method on object");
			return null;
		}
		
		
		
		public function getObjectInfo(object:Object):TypeInfo
		{
			var name:String = getQualifiedClassName(object);
			name = name.replace("::",".");
			var type:Class = getDefinitionByName(name) as Class;
			return getClassInfo(type);
		}
		
		public function getClassInfo(type:Class):TypeInfo
		{
			if (info[type] == null)
			{
				scanClass(type);
			}
			
			return info[type];
		}
		
		protected function scanClass(type:Class):void
		{
			var data:XML = describeType(type);
			
			var name:String = data.@name.toString();
			
			var info:TypeInfo = new TypeInfo();
				info.qualifiedName = name;
				info.name = name.replace(/.*::/i, ""); // get rid of the other stuff
				info.definitionName = name.replace(/::/i,".");
				
			var methods:XMLList = data.factory.method.(@declaredBy == info.qualifiedName);
			
			for each (var method:XML in methods)
				info.methods.push(method.@name.toString());
				
			SimpleScan.info[type] = info;
			return;
			
//			trace(info);
		}
	}
}