package com.shen.relationship.view.events
{
	import flash.events.Event;
	
	public class RelationShipEvent extends Event
	{
		public var data:*;
		
		public static const MICROBLOG_ITEM_CLICK:String = "microBlogItemClick";
		public static const LINE_CLICK:String = "lineClick";
		
		public function RelationShipEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			this.data = data;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new RelationShipEvent(type, data, bubbles, cancelable);
		}
		
		override public function toString():String { 
			return formatToString("RelationShipEvent", "data", "type", "bubbles", "cancelable"); 
		}
	}
}