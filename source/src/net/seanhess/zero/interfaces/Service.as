package net.seanhess.zero.interfaces
{
	import flash.utils.Dictionary;

	/**
	 * this is information about the call of a service. 
	 * 
	 * And also about who it is?
	 */
	public class Service
	{
		public var id:String;		
		public var params:Array;
		public var result:*;
		public var stop:Boolean = false;
		public var implementors:Array = []; // a record of who has worked on her, in order
	}
}