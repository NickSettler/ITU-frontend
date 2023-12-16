//
//  ScrollableTabBar.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

/// `ScrollableTabBar` is a SwiftUI view to represent a scrollable tab bar with content.
struct ScrollableTabBar<Content: View>: UIViewRepresentable {

    // The SwiftUI View that will be rendered within the scrollable tab bar.
    var content: Content
    
    // Getting Rect To Calculate Width And Height Of ScrollView...
    var rect: CGRect
    
    // ContentOffset for the scrollView
    @Binding var offset: CGFloat
    
    // The tabs to display within the tab bar.
    var tabs: [Any]
    
    // ScrollView to enable the content to scroll.
    let scrollView = UIScrollView()

    ///Initializes a `ScrollableTabBar`.
    init(
        tabs: [Any],
        rect: CGRect,
        offset: Binding<CGFloat>,
        @ViewBuilder content: ()->Content
    ) {
        
        self.content = content()
        self._offset = offset
        self.rect = rect
        self.tabs = tabs
    }
    
    func makeCoordinator() -> Coordinator {
        return ScrollableTabBar.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) ->  UIScrollView {
        
        setUpScrollView()
        // setting Content Size...
        
        scrollView.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height: rect.height)
        
        scrollView.addSubview(extractView())
        
        scrollView.delegate = context.coordinator
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
        // Updating View...
        if uiView.contentOffset.x != offset{
            
            // Animating...
            // The ANimation Glitch Is Because It s Updating On Two Times...

            // Simple....
            // Removing Delegate While Animating...
            
            uiView.delegate = nil
            
            UIView.animate(withDuration: 0.4) {
                uiView.contentOffset.x = offset
            } completion: { (status) in
                if status{uiView.delegate = context.coordinator}
            }

        }
    }
    
    // setting Up ScrollView...
    func setUpScrollView(){
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    // Extracting SwiftUI View...
    func extractView()->UIView{
        
        // since it depends upon tab size..
        // so we getting tabs also...
        
        let controller = UIHostingController(rootView: content)
        controller.view.frame = CGRect(x: 0, y: 0, width: rect.width * CGFloat(tabs.count), height: rect.height)
        
        return controller.view!
    }
    
    // Delegate Function To Get Offset...
    
    class Coordinator: NSObject,UIScrollViewDelegate{
        
        var parent: ScrollableTabBar
        
        init(parent: ScrollableTabBar) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
    }
}

// Preview of a `ScrollableTabBar` with text.
#Preview {
    GeometryReader{proxy in
        let rect = proxy.frame(in: .global)
        
        ScrollableTabBar(
            tabs: tabs,
            rect: rect,
            offset: .constant(0)
        ) {
            HStack(spacing: 0){
                ForEach(tabs, id: \.self){ tab in
                    Text(tab)
                }
            }
        }
    }
}
