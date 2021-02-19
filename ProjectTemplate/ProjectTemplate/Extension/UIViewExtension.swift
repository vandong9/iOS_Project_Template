//
//  UIViewExtension.swift
//  GoExam
//
//  Created by Dong Ha on 11/25/20.
//  Copyright © 2020 Dong. All rights reserved.
//

import UIKit
import SnapKit

typealias EmptyCompletion = () -> (Void)

// MARK: - Convenion Init
extension UIView {
    class func instanceFromNib() -> UIView {
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    class func spaceView(size: CGFloat, isHorizon: Bool = false) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.snp.makeConstraints {
            isHorizon ? $0.width.equalTo(size) :  $0.height.equalTo(size)
        }
        return view
    }
}

// MARK: - IBInspectable
@objc extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let cgColor = layer.shadowColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { layer.shadowColor = newValue?.cgColor }
    }
    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
}

// MARK: - Convenience Functions
@objc extension UIView {
    func dismissPopupView(with duration: TimeInterval = 0.3, _ completion: EmptyCompletion? = nil) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.alpha = 0
        }, completion: { [weak self] _ in
            completion?()
            self?.removeFromSuperview()
        })
    }
    
    func showLoadingOverlay() {
        DispatchQueue.main.async {
            let loadingView = LoadingOverlayView()
            loadingView.frame = self.bounds
            self.addSubview(loadingView)
            loadingView.snp.remakeConstraints { $0.edges.equalTo(0) }
            loadingView.indicator.center = loadingView.center
        }
    }
    
    func hideLoadingOverlay() {
        DispatchQueue.main.async {
            [weak self] in self?.subviews.forEach { if $0 is LoadingOverlayView { $0.removeFromSuperview() } }
        }
    }
    
    func presentPopupViewOnTop(for dismissAfter: Double = 0, _ completion: EmptyCompletion? = nil) {
        alpha = 0
        frame = UIScreen.main.bounds
        UIApplication.shared.windows.last?.addSubview(self)
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.alpha = 1
        }, completion: { _ in
            if dismissAfter <= 0 {
                completion?()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
                    [weak self] in self?.dismissPopupView(completion)
                }
            }
        })
    }
    
    func removeAllConstraints() {
        var superView = superview
        while superView != nil {
            for constraint in superView!.constraints {
                if let firstView = constraint.firstItem as? UIView, firstView == self {
                    superView?.removeConstraint(constraint)
                    continue
                }
                if let secondView = constraint.secondItem as? UIView, secondView == self {
                    superView?.removeConstraint(constraint)
                    continue
                }
            }
            superView = superView?.superview
        }
        removeConstraints(constraints)
    }
    
    func removeAllGradientLayers() {
        layer.sublayers?.forEach { ($0 as? CAGradientLayer)?.removeFromSuperlayer() }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.mask = maskLayer
    }
    
    @discardableResult
    func setGradient(with colors: [UIColor]) -> CAGradientLayer? {
        guard !colors.isEmpty else { return nil }
        layer.sublayers?.forEach { ($0 as? CAGradientLayer)?.removeFromSuperlayer() }
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.frame = bounds
        gradient.startPoint = CGPoint(x:0.0, y:0.5);
        gradient.endPoint = CGPoint(x:1.0, y:0.5);

        layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    func setGradient(with colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        guard !colors.isEmpty else { return debugPrint("Nothing to draw, return!") }
        layer.sublayers?.forEach { ($0 as? CAGradientLayer)?.removeFromSuperlayer() }
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.endPoint = endPoint
        gradient.frame = bounds
        gradient.locations = [0, 1]
        gradient.startPoint = startPoint
        layer.insertSublayer(gradient, at: 0)
    }
    
    func addDashedBorder(_ color: UIColor) -> CAShapeLayer? {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [4,4]
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
        return shapeLayer
    }
    
    func addBorderGradient(colors: [CGColor], width: CGFloat = 2, radius: CGFloat = 5) -> CAGradientLayer? {
        guard colors.count > 0 else { return nil }
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.bounds.size)
        gradient.colors = colors
        gradient.startPoint = CGPoint(x:0.0, y:0.5);
        gradient.endPoint = CGPoint(x:1.0, y:0.5);

        let shape = CAShapeLayer()
        shape.lineWidth = width
        shape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.layer.addSublayer(gradient)
        return gradient
    }
    
}

extension UIView {
    class func loadViewFromXIB<T : UIView>(nibNameOrNil: String? = nil) -> T {
            let v: T? = fromNib(nibNameOrNil: nibNameOrNil)
            return v!
    }
    
    class func fromNib<T : UIView>(nibNameOrNil: String? = nil) -> T? {
            var view: T?
            let name: String
            if let nibName = nibNameOrNil {
                name = nibName
            } else {
                name = "\(self)".components(separatedBy:".").last!
            }
            view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T
            return view
    }
    
    func setBorderCircle(color: UIColor, width: CGFloat) {
        setBorder(color: color, width: width, radius: bounds.size.height / 2)
    }
    
    func setBorder(color: UIColor, width: CGFloat, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.masksToBounds = true

    }
    
}

