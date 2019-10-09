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
    var cars: Cars!
    static let generalErrorMessage = "There are some problems please try again later"
    
    init(delegate: CarsViewModelProtocol)
    {
        self.delegate = delegate
    }
    
    func set(newCars: Cars)
    {
        
    }
    
    var nextPage: Int? {
        guard manufacturers != nil else { return 0 }
        guard let currentPage = cars?.page,
            let pageSize = manufacturers?.pageSize,
            currentPage < pageSize else {
                return nil
        }
        return currentPage + 1
    }
    
    var manufacturers: Wkda? {
        didSet {
            self.delegate.update()
        }
    }
    
    func getCar(at indexPath: IndexPath) -> Wkda
    {
        guard let wkda = manufacturers?.wkda?[indexPath.row] else {
            fatalError("Index out of range exception")
        }
        return wkda
    }
    
    var numberOfRows: Int {
        return manufacturers?.wkda?.count ?? 0
    }
    
    var title: String! {
        return "loading..."
    }
    
}
