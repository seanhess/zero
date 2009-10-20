package com.cafetownsend.control
{
	import com.cafetownsend.dep.DAuth;
	import com.cafetownsend.dep.DEmployee;
	import com.cafetownsend.dep.DPage;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	/**
	 * Putting everything in one to make it simple for this example.
	 * This is a bad idea, but you CAN do it. Consider this a really
	 * simple mock controller. I could easily change it or override it
	 * with something more complete. 
	 */
	[Bindable]
	public class MockEverything
	{
		///// AUTH IMPLEMENATION ///// 
		
		public var authStatus:String = DAuth.NORMAL_STATE;
		
		public function login(username:String, password:String):void
		{
			currentPage = DPage.LIST; // automatically pass
		}
		
		
		
		
		
		///// EMPLOYEES IMPLEMENATION /////////
		public var allEmployees:IList = new ArrayCollection();
		public var current:DEmployee;
		
		public function goToNewEmployee():void 					
		{
			current = new DEmployee(this);
			currentPage = DPage.DETAIL;
		}
		
		public function goToUpdateEmployee(emp:DEmployee):void	
		{ 
			current = emp;
			currentPage = DPage.DETAIL; 
		}
		
		public function cancelUpdate():void
		{
			currentPage = DPage.LIST;
		}
		
		public function remove(emp:DEmployee):void		
		{ 
			
		}
		
		public function save(emp:DEmployee):void			
		{ 
			 
		}
		
		
		///// PAGE IMPLEMENATION //////
		
		public var currentPage:String = DPage.LOGIN;
	}
}