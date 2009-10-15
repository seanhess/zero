package net.seanhess.zero.context
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * Creates a tree of event dispatchers that relay information to each other
	 */
	[Event(name="connect", type="net.seanhess.zero.context.ContextEvent")]
	[Event(name="disconnect", type="net.seanhess.zero.context.ContextEvent")]
	[Event(name="message", type="net.seanhess.zero.context.ContextEvent")]
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
			dispatchEvent(new ContextEvent(ContextEvent.CONNECT));
		}
		
		public function disconnect():void
		{
			parent.removeEventListener(ContextEvent.MESSAGE, onMessage);
			parent = null;
			dispatchEvent(new ContextEvent(ContextEvent.DISCONNECT));
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
				
				// parent first, then children
				if (parent && message.status == ContextEvent.MESSAGE_ACTIVE)
				{
					parent.relay(message);
				}
				
				// children
				if (message.status == ContextEvent.MESSAGE_ACTIVE)
				{
					dispatchEvent(message);
				}
			}
		}
		
		protected function onMessage(message:ContextEvent):void
		{
			relay(message);
		}
		
		public function cancelLastMessage():void
		{
			lastMessage.cancel();
		}
	}
}