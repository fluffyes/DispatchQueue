import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 # Get Main queue asynchronously
 Run task inside the main queue, preferably UI related code
 */
DispatchQueue.main.async {
    // run UI-related code / non performance intensive code here
}

/*:
 # Get global queue asynchronously
 Run task inside a global queue which will be dispatched to background threads,
 */
DispatchQueue.global().async {
    // run performance intensive / complex calculation / networking code here
}

/*:
 # Run performance intensive code in global queue, then use the result to update UI in main queue
 */

DispatchQueue.global().async {
    // run performance intensive / complex calculation / networking code here
    
    DispatchQueue.main.async {
        // use the result gotten from the complex calculation to update UI in main queue
        
        // eg: label.text = result
    }
}
