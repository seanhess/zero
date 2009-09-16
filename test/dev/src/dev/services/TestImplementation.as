package dev.services
{
	[Event(name="charlie", type="flash.events.Event")]
	public class TestImplementation
	{
		[Bindable] public var woot:String = "My Woot";
		
		[Bindable("deathbrain")]
		public var death:int = 0;
		
		public function test(message:String):String
		{
			death++;
			woot = "NEW WOOT";
			dispatchEvent(new Event("charlie"));
			return message + " worked on by TestImplementation";
		}
	}
}