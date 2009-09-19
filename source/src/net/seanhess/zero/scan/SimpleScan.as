package net.seanhess.zero.scan
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
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
			var name:String = getClassName(object);
			
			if (info[name] == null)
			{
				info[name] = scan(object);
			}
			
			return info[name];
		}
		
		public function getClassInfo(type:Class):TypeInfo
		{
			var name:String = getClassName(type);
			
			if (info[name] == null)
			{
				info[name] = scan(type);
			}
			
			return info[name];
		}
		
		public function getClassName(type:Object):String
		{
			return getQualifiedClassName(type).replace("::",".");
		}
		
		/**
		 * Can scan objects or classes 
		 */
		protected function scan(type:Object):TypeInfo
		{
			var data:XML = describeType(type);
			
			
			
			var name:String = data.@name.toString();
			
			var info:TypeInfo = new TypeInfo();
				info.qualifiedName = name;
				info.type = name.replace(/.*::/i, ""); // get rid of the other stuff
				info.definitionName = name.replace(/::/i,".");
				
			
			// handle classes AND objects
			if (data.factory.length() > 0)
				data = data.factory[0];
				
				
			var methods:XMLList = data.method.(@declaredBy == info.qualifiedName);
			
			for each (var method:XML in methods)
			{
				var methodInfo:MethodInfo = new MethodInfo();
					methodInfo.name = method.@name.toString();
					
				info.methods[methodInfo.name] = methodInfo;
			}

			
			
				
				
			var accessors:XMLList = data.accessor.(@declaredBy == info.qualifiedName);
			var variables:XMLList = data.variable;
			accessors += variables;
			
			for each (var accessor:XML in accessors)
			{
				var property:PropertyInfo = new PropertyInfo();
					property.name = accessor.@name.toString();
					property.type = accessor.@type.toString().replace("::",".");
					
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
				
				var metalist:XMLList = accessor.metadata;
				
				for each (var meta:XML in metalist)
					property.metadata[meta.@name.toString()] = meta.@name.toString();
				
				info.properties[property.name] = property;
			}
			
			
			
			
			var events:XMLList = data.metadata.(@name == "Event");
			
			for each (var event:XML in events)
			{
				var eventInfo:EventInfo = new EventInfo();
					eventInfo.name = event.arg.(@key == "name")[0].@value;
					eventInfo.type = event.arg.(@key == "type")[0].@value;
				
				info.events[eventInfo.name] = eventInfo;
			}
			
			return info;
		}
	}
}