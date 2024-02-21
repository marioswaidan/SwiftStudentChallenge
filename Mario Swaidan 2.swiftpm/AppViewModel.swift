//
//  AppViewModel.swift
//  SwiftStudentChallenge
//
//  Created by Mario Swaidan on 2/20/24.
//

import Foundation
class AppViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var currentIndex: Int = 0
    @Published var instructions: String = ""
    static let shared = AppViewModel()
    
    private init() {}
    
}
