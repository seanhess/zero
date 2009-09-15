package net.seanhess.zero.interfaces
{
	/**
	 * I need a better way to do this :)
	 */
	public class Connector extends Object
	{
		protected static var _context:Context;
		
		public var host:Object;
		
		public function Connector(host:Object)
		{
			this.host = host;	
		}
		
		public function getContext():Context
		{
			if (host is Interface)
			{
				return context;	
			}
			else
			{
				throw new Error("Host not supported. Must be of type Interface");
			}
		}
		
		public function set context(value:Context):void
		{
			_context = value;
		}
		
		public function get context():Context
		{
			if (_context == null)
				throw new Error("No context found");
			
			return _context;
		}
	}
}