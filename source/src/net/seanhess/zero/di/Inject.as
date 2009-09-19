package net.seanhess.zero.di
{
	import flash.utils.getDefinitionByName;
	
	import net.seanhess.zero.context.IContextSender;
	import net.seanhess.zero.context.Message;
	import net.seanhess.zero.scan.PropertyInfo;
	import net.seanhess.zero.scan.SimpleScan;
	import net.seanhess.zero.scan.TypeInfo;
	import net.seanhess.zero.util.Invalidator;

	/**
	 * Fills all public properties on the target with their attached values?
	 */
	public class Inject
	{
		protected var _scan:SimpleScan;
		protected var _info:TypeInfo;
		protected var _target:Object;
		protected var _context:IContextSender;
		protected var v:Invalidator = new Invalidator(commit);
		
		protected function get info():TypeInfo
		{
			_scan = _scan || new SimpleScan();
			_info = _info || _scan.getObjectInfo(_target);
			
			return _info;
		}
		
		public function set target(value:Object):void
		{
			_target = value;
			v.invalidate("inject");
		}
		
		public function set context(value:IContextSender):void
		{
			_context = value;
			v.invalidate("inject");
		}
		
		protected function commit():void
		{
			if (v.invalid("inject") && _context && _target)
			{
				inject();
			}
		}
		
		protected function inject():void
		{
			for each (var property:PropertyInfo in info.properties)
			{
				if (property.access == PropertyInfo.READ_WRITE && property.metadata["Inject"])
				{
					var map:Map = new Map();
//					map.type = getDefinitionByName(property.type) as Class;
					map.typeName = property.type;
					
					_context.send(new Message(Map.FIND_TYPE_MESSAGE, map));
					
					_target[property.name] = map.instance;
				}
			}
		}
		
		
	}
}