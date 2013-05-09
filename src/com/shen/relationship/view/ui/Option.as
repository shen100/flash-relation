package com.shen.relationship.view.ui
{
	import com.shen.relation.assets.OptionBgAsset;
	import com.shen.relation.assets.OptionMenuBgAsset;
	import com.shen.uicomps.components.Label;
	import com.shen.uicomps.components.SkinnableComponent;
	import com.shen.uicomps.components.skin.Skin;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.utils.setTimeout;

	public class Option extends Sprite
	{
		private var padding:Number = 5;
		private var background:SkinnableComponent;
		private var menuBg:Shape;
		private var relation:Label;
		private var independent:Label;
		private var line:Line;
		
		public function Option(width:Number)
		{
			background = new SkinnableComponent();
			background.skin = new Skin(new OptionBgAsset());
			addChild(background);
			
			menuBg = new Shape();
			addChild(menuBg);
			
			relation = new Label();
			relation.fontFamily = "Microsoft YaHei";
			relation.textSize = 12;
			relation.textColor = 0x2980C1;
			relation.text = "关联搜索";
			addChild(relation);
			
			independent = new Label();
			independent.fontFamily = "Microsoft YaHei";
			independent.textSize = 12;
			independent.textColor = 0x2980C1;
			independent.text = "独立搜索";
			addChild(independent);
			
			trace("relation.width: " + relation.width);
			background.width = width + 2 * (relation.width + padding);
			background.scaleY = background.scaleX;
			
			relation.x = background.width / 2 - relation.width - padding;
			relation.y = -relation.height;
			
			independent.x = background.width / 2 - independent.width - padding;
			
			var pen:Pen = new Pen(menuBg.graphics);
			pen.lineStyle(1, 0x000000, 0);
			pen.beginFill(0xBCD9EB);
			pen.drawArc(0, 0, background.width / 2, 60, -30, true);
			pen.endFill();
			
			line = new Line();
			line.lineTo(0, 0, background.width / 2, 0, 0x4EA2CE);
			addChild(line);
		}
	}
}














