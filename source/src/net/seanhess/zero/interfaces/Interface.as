package net.seanhess.zero.interfaces
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import net.seanhess.zero.event.NotificationEvent;
	import net.seanhess.zero.event.PropertyEvent;
	import net.seanhess.zero.scan.SimpleScan;
	import net.seanhess.zero.scan.TypeInfo;
	import net.seanhess.zero.util.QuickListener;
	

	public class Interface extends EventDispatcher implements IContextClient
	{
		protected var _context:IInterfaceContext;
		protected var ids:IDs = new IDs();
		protected var _info:TypeInfo;
		protected var scan:SimpleScan = new SimpleScan();
		
		public function Interface()
		{
		}

		public function set context(value:IInterfaceContext):void
		{
			if (_context)
			{
				_context.removeEventListener(PropertyEvent.UPDATE, onUpdate);
				_context.removeEventListener(NotificationEvent.SEND, onNotification);
			}
			
			_context = value;	
			
			if (value)
			{
				_context.addEventListener(PropertyEvent.UPDATE, onUpdate, false, 0, true);
				_context.addEventListener(NotificationEvent.SEND, onNotification, false, 0, true);
				// anything in here?
			}
		}
		
		public function get context():IInterfaceContext
		{
			return _context;		
		}
		
		/**
		 * The class information from describe type
		 */
		public function get info():TypeInfo
		{
			_info = _info || scan.getObjectInfo(this);
			return _info;
		}
		
		
		
		/**
		 * Sends a service
		 */
		public function send(method:Function, ...params):*
		{
			var service:Service = new Service();
			service.type = ids.getType(this);
			service.name = ids.getName(this, method);
			service.params = params;
			
			context.sendService(service);
			
			return service.result;
		}
		
		protected function onUpdate(event:PropertyEvent):void
		{
			if (event.property.type == info.name)
			{
				this[event.property.name] = event.property.value;
			}
		}
		
		protected function onNotification(event:NotificationEvent):void
		{
			if (event.notification.type == info.name)
			{
				dispatchEvent(event.notification.event);
			}
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