//
//  vers_iiApp.swift
//  vers-ii
//
//  Created by Mohameth Seck on 4/30/23.
//

import SwiftUI
import FirebaseCore

@main
struct vers_iiApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
