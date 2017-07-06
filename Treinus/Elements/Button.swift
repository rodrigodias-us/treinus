//
//  Button.swift
//  Treinus
//
//  Created by Rodrigo Dias on 06/07/17.
//  Copyright © 2017 Rodrigo Dias. All rights reserved.
//

import UIKit
import QuartzCore

class Button: UIButton {

    override func draw(_ rect: CGRect) {
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.white.cgColor
    }

}
