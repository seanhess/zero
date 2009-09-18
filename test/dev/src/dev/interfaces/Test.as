package dev.interfaces
{
	import net.seanhess.zero.interfaces.Interface;

	[Event(name="charlie", type="flash.events.Event")]
	public class Test extends Interface
	{
		[Bindable] public var woot:String;
		
		[Bindable("deathbrain")]
		public var death:int;
		
		// that way it will activate natural stuff, right? 
		// when the binding event fires (which it will, naturally because I'm listening for it already)
		// then they can get it ....  but I don't want to fire a get request every time it's called...
		
		// what if they don't mark the property as bindable?
		// we can still set it just fine
		
		// but we couldn't respond to it ;(
		// binding sucks anyway
		// your mom sucks
		
//		public function get cheese():String 		{ return g(cheese) }
//		public function set cheese(value:String)	{ s(cheese, value) }
		
		public function test(message:String):String
		{
			return send(test, message);
		}
	}
}