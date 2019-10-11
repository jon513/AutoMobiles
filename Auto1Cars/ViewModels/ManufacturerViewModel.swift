//
//  ManufacturerViewModel.swift
//  Auto1Cars
//
//  Created by Amir Abbas Kashani on 10/7/19.
//  Copyright © 2019 Auto1. All rights reserved.
//

import UIKit

protocol ManufacturerViewModelProtocol: ViewModelsProtocol {
    func update(title: String)
}

class ManufacturersViewModel: NSObject
{
    var delegate: ManufacturerViewModelProtocol
    static let generalErrorMessage = "There are some problems please try again later"
    
    init(delegate: ManufacturerViewModelProtocol)
    {
        self.delegate = delegate
    }
    
    func set(newManufacturer: Manufacturers)
    {
        guard var currentWkda = manufacturers?.wkda,
            let newWkda = newManufacturer.wkda else {
                //Is first time
                manufacturers = newManufacturer
                self.delegate.update()
                self.delegate.update(title: "Manufacturers")
                return
        }
        currentWkda.append(contentsOf: newWkda)
        manufacturers = newManufacturer
        manufacturers?.wkda = currentWkda
        self.delegate.update()
    }
    
    var isListEmpty:Bool {
        return numberOfRows < 1
    }
    
    var nextPage: Int? {
        guard manufacturers != nil else { return 0 }
        guard let currentPage = manufacturers?.page,
            let totalPageCount = manufacturers?.totalPageCount,
            currentPage < totalPageCount else {
                return nil
        }
        
        return currentPage + 1
    }
        
    var manufacturers: Manufacturers? {
        didSet {
            self.delegate.update()
        }
    }
    
    func getManufacturer(at indexPath: IndexPath) -> Wkda
    {
        guard let wkda = manufacturers?.wkda?[indexPath.row] else {
            fatalError("Index out of range exception")
        }
        return wkda
    }
    
    var numberOfRows: Int {
        return manufacturers?.wkda?.count ?? 0
    }
}
