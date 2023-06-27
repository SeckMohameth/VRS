//
//  ContentView.swift
//  vers-ii
//
//  Created by Mohameth Seck on 4/30/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                MainView()
            } else {
                LoginView()
                    //.environmentObject(viewModel)
            }
        }
//        .onReceive(viewModel.$userSession) { _ in
//                    // Trigger view update when userSession changes
//                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
