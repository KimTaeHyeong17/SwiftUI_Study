//
//  ColorUISlider.swift
//  RGBullsEye
//
//  Created by USER on 2020/10/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import Foundation
import SwiftUI

struct ColorUISlider : UIViewRepresentable {
    
    var color : UIColor
    var score : Int
    @Binding var value : Double
    
    
    func makeCoordinator() -> ColorUISlider.Coordinator {
        Coordinator(self)
    }
    
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = color
        slider.value = Float(value)
        
        slider.addTarget(context.coordinator, action: #selector(Coordinator.updateColorUISlider(_:)), for: .valueChanged)
        
        return slider
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.value = Float(self.value)
        print(value)
        print(score)
        
        uiView.thumbTintColor = color.withAlphaComponent(CGFloat(        1.0 - Double(score)/100.0))
    }
    
    class Coordinator: NSObject {
        var parent: ColorUISlider
        init(_ parent: ColorUISlider) {
            self.parent = parent
        }
        @objc func updateColorUISlider(_ sender: UISlider) {
            parent.value = Double(sender.value)
        }
    }
}

struct ColorUISlider_Previews: PreviewProvider {
    static var previews: some View {
        ColorUISlider(color: .red, score: 50, value: .constant(0.5))
            .previewLayout(.sizeThatFits)
    }
}
