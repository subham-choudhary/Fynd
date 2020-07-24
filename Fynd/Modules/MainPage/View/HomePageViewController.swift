//
//  ViewController.swift
//  Fynd
//
//  Created by user178193 on 7/22/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var viewStyleToggleButton: UIBarButtonItem!
    
    //MARK:- Properties
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
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    //MARK:- IBActions
    @IBAction func didToggleView(_ sender: Any) {
        switch viewStyle {
        case .grouped:
            viewStyle = .list
            viewStyleToggleButton.image = UIImage(systemName: "rectangle.grid.2x2.fill")
        case .list: viewStyle = .grouped
        viewStyleToggleButton.image = UIImage(systemName: "rectangle.grid.1x2.fill")
        }
    }
    
    //MARK:- CustomFunctions
    func reload() {
        categoriesTableView.reloadData()
        guard let expandedSection = expandedSection, let visibleIndexpaths = categoriesTableView.indexPathsForVisibleRows else { return }
        let indexPath = IndexPath(row: 0, section: expandedSection)
        if !visibleIndexpaths.contains(indexPath) {
            categoriesTableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    func setupViewModel() {
        viewModel = HomePageViewModel()
        viewModel?.onSuccess = { data in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.productCatagories = data
            }
        }
        viewModel?.onFaliure = { error in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showAlertWith(message: error.localizedDescription)
            }
        }
        
        viewModel?.addRemoveLoader = { (shouldAddLoader) in
            if shouldAddLoader {
                DispatchQueue.main.async {
                    Utility.startSpinner(presentingView: self.view)
                    self.view.isUserInteractionEnabled = false

                }
            }else {
                DispatchQueue.main.async {
                    Utility.stopSpinner(presentingView: self.view)
                    self.view.isUserInteractionEnabled = true
                }
            }
        }
        viewModel?.getAllDataFromApi()
    }
    
    func createHeaderView(section: Int) -> UIView {
        let selectedFilterIndex = filterState[section]?.rawValue ?? 0
        let headerView = ProductHeaderView(section: section, viewStyle: viewStyle, title: productCatagories[section].name, selectedFilterIndex: selectedFilterIndex, sectionExpanded: section == expandedSection)
        headerView.delegate = self
        return headerView
    }
}

//MARK:- UITableViewDataSource
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
        case .list: return tableView.frame.width
        }
    }
}
//MARK:- UITableViewDelegate
extension HomePageViewController: UITableViewDelegate {
    
    func  tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
}

//MARK:- HeaderProtocol
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
