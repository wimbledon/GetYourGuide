//
//  ImageViewUtilities.swift
//  David
//
//  Created by David Liu on 7/3/19.
//  Copyright © 2019 GetYourGuide. All rights reserved.
//

import Foundation
import InitialsImageView

extension UIImageView {
    @objc func setImageForName(_ string: String, backgroundColor: UIColor? = nil, circular: Bool, gradient: Bool = false) {
        setImageForName(string, backgroundColor: backgroundColor, circular: circular, textAttributes: nil, gradient: gradient)
    }
}
