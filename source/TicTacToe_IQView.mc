using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Math as Math;

var clickCount = 0;
var selection = 0;
var totalMoves = 0;
var toDraw = [0, 0, 0, 0, 0, 0, 0, 0, 0];
var locateX;
var locateY;
var winsHuman;
var winsComp;
var winner = -1;

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
    		selection++;
    		if(selection > 9){
					selection = 1;
				}
				while(toDraw[selection-1] != 0){
					selection++;
					if(selection > 9){
						selection = 1;
					}
				}
    	}
    	if(keyEvent.getKey() == btnDown){
    		selection--;
    		if(selection < 1){
					selection = 9;
				}
				while(toDraw[selection-1] != 0){
					selection--;
					if(selection < 1){
						selection = 9;
					}
				}
    	}
    	if(keyEvent.getKey() == btnSelect){
    	
    		if(clickCount == 0){
    		clickCount = 1;
    		}else{
    		winner = false;
    		if(selection != 0){
				toDraw[selection-1] = 1;
				selection = 0;
				}else{return;}
				totalMoves++;
				//Run Computer move
				TicTacToe_IQView.compMove();
					
			}
    	}
    	Ui.requestUpdate();
    }
}
class TicTacToe_IQView extends Ui.View {
    function initialize() {
        View.initialize();
        //screenShape = Sys.getDeviceSettings().screenShape;
        
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	var width = dc.getWidth();
        var height = dc.getHeight();
        var ctrX = width/2;
        var ctrY = height/2;
		var locX = [(ctrX*.7247-25), ctrX, (ctrX*1.275)+25, (ctrX*.7247)-25, ctrX, (ctrX*1.275)+25, (ctrX*.7247)-25, ctrX, (ctrX*1.275)+25];
		var locY = [(ctrY*.7247)-25, (ctrY*.7247)-25, (ctrY*.7247)-25, ctrY, ctrY, ctrY, (ctrY*1.275)+25, (ctrY*1.275)+25, (ctrY*1.275)+25];
        
        locateX = locX;
        locateY = locY;
        
        /*  
        *	Click count controls the splash screen view.  When the application is first started,
        *	the splas screen starts.  When the user presses select, clickCount is changed to 
        *	1 and the view no longer show the splash screen on startup.
        */
        //Show the splash screen
    	if(clickCount == 0){
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        }
        //Show the tic tac toe board.
        else if(clickCount == 1){	
        //Clear the screen to white
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
        dc.clear();
        // Draw the board lines.
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        	//verticel lines
        dc.drawLine(ctrX*0.7247, 0, ctrX*0.7247, height);
        dc.drawLine(ctrX*1.275, 0, ctrX*1.275, height);
        	//horizontal lines
        dc.drawLine(0, ctrY*0.7247, width, ctrY*0.7247);
        dc.drawLine(0, ctrY*1.275, width, ctrY*1.275);
        
        //Calls method to draw a circle at the currently
        //selected board position.
        drawCircle(dc, selection);
        
        //Loop through the array to determin where to draw X or O
       for(var i = 0; i < toDraw.size(); i++){
       		if(toDraw[i] == 1){
       			//Draws X for these locations
       			drawX(dc, locateX[i], locateY[i]);
       		}if(toDraw[i] == 2){
       			//Draws O for these locations
       			drawO(dc, locateX[i], locateY[i]);
       		}
       
       
       }
        winner = checkWin();
        if(winner == 1){
        	winnerX(dc);
        }else if(winner == 2){
        	winnerO(dc);
        }else if(winner == 3){
        	winnerDraw(dc);
        }
        
        }
       }
       
       //Draws a circle at a given location for the selection indicator
       function drawCircle(dc, s){
       		if(s == 0){return;}
       		else{       	
       		dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
       		dc.fillCircle(locateX[s-1], locateY[s-1], 10);
       	}
       } 
       
       //Draws an X at a given location
       function drawX(dc, x, y){
       		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
       		dc.drawLine(x-15, y-15, x+15, y+15);
       		dc.drawLine(x-15, y+15, x+15, y-15);
       } 
       
       //Draws an O at a given location
       function drawO(dc, x, y){
       		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
       		dc.drawCircle(x, y, 20);
       }
       
       //Called when the computer needs to 
       function compMove(){
       if(totalMoves >= 9){
       return;
       }else if(winner != true){
       var random;
       		while(true){
       			random = Math.rand();
       			var ranStr = random.toString();
       			ranStr = "." + ranStr;
       			random = ranStr.toFloat();
       			System.println(random);
       		
       			var num = (random * 9 + 1).toNumber();
       			
       			System.println(num);
       			if(num >= 1 && num <= 9){
       				if(toDraw[num-1] == 0){
       				toDraw[num-1] = 2;
       				break;
       			}else{}
       			}
       			
       		}
       		selection = 0;
       		totalMoves++;
       		}		
       }
       function checkWin(){
       		var rtn = 0;
       		
       		//Check horizontal wins
       		if(toDraw[0] == toDraw[1] && toDraw[1] == toDraw[2]){
       			rtn = toDraw[0];
       		}
       		else if(toDraw[3] == toDraw[4] && toDraw[4] == toDraw[5]){
       			rtn = toDraw[3];
       		}
       		else if(toDraw[6] == toDraw[7] && toDraw[7] == toDraw[8]){
       			rtn = toDraw[6];
       		}
       		//check vertical wins
       		else if(toDraw[0] == toDraw[3] && toDraw[3] == toDraw[6]){
       			rtn = toDraw[0];
       		}
       		else if(toDraw[1] == toDraw[4] && toDraw[4] == toDraw[7]){
       			rtn = toDraw[1];
       		}
       		else if(toDraw[2] == toDraw[5] && toDraw[5] == toDraw[8]){
       			rtn = toDraw[2];
       		}
       		//Check diagonal wins
       		else if(toDraw[0] == toDraw[4] && toDraw[4] == toDraw[8]){
       			rtn = toDraw[0];
       		}
       		else if(toDraw[2] == toDraw[4] && toDraw[4] == toDraw[6]){
       			rtn = toDraw[2];
       		}
       		
       		if(totalMoves == 9 && rtn == 0){
       			return 3;	
       		}
       		return rtn;
       }
    function winnerX(dc){
    	dc.drawText(
       			dc.getWidth() / 2,                      
        		dc.getHeight() / 2,                     
        		dc.FONT_LARGE,                          
        		"Winner X",                          
        		Graphics.TEXT_JUSTIFY_CENTER            
                );
                winner = true;
                zeroAll();
    }
    function winnerO(dc){
    	dc.drawText(
       			dc.getWidth() / 2,                      
        		dc.getHeight() / 2,                     
        		dc.FONT_LARGE,                          
        		"Winner O",                          
        		Graphics.TEXT_JUSTIFY_CENTER            
                );
                winner = true;
                zeroAll();
    }
    function winnerDraw(dc){
    	dc.drawText(
       	dc.getWidth() / 2,                      
       	dc.getHeight() / 2,                     
       	dc.FONT_LARGE,                          
       	"DRAW",                          
       	Graphics.TEXT_JUSTIFY_CENTER            
        );
       zeroAll();
    }
       
    function zeroAll(){
    	for(var i = 0; i < toDraw.size(); i++){
    		toDraw[i] = 0;
    		clickCount = 0;
    		totalMoves = 0;
    	}
    }
    
    
    
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}