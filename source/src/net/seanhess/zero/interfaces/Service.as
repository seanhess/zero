package net.seanhess.zero.interfaces
{
	

	/**
	 * this is information about the call of a service. 
	 * 
	 * And also about who it is?
	 */
	public class Service
	{
		public var type:String; // the interface name
		public var name:String; // the service name
		
		public var params:Array;
		public var result:*;
//		public var stop:Boolean = false; // just stop the event
//		public var implementors:Array = []; // a record of who has worked on her, in order
	}
}