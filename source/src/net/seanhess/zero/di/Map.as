package net.seanhess.zero.di
{
	import mx.core.IFactory;

	public class Map
	{
		public static const FIND_TYPE_MESSAGE:String = "findTypeMessage";
		
		public var type:Class;
		public var typeName:String;
		public var factory:IFactory;
		public var implementation:Class;
		public var instance:*;
	}
}