//
//  NVTodoCard.swift
//  NVToDo
//
//  Created by Nikilicious on 06/07/23.
//

import Foundation
import SwiftUI

struct NVTodoCard: View {
    @Environment(\.editMode) var editMode
    @State private var editedTitle = ""
    let todo: Todo
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
                    .foregroundColor(.black)
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
