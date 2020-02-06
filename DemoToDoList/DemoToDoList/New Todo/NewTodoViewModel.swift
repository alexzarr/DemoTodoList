//
//  NewTodoViewModel.swift
//  DemoToDoList
//
//  Created by Alex Zarr on 2020-02-04.
//  Copyright © 2020 alexzarr. All rights reserved.
//

import Foundation
import Combine

protocol NewTodoViewModelProtocol {
    func addNewTodo(title: String)
}

final class NewTodoViewModel: ObservableObject {
    var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
}

// MARK: - NewTodoViewModelProtocol
extension NewTodoViewModel: NewTodoViewModelProtocol {
    func addNewTodo(title: String) {
        dataManager.addTodo(title: title)
    }
}
