import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 # Serial queue, Async
Task will run in different threads (except main thread) when you use **async**.
 
 1 downloading -> 1 completed -> 2 downloading -> 2 completed -> 3 downloading -> 3 completed -> 4 downloading -> 4 completed -> 5 downloading -> 5 completed
 */

func doLongAsyncTaskInSerialQueue() {
    let serialQueue = DispatchQueue(label: "serial_async_queue")
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


//: [Next (Serial Sync)](serial-sync)
