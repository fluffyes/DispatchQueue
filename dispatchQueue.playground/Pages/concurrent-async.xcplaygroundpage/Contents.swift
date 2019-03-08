import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 # Concurrent queue, Async
 Task will run in different threads (except main thread) when you use **async**
 
 In concurrent queue, tasks are executed as the order that they are added to the queue,
 but it doesn't mean that they will finish with the same order.
 
 1 downloading -> 2 downloading -> 3 downloading -> 4 downloading -> 5 downloading -> 3 completed -> 1 completed -> 2 completed -> 5 completed -> 4 completed
 */

func doLongAsyncTaskInConcurrentQueue() {
    let concurrentQueue = DispatchQueue(label: "concurrent_async_queue", attributes: .concurrent)
    for i in 1...5 {
        concurrentQueue.async {
            
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

//: [Next (Concurrent Sync)](concurrent-sync)
