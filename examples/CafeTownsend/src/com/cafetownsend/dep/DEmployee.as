package com.cafetownsend.dep
{
	public class DEmployee extends DependencyInterface
	{
		public function get firstname():String 				{ return i.firstname }
		public function set firstname(value:String):void	{ i.firstname = value }
		
		public function get lastname():String				{ return i.lastname }
		public function set lastname(value:String):void		{ i.lastname = value }
		
		public function get email():String					{ return i.email }
		public function set email(value:String):void		{ i.email = value }

		public function get startdate():Date				{ return i.startdate }
		public function set startdate(value:Date):void		{ i.startdate = value }

		/**
		 * How I want names to display in the list. Normally I would use
		 * a formatter instead, but let's pretend we REALLY want this on
		 * our model so I can demonstrate proxies.
		 */
		public function get properName():String				{ return i.properName }

		public function DEmployee(context:*) { super(context) }
	}
}