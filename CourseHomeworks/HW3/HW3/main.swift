//
//  main.swift
//  HW3
//
//  Created by Anton Tolstov on 22.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

let patient = Patient(name: "Paul")
let doctor = Doctor()
doctor.delegate = patient

doctor.treatPatient()

let days = 2
DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * 24 * Double(days)) {
    doctor.stopTreatment()
    exit(EXIT_SUCCESS)
}

// Keeping console alive
RunLoop.current.run()
