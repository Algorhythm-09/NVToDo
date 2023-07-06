//
//  Todo.swift
//  NVToDo
//
//  Created by Nikilicious on 06/07/23.
//

import Foundation

struct Todo: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var isEditing = false
}
