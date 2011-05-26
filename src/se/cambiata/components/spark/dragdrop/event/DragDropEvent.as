package se.cambiata.components.spark.dragdrop.event
{
	import flash.events.Event;
	
	import se.cambiata.components.spark.dragdrop.DragDropItem;
	import se.cambiata.components.spark.dragdrop.DragDropTarget;
	
	public class DragDropEvent extends Event
	{
		public static const DRAG_START:String = 'drag_start';
		public static const DRAG_DROP:String = 'drag_drop';
		
		
		public var dragItem:DragDropItem;
		public var dropTarget:DragDropTarget;
		
		
		public function DragDropEvent(type:String, dragItem:DragDropItem, dropTarget:DragDropTarget=null)
		{
			this.dragItem = dragItem;
			this.dropTarget = dropTarget;
				
			super(type);
		}
	}
}