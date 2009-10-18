package net.seanhess.zero.context
{
	import flash.utils.getQualifiedClassName;

	public class Utils
	{
		public function getName(source:*):String
		{
			return getQualifiedClassName(source).replace("::",".");
		}
	}
}