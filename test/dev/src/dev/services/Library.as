package dev.services
{
	import dev.interfaces.IBook;
	import dev.interfaces.ILibrary;
	import dev.interfaces.ILog;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	import net.seanhess.zero.context.IContext;
	import net.seanhess.zero.context.IContextClient;

	[Event(name="newBook", type="flash.events.Event")]
	public class Library extends EventDispatcher implements IContextClient
	{
		public var allBooks:IList;
		public var maxBooks:int = 10;
		
		public var log:ILog;
		
		private var _context:IContext;
		
		public function set context(value:IContext):void
		{
			_context = value;
			
			
		}
		
		public function Library()
		{
			allBooks = new ArrayCollection();
		}
		
		public function createBook(title:String):void
		{
			//var book:IBook = new IBook(_context);
			//	book.title = title;
				
			log.message("Added book " + title);
			// allBooks.addItem(book);
			trace("ADDED : " + title);
			trace("BOOKS : "+ allBooks.length);
			dispatchEvent(new Event("newBook"));
		}
	}
}