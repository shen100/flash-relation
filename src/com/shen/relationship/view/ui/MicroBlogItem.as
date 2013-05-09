package com.shen.relationship.view.ui
{
	import caurina.transitions.Tweener;
	
	import com.shen.relation.assets.BlueCircleAsset;
	import com.shen.relation.assets.GrayCircleAsset;
	import com.shen.relation.assets.GreenCircleAsset;
	import com.shen.relationship.model.vo.RelationVO;
	import com.shen.uicomps.components.Label;
	import com.shen.uicomps.components.SkinnableComponent;
	import com.shen.uicomps.components.skin.Skin;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class MicroBlogItem extends Sprite
	{
		private var id:Label;
		private var padding:Number = 20;
		private var text:Label;
		private var _relation:RelationVO;
		private var _selected:Boolean;
		//private var background:SkinnableComponent;
		private var background:Shape;;
		private var bgScale:Number;
		private var bgColorState:int;
		private var overId:uint;
		private var option:Option;
		private var index:int;
		
		public function MicroBlogItem()
		{
			//buttonMode = true;
//			background = new SkinnableComponent();
//			var rand:Number = Math.random();
//			if(rand < 0.4) {
//				bgColorState = 0;
//				background.skin = new Skin(new GrayCircleAsset());	
//			}else if(rand < 0.8) {
//				bgColorState = 1;
//				background.skin = new Skin(new BlueCircleAsset());
//			}else {
//				bgColorState = 2;
//				background.skin = new Skin(new GreenCircleAsset());	
//			}
			addEventListener(MouseEvent.ROLL_OVER, 		onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, 	onRollOut);
		}
	
		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			if(_selected) {
				index = parent.getChildIndex(this);
				Tweener.addTween(background, {width:120, height:120, time:0.5});
			}else {
				Tweener.addTween(background, {scaleX:bgScale, scaleY:bgScale, time:0.5});	
			}
		}

		public function set data(relation:RelationVO):void {
			_relation = relation;
			
			background = new Shape();
			background.graphics.beginFill(_relation.color);
			background.graphics.drawCircle(0, 0, _relation.radius);
			background.graphics.endFill();
			addChild(background);
				
				
			text = new Label();
			text.fontFamily = "Microsoft YaHei";
			text.textSize = 15;
			text.text = relation.name;
			switch(bgColorState) {
				case 0:{
					text.textColor = 0x2980C1;
					break;
				}
				case 1:{
					text.textColor = 0xFFFFFF;
					break;
				}
				case 2:{
					text.textColor = 0xFFFFFF;
					break;
				}
			}
			addChild(text);
			background.width = text.width + padding;
			bgScale = background.scaleY = background.scaleX;
			text.x = -text.width / 2;
			text.y = -text.height / 2;
			this.alpha = 0.3;
		
			Tweener.addTween(this, {alpha:1, time:2});
		}
		
		public function addId():void {
			if(relation) {
				id = new Label();
				addChild(id);
				id.text = relation.id;
				id.background = true;
				id.x = -id.width / 2;
				id.y = -id.height / 2;		
			}
		}
		
		private function onRollOver(event:MouseEvent):void {
			//overId = setTimeout(createOption, 500);	
			index = parent.getChildIndex(this);
			parent.addChild(this);
		}
		
		private function createOption():void {
			option = new Option(width);
			addChildAt(option, 0);
			index = parent.getChildIndex(this);
			parent.addChild(this);
		}
		
		private function onRollOut(event:MouseEvent):void {
//			if(overId) {
//				clearTimeout(overId);	
//			}
//			if(option) {
//				removeChild(option);	
//				option = null;
//				parent.setChildIndex(this, index);
//			}
			parent.setChildIndex(this, index);
		}
	
		public function get relation():RelationVO {
			return _relation;
		}
	}
}





