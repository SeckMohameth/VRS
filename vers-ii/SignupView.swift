//
//  SignupView.swift
//  vers-ii
//
//  Created by Mohameth Seck on 5/1/23.
//
// comment to test github commit and push - June 27, 2023


import SwiftUI

struct SignupView: View {
//    @State private var username = ""
//    @State private var email = ""
//    @State private var password = ""
//    @State private var passwordConfirm = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @ObservedObject private var userRegistrationViewModel = UserSignupViewModel()
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Create an acocunt")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .padding(.bottom, 30)
                    
                    Group {
                        FormField(fieldName: "Username", fieldValue: $userRegistrationViewModel.username)
                        
                        RequirementText(iconColor: userRegistrationViewModel.isUsernameLengthValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255), text: "A minimum of 4 characters", isStrikeThrough: userRegistrationViewModel.isUsernameLengthValid)
                            .padding()
                        
                        FormField(fieldName: "Email@example.com", fieldValue: $userRegistrationViewModel.email)
                        
                        RequirementText(iconColor: userRegistrationViewModel.isUserEmailValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255),  text: "Must be a valid email", isStrikeThrough: userRegistrationViewModel.isUserEmailValid)
                            .padding()
                        
                    }
                    
                    
                    FormField(fieldName: "Password", fieldValue: $userRegistrationViewModel.password, isSecure: true)
                    
                    VStack {
                        RequirementText(iconName: "lock.open", iconColor: userRegistrationViewModel.isPasswordLengthValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255), text: "A minimum of 8 characters", isStrikeThrough: userRegistrationViewModel.isPasswordLengthValid)
                        
                        RequirementText(iconName: "lock.open", iconColor: userRegistrationViewModel.isPasswordCapitalLetter ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255), text: "One uppercase letter", isStrikeThrough: userRegistrationViewModel.isPasswordCapitalLetter)
                    }
                    .padding()
                    
                    FormField(fieldName: "Confirm Password", fieldValue: $userRegistrationViewModel.passwordConfirm, isSecure: true)
                    
                    RequirementText(iconColor: userRegistrationViewModel.isPasswordConfirmValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255), text: "Your confirm password should be the same as the password", isStrikeThrough: userRegistrationViewModel.isPasswordConfirmValid)
                        .padding()
                        .padding(.bottom, 50)
                    
                    Button(action: {
                        // Proceed to the next screen
                        //firebase auth should be here i think
                        
                        Task {
                            try await viewModel.createUser(withEmail: userRegistrationViewModel.email, password: userRegistrationViewModel.password, username: userRegistrationViewModel.username)
                        }
                    }) {
                        Text("Sign Up")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(
                                        LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing)
                                            .opacity(userRegistrationViewModel.username.isEmpty || userRegistrationViewModel.email.isEmpty || userRegistrationViewModel.password.isEmpty || userRegistrationViewModel.passwordConfirm.isEmpty ? 0.5 : 1.0)
                                    )
                            .cornerRadius(10)
                            .padding(.horizontal)
                        
                    }
                    .disabled(userRegistrationViewModel.username.isEmpty || userRegistrationViewModel.email.isEmpty || userRegistrationViewModel.password.isEmpty || userRegistrationViewModel.passwordConfirm.isEmpty)

                    
                    HStack {
                        Text("Already have an account?")
                            .font(.system(.body, design: .rounded))
                            .bold()
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Sign in")
                                .font(.system(.body, design: .rounded))
                                .bold()
                                .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
                        }
                    }.padding(.top, 50)

                    Spacer()
                    
                }//vstack
                .padding()
                
               
            }
        }
    }

}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}



struct FormField: View {
    var fieldName = ""
    @Binding var fieldValue: String
    
    var isSecure = false
    
    var body: some View {
        VStack {
            if isSecure {
                SecureField(fieldName, text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
            } else {
                TextField(fieldName, text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
            }
            
            Divider()
                .frame(height: 1)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .padding(.horizontal)
        }
    }
}


//requirement text styling
struct RequirementText: View {
    var iconName = "xmark.square"
    var iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)
    
    var text = ""
    var isStrikeThrough = false
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
                .strikethrough(isStrikeThrough)
            Spacer()
        }
    }
    
}

