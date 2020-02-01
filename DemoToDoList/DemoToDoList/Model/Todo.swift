//
//  Todo.swift
//  DemoToDoList
//
//  Created by Alex Zarr on 2020-01-29.
//  Copyright © 2020 alexzarr. All rights reserved.
//

import Foundation

struct Todo: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted = false
}
