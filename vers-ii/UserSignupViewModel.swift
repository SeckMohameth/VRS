//
//  userSignupViewModel.swift
//  vers-ii
//
//  Created by Mohameth Seck on 5/1/23.
//

import Foundation
import Combine

//comforms to the observable object protocal
class UserSignupViewModel: ObservableObject {
    
    //Input
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    
    //Output
    @Published var isUsernameLengthValid = false
    @Published var isUserEmailValid = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCapitalLetter = false
    @Published var isPasswordConfirmValid = false
    
    
    
    private var cancellableSet : Set<AnyCancellable> = []
    
    init() {
        $username
            .receive(on: RunLoop.main)
            .map{ username in
                return username.count >= 4
            }
            .assign(to: \.isUsernameLengthValid, on:self)
            .store(in: &cancellableSet)
        
        $email
            .receive(on: RunLoop.main)
            .map { email in
                return self.isValidEmail(email)
            }
            .assign(to: \.isUserEmailValid, on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.count >= 8
            }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                let pattern = "[A-Z]"
                if let _ = password.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.isPasswordCapitalLetter, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest($password, $passwordConfirm)
            .receive(on: RunLoop.main)
            .map {(password, passwordConfirm) in
                return !passwordConfirm.isEmpty && (passwordConfirm == password)
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
        
    }
    
    
    // From chat GPT
    /*
     In this code, I added a new function called isValidEmail(_:) that takes an email string as input and returns a boolean value indicating whether the email is valid or not. It uses an NSPredicate to evaluate the email string against a regular expression pattern.

     Then, I added a new pipeline for the $email property that maps the email to a boolean value indicating its validity, assigns the result to the isUserEmailValid property, and stores the subscription in the cancellableSet.
     */
    private func isValidEmail(_ email: String) -> Bool {
           let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
           return emailPredicate.evaluate(with: email)
       }
    
}
