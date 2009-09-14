package net.seanhess.zero.observe
{
	public interface INotification
	{
		function add(observer:IObserver):void;
		function remove(observer:IObserver):void;
		function send(data:*=null):void
	}
}