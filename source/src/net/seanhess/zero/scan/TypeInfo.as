package net.seanhess.zero.scan
{
	public class TypeInfo
	{
		public var type:String;
		public var qualifiedName:String;
		public var definitionName:String;
		
		public var methods:Object = {}; // MethodInfo objects
		public var events:Object = {}; // EventInfo objects
		public var properties:Object = {}; // PropertyInfo objects
	}
}