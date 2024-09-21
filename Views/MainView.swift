//
//  ContentView.swift
//  ToDoList
//
//  Created by Krish on 9/20/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // signed in
            ToDoListView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    MainView()
}
