package net.seanhess.zero.context
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	
	import net.seanhess.zero.interfaces.Implementation;

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
				
			var rule:Rule = rules.getItemAt(rules.length-1) as Rule;
			var instance:* = rule.factory.newInstance();
			
			var implementation:Implementation = new Implementation();
				implementation.onlyImplementation = instance;
				
			return implementation;
		}
	}
}