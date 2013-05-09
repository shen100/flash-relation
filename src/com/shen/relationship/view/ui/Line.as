package com.shen.relationship.view.ui
{
	import caurina.transitions.Tweener;
	
	import com.shen.relationship.model.vo.RelationVO;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Line extends Sprite
	{
		private var area:Shape;
		private var background:Shape;
		private var foreground:Shape;
		private var theMask:Shape;
		private var time:Number = 1;
		private var delay:Number = 0.3;
		private var _relationVO:RelationVO
		
		public function Line() {
			
		}	
		
		public function lineTo(fromX:Number, fromY:Number, toX:Number, toY:Number, color:uint=0x000000):void {
			graphics.lineStyle(1, color);
			graphics.moveTo(fromX, fromY);
			graphics.lineTo(toX, toY);	
		}
		
		public function set relationVO(relationVO:RelationVO):void {
			_relationVO = relationVO;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			animatelineTo(relationVO.parent.x, relationVO.parent.y, relationVO.x, relationVO.y);
		}
		
		public function get relationVO():RelationVO {
			return _relationVO;
		}
	
		private function animatelineTo(fromX:Number, fromY:Number, toX:Number, toY:Number):void {
			theMask = new Shape();
			theMask.graphics.beginFill(0x000000);
			theMask.graphics.drawRect(-2, -2, Math.abs(fromX - toX) + 4, Math.abs(fromY - toY) + 4);
			theMask.graphics.endFill();
			addChild(theMask);
			
			if(buttonMode) {
				area = new Shape();
				area.graphics.lineStyle(10, 0x000000);
				area.graphics.moveTo(fromX, fromY);
				area.graphics.lineTo(toX, toY);
				addChild(area);
				area.alpha = 0;	
				
				background = new Shape();
				background.graphics.lineStyle(4, 0x8FC320);
				background.graphics.moveTo(fromX, fromY);
				background.graphics.lineTo(toX, toY);
				addChild(background);
				background.alpha = 0;
			}
			
			foreground = new Shape();
			foreground.graphics.lineStyle(2, 0xFFFFFF);
			foreground.graphics.moveTo(fromX, fromY);
			foreground.graphics.lineTo(toX, toY);
			addChild(foreground);
			mask = theMask;
			
			if(fromX < toX) {
				theMask.x = fromX;
				theMask.y = fromY < toY ? fromY : toY;	
				theMask.scaleX = 0;
				Tweener.addTween(theMask, {scaleX:1, time:time, delay:delay});
			}else if(fromX > toX) {
				theMask.x = fromX;
				theMask.y = fromY < toY ? toY : fromY;	
				theMask.scaleX = 0;
				theMask.scaleY = -1;
				Tweener.addTween(theMask, {scaleX:-1, time:time, delay:delay});
			}else {
				theMask.x = fromX;
				theMask.y = fromY;
				if(fromY > toY) {
					theMask.scaleX = -1;
					theMask.scaleY = 0;
					Tweener.addTween(theMask, {scaleY:-1, time:time, delay:delay});
				}else {
					theMask.scaleY = 0;
					Tweener.addTween(theMask, {scaleY:1, time:time, delay:delay});	
				}
			}	
			if(buttonMode) {
				addEventListener(MouseEvent.ROLL_OVER, onRollOver);
				addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			}
		}
		
		private function onRollOver(event:MouseEvent):void {
			Tweener.addTween(background, {alpha:1, time:0.3});
		}
		
		private function onRollOut(event:MouseEvent):void {
			Tweener.addTween(background, {alpha:0, time:0.3});
		}
	}
}



