package net.seanhess.zero.dependency
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/**
	 * Anything not implemented will hit this. Just throw an error. 
	 */
	public class ThrowErrorIfMissing extends Proxy
	{
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			throw new Error("set property " + name + " to " + value);
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			throw new Error("get property "+ name);
			return null;
		}
		
		override flash_proxy function callProperty(name:*, ... args):* {
			throw new Error("call property "+ name " with " + args.length + " arguments");
			return null;
		}	
	}
}