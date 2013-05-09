package com.shen.relationship.controller
{	
	import com.shen.core.logging.Log;
	import com.shen.relationship.model.RelationProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand  {
		
		override public function execute( note:INotification ) : void {
			var app:Relation = note.getBody() as Relation;
			var data:Object = app.loaderInfo.parameters;
			var relationProxy:RelationProxy = new RelationProxy();
			facade.registerProxy(relationProxy);
			
			relationProxy.id = data.id;
			relationProxy.url = data.url;
			relationProxy.contentUrl = data.contentUrl;
			relationProxy.ifLimit = data.limit == "0" ? false : true;
			relationProxy.ifDebug = data.debug == "1" ? true : false;
			if(data.debug == "1") {
				Log.type = Log.BROWSER_LOG;
			}
		}
	}
}



