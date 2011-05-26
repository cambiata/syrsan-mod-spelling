package se.cambiata.utils.string.calculators
{
	import se.cambiata.utils.string.StringUtils;

	public class SimStringCamibataCyclic implements IStringSim
	{
		public function SimStringCamibataCyclic()
		{
		}
		
		public function calculate(strA:String, strB:String):Number
		{
			return StringUtils.stringCompareCyclic(strA, strB);
		}
	}
}