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
    var viewModel: ManufacturersViewModel!
    var networkManager = NetworkManager(authenticationParams: AuthenticationBuilder.buildApiKeyParams())
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewModel = ManufacturersViewModel(delegate: self)
        
        ManufacturerTableViewCell.registerSelf(inTableView: tableView)
        title = viewModel.title
        fetchDataFromServer()
    }
    
    func fetchDataFromServer()
    {
        guard let nextPage = viewModel.nextPage else { return }
        networkManager.getManufacturers(forPage: nextPage) { [weak self] (manufacturers, error) in
            
            DispatchQueue.main.async {
                guard error == nil, let newManufacturer = manufacturers else {
                    let errorAlert = MessageUtility.createASimpleAlert(title: "Error", message: error ?? ManufacturersViewModel.generalErrorMessage)
                    self?.present(errorAlert, animated: true)
                    return
                }
                self?.viewModel.set(newManufacturer: newManufacturer)
            }
        }
    }
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if  segue.identifier == SegueIds.fromManufacturersToCars,
            let carsViewController = segue.destination as? CarsViewController,
            let indexPath = sender as? IndexPath{
            carsViewController.viewModel.manufacturers = self.viewModel.getManufacturer(at: indexPath)
        }
    }

}

extension ManufacturersViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: SegueIds.fromManufacturersToCars, sender: indexPath)
    }
}

extension ManufacturersViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let manufacturer = viewModel.getManufacturer(at: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ManufacturerTableViewCell.reusableIdentifier, for: indexPath) as? ManufacturerTableViewCell else {
            fatalError("Can't dequeue ManufacturerTableViewCell")
        }
        cell.set(manufacturer: manufacturer)
        return cell
    }
}

extension ManufacturersViewController: ManufacturerViewModelProtocol
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
