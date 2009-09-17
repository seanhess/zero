package net.seanhess.zero.context
{
	public interface IContextNode
	{
		function link(node:*):void;
		function unlink(node:*):void;
	}
}