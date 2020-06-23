//
//  Doctor.swift
//  HW3
//
//  Created by Anton Tolstov on 22.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation
import Combine

protocol TreatmentDelegate : AnyObject {
    func shouldTakePill()
}

final class Doctor {
    
    weak var delegate: TreatmentDelegate?
    
    private var subscriptions = Set<AnyCancellable>()
    
    func treatPatient() {
        Timer
            .publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            // Simulating hours, but faster
            .scan(0) { counter, _ in (counter + 1) % 24 }
            .filter { [9, 14, 20].contains($0 % 24) }
            .sink {
                print("[Doctor] take your \($0) hours pills.")
                self.delegate?.shouldTakePill()
            }
            .store(in: &subscriptions)
    }
    
    func stopTreatment() {
        subscriptions = Set()
    }
}
