package net.seanhess.zero.context
{
	import flash.events.Event;

	public class ContextEvent extends Event
	{
		public static const MESSAGE:String = "message";
		
		public var event:Event;
		
		public function ContextEvent(type:String = MESSAGE, event:Event = null)
		{
			super(type);
			this.event = event;
		}
		
		override public function clone() : Event
		{
			return new ContextEvent(type, event);
		}
	}
}