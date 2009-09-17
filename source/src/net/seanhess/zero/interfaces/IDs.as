package net.seanhess.zero.interfaces
{
	import net.seanhess.zero.scan.SimpleScan;
	import net.seanhess.zero.scan.TypeInfo;

	public class IDs
	{
		protected var scan:SimpleScan = new SimpleScan();
		
		public function getServiceIDFromInterface(face:Interface, method:Function):String
		{
			throw new Error("deprecated");
			var info:TypeInfo = scan.getObjectInfo(face);
			return info.name + "." + scan.getMethodName(face, method); 
		}
		
		public function getType(face:Interface):String
		{
			return scan.getObjectInfo(face).name;	
		}
		
		public function getName(face:Interface, method:Function):String
		{
			return scan.getMethodName(face, method);
		}
	}
}