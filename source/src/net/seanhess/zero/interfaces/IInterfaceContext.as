package net.seanhess.zero.interfaces
{
	import flash.events.IEventDispatcher;

	public interface IInterfaceContext extends IEventDispatcher
	{
		function sendService(service:Service):void;
		function sendUpdate(property:Property):void;
		function sendGet(property:Property):void;
		function sendNotification(notification:Notification):void;
	}
}