//
//  TabBar.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

/// `TabBar` is a SwiftUI view to represent a horizontally scrollabe tab bar.
struct TabBar: View {
    // The offset of the content within the tab bar.
    @Binding var offset: CGFloat
    // The width of the tab bar.
    @State var width : CGFloat = 0
    
    var body: some View {
        GeometryReader{ proxy -> AnyView in
            let equalWidth = proxy.frame(in: .global).width / 4
            
            DispatchQueue.main.async {
                self.width = equalWidth
            }
            
            return AnyView(
                ScrollViewReader { scrollView in
                    ScrollView(.horizontal, showsIndicators: false) {
                        ZStack(alignment: .bottomLeading, content: {
                            Capsule()
                                .fill(.colorPrimaryLight)
                                .frame(
                                    width: abs(equalWidth - 15),
                                    height: 4
                                )
                                .offset(x: getOffset() + 7)
                            
                            HStack(spacing: 0) {
                                ForEach(tabs.indices,id: \.self) { index in
                                    Text(tabs[index])
                                        .fontWeight(.bold)
                                        .foregroundColor(
                                            getIndexFromOffset() == CGFloat(index)
                                            ? Color.colorPrimaryLight
                                            : Color.textColorSecondary
                                        )
                                        .frame(
                                            width: equalWidth,
                                            height: 40
                                        )
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            withAnimation {
                                                offset = UIScreen.main.bounds.width * CGFloat(index)
                                            }
                                        }
                                        .id(index)
                                    
                                }
                            }
                            
                        })
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: 40,
                            alignment: .center
                        )
                    }
                    .onChange(of: offset) {
                        withAnimation {
                            scrollView.scrollTo(getIndexFromOffset())
                        }
                    }
                }
            )
        }
        .frame(height: 40)
    }

    /// Function to calculate the offset for the tab indicator.
    /// - Returns: The offset for the tab indicator.
    func getOffset()->CGFloat{
        let progress = offset / UIScreen.main.bounds.width
        
        return progress * width
    }

    /// Function to get the index of the tab given the offset.
    /// - Returns: The index of the tab.
    func getIndexFromOffset()->CGFloat{
        let indexFloat = offset / UIScreen.main.bounds.width
        
        return indexFloat.rounded(.toNearestOrAwayFromZero)
    }
}

// Example usage of `TabBar`.
#Preview {
    var offset: CGFloat = 0
    let offsetBinding: Binding<CGFloat> = .init(
        get: {
            return offset
        },
        set: { off in
            offset = off
        }
    )
    
    return TabBar(
        offset: offsetBinding
    )
}
