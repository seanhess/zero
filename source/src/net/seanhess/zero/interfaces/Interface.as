package net.seanhess.zero.interfaces
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import net.seanhess.zero.context.ContextEvent;
	import net.seanhess.zero.context.IContext;
	import net.seanhess.zero.util.Invalidator;
	
	/**
	 * The implementation will be 
	 * 
	 */
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
			// clean up 
			if (context)
			{
				context.removeEventListener(InterfaceEvent.UPDATE, onUpdate);
				context.removeEventListener(ContextEvent.DISCONNECT, onDisconnect); 
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
					context.addEventListener(ContextEvent.DISCONNECT, onDisconnect);
					context.send(new InterfaceEvent(InterfaceEvent.FIND, this.type, onFound));
				}
				else (context == null)
				{
					implementation = null;
				}
			}
			
			if (invalidator.invalid("implementation"))
			{
				connectImplementation();
			}
		}
		
		protected function onFound(event:InterfaceEvent):void
		{
			onUpdate(event);
		}
		
		protected function onUpdate(event:InterfaceEvent):void
		{
			// only if they match!
			if (event.face == this.type)
			{
				implementation = event.implementation;	
			}
		}
		
		protected function onDisconnect(event:ContextEvent):void
		{
			context = null;
		}
		
		
		
		
		/**
		 * The actual object we work with
		 */
		public function set implementation(value:*):void
		{
			disconnectImplementation();			
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
		
		protected function connectImplementation():void
		{
			if (item)
			{
				for each(var args:Array in listeners)
				{
					item.addEventListener.apply(item, args);
				}
			}
		}
		
		protected function disconnectImplementation():void
		{
			if (item)
			{
				for each(var args:Array in listeners)
				{
					args = args.slice(0, 3);
					item.removeEventListener.apply(item, args);
				}
			}
		}
		
		
		
		
		
		
		
		
		
		protected var listeners:Dictionary = new Dictionary(true);
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			listeners[listener] = arguments; // the "listener" is the unique key
			
			if (item)
			{
				item.addEventListener(type, listener, useCapture, priority, useWeakReference);				
			}
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return item.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return item.hasEventListener(type);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			delete listeners[listener];
			
			if (item)
			{
				item.removeEventListener(type, listener, useCapture);
			}
		}
		
		public function willTrigger(type:String):Boolean
		{
			return item.willTrigger(type);
		}
	}
}
