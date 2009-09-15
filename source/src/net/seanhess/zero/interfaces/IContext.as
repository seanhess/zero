package net.seanhess.zero.interfaces
{
	import flash.events.IEventDispatcher;

	public interface IContext extends IEventDispatcher
	{
		function sendService(service:Service):void;
		function sendUpdate(property:Property):void;
		function sendNotification(notification:Notification):void;
	}
}