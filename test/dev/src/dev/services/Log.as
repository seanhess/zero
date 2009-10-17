package dev.services
{
	/**
	 * Fake thing for log messages... Just to give me a second class
	 */
	public class Log
	{
		public function Log()
		{
			
		}
		
		public function message(value:String):void
		{
			trace("MESSAGE "+ value);
		}
	}
}