package dev.interfaces
{
	import mx.collections.IList;
	
	import net.seanhess.zero.interfaces.Interface;
	
	
	// an interface HAS to be able to specify properties as read-write, write or read
	// I could definitely make a run-time test that could use a mock implementation
	// to make sure it is calling the right thing, right?
	
	// how about when debug is on, any time a new Interface is created, it calls EVERYTHING
	// in it to make sure? 
	
	// one time per interface type.. 
	
	[Event(name="newBook", type="flash.events.Event")]
	public class ILibrary extends Interface
	{
		public function get allBooks():IList 			{ return i.allBooks };
		
		public function set maxBooks(value:int):void 	{ i.maxBooks = value };
		public function get maxBooks():int			 	{ return i.maxBooks };
		
		public function createBook(title:String):void 	{ i.createBook(arguments); } // or "title" or "arguments"
	}
	
}