package com.shen.relationship.model
{
	import com.adobe.serialization.json.JSON;
	import com.shen.core.net.HttpService;
	import com.shen.relationship.model.vo.DescriptionVO;
	import com.shen.relationship.model.vo.RelationVO;
	
	import flash.utils.setTimeout;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class RelationProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "RelationProxy";
		public static const LOAD_RESULT:String = "loadResult";
		public static const LOAD_DESCRIPTION_RESULT:String = "loadDescriptionResult";
		
		private const VERSION_NAME:String 	= "关联分析";
		private const MAJOR:int 			= 1;
		private const MINOR:int 			= 0;
		private const REVISION:int 			= 3;
		
		public var id:String;
		public var ifLimit:Boolean;
		public var ifDebug:Boolean;
		public var url:String;
		public var contentUrl:String;
		private var allRelationVO:Object;
		
		public function RelationProxy()
		{
			super(NAME);
		}
		
		public function load(url:String):void {
			var httpService:HttpService = new HttpService();
			httpService.addResponder(onResult, onFault);
			httpService.send(url);
		}
		
		private function onResult(data:Object):void {
			var jsonData:Object = JSON.decode(data as String);
			var relationVO:RelationVO;
			if(!allRelationVO) {
				allRelationVO = {};
				jsonData.parent = null;
				jsonData.level = 0;
				relationVO = new RelationVO(jsonData);
				sendNotification(RelationProxy.LOAD_RESULT, relationVO);
			}else {
				if(jsonData.relation != undefined) {
					relationVO = RelationVO.getRelationVO(jsonData.id);
					if(relationVO) {
						relationVO.updateLinks(jsonData);
						sendNotification(RelationProxy.LOAD_RESULT, relationVO);	
					}
				}
			}
		}
			
		private function onFault(info:Object):void {
			trace("fault");	
		}
		
		public function loadDescription(url:String):void {
			var httpService:HttpService = new HttpService();
			httpService.addResponder(onDescripResult, onDescripFault);
			httpService.send(url);
		}
		
		private function onDescripResult(data:Object):void {
			
			var jsonData:Object = JSON.decode(data as String);
			var descripVO:DescriptionVO = new DescriptionVO(jsonData);
			sendNotification(RelationProxy.LOAD_DESCRIPTION_RESULT, descripVO);
		}
		
		private function onDescripFault(info:Object):void {
			trace("onDescripFault");	
		}
		
		public function get version():String {
			return VERSION_NAME + " " + MAJOR + "." + MINOR + "." + REVISION;
		}
	}
}










