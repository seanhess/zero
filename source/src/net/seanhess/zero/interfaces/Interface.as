package net.seanhess.zero.interfaces
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.core.IMXMLObject;
	
	import net.seanhess.zero.context.Register;
	import net.seanhess.zero.context.Utils;
	
	/**
	 * The implementation will be 
	 */
	public class Interface implements IEventDispatcher, IMXMLObject
	{
		protected var utils:Utils = new Utils();	
		
		protected var type:String;
		
		protected var context:String;
		
		/**
		 * The implementation
		 */
		protected var _implementation:*;
		
		protected var register:Register = new Register();
		
		public function Interface(context:*=null)
		{
			type = utils.getName(this);
			setContext(context);
		}

		public function initialized(document:Object, id:String):void
		{
			setContext(document);
		}
		
		
		/**
		 * Context gives this interface a place to listen
		 */
		protected function setContext(value:*):void
		{
			// only perform this if not null. 
			if (!value) return;
			
			context = utils.getName(value);
			
			connect();
		}
		
		public function disconnect():void
		{
			implementation = null;
		}
		
		public function connect():void
		{
			implementation = register.seek(type, context);
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
