//
//  GroceryCheckoutTests.swift
//  GroceryTests
//
//  Created by Gonzalo Vizeu on 5/3/22.
//

import XCTest
@testable import Grocery

class GroceryCheckoutTests: XCTestCase {
    var sut: GroceryCheckoutViewModel!
    static let totalAmount: String = "14,10 €"
    var repository: GroceryItemListRepository!
    let dataStorage = GroseryDataStorage()

    override func setUp() {
        super.setUp()
        repository = DefaultGroceryItemListRepository(session: MockGroceryAPI(), dataStorage: dataStorage)
        repository.fetchItems { _ in }
        setupModelForCheckOut(items: repository.fetchItemsFromDB(), dataStorage: dataStorage)
        sut = DefaultGroceryCheckoutViewModel(repository: repository)
    }

    override func tearDown() {
        super.tearDown()
        GroseryDataStorage.eraseData()
    }

    fileprivate func setupModelForCheckOut(items: [GroceryItem]?, dataStorage: GroseryDataStorage) {
        guard let item: GroceryItem = (items?.first),
              let item2: GroceryItem = (items?[1]),
              let item3: GroceryItem = (items?[2]) else {
                  XCTFail("Could not fetch data")
                  return
              }
        item.amount = 1
        item2.amount = 2
        item3.amount = 3
        dataStorage.updateItem(item)
        dataStorage.updateItem(item2)
        dataStorage.updateItem(item3)
    }

    func test_data_for_checkout() {
        guard let item = sut.model?.itemsType.first?.items.first?.amount,
              let item2 = sut.model?.itemsType[1].items[0].amount,
              let item3 = sut.model?.itemsType[1].items[1].amount else {
                  XCTFail("Could not fetch data")
                  return
              }

        XCTAssertEqual(item, 1)
        XCTAssertEqual(item2, 2)
        XCTAssertEqual(item3, 3)
        XCTAssertEqual(sut.totalAmount.value, Self.totalAmount)
    }

    func test_amount_when_update_cart() {
        guard let item = sut.model?.itemsType.first?.items.first,
              let cartItem = sut.viewModel(from: item) else {
                  XCTFail("Could not fetch data")
                  return
              }
        cartItem.addItem()
        let totalAmount = sut.totalAmount.value
        XCTAssertGreaterThan(totalAmount!, Self.totalAmount)
        XCTAssertGreaterThan(Int(dataStorage.getItemBy(id: item.id)?.amount ?? 0), 1)
    }
}
