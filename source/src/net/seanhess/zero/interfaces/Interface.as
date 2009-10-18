package net.seanhess.zero.interfaces
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.IMXMLObject;
	
	import net.seanhess.zero.context.ContextEvent;
	import net.seanhess.zero.context.IContext;
	import net.seanhess.zero.context.IContextClient;
	import net.seanhess.zero.context.Register;
	
	/**
	 * The implementation will be 
	 */
	public class Interface implements IEventDispatcher, IMXMLObject
	{
		/**
		 * The implementation
		 */
		protected var _implementation:*;
		
		protected var register:Register = new Register();
		
		public function Interface()
		{
			
		}

		public function initialized(document:Object, id:String):void
		{
			
		}
		
		/**
		 * A unique key identifying this class
		 */
		public function get type():String
		{
			return getQualifiedClassName(this).replace("::",".");
		}
		
		/**
		 * Context gives this interface a place to listen
		 */
		public function set context(value:IContext):void
		{
			if (value == context)
				return;
			
			// clean up 
		    disconnectContext();
			_context = value;
            connectContext();
		}
		
		public function get context():IContext
		{
			return _context;		
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
            if (value == implementation)
                return;

            disconnectImplementation();
			_implementation = value;
            connectImplementation();
		}	

		public function get implementation():*
		{
			return _implementation;
		}
		
		protected function get i():*
		{
			return _implementation;
		}
	
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    	
		
        private function disconnectImplementation():void
        {
            // clean up 
			if (implementation)
			{
				for (var type:String in listeners)
				{
					for each(var args:Array in listeners[type])
					{
						args = args.slice(0, 3);
						implementation.removeEventListener.apply(implementation, args);
					}
				}
			}
	    }	

        private function connectImplementation():void
        {
            if (implementation)
            {
				for (var type:String in listeners)
				{
					for each(var args:Array in listeners[type])
					{
						implementation.addEventListener.apply(implementation, args);
					}
				}
            }
        }
		
        private function connectContext():void
        {
			if (context)
			{
			    context.addEventListener(InterfaceEvent.UPDATE, onUpdate);
			    context.addEventListener(ContextEvent.DISCONNECT, onDisconnect);
			    context.send(new InterfaceEvent(InterfaceEvent.FIND, this.type, onFound));
			}
        }

        private function disconnectContext():void
        {
			if (context)
			{
				context.removeEventListener(InterfaceEvent.UPDATE, onUpdate);
				context.removeEventListener(ContextEvent.DISCONNECT, onDisconnect); 
                implementation = null; // clear the implementation
			}
        }
    
    
    
    
    
    
    
    
    
    
    	
		
		// IEventDispatcher Implementation // 		
		protected var listeners:Dictionary = new Dictionary(true);
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			if (listeners[type] == null) { listeners[type] = new Dictionary(true); }

			listeners[type][listener] = arguments;
			
			if (implementation)
			{
				implementation.addEventListener(type, listener, useCapture, priority, useWeakReference);				
			}
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return implementation.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return implementation.hasEventListener(type);
		}
		
		/**
		 * Remove the keeping-track of the event listener
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			if (listeners[type] == null) { listeners[type] = new Dictionary(true); }

			delete listeners[type][listener];
			
			if (implementation)
			{
				implementation.removeEventListener(type, listener, useCapture);
			}
		}
		
		public function willTrigger(type:String):Boolean
		{
			return implementation.willTrigger(type);
		}
	}
}
