package net.seanhess.zero.interfaces
{
	import flash.events.EventDispatcher;
	
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
	public class Context extends EventDispatcher implements IContext
	{
		/**
		 * the service object will be modified by the implementors
		 */
		public function sendService(service:Service):void
		{
			dispatchEvent(new ServiceEvent(service)); 
		}

		/**
		 * Property Update Event :: The interfaces should be listening on their context for these
		 * .. correcto?
		 */
		public function sendUpdate(property:Property):void
		{
			dispatchEvent(new PropertyEvent(property));
		}
		
		public function sendNotification(notification:Notification):void
		{
			dispatchEvent(new NotificationEvent(notification));
		}
	}
}