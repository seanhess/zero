package dev.dependency
{
	import mx.collections.IList;
	
	import net.seanhess.zero.dependency.DependencyInterface;
	
	
	// it could be a Zinterface
	// ha... 
	
	// or a Zero extends Zero
	
	// because it isn't exactly an interface, is it. A new concept would be better
	// ZSomething
	
	// Zinterface
	// Zecorator
	// Decorator (because that's what it is)
	// But it's acting like an interface, because it isn't doing anything. 
	// ZInterface
	// zinterface
	// zero
	// extends ZeroDecorator
	// public class ZLibrary extends ZeroDecorator
	// public class ZLibrary
	// public class DLibrary extends DependencyInterface // that's a nice touch. It is an interface to a dependency 
	
	[Event(name="newBook", type="flash.events.Event")]
	public class DLibrary extends DependencyInterface
	{
		public function DLibrary(context:*=null):void	{ super(context);	}
		
		public function get allBooks():IList 			{ return i.allBooks };
		
		[Bindable]
		public function set maxBooks(value:int):void 	{ i.maxBooks = value };
		public function get maxBooks():int			 	{ return i.maxBooks };
		
		public function createBook(title:String):void 	{ i.createBook(arguments); } // or "title" or "arguments"
	}
}