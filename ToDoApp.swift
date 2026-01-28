//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by students on 15/12/25.
//

import SwiftUI
import SwiftData

@main
struct ToDoAppApp: App {
    var body: some Scene {
        WindowGroup {
            Notes()
                .modelContainer(for: Listt.self)
        }
    }
}
