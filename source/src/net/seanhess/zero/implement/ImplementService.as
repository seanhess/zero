package net.seanhess.zero.implement
{
	import net.seanhess.zero.event.ServiceEvent;
	import net.seanhess.zero.interfaces.IContextClient;
	import net.seanhess.zero.interfaces.IInterfaceContext;

	public class ImplementService implements IContextClient
	{
		public var method:Function;
		
		protected var _context:IInterfaceContext;
		protected var type:String;
		protected var name:String;
		
		public function set context(value:IInterfaceContext):void
		{
			_context = value;
			
			if (context)
			{
				context.addEventListener(ServiceEvent.SEND, onSend);
			}
		}
		
		public function get context():IInterfaceContext
		{
			return _context;
		}
		
		
		public function ImplementService(type:String, name:String, method:Function=null)
		{
			this.type = type;
			this.name = name;
			this.method = method;
		}
		
		protected function onSend(event:ServiceEvent):void
		{
			if (event.service.type == type && event.service.name == name)
			{
				event.service.result = method.apply(null, event.service.params);
			}
		}
	}
}