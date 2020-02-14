//
//  TodoListView.swift
//  DemoToDoList
//
//  Created by Alex Zarr on 2020-01-31.
//  Copyright © 2020 alexzarr. All rights reserved.
//

import SwiftUI

struct TodoListView: View {
    @ObservedObject var viewModel = TodoListViewModel()
    
    @State private var isShowingAddNew = false
    
    private var addNewButton: some View {
        Button(action: {
            self.isShowingAddNew.toggle()
        }) {
            Image(systemName: "plus")
        }
    }
    
    private var showCompletedButton: some View {
        Button(action: {
            self.viewModel.showCompleted.toggle()
        }) {
            Image(systemName: self.viewModel.showCompleted ? "checkmark.circle.fill" : "checkmark.circle")
        }
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.todos) { todo in
                Button(action: {
                    self.viewModel.toggleIsCompleted(for: todo)
                }) {
                    TodoRow(todo: todo)
                }
            }
            .navigationBarTitle(Text("Todo List"))
            .navigationBarItems(leading: showCompletedButton, trailing: addNewButton)
        }
        .sheet(isPresented: $isShowingAddNew, onDismiss: {
            self.viewModel.fetchTodos()
        }) {
            NewTodoView(viewModel: NewTodoViewModel())
        }
        .onAppear {
            self.viewModel.fetchTodos()
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        var view = TodoListView()
        view.viewModel = TodoListViewModel(dataManager: MockDataManager())
        return view
    }
}
