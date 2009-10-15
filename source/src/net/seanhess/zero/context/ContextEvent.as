package net.seanhess.zero.context
{
	import flash.events.Event;

	public class ContextEvent extends Event
	{
		public static const MESSAGE:String = "message";
		public static const CONNECT:String = "connect";
		public static const DISCONNECT:String = "disconnect";
		
		public static const MESSAGE_ACTIVE:String = "active";
		public static const MESSAGE_CANCELLED:String = "cancelled";
		
		public var event:Event;
		public var status:String = MESSAGE_ACTIVE;
		
		public function ContextEvent(type:String, event:Event = null)
		{
			super(type);
			this.event = event;
		}
		
		override public function clone() : Event
		{
			return new ContextEvent(type, event);
		}
		
		public function cancel():void
		{
			status = MESSAGE_CANCELLED;
		}
	}
}