package net.seanhess.zero.inter
{
	import net.seanhess.zero.util.QuickListener;

	public class Interface
	{
		/**
		 * the current context. How does it get this?
		 */
		public var context:Context;
		
		
		
		/**
		 * Easy access to a quicklistener instance. See QuickListener
		 */
		public function get events():QuickListener
		{
			_events = _events || new QuickListener(this);
			return _events; 
		}
		protected var _events:QuickListener;

		public function send(method:Function, ...more):void
		{
			context.sendService(more);			
		}
	}
}