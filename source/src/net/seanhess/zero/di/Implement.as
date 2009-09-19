package net.seanhess.zero.di
{
	import flash.utils.Dictionary;
	
	import net.seanhess.zero.context.IContextReceiver;
	import net.seanhess.zero.context.IContextSender;
	import net.seanhess.zero.context.Message;
	import net.seanhess.zero.scan.SimpleScan;

	/**
	 * Specifies an implementation for a particular interface/type
	 */
	[DefaultProperty("implementations")]
	public class Implement implements IContextReceiver
	{
		protected var _context:IContextSender;
		protected var scan:SimpleScan = new SimpleScan();
		
		protected var _implementations:Dictionary;
		
		public function Implement()
		{
			_implementations = new Dictionary(true);
		}
		
		[ArrayElementType("net.seanhess.zero.di.Map")]
		public function set implementations(value:Array):void
		{
			for each (var map:Map in value)
			{
				var name:String = scan.getClassName(map.type);
				_implementations[name] = map;
			}
		}
		
		public function set context(value:IContextSender):void
		{
			value.addSubscriber(this);
		}
		
		public function receive(message:Message, from:IContextSender):void
		{
			if (message.type == Map.FIND_TYPE_MESSAGE)
			{
				var map:Map = message.data as Map;
				
				if (_implementations[map.typeName])
				{
					map.instance = getInstance(map.typeName);
				}
			}
		}
		
		protected function getInstance(typeName:String):*
		{
			var map:Map = _implementations[typeName];
			
			if (map.instance == null)
			{
				if (map.factory)
				{
					map.instance = map.factory.newInstance();
				}
				else if (map.implementation)
				{
					map.instance = new map.implementation();
				}
			}
			
			return map.instance;
		}
	}
}