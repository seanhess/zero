package com.cafetownsend.model.vos
{
	import mx.utils.ObjectProxy;

	/**
	 * Pretend our server chokes if we put this logic in Employee. We can still pretend
	 * employee has this property.
	 */
	public class EmployeeProperName extends ObjectProxy
	{
		public function get properName():String
		{
			var emp:Employee = object as Employee;
			return emp.firstname + ", " + emp.lastname;
		}	
	}
}