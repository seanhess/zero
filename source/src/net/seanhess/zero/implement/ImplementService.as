package net.seanhess.zero.implement
{
	import net.seanhess.zero.interfaces.Service;

	public class ImplementService implements IServiceImplementation
	{
		public var method:Function;
		
		public function ImplementService(method:Function=null)
		{
			this.method = method;
		}
		
		public function call(service:Service):void
		{
			service.result = method.apply(null, service.params);
		}
	}
}