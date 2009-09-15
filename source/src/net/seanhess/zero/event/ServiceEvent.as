package net.seanhess.zero.event
{
	import flash.events.Event;
	
	import net.seanhess.zero.interfaces.Service;

	public class ServiceEvent extends Event
	{
		public static const SEND:String = "sendService";

		public var service:Service;
		
		public function ServiceEvent(service:Service=null, type:String=SEND):void
		{
			super(type);
			this.service = service;
		}
	}
}