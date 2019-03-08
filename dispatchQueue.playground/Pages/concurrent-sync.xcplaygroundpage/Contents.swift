import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 # Concurrent queue, Async
 Task may run in the main thread when you use **sync**, even if you didnt use the main queue, which might affect UI
 
 In concurrent queue, tasks are executed as the order that they are added to the queue,
 but it doesn't mean that they will finish with the same order.
 
 1 downloading -> 2 downloading -> 3 downloading -> 4 downloading -> 5 downloading -> 3 completed -> 1 completed -> 2 completed -> 5 completed -> 4 completed
 */

func doLongSyncTaskInConcurrentQueue() {
    let concurrentQueue = DispatchQueue(label: "concurrent_sync_queue", attributes: .concurrent)
    for i in 1...5 {
        concurrentQueue.sync {
            
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
doLongSyncTaskInConcurrentQueue()
print("this will only be printed after all 5 downloads are complete as the queue is sync")
print("sync will only execute the code below it after all code inside it has finished processing")

//: [Next (Main / Global queue)](main-global)
