package net.seanhess.zero.interfaces
{
	import net.seanhess.zero.scan.SimpleScan;
	import net.seanhess.zero.scan.TypeInfo;

	public class IDs
	{
		protected var scan:SimpleScan = new SimpleScan();
		
		public function getServiceIDFromInterface(face:Interface, method:Function):String
		{
			var info:TypeInfo = scan.getObjectInfo(face);
			return info.name + "." + scan.getMethodName(face, method); 
		}
	}
}