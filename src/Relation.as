package
{
	import caurina.transitions.Tweener;
	
	import com.shen.relation.assets.BackgroundAsset;
	import com.shen.relationship.ApplicationFacade;
	import com.shen.relationship.model.vo.DescriptionVO;
	import com.shen.relationship.view.ui.DescriptionWindow;
	import com.shen.relationship.view.ui.MicroBlogBox;
	import com.shen.uicomps.components.SkinnableComponent;
	import com.shen.uicomps.components.skin.Skin;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Relation extends Sprite
	{
		private const FACADE_NAME:String = "relationFacade";
		
		private var facade:ApplicationFacade = ApplicationFacade.getInstance(FACADE_NAME);
		
		public var microBlogBox:MicroBlogBox;
		
		private var descripWindow:DescriptionWindow;
		
		private var background:SkinnableComponent;
		
		public function Relation()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			background = new SkinnableComponent();
			background.skin = new Skin(new BackgroundAsset());
			addChild(background);
			microBlogBox = new MicroBlogBox();
			addChild(microBlogBox);
			
			onResize();
			stage.addEventListener(Event.RESIZE, onResize);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			facade.startup(this);
		}
		
		private function onMouseDown(event:MouseEvent):void {
			var bounds:Rectangle = new Rectangle(microBlogBox.x - stage.stageWidth, microBlogBox.y - stage.stageHeight, 
				2 * stage.stageWidth, 2 * stage.stageHeight);
			microBlogBox.startDrag(false, bounds);
			if(descripWindow && contains(descripWindow)) {
				removeChild(descripWindow);
			}
			stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		}
		
		private function onStageMouseUp(event:MouseEvent):void
		{
			microBlogBox.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		}
		
		public function moveMicroBlogBox():void {
			var targetX:Number = stage.stageWidth / 2 - microBlogBox.selectMicroBlog.x;
			var targetY:Number = stage.stageHeight / 2 - microBlogBox.selectMicroBlog.y;
			Tweener.addTween(microBlogBox, {x:targetX, y:targetY, time:0.8});
		}
		
		public function showDescripWindow(descripVO:DescriptionVO):void {
			descripWindow.data = descripVO;
			addChild(descripWindow);
		}
		
		private var descripWindowPoint:Point;
		
		public function locateDescripWindow(point:Point):void {
			if(!descripWindow) {
				descripWindow = new DescriptionWindow();
				descripWindow.addEventListener(DescriptionWindow.DRAW, onDescriptionWindowDraw);
			}
			descripWindowPoint = point;
			descripWindow.x = point.x > stage.stageWidth / 2 ? point.x - descripWindow.width : point.x;
			descripWindow.y = point.y > stage.stageHeight / 2 ? point.y - descripWindow.height : point.y;
		}
		
		private function onDescriptionWindowDraw(event:Event):void
		{
			descripWindow.x = descripWindowPoint.x > stage.stageWidth / 2 ? descripWindowPoint.x - descripWindow.width : descripWindowPoint.x;
			descripWindow.y = descripWindowPoint.y > stage.stageHeight / 2 ? descripWindowPoint.y - descripWindow.height : descripWindowPoint.y;
		}
		
		private function onResize(event:Event = null):void
		{
			background.width = stage.stageWidth;
			background.height = stage.stageHeight;
			if(microBlogBox.empty) {
				microBlogBox.x = stage.stageWidth / 2;
				microBlogBox.y = stage.stageHeight / 2;
			}else {
				microBlogBox.x = stage.stageWidth / 2 - microBlogBox.selectMicroBlog.x;
				microBlogBox.y = stage.stageHeight / 2 - microBlogBox.selectMicroBlog.y;	
			}
		}
	}
}















