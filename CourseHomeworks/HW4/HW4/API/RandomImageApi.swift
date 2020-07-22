//
//  RandomImageApi.swift
//  VTB-HW4
//
//  Created by Anton Tolstov on 20.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

enum RandomImageApi {
    private static let api = "https://picsum.photos"
    private static let endpoint = "/\(600)/\(800)"
    
    static var url: URL? { URL(string: "\(Self.api)\(Self.endpoint)") }
}
