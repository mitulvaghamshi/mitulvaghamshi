module me.mitul.quizgame {
    requires javafx.controls;
    requires javafx.fxml;
    requires kotlin.stdlib;
    requires javafx.media;

    opens me.mitul.quizgame to javafx.fxml;
    exports me.mitul.quizgame;
}
