package com.shen.relationship.controller
{
	import com.shen.core.logging.Log;
	import com.shen.relationship.model.RelationProxy;
	import com.shen.relationship.model.vo.RelationVO;
	import com.shen.relationship.view.ApplicationMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class LoadDescriptionCommand extends SimpleCommand
	{
		override public function execute( note:INotification ) : void {
			var data:Object = note.getBody();
			var relationVO:RelationVO = data.vo as RelationVO;
			
			var appMediator:ApplicationMediator = facade.retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator;
			appMediator.locateDescripWindow(data.point);
			
			var ids:Vector.<String> = new Vector.<String>();
			while(relationVO) {
				ids.push(relationVO.id);
				relationVO = relationVO.parent;
			}
			var id:String = ids.join(",");
			var relationProxy:RelationProxy = facade.retrieveProxy(RelationProxy.NAME) as RelationProxy;
			var url:String = relationProxy.contentUrl + "?id=" + id;
			Log.debug(this, "load url: " + url);
			relationProxy.loadDescription(url);
		}
	}
}