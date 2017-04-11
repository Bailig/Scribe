//
//  CircleButton.swift
//  Scribe
//
//  Created by Bailig Abhanar on 2017-04-11.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
}
