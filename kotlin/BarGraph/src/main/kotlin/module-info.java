module me.mitul.bargraph {
    requires javafx.controls;
    requires javafx.fxml;
    requires kotlin.stdlib;


    opens me.mitul.bargraph to javafx.fxml;
    exports me.mitul.bargraph;
}