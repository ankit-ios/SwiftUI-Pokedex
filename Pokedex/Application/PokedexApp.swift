//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Ankit Sharma on 19/10/23.
//

import SwiftUI
import FirebaseCore

@main
struct PokedexApp: App {
    // registering app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        initialAppSetup()
        return true
    }
    
    //Initial setup
    private func initialAppSetup() {
        FirebaseApp.configure()
        PokemonGenderManager.shared.fetchGenderData()
    }
}
