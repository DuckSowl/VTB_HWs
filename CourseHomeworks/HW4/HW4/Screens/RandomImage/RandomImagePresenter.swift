//
//  RandomImagePresenter.swift
//  VTB-HW4
//
//  Created by Anton Tolstov on 19.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation
import UIKit

final class RandomImagePresenter {
    weak var view: RandomImageViewInputs?
    private let interactor: RandomImageInteractorInputs
    
    init(with interactor: RandomImageInteractorInputs) {
        self.interactor = interactor
    }
}

// MARK: - RandomImageViewOutputs

extension RandomImagePresenter: RandomImageViewOutputs {
    func viewDidLoad() {
        reloadImage()
    }
    
    func reloadImage() {
        view?.loading()
        interactor.loadImage()
    }
}

// MARK: - RandomImageInteractorOutputs

extension RandomImagePresenter: RandomImageInteractorOutputs {
    func imageLoaded(imageData: Data) {
        guard let image = UIImage(data: imageData) else {
            unableToLoad()
            return
        }
        
        view?.set(image: image)
    }
    
    func unableToLoad() {
        view?.unableToLoad()
    }
}





