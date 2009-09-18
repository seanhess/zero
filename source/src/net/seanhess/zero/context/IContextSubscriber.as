package net.seanhess.zero.context
{
	public interface IContextSubscriber extends IContextReceiver
	{
		function subscribe(node:IContextSender):void;
		function unsubscribe(node:IContextSender):void;
		function subscribed(node:IContextSender):Boolean;
	}
}