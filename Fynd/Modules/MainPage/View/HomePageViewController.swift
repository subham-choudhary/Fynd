//
//  ViewController.swift
//  Fynd
//
//  Created by user178193 on 7/22/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var viewStyleToggleButton: UIBarButtonItem!
    
    var viewModel: HomePageProtocol?
    var productCatagories: [ProductCatagory] = [] {
        didSet {
            reload()
        }
    }
    //Dictionary to keep state of Selected Filter
    var filterState:[Int:FilterType] = [:]
    //Enum to keep track of Style of Product Preview
    var viewStyle: ViewStyle = .grouped {
        didSet {
            reload()
        }
    }
    //Flag to track the Expansion or Compression of a section
    var expandedSection: Int? {
        didSet {
            reload()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }

    @IBAction func didToggleView(_ sender: Any) {
        //TODO: set image 
        switch viewStyle {
        case .grouped: viewStyle = .list
        case .list: viewStyle = .grouped
        }
    }
    
    func reload() {
        categoriesTableView.reloadData()
        categoriesTableView.scrollsToTop = true
    }
    func setupViewModel() {
        viewModel = HomePageViewModel()
        viewModel?.onSuccess = { data in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.productCatagories = data
            }
        }
        viewModel?.getAllDataFromApi()
    }
    func createHeaderView(section: Int, viewStyle: ViewStyle) -> UIView {
        let headerView = ProductHeaderView()
        headerView.titleLabel.text = productCatagories[section].name
        headerView.section = section
        headerView.expandButton.isUserInteractionEnabled = viewStyle == .grouped ? false : true
        headerView.filterSegmentControl.isHidden = viewStyle == .grouped ? false : true
        let selectedFilterIndex = filterState[section]?.rawValue ?? 0
        headerView.filterSegmentControl.selectedSegmentIndex = selectedFilterIndex
        headerView.delegate = self
        return headerView
    }
}

extension HomePageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return productCatagories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewStyle {
        case .grouped: return 1
        case .list:
            if let expandedSection = expandedSection, expandedSection == section {
                return productCatagories[section].products.count
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewStyle {
        case .grouped:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryTableViewCell", for: indexPath) as? CatagoryTableViewCell else { return UITableViewCell() }
            cell.configureCell(catagory: productCatagories[indexPath.section], filter: filterState[indexPath.section])
            return cell
            
        case .list:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
            cell.configureCell(product: productCatagories[indexPath.section].products[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewStyle {
        case .grouped: return tableView.frame.width / 1.4
        case .list: return tableView.frame.width * 1.4
        }
    }
}

extension HomePageViewController: UITableViewDelegate {
    
    func  tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView(section: section, viewStyle: viewStyle)
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

extension HomePageViewController: HeaderProtocol {
    func didTapFilter(section: Int, selectedFilterType: FilterType) {
        filterState[section] = selectedFilterType
        categoriesTableView.reloadSections([section], with: .none)
    }
    
    func didExpandOn(section: Int) {
        if expandedSection == section {
            expandedSection = nil
        } else {
            expandedSection = section
        }
    }
}
