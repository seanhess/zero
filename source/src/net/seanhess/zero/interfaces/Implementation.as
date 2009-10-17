package net.seanhess.zero.interfaces
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	public class Implementation extends Proxy
	{
		protected var item:*;
		
		public function set fullImplementation(item:*):void
		{
			this.item = item;
		}
		
		public var factory:Class;
		
		
		
		// LAZY -create stuff! wahoo!
		
		
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			item[name] = value;
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			return item[name];	
		}
		
		override flash_proxy function callProperty(name:*, ... args):* {
			
			if (args.length == 1 && args[0].hasOwnProperty("callee"))
			{
				args = args[0];
			}
			
			return item[name].apply(item, args);
		}	
	}
}