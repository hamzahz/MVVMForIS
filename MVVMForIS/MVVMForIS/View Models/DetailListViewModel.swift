//
//  DetailListViewModel.swift
//  MVVMForIS
//
//  Created by Hamza on 3/14/22.
//

import Foundation

class DetailListViewModel {
    
    var reloadTableView: (() -> Void)?
    
    let loading = Box("")
    
    var itemCellViewModels = [ItemListCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func getItems(completion: @escaping ItemListDataCompletion) {
        self.loading.value = "Loading..."
        ItemListService.fetchItemList { results, error in
            if let data = results {
                DatabaseManager.sharedInstance.clearData()
                DatabaseManager.sharedInstance.saveInCoreDataWith(array: data)
                if let items = DatabaseManager.sharedInstance.getList() {
                    self.fetchData(items: items)
                }
                completion(results, nil)
            } else {
                //Something went wrong. Need to show popup
                completion(nil, error)
            }
        }
    }
    
    func fetchData(items: [Item]) {
        var vms = [ItemListCellViewModel]()
        for item in items {
            vms.append(createCellModel(item: item))
        }
        itemCellViewModels = vms
    }
    
    func createCellModel(item: Item) -> ItemListCellViewModel {
        return ItemListCellViewModel.init(title: item.name ?? "", itemDescription: item.itemDescription ?? "", price: item.price?.doubleValue ?? Double(0))
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ItemListCellViewModel {
        return itemCellViewModels[indexPath.row]
    }
}
