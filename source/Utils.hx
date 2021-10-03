package;

class Utils
{
	public static function getClassName(obj:Dynamic):String
	{
		return Type.getClassName(Type.getClass(obj));
	}
}
