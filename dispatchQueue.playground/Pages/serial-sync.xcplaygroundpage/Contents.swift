import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 # Serial queue, Sync
 Task may run in the main thread when you use **sync**, even if you didnt use the main queue, which might affect UI
 
 1 downloading -> 1 completed -> 2 downloading -> 2 completed -> 3 downloading -> 3 completed -> 4 downloading -> 4 completed -> 5 downloading -> 5 completed
 */
func doLongSyncTaskInSerialQueue() {
    let serialQueue = DispatchQueue(label: "serial_sync_queue")
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
doLongSyncTaskInSerialQueue()
print("this will only be printed after all 5 downloads are complete as the queue is sync")
print("sync will only execute the code below it after all code inside it has finished processing")

//: [Next (Concurrent Async)](concurrent-async)
