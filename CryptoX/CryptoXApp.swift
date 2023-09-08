//
//  CryptoXApp.swift
//  CryptoX
//
//  Created by Marcelo de Araújo on 06/09/2023.
//

import SwiftUI

@main
struct CryptoXApp: App {
    @StateObject private var homeViewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(homeViewModel)
        }
    }
}
