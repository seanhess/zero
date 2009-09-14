package dev.dependency
{
	import net.seanhess.zero.inter.Dependency;
	import net.seanhess.zero.inter.Result;

	public class Test extends Dependency
	{
		public function test(message:String):Result
		{
			return send(test, message);
		}
	}
}