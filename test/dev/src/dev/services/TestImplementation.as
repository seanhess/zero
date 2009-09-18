package dev.services
{
	import dev.di.ITest;

	[Event(name="charlie", type="flash.events.Event")]
	public class TestImplementation implements ITest
	{
		[Bindable] public var woot:String = "My Woot";
		
		[Bindable("deathbrain")]
		public function set death(value:int):void
		{
			_death = value;
			dispatchEvent(new Event("deathbrain"));
		}
		
		public function get death():int
		{
			return _death;
		}
		protected var _death:int = 0;
		
		public function test(message:String):String
		{
			death++;
			dispatchEvent(new Event("deathbrain"));
			woot = "NEW WOOT";
			dispatchEvent(new Event("charlie"));
			return message + " worked on by TestImplementation";
		}
	}
}