//
//  TimerCounter.swift
//  RGBullsEye
//
//  Created by USER on 2020/10/20.
//

import Foundation
import Combine


class TimeCounter: ObservableObject {
    var timer: Timer?
    @Published var counter = 0
    
    @objc func updateCounter() {
        counter += 1 }
    
    init() {
        timer = Timer.scheduledTimer(timeInterval:1
                                     ,target:self
                                     ,selector:#selector(updateCounter)
                                     , userInfo: nil
                                     ,repeats: true)
    }
    func killTimer() {
        timer?.invalidate()
        timer = nil
        
    }
}
