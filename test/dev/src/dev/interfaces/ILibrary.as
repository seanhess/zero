package dev.interfaces
{
	import mx.collections.IList;
	
	import net.seanhess.zero.interfaces.Interface;
	
	
	// an interface HAS to be able to specify properties as read-write, write or read
	
	[Event(name="newBook", type="flash.events.Event")]
	public class ILibrary extends Interface
	{
		public function get allBooks():IList { return i.getAllBooks };
		
		public function set maxBooks(value:int):void { i.maxBooks = value };
		public function get maxBooks():int			 { return i.maxBooks };
		
		public function createBook(title:String):void { i.createBook(arguments); } // or "arguments"
	}
	
}