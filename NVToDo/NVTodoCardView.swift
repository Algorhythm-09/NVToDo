//
//  NVTodoCardView.swift
//  NVToDo
//
//  Created by Nikilicious on 05/07/23.
//

import SwiftUI

struct Todo: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var isEditing = false // Track if the card is being edited
}

class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []

    func addTodo() {
        todos.append(Todo(title: "New Todo"))
    }

    func deleteTodo(at index: Int) {
        todos.remove(at: index)
    }

    func move(from source: IndexSet, to destination: Int) {
        todos.move(fromOffsets: source, toOffset: destination)
    }

    func toggleEditing(for todo: Todo) {
        if let index = todos.firstIndex(of: todo) {
            // Toggle editing for the selected todo
            todos[index].isEditing.toggle()
        }
    }

    func updateTodoTitle(for todo: Todo, with title: String) {
        if let index = todos.firstIndex(of: todo) {
            // Update the title for the selected todo
            todos[index].title = title
        }
    }
}

struct NVTodoCardView: View {
    @StateObject var viewModel = TodoViewModel()

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.addTodo()
                }, label: {
                    Label("Add Todo", systemImage: "plus")
                })
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                EditButton()
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            List {
                ForEach(viewModel.todos) { todo in
                    NVTodoCard(todo: todo, onDelete: {
                        if let index = viewModel.todos.firstIndex(of: todo) {
                            viewModel.deleteTodo(at: index)
                        }
                    }, onToggleEditing: {
                        viewModel.toggleEditing(for: todo)
                    }, onUpdateTitle: { newTitle in
                        viewModel.updateTodoTitle(for: todo, with: newTitle)
                    })
                    .padding(.vertical, 4)
                }
                .onMove { indices, newOffset in
                    viewModel.move(from: indices, to: newOffset)
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding()
    }
}

struct NVTodoCard: View {
    @Environment(\.editMode) var editMode
    @State private var editedTitle = ""
    let todo: Todo
    let onDelete: () -> Void
    let onToggleEditing: () -> Void
    let onUpdateTitle: (String) -> Void

    var body: some View {
        HStack {
            if todo.isEditing && editMode?.wrappedValue != .active {
                TextField("Todo", text: $editedTitle, onCommit: {
                    onUpdateTitle(editedTitle)
                    onToggleEditing()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.trailing, 8)
            } else {
                Text(todo.title)
                    .font(.headline)
            }

            Spacer()

            if todo.isEditing {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .onTapGesture {
                        onUpdateTitle(editedTitle)
                        onToggleEditing()
                    }
            } else {
                Image(systemName: "pencil.circle")
                    .onTapGesture {
                        editedTitle = todo.title
                        onToggleEditing()
                    }
            }
        }
        .padding()
        .background(Color.yellow)
        .cornerRadius(8)
    }
}
