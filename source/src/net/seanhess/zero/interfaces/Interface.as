package net.seanhess.zero.interfaces
{
	import flash.events.EventDispatcher;
	
	import net.seanhess.zero.util.QuickListener;
	

	public class Interface extends EventDispatcher implements IContextClient
	{
		protected var _context:IContext;
		protected var ids:IDs = new IDs();
		protected var connector:Connector;
		
		public function Interface()
		{
			connector = new Connector();
			connector.registerInterface(this);
		}

		public function set context(value:IContext):void
		{
			_context = value;	
			
			if (value)
			{
				// anything in here?
			}
		}
		
		public function get context():IContext
		{
			return _context;		
		}
		
		// these guys need to GET a handle on the context magically somehow. //
		
		
		
		/**
		 * Sends a service
		 */
		public function send(method:Function, ...params):*
		{
			var service:Service = new Service();
			service.id = ids.getServiceIDFromInterface(this, method);
			service.params = params;
			
			context.sendService(service);
			
			return service.result;
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
		
		
	}
}