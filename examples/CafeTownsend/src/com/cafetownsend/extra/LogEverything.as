package net.seanhess.zero.dependency
{
	import flash.utils.flash_proxy;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	/**
	 * Anything not implemented will hit this
	 */
	public class LogEverything extends ObjectProxy
	{
		private var log:ILogger;
		
		public function LogEverything()
		{
			log = Log.getLogger("test"); // you can attach it somewhere else. 
		}
		
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			log.debug("set property " + name + " :: " + value);	
			super.setProperty(name, value);
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			log.debug("get property " + name);	
			return super.setProperty(name, value);
		}
		
		override flash_proxy function callProperty(name:*, ... args):* {
			log.debug("call property " + name);
			return super.callProperty.apply(this, [name].concat(args)); // there's no easy way to call super 
		}	
	}
}