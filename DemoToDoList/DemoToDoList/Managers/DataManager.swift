//
//  DataManager.swift
//  DemoToDoList
//
//  Created by Alex Zarr on 2020-01-29.
//  Copyright © 2020 alexzarr. All rights reserved.
//

import Foundation
import DBHelper
import CoreData

protocol DataManagerProtocol {
    func fetchTodoList(includingCompleted: Bool) -> [Todo]
    func addTodo(title: String)
    func toggleIsCompleted(for todo: Todo)
}

extension DataManagerProtocol {
    func fetchTodoList(includingCompleted: Bool = false) -> [Todo] {
        fetchTodoList(includingCompleted: includingCompleted)
    }
}

class DataManager {
    static let shared: DataManagerProtocol = DataManager()
    
    var dbHelper: CoreDataHelper = CoreDataHelper.shared
    
    private init() { }
    
    private func getTodoMO(for todo: Todo) -> TodoMO? {
        let predicate = NSPredicate(
            format: "uuid = %@",
            todo.id as CVarArg)
        let result = dbHelper.fetchFirst(TodoMO.self, predicate: predicate)
        switch result {
        case .success(let todoMO):
            return todoMO
        case .failure(_):
            return nil
        }
    }
}

// MARK: - DataManagerProtocol
extension DataManager: DataManagerProtocol {
    func fetchTodoList(includingCompleted: Bool = false) -> [Todo] {
        let predicate = includingCompleted ? nil : NSPredicate(format: "isCompleted == false")
        let result: Result<[TodoMO], Error> = dbHelper.fetch(TodoMO.self, predicate: predicate)
        switch result {
        case .success(let todoMOs):
            return todoMOs.map { $0.convertToTodo() }
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    func addTodo(title: String) {
        let entity = TodoMO.entity()
        let newTodo = TodoMO(entity: entity, insertInto: dbHelper.context)
        newTodo.uuid = UUID()
        newTodo.title = title
        dbHelper.create(newTodo)
    }
    
    func toggleIsCompleted(for todo: Todo) {
        guard let todoMO = getTodoMO(for: todo) else { return }
        todoMO.isCompleted.toggle()
        dbHelper.update(todoMO)
    }
}
