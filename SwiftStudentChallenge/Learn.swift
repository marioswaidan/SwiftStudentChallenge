import SwiftUI
import WebKit

// FullScreenWebView using WKWebView for a more immersive web experience
struct FullScreenWebView: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

// WebViewContainerView adjusts the positioning of FullScreenWebView
struct WebViewContainerView: View {
    var url: URL
    
    var body: some View {
        GeometryReader { geometry in
            FullScreenWebView(url: url)
                .frame(height: geometry.size.height + 100) // Adjust this value as needed
                .ignoresSafeArea()
        }
    }
}

// LearnItem model to represent each grid item
struct LearnItem: Identifiable {
    let id: Int
    let iconName: String
    let url: URL
}

// Main view displaying a grid of icons
struct Learn: View {
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    // Example data for grid items
    let items: [LearnItem] = [
        LearnItem(id: 1, iconName: "person.fill", url: URL(string: "https://www.marioswaidan.com/")!),
        LearnItem(id: 2, iconName: "paperplane.fill", url: URL(string: "https://www.aerbots.com/2")!),
        LearnItem(id: 3, iconName: "gamecontroller.fill", url: URL(string: "https://www.dronecapital.com/2")!),
        LearnItem(id: 4, iconName: "flag.checkered.2.crossed", url: URL(string: "https://www.worlddroneleague.com/2")!),
        LearnItem(id: 5, iconName: "trophy.fill", url: URL(string: "https://www.detdff.com/2")!),
        LearnItem(id: 6, iconName: "newspaper.fill", url: URL(string: "https://www.example.com/2")!),
        LearnItem(id: 7, iconName: "heart.fill", url: URL(string: "https://www.example.com/2")!),
        LearnItem(id: 8, iconName: "heart.fill", url: URL(string: "https://www.example.com/2")!),
        LearnItem(id: 9, iconName: "heart.fill", url: URL(string: "https://www.example.com/2")!),
        // Add more items as needed
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(items) { item in
                        NavigationLink(destination: WebViewContainerView(url: item.url)) {
                            VStack {
                                Image(systemName: item.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.blue)
                                Text(item.url.host!) // Display the host, safely unwrapped
                                    .font(.caption)
                                    .lineLimit(1)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Learn")
        }
    }
}

// Preview provider for SwiftUI previews
struct Learn_Previews: PreviewProvider {
    static var previews: some View {
        Learn()
    }
}
