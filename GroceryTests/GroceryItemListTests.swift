//
//  GroceryTests.swift
//  GroceryTests
//
//  Created by Gonzalo Vizeu on 26/2/22.
//

import XCTest
@testable import Grocery

class GroceryItemListTests: XCTestCase {

    var sut: GroceryListViewModel!

    override class func setUp() {
        super.setUp()
        GroseryDataStorage.eraseData()
    }

    override func setUp() {
        super.setUp()
        let repositoy  = DefaultGroceryItemListRepository(session: MockGroceryAPI(), dataStorage: GroseryDataStorage())
        sut = DefaultGroceryListViewModel(repository: repositoy)
        sut.fetchData()
    }

    override func tearDown() {
        super.tearDown()
        GroseryDataStorage.eraseData()
    }

    func test_data_when_fetch_items() {
        sut.fetchData()
        XCTAssertTrue(sut.model.value.itemsType.count == 3)
    }

    func test_cart_fill_when_add_items() {
        let item = getFirstItem()
        item?.addItem()
        XCTAssertTrue(sut.isCartFill.value)
    }

    func test_cart_empty_when_remove_item() {
        let item = getFirstItem()
        item?.addItem()
        XCTAssertTrue(sut.isCartFill.value)
        item?.removeItem()
        XCTAssertFalse(sut.isCartFill.value)
    }

    func test_full_amount_when_add_all_items() {
        sut.model.value.itemsType.forEach({ itemType in
            itemType.items.forEach({ sut.viewModel(from: $0)?.addItem() })
        })
        XCTAssertEqual(sut.model.value.totalAmount, 25.72)
        guard sut.model.value.itemsType.count > 0 else {
                  XCTFail("Could not fetch data")
                  return
              }
        XCTAssertEqual(sut.model.value.itemsType[0].totalAmountForType.value, 8.9)
        XCTAssertEqual(sut.model.value.itemsType[1].totalAmountForType.value, 4.4)
        XCTAssertEqual(sut.model.value.itemsType[2].totalAmountForType.value, 12.42)
    }

    func test_get_data_from_db_when_fetch_data_multiple_times() {
        sleep(5)
        sut.fetchData()
        guard let lastRefreshDate = sut.model.value.itemsType.first?.items.first?.timestamp,
              let timeDiff = Calendar.current.dateComponents([.second], from: lastRefreshDate, to: Date()).second else {
                  XCTFail("Could not get refresh date")
                  return
              }
       XCTAssertGreaterThan(timeDiff, 4)
    }

    fileprivate func getFirstItem() -> GroceryItemViewModel? {
        guard let item = sut.model.value.itemsType.first?.items.first else {
            XCTFail("Could not retrieve item")
            return nil
        }
        return sut.viewModel(from: item)
    }
}
