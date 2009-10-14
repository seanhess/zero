package net.seanhess.zero.interfaces
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import net.seanhess.zero.context.IContext;
	import net.seanhess.zero.util.Invalidator;
	
	
	public class Interface implements IEventDispatcher
	{
		protected var _context:IContext;
		protected var invalidator:Invalidator = new Invalidator(commit);

		/**
		 * The implementation
		 */
		protected var item:*;

		
		
		/**
		 * A unique key identifying this class
		 */
		public function get type():String
		{
			return getQualifiedClassName(this);
		}
		
		/**
		 * Context gives this interface a place to listen
		 */
		public function set context(value:IContext):void
		{
			if (context)
			{
				context.removeEventListener(InterfaceEvent.UPDATE, onUpdate);
			}
			
			_context = value;
			invalidator.invalidate("context");
		}
		
		public function get context():IContext
		{
			return _context;		
		}
		
		protected function commit():void
		{
			if (invalidator.invalid("context"))
			{
				if (context)
				{
					context.addEventListener(InterfaceEvent.UPDATE, onUpdate);
					context.addEventListener(InterfaceEvent.FOUND, onUpdate);
					context.send(new InterfaceEvent(InterfaceEvent.FIND, this));
				}
			}
			
			if (invalidator.invalid("implementation"))
			{
				for (var type:String in listeners)
				{
					item.addEventListener.apply(item, listeners[type]);
				}
			}
		}
		
		protected function onUpdate(event:InterfaceEvent):void
		{
			// only if they match!
			
			context.removeEventListener(InterfaceEvent.FOUND, onUpdate);
			implementation = event.implementation;	
		}
		
		public function set implementation(value:*):void
		{
			item = value;
			invalidator.invalidate("implementation");
		}	

		public function get implementation():*
		{
			return item;
		}
		
		protected function get i():*
		{
			return item;
		}
		
		public function detach():void
		{
			for (var type:String in listeners)
			{
				var arguments:Array = listeners[type];
				removeEventListener(type, arguments[1]);
			}
			
			listeners = new Dictionary(true);
			
			implementation = null;
		}
		
		
		// I can't have them listening directly to the event, can I? 
		// I need an easy way to detach! 
		
		protected var listeners:Dictionary = new Dictionary(true);
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			listeners[type] = arguments;
			
			if (item)
			{
				item.addEventListener(type, listener, useCapture, priority, useWeakReference);
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
			
			if (item)
			{
				item.removeEventListener(type, listener, useCapture);
			}
		}
		
		public function willTrigger(type:String):Boolean
		{
			if (item)
			{
				return item.willTrigger(type);
			}
			else
			{
				return false;
			}
		}
	}
}
