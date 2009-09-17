package net.seanhess.zero.interfaces
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * I need a better way to do this :)
	 * 
	 * What if I register the connector objects themselves?
	 * 
	 * Bind to the static guy? They need that context!
	 * 
	 * Some stupid singleton for now? What?
	 */
	[Event(name="newContext", type="flash.events.Event")]
	public class Connector extends Object implements IEventDispatcher
	{
		public static const NEW_CONTEXT:String = "newContext";
		
		protected static var _context:IContext;
		protected static var dispatcher:IEventDispatcher = new EventDispatcher();
		
		public function Connector()
		{
			
		}
		
		[Bindable("newContext")]
		public function set context(value:IContext):void
		{
			_context = value;
			dispatchEvent(new Event(NEW_CONTEXT)); // will fire the binding for EVERYBODY
		}
		
		public function get context():IContext
		{
			return _context;
		}
		
		
		
		
		
		
		
		
		
		
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return dispatcher.hasEventListener(type);	
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return dispatcher.willTrigger(type);
		}
	}
}