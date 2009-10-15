package net.seanhess.zero.interfaces
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * Proxies events by adding an extra step. It listens
	 * to the actual source for you, then dispatches it
	 * 
	 * But if the source changes, it immediatley cleans up
	 * all of its event handlers (since we can't rely on 
	 * the actual dispatcher to do this). 
	 * 
	 * We could, however, rely on OURSELVES to do it, right?
	 * 
	 * Just push to a list of things to undo if we need to 
	 * clean up?
	 */
	public class EventForward extends EventDispatcher
	{
		protected var _source:Object;
		protected var types:Object = {};
		
		public function set source(value:Object):void
		{
			if (source)
			{
				disconnect();
			}
			
			_source = value;
			
			if (source)
			{
				connect();
			}
		}
		
		public function get source():Object
		{
			return _source;
		}
		
		public function connect():void
		{
			for (var type:String in types)
			{
				source.addEventListener(type, onEvent);
			}
		}
		
		public function disconnect():void
		{
			for (var type:String in types)
			{
				source.removeEventListener(type, onEvent);
			}
		}
		
		public function forward(type:String):void
		{
			types[type] = true;
			
			if (source)
				source.addEventListener(type, onEvent);		
		}
		
		protected function onEvent(event:Event):void
		{
			dispatchEvent(event); // dispatch it yourself
		}		
	}
}