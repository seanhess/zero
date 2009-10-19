package net.seanhess.zero.dependency
{
	import mx.core.ClassFactory;
	import mx.core.IFactory;

	/**
	 * Instructions to create an implementation for a DependencyInterface
	 */
	public class Rule
	{
		public static const IMPLEMENT:String = "implement"; // means it creates one instance
		public static const FACTORY:String = "factory"; // means it creates a new one every time
		public static const PROXY:String = "proxy"; // means it pumps everything through it. Needs to use the cache rule of the parent object?
		
		public var kind:String;
		
		public var interfaces:RegExp = /.*/;
		public var contexts:RegExp = /.*/;	
		public var factory:IFactory; 
		
		public function Rule(kind:String=null, factoryOrClass:*=null, interfaceFilter:String=null, contextFilter:String=null)
		{
			this.kind = kind;
			this.factoryOrClass = factoryOrClass;
			this.interfaceFilter = interfaceFilter;
			this.contextFilter = contextFilter;
		}
		
		public function set interfaceFilter(value:String):void
		{
			if (value)
				this.interfaces = convertToRegExp(value);
		}
		
		public function set contextFilter(value:String):void
		{
			if (value)
				this.contexts = convertToRegExp(value);
		}
		
		public function set factoryOrClass(value:*):void
		{
			if (value)
				this.factory = convertToIFactory(value);
		}
		
		public function convertToRegExp(wild:String):RegExp
		{
			return new RegExp(wild.replace(/\*/gi, "\\*").replace(/\./gi, "\\."));
		}
		
		public function convertToIFactory(factory:*):IFactory
		{
			if (factory is IFactory)
				return factory as IFactory;
			
			else if (factory is Class)
				return new ClassFactory(factory);
		
			else
				return null;
		}
	}
}