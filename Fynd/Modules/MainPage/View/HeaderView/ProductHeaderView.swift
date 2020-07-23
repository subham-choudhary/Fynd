//
//  ProductHeaderView.swift
//  Fynd
//
//  Created by user178193 on 7/22/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import UIKit


class ProductHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterSegmentControl: UISegmentedControl!
    @IBOutlet var expandButton: UIButton!
    
    var section: Int?
    weak var delegate: HeaderProtocol?
    
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        commonInit()
    }
    required init?(coder aDecoder:NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ProductHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    @IBAction func didTapFilterButton(_ sender: UISegmentedControl) {
        guard let section = section else { return }
        delegate?.didTapFilter(section: section, selectedFilterType: sender.selectedSegmentIndex == 0 ? .name : .price)
    }
    @IBAction func didTapExpandButton(_ sender: Any) {
        guard let section = section else { return }
        delegate?.didExpandOn(section: section)
    }
}
