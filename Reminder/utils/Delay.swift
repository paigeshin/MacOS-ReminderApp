//
//  Delay.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import Foundation

final class Delay {
    
    private var seconds: Double
    
    init(_ seconds: Double = 2) {
        self.seconds = seconds
    }
    
    var workItem: DispatchWorkItem?
    
    func performWork(_ work: @escaping() -> Void) {
        self.workItem = DispatchWorkItem(block: work)
        DispatchQueue.main.asyncAfter(deadline: .now() + self.seconds, execute: self.workItem!)
    }
    
    func cancel() {
        self.workItem?.cancel()
    }
    
}
