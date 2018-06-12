using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class TicTacToe_IQApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
        var currentMove = [0, 0, 0, 0, 0, 0, 0, 0, 0];
        var locX = [];
        var locY = [];
        var currentLocation = 0;
        var totalMoves = 0;
    }

    // onStart() is called on application start up
    function onStart(state) {
    //load user data
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    //save user data
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new TicTacToe_IQView(), new TicTacToe_IQDelegate() ];
    }

}
