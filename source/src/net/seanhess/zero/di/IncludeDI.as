package net.seanhess.zero.di
{
	/**
	 * Make sure these are all loaded into the root application domain
	 */
	public class IncludeDI
	{
		public var gc:GlobalContext;
		public var map:Map;
		public var fetch:Fetch;
		public var impl:Implement;
		public var inject:Inject;
	}
}