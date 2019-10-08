//
//  ViewController.swift
//  Auto1Cars
//
//  Created by Amir Abbas Kashani on 10/5/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

class ManufacturersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    var viewModel = ManufacturersViewModel(delegate: self as! ManufacturerViewModelProtocol)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}

extension ManufacturersViewController: UITableViewDelegate
{
    
}

extension ManufacturersViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError()
    }
    
    
}

extension ManufacturersViewController: ManufacturerViewModelProtocol
{
    func update() {
        fatalError()
    }
    
    func loading() {
        fatalError()
    }
    
    func loaded() {
        fatalError()
    }
    
    
}
