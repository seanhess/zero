package net.seanhess.zero.observe
{
	public class Observer implements IObserver
	{
		public static const ALWAYS:String = "always";
		public static const ONCE:String = "once";
		
		public var callback:Function;
		public var params:Array;
		public var type:String = ALWAYS;
		
		public function get key():*
		{
			return callback as Object;
		}
		
		public function call(notification:INotification, data:*):void
		{
			callback.apply(null, [data].concat(params));
			
			if (type == ONCE)
				notification.remove(this);
		}
	}
}