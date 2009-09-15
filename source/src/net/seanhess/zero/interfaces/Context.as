package net.seanhess.zero.interfaces
{
	import flash.utils.Dictionary;
	
	import net.seanhess.zero.implement.IServiceImplementation;
	

	
	
	/**
	 * Remember, the class doesn't need any special access to set properties, 
	 * or fire events. It needs to register itself as an implementor of those
	 * properties and events.
	 * 
	 * 
	 */
	public class Context extends Object
	{
		protected var services:Dictionary = new Dictionary(true);
		
		public function implementService(implementation:IServiceImplementation):void
		{
			services[implementation.id] = implementation;		
		}

		/**		
		 * Only one implementor for now
		 */
		public function sendService(service:Service):*
		{
			var implementor:IServiceImplementation = services[service.id];
			
			if (implementor == null)
				throw new Error("No implementation of " + service.id);
			
			implementor.call(service);
			return service.result;
		}
	}
}