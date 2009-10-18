package dev.interfaces
{
	import net.seanhess.zero.dependency.DependencyInterface;

	public class IBook extends DependencyInterface
	{
		public function IBook(context:*) { super(context) }
		
		public function set title(value:String):void 			{ i.title = value }
		public function get title():String 						{ return i.title }
		
		public function toString():String 						{ return i.toString() }
	}
}