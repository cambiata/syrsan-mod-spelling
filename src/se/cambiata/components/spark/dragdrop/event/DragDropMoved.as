package se.cambiata.components.spark.dragdrop.event
{
	import flash.events.Event;
	
	public class DragDropMoved extends Event
	{
		
		
		public function DragDropMoved(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}