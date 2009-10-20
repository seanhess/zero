package net.seanhess.zero.dependency
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/**
	 * Anything not implemented will hit this. Do Nothing
	 */
	public class IgnoreIfMissing extends Proxy
	{
		override flash_proxy function setProperty(name:*, value:*):void 
		{
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			return null;
		}
		
		override flash_proxy function callProperty(name:*, ... args):* {
			return null;
		}	
	}
}