package net.seanhess.zero.event
{
	import flash.events.Event;
	
	import net.seanhess.zero.interfaces.Service;
	
	public class PropertyEvent extends Event
	{
		public static const UPDATE:String = "updateProperty";
		
		public var property:Property;
		
		public function PropertyEvent(service:Service=null, type:String=UPDATE):void
		{
			super(type);
			this.property = property;
		}
	}
}