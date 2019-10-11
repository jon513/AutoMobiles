//
//  ViewController.swift
//  Auto1Cars
//
//  Created by Amir Abbas Kashani on 10/5/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

class ManufacturersViewController: MasterViewController
{
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.removeExtraCells()
        }
    }
    private let refreshControl = UIRefreshControl()
    var viewModel: ManufacturersViewModel!
    var networkManager = NetworkManager(authenticationParams: AuthenticationBuilder.buildApiKeyParams())
    //MARK: - Life cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewModel = ManufacturersViewModel(delegate: self)
        
        ManufacturerTableViewCell.registerSelf(inTableView: tableView)
        showEmptyState(type: .fetchingData)
        fetchDataFromServer()
        addRefreshController()
    }
    
    //MARK: - Methods
    func addRefreshController()
    {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData ()
    {
        viewModel.resetData()
        fetchDataFromServer()
    }
    
    
    func fetchDataFromServer()
    {
        guard let nextPage = viewModel.nextPage else { return }
        Logger.log.info("Next page --------> \(nextPage)")
        networkManager.getManufacturers(forPage: nextPage) { [unowned self] (manufacturers, error) in
            
            DispatchQueue.main.async {
                self.hideEmpyState()
                guard error == nil, let newManufacturer = manufacturers else {
                    Logger.log.error(error ?? "")
                    let errorAlert = MessageUtility.createASimpleAlert(title: "Error", message: error ?? ManufacturersViewModel.generalErrorMessage)
                    self.present(errorAlert, animated: true)
                    if self.viewModel.isListEmpty {
                        self.showEmptyState(type: .cars)
                    }
                    return
                }
                self.viewModel.set(newManufacturer: newManufacturer)
            }
        }
    }
    
    func shouldLoadNextPage(nextIndexPath indexPath: IndexPath) -> Bool
    {
        return indexPath.row == viewModel.numberOfRows - 5
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if  segue.identifier == SegueIds.fromManufacturersToCars,
            let carsViewController = segue.destination as? CarsViewController,
            let indexPath = sender as? IndexPath{
            carsViewController.manufacturer = self.viewModel.getManufacturer(at: indexPath)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if shouldLoadNextPage(nextIndexPath: indexPath) {
            fetchDataFromServer()
        }
    }
}

extension ManufacturersViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
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
}
