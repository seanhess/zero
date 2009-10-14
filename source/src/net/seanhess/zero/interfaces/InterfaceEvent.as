package net.seanhess.zero.interfaces
{
	import flash.events.Event;

	public class InterfaceEvent extends Event
	{
		public static const FIND:String = "find";
		public static const FOUND:String = "found";
		
		public static const UPDATE:String = "update"; // a new interface is available

		/**
		 * The fully qualified class name of the interface
		 */
		public var face:String;
		
		/**
		 * The implementation. This is filled with the implementation on 
		 * FOUND and UPDATE events
		 */
		public var implementation:*; 
		
		public function InterfaceEvent(type:String, face:Object)
		{
			super(type);
			
			if (face is String)
			{
				this.face = face as String;
			}
			else if (face.hasOwnProperty("type")) // for Interface
			{
				this.face = face.type;
			}
			else
			{
				throw new Error("Face must be String or have a 'type' property");
			}
		}
		
		override public function clone() : Event
		{
			return new InterfaceEvent(type, face);
		}
	}
}