package com.shen.relationship.controller
{	
	import com.shen.relationship.ApplicationFacade;
	import com.shen.relationship.view.ApplicationMediator;
	import com.shen.relationship.view.MicroBlogBoxMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand {
		
		override public function execute( note:INotification ) : void {
			var app:Relation = note.getBody() as Relation;
			facade.registerMediator(new ApplicationMediator(app));	
			facade.registerMediator(new MicroBlogBoxMediator(app.microBlogBox));
			sendNotification(ApplicationFacade.LOAD);
		}
	}
}







