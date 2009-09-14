package net.seanhess.zero.observe
{
	import flash.utils.Dictionary;
	
	public class Notification implements INotification
	{
		public var observers:Dictionary;
		public var data:*;
		
		public function Notification()
		{
			observers = new Dictionary(true);
		}
		
		public function add(observer:IObserver):void
		{
			observers[observer.key] = observer;	
		}
		
		public function remove(observer:IObserver):void
		{
			delete observers[observer.key];
		}
		
		public function send(data:*=null):void
		{
			if (data != null) this.data = data;
			
			for each (var observer:IObserver in observers)
			{
				observer.call(this, data);
			}
		}
	}
}