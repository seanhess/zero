package net.seanhess.zero.implement
{
	import net.seanhess.zero.interfaces.Service;

	public class InterceptService
	{
		/**
		 * Call the method and allow it to stop the service.
		 * 
		 * I don't really need to create a new service, do I?
		 * 
		 * Any of those guys can alter it. 
		 */
		public function call(service:Service):void
		{
//			service.apply(null, service);
		}
	}
}