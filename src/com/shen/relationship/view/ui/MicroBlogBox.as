package com.shen.relationship.view.ui
{
	import caurina.transitions.Tweener;
	
	import com.shen.relationship.model.vo.RelationVO;
	import com.shen.relationship.view.events.RelationShipEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class MicroBlogBox extends Sprite
	{
		private var allItems:Vector.<MicroBlogItem>;
		public var selectMicroBlog:MicroBlogItem;
		public var selectMicroBlogIndex:int;
		private var lineBox:Sprite;
		public var empty:Boolean = true;
		private var _limit:Boolean;
		private var _debug:Boolean;
		
		public function MicroBlogBox()
		{
			lineBox = new Sprite();
			addChild(lineBox);
		}
	
		public function get debug():Boolean
		{
			return _debug;
		}

		public function set debug(value:Boolean):void
		{
			_debug = value;
		}

		public function get limit():Boolean {
			return _limit;
		}

		public function set limit(value:Boolean):void {
			_limit = value;
		}

		public function set data(curRelation:RelationVO):void {
			empty = false;
			if(curRelation.level == 0) {
				allItems = new Vector.<MicroBlogItem>();
				var mbItem:MicroBlogItem = new MicroBlogItem();
				mbItem.data = curRelation;
				if(debug) {
					mbItem.addId();	
				}
				addChild(mbItem);
				mbItem.selected = true;
				selectMicroBlog = mbItem;
				selectMicroBlogIndex = getChildIndex(selectMicroBlog);
				if(!_limit) {
					mbItem.buttonMode = true;
					mbItem.addEventListener(MouseEvent.CLICK, onMicroBlogItemClick);	
				}
				mbItem.x = curRelation.x;
				mbItem.y = curRelation.y;
			}
			addSubNode(curRelation);
			if(curRelation.level == 0) {
				addChild(selectMicroBlog);
			}
		}
		
		
		
		private function addSubNode(relation:RelationVO):void {
			for each (var relationVO:RelationVO in relation.links) {
				var line:Line = new Line();
				line.relationVO = relationVO;
				if(relationVO.level >= 2) {
					line.buttonMode = true;
					line.addEventListener(MouseEvent.CLICK, onLineClick);	
				}
				lineBox.addChild(line);
				var mbItem:MicroBlogItem = new MicroBlogItem();
				mbItem.data = relationVO;
				if(debug) {
					mbItem.addId();	
				}
				addChild(mbItem);
				if(!_limit) {
					mbItem.buttonMode = true;
					mbItem.addEventListener(MouseEvent.CLICK, onMicroBlogItemClick);
				}
				mbItem.x = relationVO.x;
				mbItem.y = relationVO.y;
				addSubNode(relationVO);
			}	
		}
		
		private function onLineClick(event:MouseEvent):void
		{
			var line:Line = event.currentTarget as Line;
			var point:Point = new Point(event.stageX, event.stageY);
			var e:RelationShipEvent = new RelationShipEvent(RelationShipEvent.LINE_CLICK);
			e.data = {};
			e.data.point = point;
			e.data.vo = line.relationVO;
			dispatchEvent(e);
		}
		
		private function onMicroBlogItemClick(event:MouseEvent):void
		{
			var mbItem:MicroBlogItem = event.currentTarget as MicroBlogItem;
			setChildIndex(selectMicroBlog, selectMicroBlogIndex);
			selectMicroBlog.selected = false;
			mbItem.selected = true;
			selectMicroBlog = mbItem;
			selectMicroBlogIndex = getChildIndex(mbItem);
			addChild(mbItem);
			
			var e:RelationShipEvent = new RelationShipEvent(RelationShipEvent.MICROBLOG_ITEM_CLICK);
			e.data = mbItem.relation;
			dispatchEvent(e);
		}
	}
}









