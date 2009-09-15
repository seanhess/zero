package net.seanhess.zero.implement
{
	import net.seanhess.zero.event.ServiceEvent;
	import net.seanhess.zero.interfaces.Connector;
	import net.seanhess.zero.interfaces.Context;
	import net.seanhess.zero.interfaces.Service;
	import net.seanhess.zero.interfaces.ContextClient;

	public class ImplementService extends ContextClient
	{
		public var method:Function;
		
		protected var _id:String;
		
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
		
		override protected function connect():void
		{
			context.addEventListener(ServiceEvent.SEND, onSend);
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