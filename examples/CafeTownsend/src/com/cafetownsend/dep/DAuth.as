package com.cafetownsend.dep
{
	[Event(name="clear", type="flash.events.Event")]
	public class DAuth extends DependencyInterface
	{
		public static const MESSAGE_STATE:String = "message";
		public static const NORMAL_STATE:String = "";
		
		public function get status():String 		{ return i.state }
		
		public function login(username:String, password:String):void	{ i.login(arguments) }
		
		public function logout():void { i.logout() }
		
		public function DLogin(context:*) { super(context) }
	}
}