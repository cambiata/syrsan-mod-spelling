package se.cambiata.components.spark.dragdrop.validator
{
	import se.cambiata.utils.string.StringUtils;

	public class SyrsanValidator
	{
		public function SyrsanValidator()
		{
		}
		
		
		private var _testString:String = '';

		
		public function get testString():String
		{
			return _testString;
		}

		public function set testString(value:String):void
		{
			_testString = value;
			this.calculate();
		}

		
		private var _correctString:String = '';

		public function get correctString():String
		{
			return _correctString;
		}

		public function set correctString(value:String):void
		{
			_correctString = value;
			this.calculate();
		}
		
		
		private function calculate(): void {
			trace('calculate...');
			this.result = StringUtils.stringCompare(this.testString, this.correctString);
		}
		
		private var _result: Number = 0;

		[Bindable]
		public function get result():Number
		{
			return _result;
		}

		public function set result(value:Number):void
		{
			_result = value;
			trace('set result', value);
		}
		
		
		
		
		
	}
}