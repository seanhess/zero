package net.seanhess.zero.context
{
	public interface IContextReceiver
	{
		function subscribe(node:IContextSender):void;
		function unsubscribe(node:IContextSender):void;
		function subscribed(node:IContextSender):Boolean;
		
		function receive(message:Message, from:IContextSender):void;
	}
}