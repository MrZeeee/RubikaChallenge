//
//  NZBottomSheetVC.swift
//  NZCodebase
//
//  Created by Mr.Zee on 2/5/20.
//  Copyright © 2020 com.nizek. All rights reserved.
//

import UIKit
import simd


public enum ZBottomSheetAnimation { case fromLeft, fromRight, fromBottom, fade}

class ZBottomSheetVC: ZBaseVC, UIViewControllerTransitioningDelegate, ZKeyboardDelegate {
    
    fileprivate var overlay: UIView!
    @objc public var contentView: UIView!
    private var keyboardIsOpen = false
    
    private var ratio: CGFloat = 0.9
    private var cornerRadius: CGFloat = 20
    private var overlayColor: UIColor = UIColor.black.withAlphaComponent(0.3)
    private var shouldDismissOnTap: Bool = false
    private var animationType: ZBottomSheetAnimation = .fromBottom
    private var strongTransitioningDelegate: UIViewControllerTransitioningDelegate! {
        get { return self.transitioningDelegate }
        set { self.transitioningDelegate = newValue }
    }
    private var bottom: NSLayoutConstraint!
    
    public init(ratio: CGFloat = 0.9, cornerRadius: CGFloat = 20, overlayColor: UIColor = UIColor.black.withAlphaComponent(0.3), shouldDismissOnTap: Bool = true, animationType: ZBottomSheetAnimation = .fromBottom) {
        self.ratio = ratio
        self.cornerRadius = cornerRadius
        self.overlayColor = overlayColor
        self.shouldDismissOnTap = shouldDismissOnTap
        self.animationType = animationType
        super.init(nibName: nil, bundle: nil)
        setupTransitioning()
    }
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    
    private func setupTransitioning() {
        self.modalPresentationStyle = .custom
        self.modalPresentationCapturesStatusBarAppearance = true
        self.view.backgroundColor = .clear
//        self.strongTransitioningDelegate = ZBottomSheetVCTransitionDelegate.init(ratio: self.ratio, cornerRadius: self.cornerRadius, animationType: self.animationType)
        self.transitioningDelegate = self
    }
    
    
    // MARK: - FUNCTIONS
    private func initialize() {
        
        overlay = UIView()
        overlay.backgroundColor = self.overlayColor
        overlay.alpha = 0
        self.view.addSubview(overlay)
        overlay.constrain(to: self.view).leadingTrailingTopBottom()
        
        contentView = UIView()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = self.cornerRadius
        contentView.clipsToBounds = true;
        self.view.addSubview(contentView)
        contentView.constrain(to: self.view).leadingTrailing()
        bottom = contentView.constrain(to: self.view).bottom(constant: UIDevice.current.bottomNotch + 12).constraints.first
        bottom.isActive = true
        
        setupContentView(contentView: contentView)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(dismissOverlay(_:)))
        overlay.addGestureRecognizer(tap)
        
        self.handleKeyboard(with: self)
    }
    
    @objc private func dismissOverlay(_ sender: UITapGestureRecognizer) {
        if keyboardIsOpen {
            self.view.endEditing(true)
        } else {
            self.tapped(on: self.overlay)
            if shouldDismissOnTap {
                dismiss(animated: true)
            }
        }
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - Methods to override
    open func tapped(on overlay: UIView) {
        
    }
    
    open func setupContentView(contentView: UIView) {
        fatalError("ZBottomSheetVC: setupContentView() is supposed to be overridden by child class.")
    }
    
    // MARK: - TRANSITION DELEGATE
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZBottomSheetVCTransitionDelegate.init(ratio: self.ratio, cornerRadius: self.cornerRadius, animationType: self.animationType)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZBottomSheetVCTransitionDelegate.init(ratio: self.ratio, cornerRadius: self.cornerRadius, animationType: self.animationType)
    }
    
    // MARK: - ZKEYBOARD DELEGATE
    func keyboard(_ vc: UIViewController, willShowWith attributes: ZKeyboard.attributes) {
        self.keyboardIsOpen = true
        self.bottom.constant = UIDevice.current.bottomNotch + 12 + attributes.frame.size.height
        UIView.animate(withDuration: attributes.animationDuration, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboard(_ vc: UIViewController, willHideWith attributes: ZKeyboard.attributes) {
        self.bottom.constant = UIDevice.current.bottomNotch + 12
        UIView.animate(withDuration: attributes.animationDuration, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.keyboardIsOpen = false
        })
    }
}

//MARK: - Transitioning Delegate
class ZBottomSheetVCTransitionDelegate: NSObject, UIViewControllerAnimatedTransitioning  {
    
    private var ratio: CGFloat
    private var cornerRadius: CGFloat
    private var animationType: ZBottomSheetAnimation
    
    init(ratio: CGFloat, cornerRadius: CGFloat, animationType: ZBottomSheetAnimation) {
        self.ratio = ratio
        self.cornerRadius = cornerRadius
        self.animationType = animationType
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animationDuration = self.transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        
        if transitionContext.viewController(forKey: .to)?.isKind(of: ZBottomSheetVC.self) ?? false{
            let fromVC = transitionContext.viewController(forKey: .from)
            let toVC = transitionContext.viewController(forKey: .to) as! ZBottomSheetVC
            
            toVC.view.layoutIfNeeded()
    
            UIView.animate(withDuration: animationDuration, animations: {
                fromVC?.view.transform = CGAffineTransform.init(scaleX: self.ratio, y: self.ratio)
                fromVC?.view.layer.cornerRadius = self.cornerRadius//max(Utilz.deviceTopNotch, 10.0)
            })
            
            containerView.addSubview(toVC.view)
            
            switch animationType {
            case .fromBottom:
                toVC.contentView.transform = .init(translationX: 0, y: toVC.contentView.frame.height)
                UIView.animate(withDuration: animationDuration, animations: {
                    toVC.overlay.alpha = 1
                    toVC.contentView.transform = .identity
                },completion: {f in
                    transitionContext.completeTransition(true)
                })
            case .fade:
                toVC.contentView.alpha = 0
                UIView.animate(withDuration: animationDuration, animations: {
                    toVC.overlay.alpha = 1
                    toVC.contentView.alpha = 1
                },completion: {f in
                    transitionContext.completeTransition(true)
                })
            case .fromLeft:
                toVC.contentView.transform = .init(translationX: -toVC.contentView.frame.width, y: 0)
                UIView.animate(withDuration: animationDuration, animations: {
                    toVC.overlay.alpha = 1
                    toVC.contentView.transform = .identity
                },completion: {f in
                    transitionContext.completeTransition(true)
                })
            case .fromRight:
                toVC.contentView.transform = .init(translationX: toVC.contentView.frame.width, y: 0)
                UIView.animate(withDuration: animationDuration, animations: {
                    toVC.overlay.alpha = 1
                    toVC.contentView.transform = .identity
                },completion: {f in
                    transitionContext.completeTransition(true)
                })
            }
            
        } else {
            let fromVC = transitionContext.viewController(forKey: .from) as! ZBottomSheetVC
            let toVC = transitionContext.viewController(forKey: .to)
            
            UIView.animate(withDuration: animationDuration, animations: {
                toVC?.view.transform = .identity
                toVC?.view.layer.cornerRadius = 0
            })
            
            switch animationType {
            case .fromBottom:
                UIView.animate(withDuration: animationDuration, animations: {
                    fromVC.overlay.alpha = 0
                    fromVC.contentView.transform = .init(translationX: 0, y: fromVC.contentView.frame.height)
                }, completion: {f in
                    transitionContext.completeTransition(true)
                })
            case .fade:
                UIView.animate(withDuration: animationDuration, animations: {
                    fromVC.overlay.alpha = 0
                    fromVC.contentView.alpha = 0
                }, completion: {f in
                    transitionContext.completeTransition(true)
                })
            case .fromLeft:
                UIView.animate(withDuration: animationDuration, animations: {
                    fromVC.overlay.alpha = 0
                    fromVC.contentView.transform = .init(translationX: -fromVC.contentView.frame.width, y: 0)
                }, completion: {f in
                    transitionContext.completeTransition(true)
                })
            case .fromRight:
                UIView.animate(withDuration: animationDuration, animations: {
                    fromVC.overlay.alpha = 0
                    fromVC.contentView.transform = .init(translationX: fromVC.contentView.frame.width, y: 0)
                }, completion: {f in
                    transitionContext.completeTransition(true)
                })
            }
        }
    }
}

