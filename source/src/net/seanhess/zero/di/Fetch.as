package net.seanhess.zero.di
{
	import flash.events.EventDispatcher;
	
	import net.seanhess.zero.context.IContextSender;
	import net.seanhess.zero.context.Message;

	/**
	 * gets an implementation for you. Does not update
	 * if another implementation registers.
	 */
	[Event(name="fetched",type="flash.events.Event")]
	public class Fetch extends EventDispatcher
	{
		public function Fetch()
		{
			trace("Fetch");
		}
		
		protected var _context:IContextSender;
		protected var _type:Class;
		
		[Bindable]
		public var value:*;
		
		public function set context(value:IContextSender):void
		{
			_context = value;
			find();
		}
		
		public function set type(value:Class):void
		{
			_type = value;
			find();
		}
		
		protected function find():void
		{
			if (_context && _type && value == null)
			{
				trace("FIND");
				var map:Map = new Map();
					map.type = _type; 
						
				var message:Message = new Message(Map.FIND_TYPE_MESSAGE, map);
				_context.send(message);
				
				value = map.instance;
				dispatchEvent(new Event("fetched"));
			}
		}
		
	}
}