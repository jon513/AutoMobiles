//
//  CarsViewModel.swift
//  Auto1Cars
//
//  Created by Amir Kashani on 2019-10-08.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit
protocol CarsViewModelProtocol: ViewModelsProtocol {
    func update(title: String)
}

class CarsViewModel: NSObject
{
    var delegate: CarsViewModelProtocol
    var cars: Cars?
    let defaultTitle = "Car"
    var manufacturer: Wkda

    static let generalErrorMessage = "There are some problems please try again later"
    
    init(delegate: CarsViewModelProtocol, manufacturer: Wkda)
    {
        self.delegate = delegate
        self.manufacturer = manufacturer
    }
    
    func set(newCars: Cars)
    {
        guard var currentWkda = cars?.wkda,
        let newWkda = newCars.wkda else {
            cars = newCars
            self.delegate.update()
            return
        }
        
        currentWkda.append(contentsOf: newWkda)
        cars = newCars
        cars?.wkda = currentWkda
        self.delegate.update()
        self.delegate.update(title: manufacturer.value ?? defaultTitle)
        self.delegate.update()
    }
    
    var nextPage: Int? {
        guard let currentCars = cars else { return 0 }
        guard let currentPage = currentCars.page,
            let totalPageCount = currentCars.totalPageCount,
            currentPage < totalPageCount else {
                return nil
        }
        return currentPage + 1
    }
    
    func getCar(at indexPath: IndexPath) -> Wkda
    {
        guard let wkda = cars?.wkda?[indexPath.row] else {
            fatalError("Index out of range exception")
        }
        return wkda
    }
    
    var numberOfRows: Int {
        return cars?.wkda?.count ?? 0
    }
        
    func getAlertMessage(forRow indexPath:IndexPath) -> String
    {
        guard let wkda = cars?.wkda?[indexPath.row] else {
            fatalError("Index out of range exception")
        }
        let message = """
Manufacturer Id: \(manufacturer.key ?? "")
Manufacturer: \(manufacturer.value ?? "")
Car Id: \(wkda.key ?? "")
Car: \(wkda.value ?? "")
"""
        return message
    }
}
