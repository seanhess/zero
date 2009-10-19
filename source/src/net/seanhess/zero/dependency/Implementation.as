package net.seanhess.zero.dependency
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	 * Proxy to allow us to manage multiple overlapping implementations
	 * 
	 * Also lets DependencyInterfaces just send in "arguments" instead of the 
	 * parameters. 
	 */
	public class Implementation extends Proxy
	{
		public var onlyImplementation:*;		
		
		// LAZY -create stuff! wahoo!
		
		
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			onlyImplementation[name] = value;
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			return onlyImplementation[name];	
		}
		
		override flash_proxy function callProperty(name:*, ... args):* {
			
			if (args.length == 1 && args[0].hasOwnProperty("callee"))
			{
				args = args[0];
			}
			
			return onlyImplementation[name].apply(onlyImplementation, args);
		}	
	}
}