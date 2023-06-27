//
//  MainView.swift
//  vers-ii
//
//  Created by Mohameth Seck on 5/2/23.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        TabView {
            HomeView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ExploreView()
                //.font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
            
            //Text("Camera Tab")
            CameraView()
                //.font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "video.circle.fill")
                    Text("Video")
                }
            
            ProfileView()
            //Text("Profile Tab")
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
            
        }
        .accentColor(.black)
    }
}


//Color(red: 240/255, green: 240/255, blue: 240/255)

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AuthViewModel())
    }
}
