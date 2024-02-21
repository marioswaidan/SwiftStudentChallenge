import SwiftUI
import SafariServices

struct Licensing: View {
    let terms: [LicensingTerm] = [
        LicensingTerm(name: "Term 1", url: "https://www.dronecapital.com/"),
        LicensingTerm(name: "Term 2", url: "https://www.yahoo.com/"),
    ]
    
    var body: some View {
        ZStack {
            Questions()
            VStack {
                Spacer()
                PagerView()}
        }
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
