//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
// Copyright (c) 2023 Hackenbacker.
//
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php
//
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

import SwiftUI

/// Custom View Modifier
extension View {
    @ViewBuilder
    func hideNavBarOnSwipe(_ isHidden: Bool) -> some View {
        self
            .modifier(NavBarModifier(isHidden: isHidden))
    }
}

private struct NavBarModifier: ViewModifier {
    var isHidden: Bool
    @State private var isNavBarHidden: Bool?
    func body(content: Content) -> some View {
        content
            .onChange(of: isHidden, initial: true, { oldValue, newValue in
                isNavBarHidden = newValue
            })
            .onDisappear(perform: {
                isNavBarHidden = nil
            })
            .background {
                NavigationControllerExtractor(isHidden: isNavBarHidden)
            }
    }
}

/// Extracting UINavigationController from SwiftUI View
private struct NavigationControllerExtractor: UIViewRepresentable {
    var isHidden: Bool?
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            // You don't need to go via superview,
            // just simply use uiView.
            if let hostView = uiView.superview?.superview,
               let parentController = hostView.parentController {
                if let isHidden {
                    parentController.navigationController?.hidesBarsOnSwipe = isHidden
                }
            }
        }
    }
}

// What I'm going to do is extract the associated root
// UIViewController from the UIView with a custom extension,
// The associated view controller will hold the UINavigationController,
// and with that, we can make customizations.
private extension UIView {
    var parentController: UIViewController? {
        sequence(first: self) { view in
            view.next
        }
        .first { responder in
            return responder is UIViewController
        } as? UIViewController
    }
}

#Preview {
    ContentView()
}
