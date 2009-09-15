package dev.interfaces
{
	import net.seanhess.zero.interfaces.Interface;

	public class Test extends Interface
	{
		public function test(message:String):String
		{
			return send(test, message);
		}
	}
}