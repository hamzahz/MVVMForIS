//
//  DetailListViewController.swift
//  MVVMForIS
//
//  Created by Hamza on 3/13/22.
//

import UIKit

class DetailListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelLoading: UILabel!
    
    lazy var viewModel = {
        DetailListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
        bindingGenerics()
    }
    
    func initView() {
        // TableView customization
        tableView.dataSource = self
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
        tableView.register(ItemListTableViewCell.nib, forCellReuseIdentifier: ItemListTableViewCell.identifier)
    }
    
    func initViewModel() {
        // Get employees data
        viewModel.getItems { _, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.labelLoading.text = ""
                    let alert = Constant.showAlert(title: "Alert", message: String(describing: error!))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
        }
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.labelLoading.text = ""
                self?.tableView.reloadData()
            }
        }
    }
    
    func bindingGenerics() {
        viewModel.loading.bind { value in
            self.labelLoading.text = value
        }
    }
}

// MARK: - UITableViewDataSource

extension DetailListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.identifier, for: indexPath) as? ItemListTableViewCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}
