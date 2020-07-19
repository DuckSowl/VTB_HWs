//
//  ViewController.swift
//  HW3+UI
//
//  Created by Anton Tolstov on 23.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var imageView: UIImageView!
    var activityIndicator: UIActivityIndicatorView!
    var updateButton: UIButton!
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateImage()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        activityIndicator = UIActivityIndicatorView()
        
        updateButton = UIButton()
        updateButton.setTitle("Update View", for: .normal)
        updateButton.setTitleColor(UIColor.black, for: .normal)
        updateButton.addTarget(self, action: #selector(updateImageButton), for: .touchUpInside)
        updateButton.layer.cornerRadius = 10
        updateButton.layer.borderWidth = 1
        updateButton.layer.borderColor = UIColor.black.cgColor
        
        let hstack = UIStackView(arrangedSubviews: [imageView, updateButton])
        hstack.axis = .vertical
        hstack.spacing = 20
        
        [activityIndicator, hstack].forEach {
            if let subview = $0 {
                subview.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(subview)
            }
        }
                
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            hstack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            hstack.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            hstack.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            hstack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
                        
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func updateImageButton(sender: UIButton!) {
        updateImage()
    }
    
    func updateImage() {
        imageView.image = nil
        activityIndicator.startAnimating()
        
        URLSession
            .shared.dataTaskPublisher(for: URL(string: "https://picsum.photos/600/800")!)
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                self.activityIndicator.stopAnimating()
                if case .failure = $0 { self.showUnableToDownloadAlert() }
            }, receiveValue: { self.imageView.image = UIImage(data: $0) })
            .store(in: &subscriptions)
    }
    
    func showUnableToDownloadAlert() {
        let alert = UIAlertController(title: "Unable to download image!",
                                      message: "Check your internet connection and try again",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .default,
                                      handler: { _ in self.updateImage() }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}

