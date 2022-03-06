//
//  ViewController.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 26/2/22.
//

import UIKit
import CoreData

class GroceryListViewController: UITableViewController {

    var viewModel: GroceryListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.reloadData()
        setupUI()
        viewModel.isCartFill.bind { filled in
            self.setupButtonNavBar(filled)
        }
        viewModel.model.bind({ _ in
            self.tableView.reloadData()
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchData()
        self.tableView.reloadData()

    }

    fileprivate func setupUI() {
        tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .groceryPrimaryColor
        tableView.alwaysBounceVertical = false

        view.backgroundColor = .groceryPrimaryColor
        navigationController?.navigationBar.backgroundColor = .groceryPrimaryColor
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.arialBold(size: 21)!]
        title = "GROCERY_TITLE_LIST".localized
    }

    fileprivate func setupButtonNavBar(_ filled: Bool = false) {
        let image: UIImage = filled ? .groceryCartFill : .groceryCartEmpty
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.checkOut))
        button.tintColor = UIColor.groceryBlackText
        button.isEnabled = filled
        navigationItem.rightBarButtonItem = button
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.value.itemsType[section].items.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.model.value.itemsType.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let itemType = viewModel.model.value.itemsType[section]
        return GroceryItemSectionHeaderView(name: itemType.name, amount: itemType.totalAmountForType)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.model.value.itemsType[indexPath.section].items[indexPath.row]
        let cell = GroceryItemTableViewCell()
        cell.viewModel = viewModel.viewModel(from: item)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    @objc func checkOut(sender: UIButton) {
        viewModel.didTapOncheckout()
    }

}
