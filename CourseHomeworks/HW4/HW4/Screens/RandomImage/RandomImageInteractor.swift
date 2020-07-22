//
//  RandomImageInteractor.swift
//  VTB-HW4
//
//  Created by Anton Tolstov on 19.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation
import Combine

protocol RandomImageInteractorInputs {
    func loadImage()
}

protocol RandomImageInteractorOutputs: AnyObject {
    func imageLoaded(imageData: Data)
    func unableToLoad()
}

final class RandomImageInteractor {
    weak var presenter: RandomImageInteractorOutputs?

    private let api = RandomImageApi.self
    private var imageRequest: AnyCancellable?
}

// MARK: - RandomImageInteractorInput

extension RandomImageInteractor: RandomImageInteractorInputs {
    func loadImage() {
        guard let url = api.url else {
            presenter?.unableToLoad()
            return
        }
        
        imageRequest = URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .sink(receiveCompletion: {
                if case .failure = $0 { self.presenter?.unableToLoad() }
            }, receiveValue: { self.presenter?.imageLoaded(imageData: $0) })
    }
}
