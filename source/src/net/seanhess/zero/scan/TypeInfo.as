package net.seanhess.zero.scan
{
	public class TypeInfo
	{
		public var name:String;
		public var qualifiedName:String;
		public var definitionName:String;
		
		public var methods:Array = []; // MethodInfo objects
		public var events:Array = []; // EventInfo objects
		public var properties:Array = []; // PropertyInfo objects
	}
}