//
//  ScrollableTabBar.swift
//  ITU
//
//  Created by Никита Моисеев on 04.11.2023.
//

import SwiftUI

struct ScrollableTabBar<Content: View>: UIViewRepresentable {

    // to store our SwiftUI View...
    var content: Content
    
    // Getting Rect To Calculate Width And Height Of ScrollView...
    
    var rect: CGRect
    
    // ContentOffset...
    @Binding var offset: CGFloat
    
    // Tabs...
    var tabs: [Any]
    
    // ScrollView...
    // For Paging AKA Scrollable Tabs...
    let scrollView = UIScrollView()
    
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
