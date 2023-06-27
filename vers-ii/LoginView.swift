//
//  LoginView.swift
//  vers-ii
//
//  Created by Mohameth Seck on 5/1/23.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                
                Image("vers")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)
                    
                
                TextField("Email", text: $email)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
                
                
                Divider()
                    .frame(height: 1)
                    .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 50)
                
                SecureField("Password", text: $password)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
                Divider()
                    .frame(height: 1)
                    .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                    .padding(.horizontal)
                
                Button(action: {
                    // Proceed to the next screen
                    //firebase auth
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                }) {
                    Text("Login")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .disabled(!formIsValid)
                        .opacity(formIsValid ? 1.0 : 0.5)
                    
                }
                .padding(.top, 40)
                
               
                
                NavigationLink {
                    SignupView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack (spacing: 10) {
                        Text("Don't have an account?")
                            .font(.system(.body, design: .rounded))
                            .bold()
                            .foregroundColor(.black)
                        Text("Sign Up!")
                            .font(.system(.body, design: .rounded))
                            .bold()
                            .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
                    }

                }
                .padding(.top, 160)
                
               
                
                

              
                
            } // first vstack for email and password login
            .padding(.bottom, 200)
             
            
           

        }
    }
}
// MARK - authentication protocol -> form validation for login screen
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count >= 8
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
