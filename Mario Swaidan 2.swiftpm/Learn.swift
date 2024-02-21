import SwiftUI

struct Learn: View {
    var body: some View {
        ZStack {
            VStack{
                ScrollView {
                    VStack{
                        Image("UN")
                            .resizable()
                            .scaledToFit()
                        Text("\nMario Swaidan")
                            .font(.largeTitle)
                        Text("\n\nMario Swaidan graduated with a degree in Neuroscience from Michigan State University, then partnered with MSU's Conquer Accelerator Program as its first investor to form a drone company called AerBots.")
                            .font(.title2)
                        Image("patent")
                            .resizable()
                            .scaledToFit()
                            .padding(100)
                        Text("Most recently receiving a US patent for its proprietary propulsion system with Mario as its inventor.")
                            .font(.title2)
                        Image("DCA")
                            .resizable()
                            .scaledToFit()
                            .padding(100)
                        Text("Mario has taught several hundred students under a subsidiary of AerBots called Drone Capital Academy. He hopes to use Swift as he develops a proprietary AR platform for Drone Delivery Drone Pilot Training in Detroit.")
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                    }
                    
                    .padding(100)
                    
                }
                Spacer()
                PagerView()
            }
          
        }
    }
}

struct Learn_Previews: PreviewProvider {
    static var previews: some View {
        Learn()
    }
}
