package com.shen.relationship.model.vo
{
	public class RelationVO
	{
		private static var allRelationVO:Object = {};	//全局系统下，所有的结点
		
		public var id:String;
		public var color:uint = 0xFFFFFF;			//背景色
		public var radius:Number = 70;		//半径
		public var level:int;			//第几级结点(全局系统下）0, 1, 2...
		public var parent:RelationVO;	//父结点
		public var brotherCount:int; 	//有多少个兄弟结点
		public var order:int;			//同一个parent下的顺序号0, 1, 2...
		public var x:Number;
		public var y:Number;
		
		
		public var img:String;
		public var name:String;
		public var distance:Number = 160;		//全局系统，同心圆半径以distance为步长,level * distance是当前圆的半径
		private var _links:Vector.<RelationVO>;	//相关联的子结点
		
		public function RelationVO(data:Object)
		{
			allRelationVO[data.id] = this;
			
			id 				= data.id;
			color			= data.color != undefined ? data.color : color;
			parent 			= data.parent;
			radius			= data.radius != undefined ? data.radius : radius;
			level			= data.level;
			brotherCount 	= data.brotherCount;
			order			= data.order;
			img 			= data.img;
			name 			= data.name;
			
			if(level == 0) {
				x = 0;
				y = 0;
			}else if(level == 1) {
				var angle:Number = 2 * Math.PI / brotherCount * order;
				var x1:Number = 0;
				var y1:Number = distance;	
				x = Math.cos(angle) * x1 - Math.sin(angle) * y1;
				y = Math.cos(angle) * y1 + Math.sin(angle) * x1;
			}else {
				var theX:Number = level / parent.level * parent.x;
				var theY:Number = level / parent.level * parent.y;
				if(order == 0) {
					x = theX;
					y = theY;
				}else {
					var bAngel:Number = Math.PI / 6 * 5;
					var sinC:Number = parent.level / level * Math.sin(bAngel);
					var cAngel:Number = Math.asin(sinC); //角b为150度，是钝角,　所以角c一定是锐角
					var aAngel:Number = Math.PI - bAngel - cAngel;
					aAngel = Math.ceil(order / 2) * aAngel;
					aAngel = order % 2 == 0 ? -aAngel : aAngel;
					var x2:Number = Math.cos(aAngel) * theX - Math.sin(aAngel) * theY;
					var y2:Number = Math.cos(aAngel) * theY + Math.sin(aAngel) * theX;
					x = x2;
					y = y2;
				}
				
			}
			if(data.relation != undefined) {
				_links = new Vector.<RelationVO>();
				var i:int = 0;
				for each (var relationData:Object in data.relation) {
					relationData.parent 		= this;
					relationData.level			= level + 1;
					relationData.brotherCount 	= data.relation.length;
					relationData.order			= i++;
					var relationVO:RelationVO = new RelationVO(relationData);
					_links.push(relationVO);
				}
			}
			trace("id: " + id + ", level: " + level);
		}
		
		public function updateLinks(data:Object):void {
			if(data.relation != undefined) {
				_links = new Vector.<RelationVO>();
				var i:int = 0;
				for each (var relationData:Object in data.relation) {
					relationData.parent 		= this;
					relationData.level			= level + 1;
					relationData.brotherCount 	= data.relation.length;
					relationData.order			= i++;
					var relationVO:RelationVO = new RelationVO(relationData);
					_links.push(relationVO);
				}
			}
		}
		
		public function get links():Vector.<RelationVO> {
			return _links;
		}
			
		public static function getRelationVO(id:String):RelationVO {
			if(allRelationVO[id]) {
				return allRelationVO[id];
			}else {
				return null;
			}
		}
	}
}




