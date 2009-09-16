package net.seanhess.zero.implement
{
	import flash.utils.Dictionary;
	
	import net.seanhess.zero.interfaces.Connector;
	import net.seanhess.zero.interfaces.Context;
	import net.seanhess.zero.interfaces.IContext;
	import net.seanhess.zero.interfaces.IContextClient;

	/**
	 * Utility class to make the syntax for connecting implementations easier
	 */
	[DefaultProperty("implementations")]
	public class Implement implements IContextClient
	{
		protected var _context:IContext;
		protected var _implementations:Dictionary;
		protected var connector:Connector;
		
		public function Implement(context:IContext=null):void
		{
			this.connector = new Connector();
			_implementations = new Dictionary(true);
			this.context = (context) ? context : new Context();
		}
		
		public function set context(value:IContext):void
		{
			_context = value;
			connector.context = value;
			
			for (var implementation:* in _implementations)
			{
				implementation.context = value;
			}
		}
		
		public function get context():IContext
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