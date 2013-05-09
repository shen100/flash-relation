package com.shen.relationship.view
{
	import com.shen.relationship.ApplicationFacade;
	import com.shen.relationship.model.RelationProxy;
	import com.shen.relationship.model.vo.RelationVO;
	import com.shen.relationship.view.events.RelationShipEvent;
	import com.shen.relationship.view.ui.MicroBlogBox;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class MicroBlogBoxMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "MicroBlogBoxMediator";
		private var relationProxy:RelationProxy;
		
		public function MicroBlogBoxMediator(viewComponent:MicroBlogBox) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			relationProxy = facade.retrieveProxy(RelationProxy.NAME) as RelationProxy;
			if(relationProxy.ifDebug) {
				microBlogBox.debug = true;	
			}
			if(relationProxy.ifLimit) {
				microBlogBox.limit = true;	
			}
			microBlogBox.addEventListener(RelationShipEvent.MICROBLOG_ITEM_CLICK, onMicroBlogItemClick);
			microBlogBox.addEventListener(RelationShipEvent.LINE_CLICK, onLineClick);
		}
		
		private function onLineClick(event:RelationShipEvent):void {
			sendNotification(ApplicationFacade.LOAD_DESCRIPTION, event.data);
		}
		
		private function onMicroBlogItemClick(event:RelationShipEvent):void {
			sendNotification(ApplicationFacade.LOAD, event.data);
		}
	
		override public function listNotificationInterests():Array {
			return [
				RelationProxy.LOAD_RESULT
			];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case RelationProxy.LOAD_RESULT: {
					microBlogBox.data = note.getBody() as RelationVO;
					break;
				}
			}
		}
		
		private function get microBlogBox():MicroBlogBox {
			return viewComponent as MicroBlogBox;
		}
	}
}


