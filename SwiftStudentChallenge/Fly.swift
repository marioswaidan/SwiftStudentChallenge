import SwiftUI

// ViewModel for managing selected tab across the app

// Define your detail views
struct DetailFly1: View {
    var body: some View {
        Text("Detail View 1")
        PagerView()
    }
}

struct DetailFly2: View {
    var body: some View {
        Text("Detail View 2")
        PagerView()
    }
}

struct DetailFly3: View {
    var body: some View {
        Text("Detail View 3")
        PagerView()
    }
}

// StoryView for navigating through detail views and to the second tab

struct FlyView: View {
    //    @EnvironmentObject var viewModel: AppViewModel
   //@State private var currentIndex = 0
    @StateObject var viewModel = AppViewModel.shared
    
    var body: some View {
        VStack {
            switch viewModel.currentIndex {
            case 0:
                DetailView1()
            case 1:
                DetailView2()
            case 2:
                DetailView3()
            default:
                EmptyView()
            }
            
//            HStack {
//                Button(action: {
//                    if viewModel.currentIndex > 0 {
//                        viewModel.selectedTab -= 1
//                        viewModel.currentIndex -= 1
//                    }
//                }) {
//                    Image(systemName: "arrow.left")
//                }
//                .disabled(viewModel.currentIndex == 0)
//
//                Button(action: {
//                    if viewModel.currentIndex < 2 {
//                        viewModel.currentIndex += 1
//                    } else {
//                        viewModel.selectedTab = 1 // Switch to the second tab
//                    }
//                }) {
//                    Image(systemName: "arrow.right")
//                }
//            }
//            .padding()
        }
    }
}


// Main ContentView with TabView


// Main App Entry

// Preview for StoryView
struct FlyView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView().environmentObject(AppViewModel.shared)
    }
}
