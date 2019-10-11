//
//  ViewControlleUtility.swift
//  Auto1Test
//
//  Created by Amir Abbas Kashani on 9/11/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

//MARK: - Empty State

class MasterViewController: UIViewController
{
    public enum Empty {
        case cars, fetchingData
    }
    
    public var screenName = ""
    private let cView = UIView()
    private let titlelabel = UILabel()
    private let messageLabel = UILabel()
    private let imageView = UIImageView()
    private var contentViewTopConstraint = NSLayoutConstraint()
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        setupEmptyView()
    }
    
    public func initializeEmptyView() {
        setupEmptyView()
    }
    
    private func setupEmptyView () {
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.alpha = 0
        cView.backgroundColor = .clear
        
        
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        titlelabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titlelabel.textColor = UIColor.darkGray
        titlelabel.numberOfLines = 0
        titlelabel.textAlignment = .center
        
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        messageLabel.textColor = .systemBlue
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(cView)
        cView.addSubview(titlelabel)
        cView.addSubview(messageLabel)
        cView.addSubview(imageView)
        
        
        contentViewTopConstraint = cView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        
        [cView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
         contentViewTopConstraint,
         cView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
         cView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
         
         titlelabel.leadingAnchor.constraint(equalTo: cView.leadingAnchor, constant: 20),
         titlelabel.topAnchor.constraint(equalTo: cView.topAnchor, constant: 72),
         titlelabel.trailingAnchor.constraint(equalTo: cView.trailingAnchor, constant: -20),
         
         messageLabel.leadingAnchor.constraint(equalTo: cView.leadingAnchor, constant: 20),
         messageLabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 12),
         messageLabel.trailingAnchor.constraint(equalTo: cView.trailingAnchor, constant: -20),
         
         imageView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 50),
         imageView.widthAnchor.constraint(equalToConstant: 169),
         imageView.heightAnchor.constraint(equalToConstant: 169),
         imageView.centerXAnchor.constraint(equalTo: cView.centerXAnchor)
            ].forEach { $0.isActive = true }
        
    }
    
    
    public func showEmptyState(type: Empty) {
        switch type {
        case .cars:
            titlelabel.text = "There is a problem!"
            messageLabel.text = "Please try again later"
            imageView.image = #imageLiteral(resourceName: "diagnostic")
            
        case .fetchingData:
            titlelabel.text = "Loading .... "
            messageLabel.text = "Please Wait!"

        }
        
        
        DispatchQueue.main.async {
            let topConstraint = (self.navigationController?.navigationBar.frame.height  ?? 0) + 20
            UIView.animate(withDuration: 0.7,
                           delay: 0,
                           usingSpringWithDamping: 10,
                           initialSpringVelocity: 2,
                           options: .curveEaseInOut,
                           animations: {
                            self.cView.alpha = 1
                            self.contentViewTopConstraint.constant = topConstraint
                            self.view.layoutIfNeeded()
            })
        }
    }
    
    func hideEmpyState() {
        self.cView.alpha = 0
        self.contentViewTopConstraint.constant = 100
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.7,
                           delay: 0,
                           usingSpringWithDamping: 10,
                           initialSpringVelocity: 2,
                           options: .curveEaseInOut,
                           animations: {
                            
                            self.view.layoutIfNeeded()
            })
        }
    }
}
