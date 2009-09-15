package net.seanhess.zero.interfaces
{
	/**
	 * I need a better way to do this :)
	 */
	public class Connector extends Object
	{
		protected static var _context:Context;
		
		public function Connector()
		{
			
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