package net.seanhess.zero.observe
{
	public interface IObserver
	{
		function get key():*;
		function call(notification:INotification, data:*):void;
	}
}