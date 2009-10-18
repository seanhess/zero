package net.seanhess.zero.dependency
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