package com.shen.relationship
{	
	import com.shen.relationship.controller.LoadCommand;
	import com.shen.relationship.controller.LoadDescriptionCommand;
	import com.shen.relationship.controller.StartupCommand;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade {
		
		public static const STARTUP:String  			= "startup";
		public static const LOAD:String  				= "load";
		public static const LOAD_DESCRIPTION:String  	= "loadDescription";
		
		public function ApplicationFacade(key:String) {
			super(key);    
		}
		
		public static function getInstance(key:String):ApplicationFacade {
			if ( instanceMap[key] == null ){
				instanceMap[key] = new ApplicationFacade(key);
			}
			return instanceMap[key] as ApplicationFacade;
		}
		
		override protected function initializeController() : void {
			super.initializeController();     
			registerCommand( STARTUP, 				StartupCommand );
			registerCommand( LOAD, 					LoadCommand );
			registerCommand( LOAD_DESCRIPTION, 		LoadDescriptionCommand );
		}
		
		public function startup( app:Relation ):void {
			sendNotification( STARTUP, app );
		}
		
	}
}















