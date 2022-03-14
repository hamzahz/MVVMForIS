//
//  ItemListTableViewCell.swift
//  MVVMForIS
//
//  Created by Hamza on 3/14/22.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: ItemListCellViewModel? {
        didSet {
            labelPrice.text = "Price: \(cellViewModel?.price ?? 0)"
            labelDescription.text = cellViewModel?.itemDescription
            labelTitle.text = cellViewModel?.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    func initView() {
        // Cell view customization
        backgroundColor = .clear
        
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        labelPrice.text = nil
        labelDescription.text = nil
        labelTitle.text = nil
    }
}
