package net.seanhess.zero.context
{
	public interface IContextConnectable
	{
		function set connected(value:Boolean):void;
		function get connected():Boolean;
		function destroyConnection():void;
	}
}