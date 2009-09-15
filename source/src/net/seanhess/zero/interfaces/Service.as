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
		public var face:Interface;
		
		public var type:Class;
		public var method:String;
		public var params:Array;
		public var result:*;
		public var stop:Boolean = false;
		
		public var scan:SimpleScan = new SimpleScan();
		
		public function get key():String
		{
			var info:TypeInfo = (type) ? scan.getClassInfo(type) : scan.getObjectInfo(face);
			
			return "Service::" + info.definitionName + "::" + method;
		}
	}
}