//
//  AuthViewModel.swift
//  vers-ii
//
//  Created by Mohameth Seck on 5/2/23.
//

import Foundation

//importing firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

protocol AuthenticationFormProtocol{
    var formIsValid: Bool { get }
}


//this will handle the networking for the authentication
@MainActor
class AuthViewModel: ObservableObject {
    
    //firebase user
    @Published var userSession: FirebaseAuth.User?
    //our user we created
    @Published var currentUser: User?
    
    init() {
        // when the auth view model initailizes it will check to see if the user is signed in
        // firebase stores (cache) that info locally on the device
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    //sign in user function
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to login user with error: \(error.localizedDescription)")

        }
    }
    
    //function to create the user
    func createUser(withEmail email: String, password: String, username: String) async throws {
        do {
            //creating the user with firebase. Awaits the result and stores it in result variable
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            //when we get the result we set the session
            self.userSession = result.user
            
            //Then we create our user object
            let user = User(id: result.user.uid,  email: email, username: username, creationDate: Date())
           
            //then we encode that object through the encoder protocal
            let encodedUser = try Firestore.Encoder().encode(user)
            
            //then we upload that data to firestore
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            await fetchUser()
            
            //catches the errors
        } catch {
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
        }
        
        
    }
    
    //function to sign out
    func signOut(){
        do {
            try Auth.auth().signOut() // signs out user on backend
            self.userSession = nil // wipes out the user session and takes us back to login screen
            self.currentUser = nil // wipes out current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    //delete account
    func deleteAccount(){
        
    }
    
    //fetch the userData
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
    }
    
    
}
