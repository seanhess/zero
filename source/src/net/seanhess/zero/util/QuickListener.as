package net.seanhess.zero.util
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	 * Allows someone to listen to several possible events on an object
	 * with the following syntax:
	 * 
	 * var listener:QuickListener = new QuickListener(myIEventDispatcher);
	 * listener.firstEvent(onFirstEvent).secondEvent(onSecondEvent)
	 * 
	 * It removes all listeners when ANY of them fire
	 */
	dynamic public class QuickListener extends Proxy
	{
		public var target:IEventDispatcher;
		
		protected var listeners:Dictionary;
		
		public function QuickListener(target:IEventDispatcher)
		{
			this.target = target;	
			listeners = new Dictionary(true);
		}
		
		override flash_proxy function callProperty(name:*, ... rest):*
		{
			var type:String = name as String;
			var callback:Function = rest[0] as Function;
			
			target.addEventListener(type, callback, false, 0, true);
			target.addEventListener(type, onEvent, false, 0, true);
			listeners[type] = callback;
			
			return this;
		}
		
		public function removeAll():void
		{
			for (var type:String in listeners)
			{
				target.removeEventListener(type, listeners[type]);
				target.removeEventListener(type, onEvent);
			}
		}
		
		protected function onEvent(event:Event):void
		{
			removeAll();
		}
	}
}