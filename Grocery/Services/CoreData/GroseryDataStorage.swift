//
//  CoreDataHelper.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 26/2/22.
//

import Foundation
import CoreData

protocol GroseryStorage {
    func fetchGroceryItems() -> [GroceryItem]?
    func addItem(name: String, id: Int64, price: Float, type: String)
    func getItemBy(id: Int64) -> GroceryItem?
    func updateItem(_ item: GroceryItem)
}

class GroseryDataStorage: GroseryStorage {

    private static var persistentContainer: NSPersistentContainer!
    private var viewContext: NSManagedObjectContext { Self.persistentContainer.viewContext }

    init() {
        Self.persistentContainer = NSPersistentContainer(name: "GroceryDataModel")
        Self.persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
        Self.persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        print(NSPersistentContainer.defaultDirectoryURL())
    }

    func fetchGroceryItems() -> [GroceryItem]? {
        let request: NSFetchRequest<GroceryItem> = GroceryItem.fetchRequest()
        let viewContext = viewContext
        do {
            let task = try viewContext.fetch(request)
            return task
        } catch {
            return nil
        }
    }

    func addItem(name: String, id: Int64, price: Float, type: String) {
        if getItemBy(id: id) == nil {
            let newItem = GroceryItem(context: viewContext)
            newItem.name = name
            newItem.id = id
            newItem.price = price
            newItem.type = type
            newItem.amount = 0
            newItem.timestamp = Date()
            try? viewContext.save()
        }

    }

    func getItemBy(id: Int64) -> GroceryItem? {
        let request: NSFetchRequest<GroceryItem> = GroceryItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %i", id)

        let viewContext = viewContext

        do {
            let task = try viewContext.fetch(request).first
            return task

        } catch {
            return nil
        }
    }

    func updateItem(_ item: GroceryItem) {
        try? viewContext.save()
    }

    static func eraseData() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "GroceryItem")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        _ = try? Self.persistentContainer.viewContext.execute(request)
    }
}
