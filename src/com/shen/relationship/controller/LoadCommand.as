package com.shen.relationship.controller
{	
	import com.shen.relationship.model.RelationProxy;
	import com.shen.relationship.model.vo.RelationVO;
	import com.shen.relationship.view.ApplicationMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class LoadCommand extends SimpleCommand  {
		
		override public function execute( note:INotification ) : void {
			var relationProxy:RelationProxy = facade.retrieveProxy(RelationProxy.NAME) as RelationProxy;
			var relationVO:RelationVO = note.getBody() as RelationVO;
			var appMediator:ApplicationMediator = facade.retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator;
			var url:String;
			var ids:Array;
			if(relationProxy.ifDebug) {
				if(!relationVO) {
					url = relationProxy.url;
					url += "data_0";
					url += "?id=" + relationProxy.id;
					relationProxy.load(url);
				}else if(!relationVO.links) {
					url = relationProxy.url;
					url += ("data_" + relationVO.id);
					ids = [];
					while(relationVO) {
						ids.push(relationVO.id);
						relationVO = relationVO.parent;
					}
					url += "?id=" + ids.join(",");
					relationProxy.load(url);
					appMediator.moveMicroBlogBox();
				}else {
					appMediator.moveMicroBlogBox();
				}	
			}else {
				if(!relationVO) {
					url = relationProxy.url + "?id=" + relationProxy.id;
					relationProxy.load(url);
				}else if(!relationVO.links) {
					url = relationProxy.url;
					ids = [];
					while(relationVO) {
						ids.push(relationVO.id);
						relationVO = relationVO.parent;
					}
					url += "?id=" + ids.join(",");
					relationProxy.load(url);
					appMediator.moveMicroBlogBox();
				}else {
					appMediator.moveMicroBlogBox();	
				}
			}
		}
	}
}




















