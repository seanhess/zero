package net.seanhess.zero.di
{
	import flash.utils.Dictionary;
	
	import net.seanhess.zero.context.IContextReceiver;
	import net.seanhess.zero.context.IContextSender;
	import net.seanhess.zero.context.Message;

	/**
	 * Specifies an implementation for a particular interface/type
	 */
	[DefaultProperty("implementations")]
	public class Implement implements IContextReceiver
	{
		protected var _context:IContextSender;
		
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
				_implementations[map.type] = map;
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
				
				if (_implementations[map.type])
				{
					map.instance = getInstance(map.type);
				}
			}
		}
		
		protected function getInstance(type:Class):*
		{
			var map:Map = _implementations[type];
			
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