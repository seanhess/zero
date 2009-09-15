package net.seanhess.zero.event
{
	import flash.events.Event;
	
	import net.seanhess.zero.interfaces.Service;
	
	public class NotificationEvent extends Event
	{
		public static const SEND:String = "sendNotification";
		
		public var notification:Notification;
		
		public function NotificationEvent(notification:Notification, type:String=SEND):void
		{
			super(type);
			this.notification = notification;
		}
	}
}