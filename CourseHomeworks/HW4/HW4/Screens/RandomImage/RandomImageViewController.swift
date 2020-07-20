//
//  RandomImageViewController.swift
//  VTB-HW4
//
//  Created by Anton Tolstov on 23.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol RandomImageViewInputs: AnyObject {
    func loading()
    func set(image: UIImage)
    func unableToLoad()
}

protocol RandomImageViewOutputs {
    func viewDidLoad()
    func reloadImage()
}

final class RandomImageViewController: UIViewController {
    
    let presenter: RandomImageViewOutputs
    
    // MARK: - Initializers
    
    init(with presenter: RandomImageViewOutputs) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var reloadImageActivityIndicator: UIActivityIndicatorView = {
        let reloadImageActivityIndicator = UIActivityIndicatorView()
        view.addSubview(reloadImageActivityIndicator)
        reloadImageActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reloadImageActivityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            reloadImageActivityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return reloadImageActivityIndicator
    }()

    private var reloadImageButton : UIButton {
        let reloadImageButton = UIButton()
        reloadImageButton.setTitle(Constants.reloadImageButtonTitle, for: .normal)
        reloadImageButton.setTitleColor(UIColor.black, for: .normal)
        
        reloadImageButton.layer.cornerRadius = Constants.reloadImageButtonCornerRadius
        reloadImageButton.layer.borderWidth = 1
        
        reloadImageButton.addTarget(self, action: #selector(reloadImage), for: .touchUpInside)
        
        return reloadImageButton
    }
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        setupStackView()
        presenter.viewDidLoad()
    }
    
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [imageView, reloadImageButton])
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                        constant: Constants.spacing),
            stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor,
                                         constant: Constants.spacing),
            stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor,
                                          constant: -Constants.spacing),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                           constant: -Constants.spacing)
        ])
    }
        
    // MARK: - Actions
    
    @objc private func reloadImage() {
        presenter.reloadImage()
    }
    
    // MARK: - Alert Views
    
    private lazy var unableToLoadAlert: UIAlertController = {
        let unableToLoadAlert = UIAlertController(title: Constants.unableToLoadAlertTitle,
                                                  message: Constants.unableToLoadAlertMessage,
                                                  preferredStyle: .alert)
        let retryAction = UIAlertAction(title: Constants.unableToLoadAlertRetryTitle,
                                        style: .default,
                                        handler: { _ in self.reloadImage() })
        let cancelAction = UIAlertAction(title: Constants.unableToLoadAlertCancelTitle,
                                         style: .cancel, handler: nil)

        [retryAction, cancelAction].forEach { unableToLoadAlert.addAction($0) }
        
        return unableToLoadAlert
    }()
    
    // MARK: - Constants
    
    private enum Constants {
        static let reloadImageButtonTitle = "Reload Image"
        static let reloadImageButtonCornerRadius = CGFloat(10)
        
        static let unableToLoadAlertTitle = "Unable to load image!"
        static let unableToLoadAlertMessage = "Check your internet connection or maybe " +
                                              "service isn't working right now"
        static let unableToLoadAlertRetryTitle = "Retry"
        static let unableToLoadAlertCancelTitle = "Cancel"
        
        static let spacing = CGFloat(20)
    }
}

// MARK: - RandomImageViewInputs

extension RandomImageViewController: RandomImageViewInputs {
    func loading() {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = nil
            self?.reloadImageActivityIndicator.startAnimating()
        }
    }
    
    func set(image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.reloadImageActivityIndicator.stopAnimating()
            self?.imageView.image = image
        }
    }
    
    func unableToLoad() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(self.unableToLoadAlert, animated: true)
        }
    }
}
