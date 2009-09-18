package net.seanhess.zero.scan
{
	public class PropertyInfo
	{
		public static const READ:String = "read";
		public static const WRITE:String = "write";
		public static const READ_WRITE:String = "readwrite";
		
		public var name:String;
		public var type:String;
		public var access:String;
		public var bindable:Boolean;
		public var event:String; // the bindable event type
		public var metadata:Object = {}; // just a flat map of metadata flags... no values for now
		
		public function toString():String
		{
			return name;
		}
	}
}