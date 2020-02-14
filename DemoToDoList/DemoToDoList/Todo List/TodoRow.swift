//
//  TodoRow.swift
//  DemoToDoList
//
//  Created by Alex Zarr on 2020-02-12.
//  Copyright © 2020 alexzarr. All rights reserved.
//

import SwiftUI

struct TodoRow: View {
    var todo: Todo
    
    var body: some View {
        HStack { // 1
            Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square") // 2
                .resizable() // 3
                .frame(width: 20, height: 20) // 4
                .foregroundColor(todo.isCompleted ? .blue : .black) // 5
            Text(todo.title)
            Spacer() // 6
        }
    }
}

struct TodoRow_Previews: PreviewProvider {
    static var previews: some View {
        Group { // 7
            TodoRow(todo: Todo(title: "Buy groceries"))
            TodoRow(todo: Todo(title: "Visit a doctor", isCompleted: true)) // 8
        }
        .previewLayout(.fixed(width: 300, height: 44)) // 9
    }
}
