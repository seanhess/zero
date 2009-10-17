package net.seanhess.zero.interfaces
{
	import net.seanhess.zero.context.IContext;
	import net.seanhess.zero.util.Invalidator;

	[DefaultProperty("rules")]
	public class Connect
	{
		protected var _context:IContext;
		protected var _rules:Array;
		protected var invalidator:Invalidator = new Invalidator(commit);
		
		public function set context(value:IContext):void
		{
			_context = value;
			invalidator.invalidate("init");
		}
		
		public function set rules(value:Array):void
		{
			_rules = value;
			invalidator.invalidate("init");
		}
		
		protected function commit():void
		{
			// loop through and create a proxy for each one, based on the rules! // 
		}
	}
}