package se.cambiata.utils.string
{
	import com.adobe.utils.ArrayUtil;
	
	import mx.controls.Alert;
	import mx.utils.ArrayUtil;
	import mx.utils.ObjectUtil;
	
	
	import se.cambiata.utils.array.ArrayUtils;
	
	public class StringUtils
	{
		
		public function StringUtils()
		{
		}
		
		// replace parameters... _PARAM_		
		public static function InsertSqlParameters(sourceString:String, parameters:Array):String
		{
			for (var i:int = 0; i < parameters.length; i++)
			{
				var lookFor:String = '_PARAM_' + String(i);
				var replaceWith:String = parameters[i];
				//trace(lookFor, replaceWith);								
				var regExp:RegExp = new RegExp(lookFor, "g");
				sourceString = sourceString.replace(regExp, replaceWith);
				//trace(sourceString);			
			}
			//trace(sourceString.search('_PARAM_'));
			if (sourceString.search('_PARAM_') != -1)
			{
				Alert.show(sourceString, 'InsertStringParameters Error');
			}
			return sourceString;
		}
		
		public static function switchItemInCommaSeparatedList(item:String, csList:String, turnOn:Boolean):String
		{
			//trace(csList, item, turnOn);
			var csListArray:Array = csList.split(',');
			var csReturnListArray:Array = ObjectUtil.copy(csListArray) as Array;
			var itemPos:int = csListArray.indexOf(item);
			//trace(itemPos, 'itemPos');
			if (itemPos > -1)
			{
				csReturnListArray.splice(itemPos, 1);
				//trace('csListArray', csListArray, 'csReturnListArray', csReturnListArray);
				return csReturnListArray.join(',');
			}
			else
			{
				csReturnListArray.push(String(item));
				var sortListArray:Array = [];
				for each (var s:String in csReturnListArray)
				{
					if (s.length == 1)
						s = '0' + s;
					sortListArray.push(s);
				}
				//trace('sortListArray', sortListArray);
				sortListArray = sortListArray.sort();
				var retListArray:Array = [];
				for each (s in sortListArray)
				{
					if (s.length == 1)
						s = '0' + s;
					retListArray.push(String(int(s)));
				}
				//trace('retListArray', retListArray);
				var ret:String = retListArray.join(',');
				if (ret == '0')
					ret = '';
				return ret;
			}
			return '';
		}
		
		public static function addLeadingChar(val:int, char:String, totalCharsCount:int):String
		{
			var valLength:int = String(val).length;
			var retStr:String = String(val);
			for (var i:int = valLength; i < totalCharsCount; i++)
			{
				retStr = char + retStr;
			}
			return retStr;
			
		}
		
		//************************************************
		public static function getValueFromPairs(strToParse:String, keyStr:String, pairSepChar:String = '&', valueAssignChar:String = '='):String
		{
			var keyPos:int = strToParse.indexOf(keyStr + valueAssignChar);
			if (keyPos < 0)
				return '';
			var keyLength:int = keyStr.length + valueAssignChar.length;
			var subStr:String = strToParse.slice(keyPos + keyLength);
			var subStrSepPos:int = subStr.indexOf(pairSepChar);
			subStrSepPos = (subStrSepPos == -1) ? 100 : subStrSepPos;
			var valueStr:String = subStr.substr(0, subStrSepPos);
			return valueStr;
		}
		
		//******************************************************
		
		public static function formatDecimals(num:Number, digits:uint):String
		{
			var tenToPower:Number = Math.pow(10, digits);
			var cropped:String = String(Math.round(num * tenToPower) / tenToPower);
			
			var decimalPosition:int;
			
			for (var i:int = 0; i < cropped.length; i++)
			{
				if (cropped.charAt(i) == ".")
				{
					decimalPosition = i;
				}
			}
			
			var output:String = cropped;
			var decimals:String = cropped.substr(decimalPosition + 1, cropped.length);
			var missingZeros:Number = digits - decimals.length;
			
			if (decimals.length < digits && decimalPosition > 0)
			{
				for (var j:int = 0; j < missingZeros; j++)
				{
					output += "0";
				}
			}
			
			return output;
		}
		
		public static function currency(num:Number,decimalPlace:Number=2,currency:String="$"):String
		{
			//assigns true boolean value to neg in number less than 0
			var neg:Boolean = (num < 0);
			
			//make the number positive for easy conversion
			num = Math.abs(num)
			
			var roundedAmount:String = String(num.toFixed(decimalPlace));
			
			//split string into array for dollars and cents
			var amountArray:Array = roundedAmount.split(".");
			var dollars:String = amountArray[0]
			var cents:String = amountArray[1]
			
			//create dollar amount
			var dollarFinal:String = ""
			var i:int = 0
			for (i; i < dollars.length; i++)
			{
				if (i > 0 && (i % 3 == 0 ))
				{
					dollarFinal = "," + dollarFinal;
				}
				
				dollarFinal = dollars.substr( -i -1, 1) + dollarFinal;
			}	
			
			//create Cents amount and zeros if necessary
			var centsFinal:String = String(cents);
			
			var missingZeros:int = decimalPlace - centsFinal.length;
			
			if (centsFinal.length < decimalPlace)
			{
				for (var j:int = 0; j < missingZeros; j++) 
				{
					centsFinal += "0";
				}
			}
			
			var finalString:String = ""
			
			if (neg)
			{
				finalString = "-"+currency + dollarFinal
			} else
			{
				finalString = currency + dollarFinal
			}
			
			if(decimalPlace > 0)
			{
				finalString += "." + centsFinal;
			} 
			
			return finalString;
		}
		
		
		public static function stringCompareCyclic(strA:String, strB:String):Number {
			
			var testA:String = '';
			
			var topResult:Number = 0;
			
			for (var i:int = 0; i < strA.length; i++) {
				
				var firstA:String = strA.substr(i, strA.length-i);
				var secondA:String = strA.substr(0, i);
				testA = firstA + secondA;
				
				
				var currResult:Number = stringCompare(testA, strB);
				//trace(testA, strB, currResult);
				topResult = Math.max(topResult, currResult);
				
				
			}
			//trace(topResult);
			return topResult;
		}
		
		
		public static function stringCompare(strA:String, strB:String, replaceChar:String = '%', caseSensitive:Boolean = true):Number {
			
			if (!strA) return 0;
			if (!strB) return 0;
			
			if (!caseSensitive) {
				strA = strA.toLowerCase();
				strB = strB.toLowerCase();
			}
			
			
			//-----------------------------------------------------
			
			strA = limitCharOccurances(strA, strB, replaceChar);
			
			//------------------------------------------------------
			
			
			var lengthA:int = strA.length;
			var lengthB:int = strB.length;
			
			var segmentCount:int = 0;
			var segementsInfo:Array = new Array();
			var segment:String = '';
			
			var i:int = 0;
			
			
			while (i < lengthA) {
				var char:String = strA.substr(i, 1);
				
				if (strB.indexOf(char) >= 0) {
					
					
					segment = segment + char;
					if (strB.indexOf(segment) >= 0) {
						var segmentPosA:int = i - segment.length + 1;
						var segmentPosB:int = strB.indexOf(segment);
						var positionDiff:int = Math.abs(segmentPosA - segmentPosB);
						var posFactor:Number = (lengthB-positionDiff) / lengthB;
						var lengthFactor:Number = segment.length / lengthB;
						//trace(segment, positionDiff, posFactor, lengthFactor);
						segementsInfo[segmentCount] = ({'segment': segment, 'score': (posFactor * lengthFactor)});
					} else {
						segment = '';
						i--;
						segmentCount++;
					}
				} else {
					segment = '';
					segmentCount++;
				}
				
				i++;
			}
			
			var totalScore:Number = 0;
			
			for each (var info:Object in segementsInfo)
			totalScore += info.score;
			
			if (strA.length > strB.length) totalScore = totalScore * strB.length / strA.length;
			
			
			
			
			return totalScore;  //* stringDifferenceValue(strA, strB);
		}		
		
		
		/**
		 *  
		 * 
		 * 
		 */
		static public function stringDifference(strA:String, strB:String, doublesided:Boolean, caseSensitive:Boolean = false): Array {
			
			if (!caseSensitive) {
				strA = strA.toLowerCase();
				strB = strB.toLowerCase();
			}
			
			var arrA:Array = strA.split('');
			var arrB:Array = strB.split('');
			
			var difference:Array = [];
			
			if (strA.length > 0 && strB.length > 0 ) {
				difference = se.cambiata.utils.array.ArrayUtils.differenceGreedy(arrA, arrB);
			} else if (strA.length > 0) {
				difference = arrA;			
			} 
			
			if (doublesided) {
				var difference2:Array = [];
				if (strA.length > 0 && strB.length > 0 ) {
					difference2 = se.cambiata.utils.array.ArrayUtils.differenceGreedy(arrB, arrA);
				} else if (strB.length > 0) {
					difference2 = arrB;
				}				
				difference = difference.concat(difference2);
			}
			return difference; 
		}		
		
		static public function stringDifferenceValue(strA:String, strB:String): Number {
			
			var diff:Array = stringDifference(strA, strB, true);
			var diffLength:int = Math.min(strB.length, diff.length);
			return (strB.length - diffLength) / strB.length;
		}
		
		static public function countCharOccurances(char:String, inString:String): int {			
			return se.cambiata.utils.array.ArrayUtils.countOccurances(inString.split(''), char);
		}
		
		static public function reduceCharOccurances(str:String, char:String, maxcount:int = 0, replaceChar:String = ''):String {
			var a:Array = se.cambiata.utils.array.ArrayUtils.reduceOccurances(str.split(''), char, maxcount, replaceChar);
			return a.join('');
		}
		
		static public function limitCharOccurances(testString:String, checkString:String, replaceChar:String = ''): String {
			var uArr:Array = com.adobe.utils.ArrayUtil.createUniqueCopy(testString.split(''));	
			for each (var uChar:String in uArr) {
				testString = reduceCharOccurances(testString, uChar, countCharOccurances(uChar, checkString), replaceChar);			
			}
			return testString;
		}
		
		
	}
}