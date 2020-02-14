//
//  DataManager.swift
//  DemoToDoList
//
//  Created by Alex Zarr on 2020-01-29.
//  Copyright © 2020 alexzarr. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    func fetchTodoList(includingCompleted: Bool) -> [Todo]
    func add(todo: Todo)
    func toggleIsCompleted(for todo: Todo)
}

extension DataManagerProtocol {
    func fetchTodoList(includingCompleted: Bool = false) -> [Todo] {
        fetchTodoList(includingCompleted: includingCompleted)
    }
}

class DataManager {
    static let shared: DataManagerProtocol = DataManager()
    
    private var todos = [Todo]()
    
    private init() { }
}

// MARK: - DataManagerProtocol
extension DataManager: DataManagerProtocol {
    func fetchTodoList(includingCompleted: Bool = false) -> [Todo] {
        includingCompleted ? todos : todos.filter { !$0.isCompleted }
    }
    
    func add(todo: Todo) {
        todos.insert(todo, at: 0)
    }
    
    func toggleIsCompleted(for todo: Todo) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
        }
    }
}
