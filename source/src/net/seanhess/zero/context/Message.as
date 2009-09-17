package net.seanhess.zero.context
{
	public class Message
	{
		public var data:*;
		public var type:String; // or a class, or a constant, or what?
		public var broadcaster:IContextSender;
		public var cancelled:Boolean = false;
	}
}