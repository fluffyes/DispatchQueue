import Foundation

/*:
 # Sync vs Async
 **queue.sync** will pause whatever task running on the current thread and run the task you have assigned,
 then after finish running your task, the current thread will resume its previously paused task.
 
 Avoid using DispatchQueue.main.sync as it will pause the UI interaction of the user to run your task causing freeze, always use **DispatchQueue.main.async** if possible

 
 
 */

/*:
 # Serial queue
 Create a serial queue and run task inside
 */
let serialQueue = DispatchQueue(label: "serial_queue_name")
serialQueue.sync {
    // do your task here
    if let _ = try? Data(contentsOf: URL(string: "https://github.com/fluffyes/AppStoreCard/archive/master.zip")!){
        print("App Store Card project finished downloading")
    }
}

/*:
 # Concurrent queue
 Create a concurrent queue and run task inside
*/
let concurrentQueue = DispatchQueue(label: "concurrent_queue_name", attributes: .concurrent)
concurrentQueue.sync {
    // do your task there
    if let _ = try? Data(contentsOf: URL(string: "https://github.com/fluffyes/cloudkitPush/archive/master.zip")!){
        print("Cloud Kit Push finished downloading")
    }
}
