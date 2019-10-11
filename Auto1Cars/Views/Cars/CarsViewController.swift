//
//  CarsViewController.swift
//  Auto1Cars
//
//  Created by Amir Kashani on 2019-10-08.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

class CarsViewController: MasterViewController
{
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.removeExtraCells()
        }
    }
    var viewModel: CarsViewModel!
    
    var manufacturer: Wkda? {
        didSet {
            guard let newManufacturer = manufacturer else { return }
            viewModel = CarsViewModel(delegate: self, manufacturer: newManufacturer)
            fetchDataFromServer()
        }
    }
    var networkManager = NetworkManager(authenticationParams: AuthenticationBuilder.buildApiKeyParams())
    
    //MARK: - Life cycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        CarsTableViewCell.registerSelf(inTableView: tableView)
        showEmptyState(type: .fetchingData)
    }
    
    //MARK: - Methods
        
    func fetchDataFromServer()
    {
        guard let nextPage = viewModel.nextPage ,
            let manufacturerId = manufacturer?.key
            else { return }
        Logger.log.info("Next page --------> \(nextPage)")
        networkManager.getCars(forManufacturerId: manufacturerId, forPage: nextPage) { [unowned self] (cars, error) in

            DispatchQueue.main.async {
                self.hideEmpyState()
                guard error == nil, let newCars = cars else {
                    let errorAlert = MessageUtility.createASimpleAlert(title: "Error", message: error ?? CarsViewModel.generalErrorMessage)
                    self.present(errorAlert, animated: true)
                    self.showEmptyState(type: .cars)
                    return
                }
                self.viewModel.set(newCars: newCars)
            }
        }
    }
    
    func shouldLoadNextPage(nextIndexPath indexPath: IndexPath) -> Bool
    {
        return indexPath.row == viewModel.numberOfRows - 5
    }
    
    func showAlert(forRow indexPath:IndexPath)
    {
        let message = viewModel.getAlertMessage(forRow: indexPath)
        let alert = MessageUtility.createASimpleAlert(title: "", message: message)
        present(alert, animated: true)
    }
}

extension CarsViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showAlert(forRow: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if shouldLoadNextPage(nextIndexPath: indexPath) {
            fetchDataFromServer()
        }
    }
}

extension CarsViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
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
}
