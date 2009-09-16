package dev.interfaces
{
	import net.seanhess.zero.interfaces.Interface;

	[Event(name="charlie", type="flash.events.Event")]
	public class Test extends Interface
	{
		[Bindable] public var woot:String;
		
		[Bindable("deathbrain")]
		public var death:int;
		
		public function test(message:String):String
		{
			return send(test, message);
		}
	}
}