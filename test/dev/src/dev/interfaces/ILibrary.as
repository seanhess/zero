package dev.interfaces
{
	import mx.collections.IList;
	
	import net.seanhess.zero.common.ZEventDispatcher;
	import net.seanhess.zero.interfaces.Interface;
	
	
	[Event(name="newBook", type="flash.events.Event")]
	public class ILibrary extends ZEventDispatcher
	{
		public function ILibrary(context:*=null):void	{ super(context);	}
		
		public function get allBooks():IList 			{ return i.allBooks };
		
		[Bindable]
		public function set maxBooks(value:int):void 	{ i.maxBooks = value };
		public function get maxBooks():int			 	{ return i.maxBooks };
		
		public function createBook(title:String):void 	{ i.createBook(arguments); } // or "title" or "arguments"
	}
}