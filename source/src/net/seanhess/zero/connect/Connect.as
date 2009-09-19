package net.seanhess.zero.connect
{
	import flash.utils.Dictionary;
	
	import net.seanhess.zero.interfaces.IContextClient;
	import net.seanhess.zero.interfaces.IInterfaceContext;
	import net.seanhess.zero.interfaces.InterfaceContext;

	/**
	 * Utility class to make the syntax for connecting implementations easier
	 */
	[DefaultProperty("implementations")]
	public class Connect implements IContextClient
	{
		protected var _context:IInterfaceContext;
		protected var _implementations:Dictionary;
		
		public function Connect(context:IInterfaceContext=null)
		{
			_implementations = new Dictionary(true);
			this.context = context;
		}
		
		public function set context(value:IInterfaceContext):void
		{
			_context = value;
			
			for (var implementation:* in _implementations)
			{
				implementation.context = value;
			}
		}
		
		public function get context():IInterfaceContext
		{
			return _context;
		}
		
		public function add(implementation:IContextClient):void
		{
			implementation.context = context;	
			_implementations[implementation] = true;
		}
		
		public function remove(implementation:IContextClient):void
		{
			implementation.context = null;
			_implementations[implementation] = false;
		}
		
		[ArrayElementType("net.seanhess.zero.interfaces.IContextClient")]
		public function set implementations(value:Array):void
		{
			for each (var implementation:IContextClient in value)
			{
				add(implementation);
			}
		}
	}
}