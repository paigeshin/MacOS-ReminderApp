//
//  HomeScreen.swift
//  Reminder
//
//  Created by paige shin on 10/20/23.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationView {
            SideBarView()
            Text("My List Item")
        } //: NavigationView
    } //: body
}

#Preview {
    HomeScreen()
}
