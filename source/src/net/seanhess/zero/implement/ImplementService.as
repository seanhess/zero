package net.seanhess.zero.implement
{
	import net.seanhess.zero.interfaces.Service;

	public class ImplementService implements IServiceImplementation
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
		
		public function call(service:Service):void
		{
			service.result = method.apply(null, service.params);
		}
	}
}