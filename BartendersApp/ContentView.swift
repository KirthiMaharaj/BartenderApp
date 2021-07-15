//
//  ContentView.swift
//  BartendersApp
//
//  Created by Kirthi Maharaj on 2021/07/14.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured
    enum Tab{
        case featured
        case list
    }
    var body: some View {
        VStack{
            TabView(selection: $selection) {
                BarCategory()
                .tabItem {
                    Label("list", systemImage: "list.bullet")
                }.tag(Tab.featured)
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
