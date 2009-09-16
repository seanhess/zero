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
			{
				var methodInfo:MethodInfo = new MethodInfo();
					methodInfo.name = method.@name.toString();
					
				info.methods[methodInfo.name] = methodInfo;
			}

			
			
				
				
			var accessors:XMLList = data.factory.accessor.(@declaredBy == info.qualifiedName);
			var variables:XMLList = data.factory.variable;
			accessors += variables;
			
			for each (var accessor:XML in accessors)
			{
				var property:PropertyInfo = new PropertyInfo();
					property.name = accessor.@name.toString();
					property.type = accessor.@type.toString();
					
				if (accessor.localName() == "accessor")
					property.access = accessor.@access.toString();
				else
					property.access = PropertyInfo.READ_WRITE;
					
				var bindableList:XMLList = accessor.metadata.(@name == "Bindable");
				
				if (bindableList.length() > 0)
				{
					property.bindable = true;
					property.event = bindableList[0].arg[0].@value;
				}
				
				info.properties[property.name] = property;
			}
			
			
			
			
			var events:XMLList = data.factory.metadata.(@name == "Event");
			
			for each (var event:XML in events)
			{
				var eventInfo:EventInfo = new EventInfo();
					eventInfo.name = event.arg.(@key == "name")[0].@value;
					eventInfo.type = event.arg.(@key == "type")[0].@value;
				
				info.events[eventInfo.name] = eventInfo;
			}
			
			
			
			
			
			
			SimpleScan.info[type] = info;
			return;
			
//			trace(info);
		}
	}
}