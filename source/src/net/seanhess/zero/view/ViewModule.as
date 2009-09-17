package net.seanhess.zero.view
{
	import flash.events.Event;
	
	import mx.modules.Module;
	
	import net.seanhess.zero.context.IContextNode;
	import net.seanhess.zero.interfaces.IInterfaceContext;
	import net.seanhess.zero.interfaces.InterfaceContext;
	
	/**
	 * Handles connecting / disconnecting... 
	 */
	public class ViewModule extends Module implements IViewChild
	{
		protected var _context:IInterfaceContext;
		protected var _parent:IContextNode;
		
		public function ViewModule()
		{
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		protected function onRemoved(event:Event):void
		{
			if (_parent)
				_parent.unlink(_context);
			
			_parent = null;
			_context = null;
		}
		
		/**
		 * Sets the PARENT context
		 */
		public function set parentContext(value:IContextNode):void
		{
			_parent = value;
			
			if (value)
			{
				_context = new InterfaceContext();
				_parent.link(_context);
			}
			else
			{
				_context = null;
			}
			
			dispatchEvent(new Event("context"));
		}
		
		/**
		 * Returns the CHILD context
		 */
		[Bindable("context")]
		public function get context():IInterfaceContext
		{
			return _context;	
		}
	}
}