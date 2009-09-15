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
		protected var implementors:Dictionary = new Dictionary(true);
		
		public function implementService(service:Service, implementation:IServiceImplementation):void
		{
			implementors[service.key] = implementation;		
		}

		/**		
		 * Only one implementor for now
		 */
		public function sendService(service:Service):*
		{
			var implementor:IServiceImplementation = implementors[service.key];
			
			if (implementor == null)
				throw new Error("No implementation of " + service.key);
			
			implementor.call(service);
			return service.result;
		}
	}
}