package net.seanhess.zero.interfaces
{
	import flash.events.Event;

	public class InterfaceEvent extends Event
	{
		public static const FIND:String = "find";
		
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
		
		/**
		 * the callback to call once a find request is finished
		 * Takes one parameter, this event. 
		 */
		public var callback:Function;
		
		public function InterfaceEvent(type:String, face:String, callback:Function = null)
		{
			super(type);
			
			this.callback = callback;
			this.face = face;			
		}
		
		override public function clone() : Event
		{
			return new InterfaceEvent(type, face, callback);
		}
	}
}