//
//  ProfileView.swift
//  vers-ii
//
//  Created by Mohameth Seck on 5/2/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
     //   if let user = viewModel.currentUser {
            List {
                Section{
                    Text(viewModel.currentUser?.username ?? "Unknown")
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(height: 72)
                    Text(viewModel.currentUser?.email ?? "Unknown")
                        .foregroundColor(.gray)
                        
                }
                Section("General") {
                    HStack {
                        Image(systemName: "gear")
                        Text("More accoount settings to be added")
                            .foregroundColor(Color(.systemGray))
                    }
                    Text("Contact developer to have your account deleted")
                        .foregroundColor(Color(.systemGray))
                    
                }
                Section("Account") {
                    Button(action: {
                        viewModel.signOut()
                    }) {
                        Text("Logout")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        
                    }
                    .padding()
                    
                }
            }
        //}
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())

    }
}
