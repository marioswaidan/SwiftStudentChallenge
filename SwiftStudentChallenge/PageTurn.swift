//
//  PageTurn.swift
//  SwiftStudentChallenge
//
//  Created by Mario Swaidan on 2/21/24.
//

        import SwiftUI

        struct PageTurn: View {
            @State private var isFlipped = false
            
            var body: some View {
                VStack {
                    if isFlipped {
                        BackPageView()
                            .transition(.asymmetric(insertion: .identity, removal: .identity))
                    } else {
                        FrontPageView()
                            .transition(.asymmetric(insertion: .identity, removal: .identity))
                    }
                }
                .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        isFlipped.toggle()
                    }
                }
            }
        }

        struct FrontPageView: View {
            var body: some View {
                ZStack {
                    Color.blue
                    Text("Front Page")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
        }

        struct BackPageView: View {
            var body: some View {
                ZStack {
                    Color.green
                    Text("Back Page")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
        }

        struct PageTurnView_Previews: PreviewProvider {
            static var previews: some View {
                PageTurn()
            }
        }

#Preview {
    PageTurn()
}
