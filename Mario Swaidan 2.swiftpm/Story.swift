import SwiftUI


struct DetailViewData {
    var imageName: String
    var text: String
}

struct DetailView: View {
    var data: DetailViewData
    
    var body: some View {
        VStack {
            Spacer()
            Image(data.imageName)
                .resizable()
                .scaledToFit()
                .padding()
            Spacer()
            Text(data.text)
                .font(.title2)
                .frame(width: 300,height: 300)
            Spacer()
            PagerView()
        }
    }
}


struct StoryView: View {
    @StateObject var viewModel = AppViewModel.shared
    

    let detailViewsData = [
        DetailViewData(imageName: "MSU", text: "On the most beautiful campus on the planet, Michigan State University, is a young man named Mario studying Neuroscience."),
        DetailViewData(imageName: "neuro", text: "Fascinated with neuroscience and how our bodies are animated by electricity, he specializes in Neural Engineering."),
        DetailViewData(imageName: "drone wood", text: "One day, he was studying while his friend's were out, and he looked out the window at a hawk flying. It's liberty in being able to soar around captivated the young man. 'I wonder how it feels to fly; to be free like that.' Because of that, he decided he would build his own drone, and he did.")
    ]
    
    var body: some View {

        if viewModel.currentIndex >= 0 && viewModel.currentIndex < detailViewsData.count {
            DetailView(data: detailViewsData[viewModel.currentIndex])
        } else {

            Text("Content not available")
        }
    }
}


struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView().environmentObject(AppViewModel.shared)
    }
}
