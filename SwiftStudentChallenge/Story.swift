import SwiftUI

// ViewModel for managing selected tab across the app

// Define your detail views
struct DetailView1: View {
    var body: some View {
        ZStack {
            Color.red
            Color.white
                .frame(width: 375, height: 725)
            
            VStack {
                Spacer()
                Image("MSU")
                    .resizable()
                    .scaledToFit()
                    .frame(width:300)
                Spacer()
                Text("On the most beautiful campus on the planet, Michigan State University, is a young man named Mario studying Neuroscience.")
                    .font(.title2)
                    .frame(width: 325)
                Spacer()
                PagerView()
                Spacer()
            }
        }
        
    }
}

struct DetailView2: View {
    var body: some View {
        ZStack {
            Color.red
            Color.white
                .frame(width: 375, height: 725)
            
            VStack {
                Spacer()
                
                Image("MSU")
                    .resizable()
                    .scaledToFit()
                    .frame(width:300)
                Spacer()
                Text("Fascinated with neuroscience and how our bodies are animated by electricity, he specializes in Neural Engineering.")
                    .font(.title2)
                    .frame(width: 300)
                Spacer()
                PagerView()
                Spacer()
            }
        }
    }
}

struct DetailView3: View {
    var body: some View {
        ZStack {
            Color.red
            Color.white
                .frame(width: 375, height: 725)
            VStack {
                Spacer()
                Image("MSU")
                    .resizable()
                    .scaledToFit()
                    .frame(width:300)
                Spacer()
                Text("One day, he was studying while his friend's were out, and he looked out the window at a hawk flying. It's liberty in being able to soar around captivated the young man. 'I wonder how it feels to fly; to be free like that.'")
                    .font(.title2)
                    .frame(width: 300)
                Spacer()
                PagerView()
                Spacer()
            }
        }
    }
}

// StoryView for navigating through detail views and to the second tab

struct StoryView: View {
    //    @EnvironmentObject var viewModel: AppViewModel
    //@State private var currentIndex = 0
    @StateObject var viewModel = AppViewModel.shared
    
    var body: some View {
        VStack {
            switch viewModel.currentIndex {
            case 0:
                DetailView1()
                //                AppViewModel.instructions = "Detail vstring 1"
            case 1:
                DetailView2()
            case 2:
                DetailView3()
            default:
                EmptyView()
            }
        }
    }
}


// Main ContentView with TabView


// Main App Entry

// Preview for StoryView
struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView().environmentObject(AppViewModel.shared)
    }
}
