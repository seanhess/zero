package net.seanhess.zero.di
{
	import flash.utils.getDefinitionByName;
	
	import net.seanhess.zero.context.IContextSender;
	import net.seanhess.zero.context.Message;
	import net.seanhess.zero.scan.PropertyInfo;
	import net.seanhess.zero.scan.SimpleScan;
	import net.seanhess.zero.scan.TypeInfo;

	/**
	 * Fills all public properties on the target with their attached values?
	 */
	public class Inject
	{
		protected var _scan:SimpleScan;
		protected var _info:TypeInfo;
		protected var _target:Object;
		protected var _context:IContextSender;
		protected var injected:Boolean = false;
		
		protected function get info():TypeInfo
		{
			_scan = _scan || new SimpleScan();
			_info = _info || _scan.getObjectInfo(_target);
			
			return _info;
		}
		
		public function set target(value:Object):void
		{
			_target = value;
			inject();
		}
		
		public function set context(value:IContextSender):void
		{
			_context = value;
			inject();
		}
		
		protected function inject():void
		{
			if (_context && _target && !injected)
			{
				for each (var property:PropertyInfo in info.properties)
				{
					if (property.access == PropertyInfo.READ_WRITE && property.metadata["Inject"])
					{
						var map:Map = new Map();
						map.type = getDefinitionByName(property.type) as Class;
						
						_context.send(new Message(Map.FIND_TYPE_MESSAGE, map));
						
						_target[property.name] = map.instance;
					}
				}
				
				injected = true;
			}
		}
	}
}