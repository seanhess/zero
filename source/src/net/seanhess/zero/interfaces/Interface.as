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
	public class Interface implements IMXMLObject
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

			if (implementation)
            	disconnectImplementation();
			
			_implementation = value;
			
			if (implementation)
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
	
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    	
		
        protected function disconnectImplementation():void
        {

		}	

        protected function connectImplementation():void
        {

		}
		
    
    
    
    
    
    
    
    
    
    	
	}
}
