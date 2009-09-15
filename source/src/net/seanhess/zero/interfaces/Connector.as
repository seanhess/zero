package net.seanhess.zero.interfaces
{
	/**
	 * I need a better way to do this :)
	 */
	public class Connector extends Object
	{
		protected static var _context:IContext;
		protected static var interfaces:Array = [];
		
		public function Connector()
		{
			
		}
		
		public function set context(value:IContext):void
		{
			_context = value;
			
			/// loop through static interfaces
			for each (var face:Interface in interfaces)
			{
				face.context = _context;
			}
		}
		
		public function get context():IContext
		{
			return _context;
		}
		
		public function registerInterface(face:Interface):void
		{
			interfaces.push(face); // registers it staticly
			face.context = context;
		}
	}
}