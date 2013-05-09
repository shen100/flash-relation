package com.shen.relationship.model.vo
{
	public class DescriptionVO
	{
		public var title:String;
		public var content:String;
		
		public function DescriptionVO(data:Object)
		{
			this.title = data.title;
			this.content = data.content;
		}
	}
}