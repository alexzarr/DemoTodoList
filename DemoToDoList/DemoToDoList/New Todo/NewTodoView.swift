//
//  NewTodoView.swift
//  DemoToDoList
//
//  Created by Alex Zarr on 2020-02-04.
//  Copyright © 2020 alexzarr. All rights reserved.
//

import SwiftUI

struct NewTodoView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: NewTodoViewModel

    @ObservedObject private var keyboard = KeyboardResponder()
    
    @State private var title = ""
    
    private var isAddButtonDisabled: Bool { // 1
        title.isEmpty
    }
    
    private var addButtonColor: Color { // 2
        isAddButtonDisabled ? .gray : .blue
    }
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Enter Name", text: $title)
            Spacer()
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
                .padding(.vertical, 16.0)
                .frame(minWidth: 0, maxWidth: .infinity)

                Button(action: {
                    if !self.isAddButtonDisabled { // 3
                        self.viewModel.addNewTodo(title: self.title)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Add")
                        .foregroundColor(.black) // 4
                }
                .padding(.vertical, 16.0)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(addButtonColor) // 5
                .disabled(isAddButtonDisabled) // 5
            }
        }
        .padding()
        .padding(.bottom, keyboard.currentHeight)
        .animation(.easeOut(duration: keyboard.duration))
    }
}

struct NewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        NewTodoView(viewModel: NewTodoViewModel())
    }
}
