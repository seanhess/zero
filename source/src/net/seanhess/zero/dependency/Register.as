package net.seanhess.zero.dependency
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	
	public class Register
	{
		/**
		 * A cache of instances of singletonish objects. Keyed off of the factory
		 * instance. 
		 */
		protected static var cache:Dictionary = new Dictionary(true);
		
		/**
		 * This way we can fire global events
		 */
		protected static var dispatcher:IEventDispatcher = new EventDispatcher();

		/**
		 * The registered rules
		 */
		protected static var rules:ArrayCollection = new ArrayCollection();
		
		public function seek(type:String, context:String):*
		{
			return generate(type, context);
		}
		
		public function addRule(value:Rule):void
		{	
			rules.addItem(value);
		}
		
		protected function generate(type:String, context:String):*
		{
			var filterRule:Function = function(rule:Rule):Boolean
			{
				return (rule.interfaces.test(type) && rule.contexts.test(context));
			}	

			var rules:ListCollectionView = new ListCollectionView(rules);
				rules.filterFunction = filterRule;
				rules.refresh();
				
			if (rules.length == 0)
			{
				throw new DependencyError("Could not find implementation for " + type + " in context "+ context);
			}
				
			var rule:Rule = rules.getItemAt(rules.length-1) as Rule;
			
			var instance:*;
			
			if (rule.kind == Rule.IMPLEMENT)
			{
				if (cache[rule.factory] == null)
					cache[rule.factory] = rule.factory.newInstance();

				instance = cache[rule.factory];
			}
			else if (rule.kind == Rule.FACTORY)
			{
				instance = rule.factory.newInstance();
			}
			else
			{
				throw new Error("Rule not implemented");
			}
			
			var implementation:Implementation = new Implementation();
				implementation.onlyImplementation = instance;
				
			return implementation;
		}
	}
}