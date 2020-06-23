//
//  Patient.swift
//  HW3
//
//  Created by Anton Tolstov on 22.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

final class Patient {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Patient: TreatmentDelegate {
    func shouldTakePill() {
        print("[\(name)] took a pill.")
    }
}

