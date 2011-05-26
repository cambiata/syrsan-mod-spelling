package se.cambiata.components.spark.dragdrop
{
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	
	import spark.components.Group;
	import spark.components.SkinnableContainer;

	public class ScrambleChildren
	{
		public function ScrambleChildren()
		{
		}
		
		static public function scramble(target:SkinnableContainer): void {
			var numElements:int = target.numElements;
			for(var i:int = 0; i < numElements; i++) {
				var randomIndex:int = Math.abs(Math.random() * numElements);
				var el:IVisualElement = target.getElementAt(0);
				target.setElementIndex(el, randomIndex);
				
			} 
		}
	}
}