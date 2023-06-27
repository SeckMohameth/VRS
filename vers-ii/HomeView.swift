//
//  HomeView.swift
//  vers-ii
//
//  Created by Mohameth Seck on 5/3/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            ScrollView (.horizontal) {
                HStack {
                    ForEach(0..<10) {
                        Text("vid \($0)")
                            .frame(width: 300, height: 500)
                            .background(.black)
                            .foregroundColor(.white)
                            .padding()
            
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
