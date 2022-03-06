//
//  GroceryCheckoutViewController.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 27/2/22.
//

import UIKit

class GroceryCheckoutViewController: UIViewController {

    fileprivate var headerContainer: UIView!
    fileprivate var headerImage: GroceryRoundedImageView!
    fileprivate var titleLabel: GroceryLabel!
    fileprivate var tableView: UITableView!
    fileprivate var checkoutButton: GroceryBarButton!

    var viewModel: GroceryCheckoutViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }

    fileprivate func setupUI() {
        setupButtonNavBar()
        setupHeader()
        setupTableView()
        setupCheckoutButton()
        view.backgroundColor = .groceryPrimaryColor
        view.addSubview(headerContainer)
        headerContainer.addSubview(titleLabel)
        headerContainer.addSubview(headerImage)
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
    }

    fileprivate func setupButtonNavBar() {
        navigationItem.hidesBackButton = true
        let button = UIBarButtonItem(image: .groceryQuit, style: .plain, target: self, action: #selector(self.close))
        button.tintColor = UIColor.groceryBlackText
        navigationItem.rightBarButtonItem = button
    }

    fileprivate func setupHeader() {
        headerContainer = UIView()
        headerContainer.translatesAutoresizingMaskIntoConstraints = false
        headerContainer.backgroundColor = .groceryPrimaryColor

        headerImage = GroceryRoundedImageView()
        headerImage.setImage(.groceryCartFill)

        titleLabel = GroceryLabel()
        titleLabel.text = "CHECK_OUT_TITLE".localized
        titleLabel.font = .arialBold(size: 18)
    }

    fileprivate func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .groceryPrimaryColor
        tableView.alwaysBounceVertical = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    fileprivate func setupCheckoutButton() {
        checkoutButton = GroceryBarButton()
        viewModel.totalAmount.bind({
            self.checkoutButton.setTitle("CHECKOUT_BUTTON_TITLE".localized($0 ?? ""), for: .normal)
        })
        checkoutButton.addTarget(self, action: #selector(checkoutAction), for: .touchUpInside)
    }

    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerContainer.heightAnchor.constraint(equalToConstant: 200),
            headerContainer.bottomAnchor.constraint(equalTo: tableView.topAnchor),

            headerImage.heightAnchor.constraint(equalToConstant: 128),
            headerImage.widthAnchor.constraint(equalToConstant: 128),
            headerImage.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 12),
            headerImage.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor),

            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor),

            checkoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            checkoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc fileprivate func close() {
        viewModel.close()
    }

    @objc fileprivate func checkoutAction() {
        viewModel.checkout()
    }
}

extension GroceryCheckoutViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model?.itemsType[section].items.count ?? 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.model?.itemsType.count ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let itemType = viewModel.model?.itemsType[section] else { return nil }
        return GroceryItemSectionHeaderView(name: itemType.name, amount: itemType.totalAmountForType)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.model?.itemsType[section].name.uppercased() ?? ""
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = viewModel.model?.itemsType[indexPath.section].items[indexPath.row] {
            let cell = GroceryItemTableViewCell()
            cell.viewModel = viewModel.viewModel(from: item)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
