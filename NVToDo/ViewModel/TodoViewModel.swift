//
//  TodoViewModel.swift
//  NVToDo
//
//  Created by Nikilicious on 06/07/23.
//

import Foundation
import SwiftUI

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
            todos[index].isEditing.toggle()
        }
    }

    func updateTodoTitle(for todo: Todo, with title: String) {
        if let index = todos.firstIndex(of: todo) {
            todos[index].title = title
        }
    }
}
