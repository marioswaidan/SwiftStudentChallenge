//
//  PagerView.swift
//  SwiftStudentChallenge
//
//  Created by Mario Swaidan on 2/20/24.
//

import SwiftUI

struct PagerView: View {
    
    @StateObject var viewModel = AppViewModel.shared
    
    var body: some View {
        HStack {
            
            
            //            left arrow
            Button(action: {
                if viewModel.currentIndex <= 4 {
                    viewModel.currentIndex -= 1
                } else {
                    viewModel.selectedTab = 1 // Switch to the second tab
                }
            }) {
                Spacer()
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width:100)
                Spacer()
            }
            .disabled(viewModel.currentIndex == 0)
            
            
//            right arrow
            Button(action: {
                if viewModel.currentIndex < 2 {
                    viewModel.currentIndex += 1
                } else {
                    viewModel.selectedTab = 1 // Switch to the second tab
                }
            }) {
                Spacer()
                Image(systemName: "arrow.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width:100)
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    PagerView()
}
