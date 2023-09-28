//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
// Copyright (c) 2023 Hackenbacker.
//
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php
//
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

import SwiftUI

struct ContentView: View {
    @State private var hideNavBar: Bool = true
    var body: some View {
        NavigationStack {
            List {
                ForEach(1...50, id: \.self) { index in
                    NavigationLink {
                        List {
                            ForEach(1...45, id: \.self) { index2 in
                                Text("Sub Item \(index2)")
                            }
                        }
                        .navigationTitle("Item  \(index)")
                        .hideNavBarOnSwipe(false)
                    } label: {
                        Text("List Item \(index)")
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Chat App")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        hideNavBar.toggle()
                    }, label: {
                        Image(systemName: hideNavBar ? "eye.slash" : "eye")
                    })
                }
            })
            .hideNavBarOnSwipe(hideNavBar)
        }
    }
}

#Preview {
    ContentView()
}
