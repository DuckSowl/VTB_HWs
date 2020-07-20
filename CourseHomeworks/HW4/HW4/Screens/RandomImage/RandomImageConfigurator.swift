//
//  RandomImageConfigurator.swift
//  VTB-HW4
//
//  Created by Anton Tolstov on 20.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

enum RandomImageConfigurator {
    static func configure() -> RandomImageViewController {
        let interactor = RandomImageInteractor()
        let presenter = RandomImagePresenter(with: interactor)
        let view = RandomImageViewController(with: presenter)

        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
}
