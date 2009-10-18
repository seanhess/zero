package net.seanhess.zero.context
{
	import mx.core.ClassFactory;
	import mx.core.IFactory;

	public class Rule
	{
		public static const IMPLEMENT:String = "implement"; // means it creates one instance
		public static const FACTORY:String = "factory"; // means it creates a new one every time
		public static const PROXY:String = "proxy"; // means it pumps everything through it. Needs to use the cache rule of the parent object?
		
		// Remember that BasicProxy nonsense?
		// That way you can avoid having a billion proxies
		// You ALWAYS have one (extra) proxy
		// Or, should I make the interface itself be that kind of a proxy?
		// It could get a reference to all the several implementations, and a list of the rules
		// then it could know where to go for each thing?
		
		// if two classes are listen as implementations for the same interface
		// the latter takes priority
		// if nothing overlaps, hopefully we can just do both, right?
		// if things DO overlap, we use the latter...
		// how would you even DO that? a try/catch block?... sure... you can specifically catch TypeErrors
		
		// Proxies - can my little proxy handle other proxies? He gets asked to call "send" for which he has a proxy and an
		// implementation. The proxy is second (thank goodness?).
		
		// Definitely easiest to send EVERYTHING through the proxy. So do that!
		// Does a proxy have to actually BE a proxy? If so, how do you set the item?
		// We'd need to be able to change the item it is proxying? NO - so they can extend ObjectProxy
		
		
		
		// They either need to extend ObjectProxy, and send everything through them, or they need
		// some other way to know the item they'll be proxying, right?
		
		// Since I try to make this class-based... as in, the class makes the decisions, let's go with 
		// the other option. 
		
		// Overlapping implementations... Hmm, just 
		
		// Overlapping implementations - just use the later one... Or rather, try the later one first? 
		// Or, should we create a NEW proxy that uses all our stuff for us. 
		// How would it call a proxy?
		// 
		
		// callProperty
		//   try calling the first proxy... 
		//   no, proxies need access!
		// 	 k, do it the normal way. 
		// 	 so, when it returns an implementation, though, it needs to be 
		
		// just pass in the real implementation for now?
		
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