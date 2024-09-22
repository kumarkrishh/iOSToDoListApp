//
//  ProfileViewViewModel.swift
//  ToDoList
//
//  Created by Krish on 9/20/24.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class ProfileViewViewModel: ObservableObject {
    @Published var user: User? = nil
    
    init() {
    }
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No user logged in")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            if let error = error {
                print("Firestore error: \(error.localizedDescription)")
                return
            }
            guard let data = snapshot?.data() else {
                print("No data found for user")
                return
            }
            
            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0
                )
            }
        }
    }
    
    func logOut() {
        try? Auth.auth().signOut()
        user = nil
    }
}
