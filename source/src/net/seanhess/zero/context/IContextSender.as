package net.seanhess.zero.context
{
	public interface IContextSender
	{
		function addSubscriber(node:IContextReceiver):void;
		function removeSubscriber(node:IContextReceiver):void;
		function subscribed(node:IContextReceiver):Boolean;
		
		
		function send(message:Message):void;
	}
}