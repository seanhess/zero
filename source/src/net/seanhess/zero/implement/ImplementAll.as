package net.seanhess.zero.implement
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.events.PropertyChangeEvent;
	
	import net.seanhess.zero.event.ServiceEvent;
	import net.seanhess.zero.interfaces.IContext;
	import net.seanhess.zero.interfaces.IContextClient;
	import net.seanhess.zero.interfaces.Interface;
	import net.seanhess.zero.interfaces.Notification;
	import net.seanhess.zero.interfaces.Property;
	import net.seanhess.zero.scan.PropertyInfo;
	import net.seanhess.zero.scan.TypeInfo;
	
	public class ImplementAll implements IContextClient
	{
		protected var _source:Object;
		protected var _context:IContext;
		protected var face:Interface;
		
		public function set context(value:IContext):void
		{
			_context = value;
			tryConnect();
		}
		
		public function get context():IContext
		{
			return _context;
		}
		
		public function ImplementAll(face:Interface, source:Object)
		{
			this.face = face;
			this.source = source;
		}
		
		protected function set source(value:Object):void
		{
			_source = value;	
		}
		
		protected function get source():Object
		{
			return _source;
		}
		
		protected function tryConnect():void
		{
			if (context && face && source)
			{
				connect();
			}
		}
		
		// don't I want to scan the interface instead?
		protected function connect():void
		{
			// SERVICES
			context.addEventListener(ServiceEvent.SEND, onSend);

			// EVENTS
			if (source is IEventDispatcher)
			{
				for each (var event:String in face.info.events)
				{
					(source as IEventDispatcher).addEventListener(event, onEvent);					
				}
			}
			
			// PROPERTIES
			if (source is IEventDispatcher)
			{
				for each (var property:PropertyInfo in face.info.properties)
				{
					(source as IEventDispatcher).addEventListener(property.event, onProperty);
				}
			}
		}
		
		protected function onSend(event:ServiceEvent):void
		{
			if (event.service.type == face.info.name && source[event.service.name] && source[event.service.name] is Function)
			{
				event.service.result = (source[event.service.name] as Function).apply(null, event.service.params);
			}
		}
		
		protected function onEvent(event:Event):void
		{			
			var notification:Notification = new Notification();
				notification.event = event;
				notification.type = face.info.name;
				notification.name = event.type;
					
			context.sendNotification(notification);
		}
		
		protected function onProperty(event:PropertyChangeEvent):void
		{
			var property:Property = new Property();
				property.type = face.info.name;
				property.name = event.property.toString();
				property.oldValue = event.oldValue;
				property.value = event.newValue;
				
			context.sendUpdate(property);
		}
	}
}