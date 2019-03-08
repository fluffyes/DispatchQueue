import Foundation
import PlaygroundSupport
/*:
 # Serial queue, Async
Task will run in different threads (except main thread) when you use **async**.
 
 1 downloading -> 1 completed -> 2 downloading -> 2 completed -> 3 downloading -> 3 completed -> 4 downloading -> 4 completed -> 5 downloading -> 5 completed
 */

PlaygroundPage.current.needsIndefiniteExecution = true
func doLongAsyncTaskInSerialQueue() {
    let serialQueue = DispatchQueue(label: "com.queue.Serial")
    for i in 1...5 {
        serialQueue.async {
            
            if Thread.isMainThread{
                print("task running in main thread")
            }else{
                print("task running in background thread")
            }
            let zipURL = URL(string: "https://github.com/fluffyes/AppStoreCard/archive/master.zip")!
            let _ = try! Data(contentsOf: zipURL)
            print("\(i) completed downloading")
        }
    }
}

// 1 completed downloading -> 2 completed downloading -> 3 completed downloading -> 4 completed downloading -> 5 completed downloading
//doLongAsyncTaskInSerialQueue()
print("this will be printed before the download completes as the queue is async")
print("async lets the code below it executes even before itself has finished")

/*:
 # Serial queue, Sync
 Task may run in the main thread when you use **sync**, even if you didnt use the main queue.
 
 1 downloading -> 1 completed -> 2 downloading -> 2 completed -> 3 downloading -> 3 completed -> 4 downloading -> 4 completed -> 5 downloading -> 5 completed
 */
func doLongSyncTaskInSerialQueue() {
    let serialQueue = DispatchQueue(label: "com.queue.Serial")
    for i in 1...5 {
        serialQueue.sync {
            if Thread.isMainThread{
                print("task running in main thread")
            }else{
                print("task running in background thread")
            }
            let zipURL = URL(string: "https://github.com/fluffyes/AppStoreCard/archive/master.zip")!
            let _ = try! Data(contentsOf: zipURL)
            print("\(i) completed downloading")
        }
    }
}

// 1 completed downloading -> 2 completed downloading -> 3 completed downloading -> 4 completed downloading -> 5 completed downloading
//doLongSyncTaskInSerialQueue()
print("this will only be printed after all 5 downloads are complete as the queue is sync")
print("sync will only execute the code below it after all code inside it has finished processing")


/*:
 # Concurrent queue, Async
 Task will run in different threads (except main thread) when you use **async**
 In concurrent queue, tasks are executed as the order that they are added to the queue,
 but it doesn't mean that they will finish with the same order.
 
  1 downloading -> 2 downloading -> 3 downloading -> 4 downloading -> 5 downloading -> 3 completed -> 1 completed -> 2 completed -> 5 completed -> 4 completed
 */

func doLongAsyncTaskInConcurrentQueue() {
    let serialQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)
    for i in 1...5 {
        serialQueue.async {
            
            if Thread.isMainThread{
                print("task running in main thread")
            }else{
                print("task running in background thread")
            }
            let zipURL = URL(string: "https://github.com/fluffyes/AppStoreCard/archive/master.zip")!
            let _ = try! Data(contentsOf: zipURL)
            print("\(i) completed downloading")
        }
    }
}

// 3 completed downloading -> 1 completed downloading -> 2 completed downloading -> 5 completed downloading -> 4 completed downloading
doLongAsyncTaskInConcurrentQueue()
print("this will be printed before the download completes as the queue is async")
print("async lets the code below it executes even before itself has finished")

/*:
 # Serial queue
 Create a serial queue and run task inside
 */
let serialQueue = DispatchQueue(label: "serial_queue_name")
serialQueue.async {
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
concurrentQueue.async {
    // do your task there
    if let _ = try? Data(contentsOf: URL(string: "https://github.com/fluffyes/cloudkitPush/archive/master.zip")!){
        print("Cloud Kit Push finished downloading")
    }
}


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
