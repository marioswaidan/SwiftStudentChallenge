//
//  ContentView.swift
//  SwiftStudentChallenge
//
//  Created by Mario Swaidan on 1/7/24.
//
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = AppViewModel.shared
    
    var body: some View {
        VStack {
            TabView(selection: $viewModel.selectedTab) {
                StoryView()
                    .tabItem {
                        Label("Story", systemImage: "book.fill")
                    }
                    .tag(0)
                Build()
                    .tabItem {
                        Label("Build", systemImage: "paperplane.fill")
                    }
                    .tag(1)
                FlyARView()
                    .tabItem {
                        Label("Fly", systemImage: "gamecontroller.fill")
                    }
                    .tag(2)
                Licensing()
                    .tabItem {
                        Label("Licensing", systemImage: "person.text.rectangle.fill")
                    }
                    .tag(3)
                Learn()
                    .tabItem{
                        Label("Learn", systemImage: "person.fill")
                    }
                    .tag(4)
            }
        }
        //.environmentObject(viewModel)
    }
}
#Preview {
    ContentView()
}
