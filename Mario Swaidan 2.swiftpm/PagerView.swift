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
        ZStack {
            Color.red
                .frame(height: 50)
            HStack {
                
                
  
                Button(action: {
                    if viewModel.selectedTab > 0 && viewModel.currentIndex > 3 {
                        viewModel.currentIndex -= 1
                        viewModel.selectedTab -= 1
                    } else if viewModel.currentIndex > 0 {
                        viewModel.currentIndex -= 1
                    } else {
                        viewModel.selectedTab = 1
                    }
                }) {
                    Spacer()
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width:50)
                    Spacer()
                }
                .disabled(viewModel.currentIndex == 0)
                
                

                
                Button(action: {
                    
                    
                    
                    
                    if viewModel.currentIndex < 2 {
                        viewModel.currentIndex += 1
                    }
                    else if viewModel.currentIndex < 7{
                        //viewModel.currentIndex += 1
                        viewModel.selectedTab += 1
                    }
                    else {
                        viewModel.selectedTab = 0
                        viewModel.currentIndex = 0

                    }
                }) {
                    Spacer()
                    Image(systemName: "arrow.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width:50)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    PagerView()
}
