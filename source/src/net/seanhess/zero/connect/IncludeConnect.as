package net.seanhess.zero.connect
{
	import net.seanhess.zero.interfaces.IContextClient;
	import net.seanhess.zero.interfaces.IInterfaceContext;
	import net.seanhess.zero.interfaces.Interface;
	import net.seanhess.zero.interfaces.InterfaceContext;
	import net.seanhess.zero.interfaces.Notification;
	import net.seanhess.zero.interfaces.Property;
	import net.seanhess.zero.util.QuickListener;

	/**
	 * Make sure all this stuff is included in your application domain
	 */
	public class IncludeConnect
	{
		public var connect:Connect;
		public var full:Full;
//		public var service:Service;
		public var icc:IContextClient;
		public var iic:IInterfaceContext;
		public var inter:Interface;
		public var ic:InterfaceContext;
		public var not:Notification;
		public var prop:Property;
		public var serv:net.seanhess.zero.interfaces.Service;
		public var ql:QuickListener;
	}
}