module me.mitul.checkers {
    requires javafx.controls;
    requires javafx.fxml;
    requires kotlin.stdlib;


    opens me.mitul.checkers to javafx.fxml;
    exports me.mitul.checkers;
}