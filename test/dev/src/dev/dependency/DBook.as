package dev.dependency
{
	import net.seanhess.zero.dependency.DependencyInterface;

	public class DBook extends DependencyInterface
	{
		public function DBook(context:*) { super(context) }
		
		public function set title(value:String):void 			{ i.title = value }
		public function get title():String 						{ return i.title }
		
		public function toString():String 						{ return i.toString() }
	}
}