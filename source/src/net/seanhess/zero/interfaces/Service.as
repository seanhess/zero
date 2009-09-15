package net.seanhess.zero.interfaces
{
	import net.seanhess.zero.scan.SimpleScan;
	import net.seanhess.zero.scan.TypeInfo;

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
	}
}