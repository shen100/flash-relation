package com.shen.relationship.view.ui
{
	import com.shen.relation.assets.CloseAsset;
	import com.shen.relation.assets.DescriptionBgAsset;
	import com.shen.uicomps.components.Label;
	import com.shen.uicomps.components.SkinnableComponent;
	import com.shen.uicomps.components.skin.Skin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class DescriptionWindow extends Sprite
	{
		public static const DRAW:String = "draw";
		
		private var topPadding:int = 12;
		private var bottomPadding:int = 16;
		private var leftPadding:int = 12;
		private var rightPadding:int = 12;
		private var gap:int = 10;
		private var background:SkinnableComponent;
		private var close:SkinnableComponent;
		private var title:Label;
		private var content:TextField;
		private var filter:DropShadowFilter
		
		public function DescriptionWindow()
		{
			background = new SkinnableComponent();
			background.skin = new Skin(new DescriptionBgAsset());
			addChild(background);
		
			close = new SkinnableComponent();
			close.skin = new Skin(new CloseAsset());
			addChild(close);
			close.buttonMode = true;
			
			title = new Label();
			addChild(title);
			title.textColor = 0x006A92;
			title.textSize = 14;
			title.x = leftPadding;
			title.y = topPadding;
			
			content = new TextField();
			addChild(content);
			var format:TextFormat = new TextFormat();
			format.color = 0x333333;
			format.size = 14;
			format.letterSpacing = 1;
			format.leading = 8;
			content.defaultTextFormat = format;
			content.autoSize = TextFieldAutoSize.LEFT;
			content.multiline = true;
			content.wordWrap = true;
			content.width = background.width - leftPadding - rightPadding;
			content.x = leftPadding;
			
			this.filters = [new DropShadowFilter(5, 45, 0x555555, 1, 5, 5)];
		}
		
		public function set data(data:Object):void {
			title.text = data.title;
			content.text = data.content;
			content.y = title.y + title.height + gap;
			background.skin.asset.height = content.y + content.height + bottomPadding;
			
			close.x = background.width - close.width - 9;
			close.y = 9;
			
			dispatchEvent(new Event(DRAW));
		}
	}
}

















