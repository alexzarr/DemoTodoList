//
//  TodoMO.swift
//  DemoToDoList
//
//  Created by alex.zarr on 5/26/20.
//  Copyright © 2020 alexzarr. All rights reserved.
//

import CoreData

@objc(TodoMO)
final class TodoMO: NSManagedObject {
//    static let entityName = "TodoMO"
//    
//    class func entityFetchRequest() -> NSFetchRequest<TodoMO> {
//        return NSFetchRequest<TodoMO>(entityName: entityName)
//    }
    
    @NSManaged var uuid: UUID?
    @NSManaged var title: String
    @NSManaged var isCompleted: Bool
}

extension TodoMO {
    func convertToTodo() -> Todo {
        Todo(
            id: uuid ?? UUID(),
            title: title,
            isCompleted: isCompleted
        )
    }
}
