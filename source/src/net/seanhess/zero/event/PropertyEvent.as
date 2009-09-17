package net.seanhess.zero.event
{
	import flash.events.Event;
	
	import net.seanhess.zero.interfaces.Property;
	import net.seanhess.zero.interfaces.Service;
	
	public class PropertyEvent extends Event
	{
		public static const UPDATE:String = "updateProperty";
		public static const GET:String = "getProperty";
		
		public var property:Property;
		
		public function PropertyEvent(property:Property=null, type:String=UPDATE):void
		{
			super(type);
			this.property = property;
		}
	}
}