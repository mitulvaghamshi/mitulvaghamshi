package helpers

import javafx.scene.control.Button

/**
 * This interface declarers a method to add signs
 *
 * @author mitul vaghamshi
 */
interface AddSignCallBack {
    /**
     * virtual method signature
     *
     * @param button - whether answer is true or false
     */
    fun addSign(button: Button?)
}
