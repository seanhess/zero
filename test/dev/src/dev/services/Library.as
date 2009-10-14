package dev.services
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	[Event(name="newBook", type="flash.events.Event")]
	public class Library extends EventDispatcher
	{
		public var allBooks:IList;
		public var maxBooks:int = 10;
		
		public function Library()
		{
			allBooks = new ArrayCollection();
		}
		
		public function createBook(title:String):void
		{
			allBooks.addItem(title);
			trace("ADDED : " + title);
			trace("BOOKS : "+ allBooks.length);
			dispatchEvent(new Event("newBook"));
		}
	}
}