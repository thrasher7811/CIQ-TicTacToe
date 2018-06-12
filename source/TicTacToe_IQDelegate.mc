/*

using Toybox.WatchUi as Ui;

class TicTacToe_IQDelegate extends Ui.BehaviorDelegate {
	private var btnUp = 13;
	private var btnDown = 8;
	private var btnSelect = 4;


    function initialize() {
        BehaviorDelegate.initialize();
    }
 
    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new TicTacToe_IQMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }
    
    function onKey(keyEvent){
    	// Called when a button is pressed
    	if(keyEvent.getKey() == btnUp){
    		System.println("Up");
    	}
    	if(keyEvent.getKey() == btnDown){
    		System.println("Down");
    	}
    	if(keyEvent.getKey() == btnSelect){
    		System.println("Select");
    		TicTacToe_IQView.incrementClickCount();
    		Ui.requestUpdate();
    		
    	}
    	
    }
 
}

*/