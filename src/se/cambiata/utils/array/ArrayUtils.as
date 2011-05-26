package se.cambiata.utils.array {
	import com.adobe.utils.ArrayUtil;

	public class ArrayUtils {
		public function ArrayUtils() {
		}

		static public function removeAt(arr:Array, idx:int):Array {
			var spliceArr:Array = ArrayUtil.copyArray(arr);
			spliceArr.splice(idx, idx);
			return spliceArr;
		}

		static public function difference(newValues:Array, oldValues:Array):Array {
			var difference : Array = new Array();
			var i : int;
			for (i = 0; i < newValues.length; i++)
				if (oldValues.indexOf(newValues[i]) == -1)
					difference.push(newValues[i])
			return difference;
		}

		static public function differenceGreedy(arrA:Array, arrB:Array):Array {
			var difference : Array = new Array();
			for each (var objA:Object in arrA) {
				//trace('sök efter', objA, 'i', arrB);
				if (arrB.indexOf(objA) > -1) {
					var ix:int = arrB.indexOf(objA);
					//trace('--finns', ix);
					arrB.splice(ix, 1);
					//trace('efter:', arrB);
				} else {
					//trace('---finns inte');
					difference.push(objA);
				}
			} 
			
			return difference;
			
		}
		
		static public function countOccurances(arr:Array, o:Object):int {
			var count:int = 0;
			for each (var ao:Object in arr) {
				if (ao == o)
					count++;
			}
			return count;
		}

		static public function reduceOccurances(arr:Array, obj:Object, maxcount:int = 0, replaceObj:Object = null): Array {
			var arrayCopy:Array = ArrayUtil.copyArray(arr);
			while (countOccurances(arrayCopy, obj) > maxcount) {
				arrayCopy.splice(arrayCopy.indexOf(obj), 1, replaceObj);
			}
			return arrayCopy;
			
		} 
		
		
		
	}
}