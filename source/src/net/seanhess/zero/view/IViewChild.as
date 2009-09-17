package net.seanhess.zero.view
{
	import net.seanhess.zero.context.IContextNode;

	public interface IViewChild
	{
		function set parentContext(value:IContextNode):void;
	}
}