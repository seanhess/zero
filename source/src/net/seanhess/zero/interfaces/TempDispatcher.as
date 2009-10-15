package net.seanhess.zero.interfaces
{
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import net.seanhess.zero.util.Invalidator;

	public class TempDispatcher implements IEventDispatcher
	{
		protected var _dispatcher:IEventDispatcher;
		protected var listeners:Dictionary;
		protected var invalidator:Invalidator = new Invalidator(commit);
		
		public function TempDispatcher()
		{
			listeners = new Dictionary(true);
		}
		
		public function set dispatcher(value:IEventDispatcher):void
		{
			if (dispatcher && dispatcher != value)
			{
				for (var type:String in listeners)
				{
					var arguments:Array = listeners[type];
					removeEventListener(type, arguments[1]);
				}
				
				listeners = new Dictionary(true);
			}
			
			_dispatcher = value;
			invalidator.invalidate();
		}
		
		public function get dispatcher():IEventDispatcher
		{
			return _dispatcher;	
		}
		
		protected function commit():void
		{
			if (dispatcher)
			{
				for (var type:String in listeners)
				{
					dispatcher.addEventListener.apply(dispatcher, listeners[type]);
				}
			}
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			// I need to add it to the ARRAY of listeners for that particular event
			// LAME 
			listeners[type] = arguments;
			
			if (dispatcher)
			{
				dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
			}
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			throw new Error("Cannot dispatch an event!");
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return (listeners[type] != null);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			delete listeners[type];
			
			if (dispatcher)
			{
				dispatcher.removeEventListener(type, listener, useCapture);
			}
		}
		
		public function willTrigger(type:String):Boolean
		{
			if (dispatcher)
			{
				return dispatcher.willTrigger(type);
			}
			else
			{
				return false;
			}
		}
	}
}