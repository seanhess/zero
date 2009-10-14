package net.seanhess.zero.context
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * Creates a tree of event dispatchers that relay information to each other
	 */
	public class Context extends EventDispatcher
	{
		protected var parent:IContext;
		protected var lastMessage:ContextEvent;
		
		/**
		 * Attach yourself to the network.
		 */
		public function connect(parent:IContext):void
		{
			this.parent = parent;
			this.parent.addEventListener(ContextEvent.MESSAGE, onMessage);
		}
		
		public function disconnect():void
		{
			parent.removeEventListener(ContextEvent.MESSAGE, onMessage);
			parent = null;
		}
		
		
		/**
		 * Dispatch an event to everybody
		 */
		public function send(event:Event):void
		{
			var message:ContextEvent = new ContextEvent(ContextEvent.MESSAGE, event);
			relay(message);
		}
		
		public function relay(message:ContextEvent):void
		{
			// only do it once!
			if (lastMessage != message)
			{
				lastMessage = message;
				
				// self 
				dispatchEvent(message.event);
				
				// children
				dispatchEvent(message);
				
				// parent
				if (parent)
				{
					parent.relay(message);
				}
			}
		}
		
		protected function onMessage(message:ContextEvent):void
		{
			relay(message);
		}
	}
}