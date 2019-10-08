//
//  CarsViewController.swift
//  Auto1Cars
//
//  Created by Amir Kashani on 2019-10-08.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

class CarsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    var viewModel: CarsViewModel!
    var networkManager = NetworkManager(authenticationParams: AuthenticationBuilder.buildApiKeyParams())
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewModel = CarsViewModel(delegate: self)
        
        CarsTableViewCell.registerSelf(inTableView: tableView)
        title = viewModel.title
        fetchDataFromServer()
    }
    
    func fetchDataFromServer()
    {
        guard let nextPage = viewModel.nextPage ,
        let manufacturerId = self.viewModel.manufacturer.key
        else { return }
        networkManager.getCars(forManufacturerId: manufacturerId, forPage: nextPage) { [weak self] (cars, error) in
            
            DispatchQueue.main.async {
                guard error == nil, let newCars = cars else {
                    let errorAlert = MessageUtility.createASimpleAlert(title: "Error", message: error ?? CarsViewModel.generalErrorMessage)
                    self?.present(errorAlert, animated: true)
                    return
                }
                self?.viewModel.set(newCars: newCars)
            }
        }
    }
}

extension CarsViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CarsViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let car = viewModel.getCar(at: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarsTableViewCell.reusableIdentifier, for: indexPath) as? CarsTableViewCell else {
            fatalError("Can't dequeue CarsTableViewCell")
        }
        cell.set(car: car)
        return cell
    }
}

extension CarsViewController: CarsViewModelProtocol
{
    func update() {
        tableView.reloadData()
    }
    
    func update(title: String) {
        self.title = title
    }
    
    func loading() {
        fatalError()
    }
    
    func loaded() {
        fatalError()
    }
    
    
}
