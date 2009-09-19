package net.seanhess.zero.connect
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.events.PropertyChangeEvent;
	
	import net.seanhess.zero.event.PropertyEvent;
	import net.seanhess.zero.event.ServiceEvent;
	import net.seanhess.zero.interfaces.IContextClient;
	import net.seanhess.zero.interfaces.IInterfaceContext;
	import net.seanhess.zero.interfaces.Notification;
	import net.seanhess.zero.interfaces.Property;
	import net.seanhess.zero.scan.PropertyInfo;
	import net.seanhess.zero.scan.SimpleScan;
	import net.seanhess.zero.scan.TypeInfo;
	
	public class Full implements IContextClient
	{
		protected var _source:Object;
		protected var _context:IInterfaceContext;
		protected var face:TypeInfo;
		protected var customBindingEvents:Object = {};
		protected var scan:SimpleScan = new SimpleScan();
		
		public function set context(value:IInterfaceContext):void
		{
			_context = value;
			tryConnect();
		}
		
		public function get context():IInterfaceContext
		{
			return _context;
		}
		
		public function set type(value:Class):void
		{
			this.face = scan.getClassInfo(value);
			tryConnect();
		}
		
		public function set source(value:Object):void
		{
			_source = value;
			tryConnect();
		}
		
		public function get source():Object
		{
			return _source;
		}
		
		public function Full(type:Class=null, source:Object=null)
		{
			this.type = type;
			this.source = source;
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
				for each (var event:String in face.events)
				{
					(source as IEventDispatcher).addEventListener(event, onEvent);					
				}
			}
			
			// PROPERTIES
			if (source is IEventDispatcher)
			{
				for each (var property:PropertyInfo in face.properties)
				{
					(source as IEventDispatcher).addEventListener(property.event, onProperty);
					
					if (property.event != PropertyChangeEvent.PROPERTY_CHANGE)
					{
						(source as IEventDispatcher).addEventListener(property.event, onEvent);					
						customBindingEvents[property.event] = property;
					}
				}
			}
			
			context.addEventListener(PropertyEvent.GET, onGet);
		}
		
		protected function onSend(event:ServiceEvent):void
		{
			if (event.service.type == face.type && source[event.service.name] && source[event.service.name] is Function)
			{
				event.service.result = (source[event.service.name] as Function).apply(null, event.service.params);
			}
		}
		
		protected function onEvent(event:Event):void
		{			
			var notification:Notification = new Notification();
				notification.event = event;
				notification.type = face.type;
				notification.name = event.type;
					
			context.sendNotification(notification);
		}
		
		protected function onGet(event:PropertyEvent):void
		{
			if (event.property.type == face.type && source[event.property.name])
			{
				event.property.value = source[event.property.name];
			}
		}
		
		protected function onProperty(event:Event):void
		{
			var property:Property = new Property();
				property.type = face.type;
			
			if (event is PropertyChangeEvent)
			{
				var pce:PropertyChangeEvent = event as PropertyChangeEvent;
				
				property.name = pce.property.toString();
				property.oldValue = pce.oldValue;					
			}
			else
			{
				property.name = (customBindingEvents[event.type] as PropertyInfo).name;
				property.oldValue = null;
			}
			
			property.value = source[property.name];
			
				
			context.sendUpdate(property);
		}
	}
}