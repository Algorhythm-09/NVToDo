//
//  NVTodoCardView.swift
//  NVToDo
//
//  Created by Nikilicious on 05/07/23.
//

import SwiftUI

struct NVTodoCardView: View {
    @StateObject var viewModel = TodoViewModel()

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.addTodo()
                }, label: {
                    Label("Add to Todo", systemImage: "plus")
                })
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                if !viewModel.todos.isEmpty {
                    EditButton()
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }

            List {
                ForEach(viewModel.todos) { todo in
                    NVTodoCard(todo: todo, onToggleEditing: {
                        viewModel.toggleEditing(for: todo)
                    }, onUpdateTitle: { newTitle in
                        viewModel.updateTodoTitle(for: todo, with: newTitle)
                    })
                    .padding(.vertical, 4)
                }
                .onMove { indices, newOffset in
                    viewModel.move(from: indices, to: newOffset)
                }
                .onDelete { index in
                    viewModel.deleteTodo(at: index.first ?? 0)
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding()
    }
}

