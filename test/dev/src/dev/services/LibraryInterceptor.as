package dev.services
{
	import mx.utils.ObjectProxy;

	public class LibraryInterceptor extends ObjectProxy // automatically proxies everything else. 
	{
		public var log:ILog;
		
		public function LibraryInterceptor(item:Object)
		{
			super(item);
		}
		
		/** 
		 * Handles the logging!
		 */
		public function createBook(title:String):void
		{
			log.message("Added book " + title);
			this.object.createBook(title); // I could even change the method signature this way. 
		}
	}
}