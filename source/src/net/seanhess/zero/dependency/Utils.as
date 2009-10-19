package net.seanhess.zero.dependency
{
	import flash.utils.getQualifiedClassName;

	/**
	 * Just returns the full name of the class, without the stupid double-colon
	 */
	public class Utils
	{
		public function getName(source:*):String
		{
			return getQualifiedClassName(source).replace("::",".");
		}
	}
}