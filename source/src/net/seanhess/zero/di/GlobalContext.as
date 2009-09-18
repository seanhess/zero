package net.seanhess.zero.di
{
	import net.seanhess.zero.context.Context;

	/**
	 * Connects to a global context. So you can just create
	 * a new one of these.
	 */
	public class GlobalContext extends Context
	{
		public static const FIND_TYPE:String = "findType";
		
		public static var root:Context = new Context();
		
		public function GlobalContext()
		{
			trace("NEW GLOBAL CONTEXT");
			root.link(this); // unless it IS root			
		}
	}
}