//
//  ProductHeaderView.swift
//  Fynd
//
//  Created by user178193 on 7/22/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import UIKit


class ProductHeaderView: UIView {
    
    //MARK:- IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterSegmentControl: UISegmentedControl!
    @IBOutlet var expandButton: UIButton!
    @IBOutlet weak var expandImage: UIImageView!
    
    //MARK:- IBOutlets
    var section: Int?
    weak var delegate: HeaderProtocol?
    
    //MARK:- Initializers
    convenience init(section: Int, viewStyle: ViewStyle, title: String, selectedFilterIndex: Int, sectionExpanded: Bool) {
        self.init(frame: CGRect.zero)
        titleLabel.text = title
        self.section = section
        
        filterSegmentControl.isHidden = viewStyle == .grouped ? false : true
        filterSegmentControl.selectedSegmentIndex = selectedFilterIndex
        
        expandImage.image = sectionExpanded ? UIImage(imageLiteralResourceName: "arrowUp") : UIImage(imageLiteralResourceName: "arrowDown")
        expandImage.isHidden = viewStyle == .grouped ? true : false
        expandButton.isUserInteractionEnabled = viewStyle == .grouped ? false : true
    }
    override init(frame:CGRect) {
        super.init(frame:frame)
        commonInit()
    }
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    //MARK:- CustomFunctions
    func commonInit() {
        Bundle.main.loadNibNamed("ProductHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    //MARK:- IBActions
    @IBAction func didTapFilterButton(_ sender: UISegmentedControl) {
        guard let section = section else { return }
        delegate?.didTapFilter(section: section, selectedFilterType: sender.selectedSegmentIndex == 0 ? .name : .price)
    }
    
    @IBAction func didTapExpandButton(_ sender: Any) {
        guard let section = section else { return }
        delegate?.didExpandOn(section: section)
    }
}
