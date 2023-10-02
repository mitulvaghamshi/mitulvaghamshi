package helpers

import javafx.event.ActionEvent
import javafx.scene.control.Button

/**
 * This class provides method to handle button clicks
 * it sends reference of clicked button to the caller class
 *
 * @author mitul vaghamshi
 */
object OnClickListener {
    // instance of interface to add sign on sign bar
    private lateinit var addSignCallBack: AddSignCallBack

    /**
     * A static method that register method call back
     *
     * @param addSignCallBack - instance of interface
     */
    fun register(addSignCallBack: AddSignCallBack) {
        OnClickListener.addSignCallBack = addSignCallBack
    }

    /**
     * This method handles button clicks
     * it calls the interface method and pass button reference
     *
     * @param event - object of [ActionEvent] provides information of its
     * subscribers
     */
    fun handler(event: ActionEvent) = addSignCallBack!!.addSign(event.source as Button)
}
