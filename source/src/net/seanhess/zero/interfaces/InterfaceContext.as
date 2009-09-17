package net.seanhess.zero.interfaces
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import net.seanhess.zero.context.Context;
	import net.seanhess.zero.context.IContextSender;
	import net.seanhess.zero.context.Message;
	import net.seanhess.zero.event.NotificationEvent;
	import net.seanhess.zero.event.PropertyEvent;
	import net.seanhess.zero.event.ServiceEvent;
	
	
	
	/**
	 * Remember, the class doesn't need any special access to set properties, 
	 * or fire events. It needs to register itself as an implementor of those
	 * properties and events.
	 * 
	 * 
	 */
	public class InterfaceContext extends Context implements IInterfaceContext
	{
		public static const SERVICE:String = "service";
		public static const UPDATE:String = "update";
		public static const GET:String = "get";
		public static const NOTIFICATION:String = "notification";
		
		protected var dispatcher:IEventDispatcher = new EventDispatcher();

		
		public function sendService(service:Service):void
		{
			var message:Message = new Message(SERVICE, service);
			dispatchMessage(message); // shoot, this will relay it
			send(message);
		}

		public function sendUpdate(property:Property):void
		{
			var message:Message = new Message(UPDATE, property); 
			dispatchMessage(message);
			send(message);
		}
		
		public function sendGet(property:Property):void
		{
			var message:Message = new Message(GET, property);
			dispatchMessage(message);
			send(message);
		}
		
		public function sendNotification(notification:Notification):void
		{
			var message:Message = new Message(NOTIFICATION, notification) 
			dispatchMessage(message);
			send(message);
		}
		
		
		// so now I have the same thing as before, but it can happen through the context network 		
		override public function receive(message:Message, from:IContextSender) : void
		{
			super.receive(message, from);
			dispatchMessage(message);
		}
		
		protected function dispatchMessage(message:Message):void
		{
			switch (message.type)
			{
				case SERVICE:
					dispatchEvent(new ServiceEvent(message.data as Service));
					break;
				
				case UPDATE:
					dispatchEvent(new PropertyEvent(message.data as Property));
					break;
				
				case GET:
					dispatchEvent(new PropertyEvent(message.data as Property, PropertyEvent.GET));
					break;
				
				case NOTIFICATION:
					dispatchEvent(new NotificationEvent(message.data as Notification));
					break;
			}
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