package net.seanhess.zero.view
{
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	
	import mx.events.ModuleEvent;
	import mx.modules.ModuleLoader;
	
	import net.seanhess.zero.context.IContextNode;

	/**
	 * Handles connecting / disconnecting... 
	 */
	public class View extends ModuleLoader
	{
		protected var _context:IContextNode;
		protected var moduleurl:String;

		protected var loading:Boolean = false;		
		protected var loaded:Boolean = false;
		protected var visibleChanged:Boolean = false;
		protected var urlChanged:Boolean = false;
		
		public function View()
		{
			addEventListener(ModuleEvent.UNLOAD, onUnload);
			addEventListener(ModuleEvent.READY, onReady);
			addEventListener(ModuleEvent.ERROR, onError);
		}
		
		protected function onUnload(event:Event):void
		{
			loading = false;
			
			if (urlChanged || visibleChanged)
				invalidateProperties();
		}
		
		protected function onReady(event:Event):void
		{
			if (view)
				view.parentContext = _context;
			
			loading = false;
			loaded = true;
			
			if (urlChanged || visibleChanged)
				invalidateProperties();
		}
		
		protected function onError(event:ModuleEvent):void
		{
			
		}	
		
		public function set context(value:IContextNode):void
		{
			_context = value;
			
			if (loaded && view)
				view.parentContext = _context;
		}
		
		/**
		 * Package name of the module.
		 */
		public function set module(value:String):void
		{
			moduleurl = value.replace(/(\.|::)/gi, "/") + ".swf";
			urlChanged = true;
			invalidateProperties();
		}
		
		override public function setVisible(value:Boolean, noEvent:Boolean = false):void
		{
			super.setVisible(value, noEvent);
			visibleChanged = true;
			invalidateProperties();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if ((visibleChanged || urlChanged) && !loading)
			{
				visibleChanged = false;
				urlChanged = false;
				
				if (visible && !loaded) // if it is visible and not loaded
				{
					loading = true;					
					loadModule(moduleurl);
				}
				
				else if(!visible && loaded) // if it is not visible and loaded
				{
					loading = true;
					loaded = false;
					unloadModule();
				}
			}
		}
		
		
		public function get view():IViewChild
		{
//			if (child && !(child is IViewChild))
//			{
//				throw new Error("The module must implement IViewChild");	
//			}
			
			return child as IViewChild;			
		}
	}
}