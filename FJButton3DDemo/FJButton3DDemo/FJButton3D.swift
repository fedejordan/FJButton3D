//
//  Button3D.swift
//  FJButton3D
//
//  Created by Federico Jordán on 19/10/17.
//  Copyright © 2017 LettersWar. All rights reserved.
//

import UIKit

protocol FJButton3DDelegate: class {
    func didTap(onButton3D button3d: FJButton3D)
}

enum FJButton3DStyle {
    case pressed
    case `default`
}

@IBDesignable
class FJButton3D: UIView {

    private let zValue: CGFloat = 5
    private let roundedPercentage: CGFloat = 0.2
    private var behindView = UIView()
    private var frontView = UIView()
    private var titleLabel = UILabel()
    
    @IBInspectable var pressed: Bool = false {
        didSet(oldValue) {
            if oldValue != pressed {
                updatePressedStatus()
            }
        }
    }
    
    var style = FJButton3DStyle.default
    
    weak var delegate: FJButton3DDelegate?
    
    @IBInspectable var frontColor: UIColor = UIColor.red {
        didSet(oldValue) {
            frontView.backgroundColor = frontColor
        }
    }
    
    @IBInspectable var behindColor: UIColor = UIColor.orange {
        didSet(oldValue) {
            behindView.backgroundColor = behindColor
        }
    }
    
    @IBInspectable var textColor: UIColor = UIColor.white {
        didSet(oldValue) {
            titleLabel.textColor = textColor
        }
    }
    
    @IBInspectable var text: String = "PRESS ME" {
        didSet(oldValue) {
            titleLabel.text = text.uppercased()
        }
    }
    
    override func awakeFromNib() {
        backgroundColor = UIColor.clear
        prepareBehindView()
        prepareFrontView()
        prepareTitleLabel()

        isUserInteractionEnabled = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        behindView.frame = frame
        behindView.frame.origin = CGPoint(x: 0, y: 0)
        behindView.frame.origin.y += zValue
        frontView.frame = frame
        frontView.frame.origin = CGPoint(x: 0, y: 0)
        titleLabel.frame = frame
        titleLabel.frame.origin = CGPoint(x: 0, y: 0)
    }
    
    private func prepareBehindView() {
        behindView.frame = frame
        addSubview(behindView)
        behindView.frame.origin = CGPoint(x: 0, y: 0)
        behindView.frame.origin.y += zValue
        behindView.layer.borderWidth = 0.0
        behindView.layer.cornerRadius = frame.height*roundedPercentage
        behindView.backgroundColor = behindColor
    }
    
    private func prepareFrontView() {
        frontView.frame = frame
        addSubview(frontView)
        frontView.frame.origin = CGPoint(x: 0, y: 0)
        frontView.layer.borderWidth = 0.0
        frontView.layer.cornerRadius = frame.height*roundedPercentage
        frontView.backgroundColor = frontColor
    }
    
    private func prepareTitleLabel() {
        titleLabel.frame = frame
        addSubview(titleLabel)
        titleLabel.frame.origin = CGPoint(x: 0, y: 0)
        titleLabel.text = text.uppercased()
        titleLabel.textColor = textColor
        titleLabel.textAlignment = .center
        titleLabel.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if style == .pressed {
            if pressed == false {
                pressed = !pressed
            }
        } else {
            pressed = true
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if style != .pressed {
            pressed = false
        }
        if let touch = touches.first?.location(in: self.superview!), frame.contains(touch) {
            delegate?.didTap(onButton3D: self)
        }
    }
    
    private func updatePressedStatus() {
        if pressed == false {
            frontView.frame.origin.y -= zValue
            titleLabel.frame.origin.y -= zValue
        } else {
            frontView.frame.origin.y += zValue
            titleLabel.frame.origin.y += zValue
        }
    }
}
