package dev.interfaces
{
	import net.seanhess.zero.interfaces.Interface;

	public class IBook extends Interface
	{
		public function set title(value:String):void 			{ i.title = value }
		public function get title():String 						{ return i.title }
		
		public function toString():String 						{ return i.toString() }
	}
}