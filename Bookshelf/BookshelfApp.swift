//
//  BookshelfApp.swift
//  Bookshelf
//
//  Created by Andrea Yong on 6/9/23.
//

import SwiftUI

@main
struct BookshelfApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
