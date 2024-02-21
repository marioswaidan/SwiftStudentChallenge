import SwiftUI
import SafariServices

struct Licensing: View {
    // Define a list of glossary terms and their corresponding URLs
    let terms: [LicensingTerm] = [
        LicensingTerm(name: "Term 1", url: "https://www.google.com/"),
        LicensingTerm(name: "Term 2", url: "https://www.yahoo.com/"),
        // Add more terms as needed
    ]
    
    var body: some View {
        Questions()
        PagerView()
            }
        }

struct LicensingTerm {
    let name: String
    let url: String
}

struct Licensing_Previews: PreviewProvider {
    static var previews: some View {
        Licensing()
    }
}
