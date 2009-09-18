package net.seanhess.zero.context
{
	public interface IContextReceiver
	{		
		function receive(message:Message, from:IContextSender):void;
	}
}