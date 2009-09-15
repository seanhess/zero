package net.seanhess.zero.interfaces
{
	import flash.events.EventDispatcher;
	
	import net.seanhess.zero.scan.SimpleScan;
	import net.seanhess.zero.util.QuickListener;

	public class Interface extends EventDispatcher
	{
		/**
		 * the current context. How does it get this?  Singleton for now?
		 */
		protected var context:Context;
		
		/**
		 * Helps us get the current context
		 */
		protected var connector:Connector;
		
		protected var scan:SimpleScan = new SimpleScan();
		
		public function Interface()
		{
			connector = new Connector(this);
			context = connector.getContext();
		}
		
		
		/**
		 * Easy access to a quicklistener instance. See QuickListener
		 */
		public function get events():QuickListener
		{
			_events = _events || new QuickListener(this);
			return _events; 
		}
		protected var _events:QuickListener;

		/**
		 * Sends a service
		 */
		public function send(method:Function, ...params):*
		{
			var service:Service = new Service();
				service.face = this;
				service.method = scan.getMethodName(this, method);
				service.params = params;
			
			return context.sendService(service);
		}
	}
}