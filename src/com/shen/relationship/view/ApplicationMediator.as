package com.shen.relationship.view
{
	import com.shen.relationship.model.RelationProxy;
	import com.shen.relationship.model.vo.DescriptionVO;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class ApplicationMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "ApplicationMediator";
		
		private var relationProxy:RelationProxy;
		
		public function ApplicationMediator(viewComponent:Relation) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			relationProxy = facade.retrieveProxy(RelationProxy.NAME) as RelationProxy;
			var menu:ContextMenu = app.contextMenu;
			if(!menu) {
				menu = new ContextMenu();
			}
			var menuItem:ContextMenuItem = new ContextMenuItem(relationProxy.version, false, false);
			menu.customItems.push(menuItem);
			menu.hideBuiltInItems();
			app.contextMenu = menu;	
		}
		
		override public function listNotificationInterests():Array {
			return [
				RelationProxy.LOAD_DESCRIPTION_RESULT
			];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case RelationProxy.LOAD_DESCRIPTION_RESULT: {
					var descripVO:DescriptionVO = note.getBody() as DescriptionVO;
					app.showDescripWindow(descripVO);
					break;
				}
			}
		}
		
		public function locateDescripWindow(point:Point):void {
			app.locateDescripWindow(point);
		}
		
		public function moveMicroBlogBox():void
		{
			app.moveMicroBlogBox();
		}
		
		
		private function get app():Relation {
			return viewComponent as Relation;
		}
	}
}


