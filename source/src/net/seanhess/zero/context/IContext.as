package net.seanhess.zero.context
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public interface IContext extends IEventDispatcher
	{
		function relay(message:ContextEvent):void;
		function send(message:Event):void;
	}
}