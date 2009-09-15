package net.seanhess.zero.implement
{
	import net.seanhess.zero.interfaces.Service;

	public interface IServiceImplementation
	{
		function call(service:Service):void;
		function get id():String; // the service you are implementing ... 
	}
}