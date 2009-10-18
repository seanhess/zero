package net.seanhess.zero.common
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import net.seanhess.zero.interfaces.Interface;
	
	public class ZEventDispatcher extends Interface implements IEventDispatcher
	{
		public function ZEventDispatcher(context:*) { super(context) }
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			i.addEventListener(arguments);	
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return i.dispatchEvent(event);	
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return i.hasEventListener(type);	
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			i.removeEventListener(arguments);	
		}
		
		public function willTrigger(type:String):Boolean
		{
			return i.willTrigger(type);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
//		private function disconnectImplementation():void
//		{
//			for (var type:String in listeners)
//			{
//				for each(var args:Array in listeners[type])
//				{
//					args = args.slice(0, 3);
//					implementation.removeEventListener.apply(implementation, args);
//				}
//			}
//		}	
//		
//		private function connectImplementation():void
//		{
//			for (var type:String in listeners)
//			{
//				for each(var args:Array in listeners[type])
//				{
//					implementation.addEventListener.apply(implementation, args);
//				}
//			}
//		}
		
		
		
		
		
		//		// IEventDispatcher Implementation // 		
		//		protected var listeners:Dictionary = new Dictionary(true);
		//		
		//		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		//		{
		//			if (listeners[type] == null) { listeners[type] = new Dictionary(true); }
		//
		//			listeners[type][listener] = arguments;
		//			
		//			if (implementation)
		//			{
		//				implementation.addEventListener(type, listener, useCapture, priority, useWeakReference);				
		//			}
		//		}
		//		
		//		public function dispatchEvent(event:Event):Boolean
		//		{
		//			return implementation.dispatchEvent(event);
		//		}
		//		
		//		public function hasEventListener(type:String):Boolean
		//		{
		//			return implementation.hasEventListener(type);
		//		}
		//		
		//		/**
		//		 * Remove the keeping-track of the event listener
		//		 */
		//		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		//		{
		//			if (listeners[type] == null) { listeners[type] = new Dictionary(true); }
		//
		//			delete listeners[type][listener];
		//			
		//			if (implementation)
		//			{
		//				implementation.removeEventListener(type, listener, useCapture);
		//			}
		//		}
		//		
		//		public function willTrigger(type:String):Boolean
		//		{
		//			return implementation.willTrigger(type);
		//		}
	}
}