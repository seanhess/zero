package net.seanhess.zero.implement
{
	import net.seanhess.zero.event.ServiceEvent;
	import net.seanhess.zero.interfaces.IContext;
	import net.seanhess.zero.interfaces.IContextClient;

	public class ImplementService implements IContextClient
	{
		public var method:Function;
		
		protected var _id:String;
		protected var _context:IContext;
		
		public function set context(value:IContext):void
		{
			_context = value;
			
			if (context)
			{
				context.addEventListener(ServiceEvent.SEND, onSend);
			}
		}
		
		public function get context():IContext
		{
			return _context;
		}
		
		
		public function set id(value:String):void
		{
			_id = value;	
		}
		
		public function get id():String
		{
			return _id;	
		}
		
		public function ImplementService(id:String=null, method:Function=null)
		{
			this.id = id;
			this.method = method;
		}
		
		protected function onSend(event:ServiceEvent):void
		{
			if (event.service.id == id)
			{
				event.service.implementors.push(this);
				event.service.result = method.apply(null, event.service.params);
			}
		}
	}
}