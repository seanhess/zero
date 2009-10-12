package dev.interfaces
{
	import net.seanhess.zero.interfaces.Interface;

	[Event(name="charlie", type="flash.events.Event")]
	public class Test extends Interface
	{
		[Bindable] public var woot:String;
		
		[Bindable("deathbrain")]
		public var death:int;
		
		// shoot, this won't work, bc it will just call the getter again
		// lame!
		
		// the other option is to always declare them as properties, and the implementation can decide 
		// whether they are get/set or read-only or whatever
		
		// it wouldn't be THAT big of a deal
		
		// could throw a run-time error if they set a read-only prop. 
		// could throw a run-time error if the implementor is only read-only and there's no one listening
		
		[Bindable("message")]
		public function get message():String 		{ return _get(message) }
		public function set message(value:String)	{ _set(message, value) }
		
		public function test(message:String):String
		{
			return _send(test, message);
		}
	}
}