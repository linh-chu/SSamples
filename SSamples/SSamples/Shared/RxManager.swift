//
//  RxManager.swift
//  SSamples
//
//  Created by Linh Chu on 1/11/17.
//  Copyright © 2017 Linh Chu. All rights reserved.
//

import Foundation
import RxSwift

struct RxManager {
    
    static func playGround() {
        
        let helloSequence = Observable.of(["H","e","l","l","o"])
        let subscription = helloSequence.subscribe { event in
            switch event {
            case .next(let value):
                print(value)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
        
        // Creating a DisposeBag so subscribtion will be cancelled correctly
        let bag = DisposeBag()
        // Creating an Observable Sequence that emits a String value
        let observable = Observable.just("Hello Rx!")
        // Creating a subscription just for next events
        let subscription1 = observable.subscribe (onNext:{
            print($0)
        })
        // Adding the Subscription to a Dispose Bag
        subscription1.addDisposableTo(bag)
    }
}

struct Countdown: Sequence, IteratorProtocol {
    var count: Int
    
    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1 }
            return count
        }
    }
    
}

struct NotSequence {
    
}
