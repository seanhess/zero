package net.seanhess.zero.context
{
	import flash.utils.Dictionary;
	
	

	/**
	 * A node for communication across a distance
	 */
	public class Context implements IContextSender, IContextReceiver, IContextConnectable, IContextNode
	{
		protected var subscribers:Dictionary;
		protected var senders:Dictionary;
		protected var lastMessage:Message;
		
		public function Context()
		{
			subscribers = new Dictionary(true);
		}
		
		
		
		
		
		private var _connected:Boolean;
		
		public function set connected(value:Boolean):void
		{
			_connected = value;
		}
		
		public function get connected():Boolean
		{
			return _connected;	
		}
		
		public function destroyConnection():void
		{
			
		}

		
		
		/**
		 * Means the node is subscribing to you... Don't call this! 
		 */
		internal function addSubscriber(node:IContextReceiver):void
		{
			subscribers[node] = node;
		}
		
		internal function removeSubscriber(node:IContextReceiver):void
		{
			delete subscribers[node];						
		}
		
		internal function hasSubscriber(node:IContextReceiver):Boolean
		{
			return (subscribers[node] != null);	
		}
		
		
		
		/**
		 * Subscribe yourself to the sender
		 */
		public function subscribe(node:IContextSender):void
		{
			node.addSubscriber(this);
			senders[node] = node;
		}
		
		/**
		 * Unsubscribe one's self from the sender
		 */
		public function unsubscribe(node:IContextSender):void
		{
			node.removeSubscriber(this);
			delete senders[node];
		}
		
		/**
		 * Whether we are subscribed to the sender
		 */
		public function subscribed(node:IContextSender):Boolean
		{
			return (senders[node] != null);
		}
		
		
		
		/**
		 * Sets up subscriptions in both directions
		 */
		public function link(node:*):void
		{
			if (node is IContextSender && !subscribed(node))
			{
				subscribe(node);
			}
			
			if (node is IContextReceiver && !node.subscribed(this))
			{
				node.subscribe(this);
			}	
		}	

		public function unlink(node:*):void
		{
			if (node is IContextSender)
			{
				unsubscribe(node);
			}
			
			if (node is IContextReceiver)
			{
				node.unsubscribe(this);
			}
		}

		
		
		
		
		
		
		
		
		
		/**
		 * Broadcast a message
		 */
		public function send(message:Message):void
		{
			// send to all your links	
			message.broadcaster = this;
			relay(message, this);
		}
		
		/**
		 * Receive a message (unless we've already had it)
		 */
		public function receive(message:Message, from:IContextSender):void
		{
			if (message != lastMessage)
			{
				relay(message, from);
			}
		}
		
		/**
		 * Send a message to all of our subscribers (unless they've already had it)
		 */
		protected function relay(message:Message, from:IContextSender):void
		{
			lastMessage = message;
			
			for each (var subscriber:IContext in subscribers)
			{
				if (subscriber != message.broadcaster && subscriber != from) // don't send it back
				{
					subscriber.receive(message, this);
				}
			}
		}
		
	}
}