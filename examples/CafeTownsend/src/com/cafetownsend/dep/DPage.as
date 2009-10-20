package com.cafetownsend.dep
{
	public class DPage extends DependencyInterface
	{
		public static const LOGIN:String = "login";
		public static const LIST:String = "list";
		public static const DETAIL:String = "detail";
		
		[Bindable]
		public function get currentPage():String 	{ return i.currentPage };
		
		
		public function DPage(context:*) { super(context) }
	}
}