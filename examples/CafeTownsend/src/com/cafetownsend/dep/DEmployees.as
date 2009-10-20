package com.cafetownsend.dep
{
	public class DEmployees extends DependencyInterface
	{
		[Bindable]
		public function get allEmployees():IList 	{ return i.allEmployees }
		
		[Bindable]
		public function get current():DEmployee 		{ return i.current }
				
		public function goToNewEmployee():void 					{ i.goToNewEmployee() }
		public function goToUpdateEmployee(emp:DEmployee):void	{ i.goToUpdateEmployee(arguments) }
		public function cancelUpdate():void						{ i.cancelUpdate() }
		
		public function remove(emp:DEmployee):void		{ i.remove(arguments) }
		public function save(emp:DEmployee):void			{ i.save(arguments) }
		
		public function DEmployees(context:*) { super(context) }
	}
}