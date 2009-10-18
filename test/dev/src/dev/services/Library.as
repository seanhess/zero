package dev.services
{
	
	import dev.dependency.DBook;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	[Event(name="newBook", type="flash.events.Event")]
	public class Library extends EventDispatcher
	{
		public var allBooks:IList;
		
		[Bindable]
		public var maxBooks:int = 10;
				
		public function Library()
		{
			allBooks = new ArrayCollection();
		}
		
		public function createBook(title:String):void
		{
			var book:DBook = new DBook(this);
				book.title = title + Math.random();
				

			allBooks.addItem(book);
			trace("ADDED : " + title);
			trace("BOOKS : "+ allBooks.length);
			dispatchEvent(new Event("newBook"));
		}
	}
}