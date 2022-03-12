//
//  ZBaseVC.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 8/14/21.
//

import UIKit
import RxSwift


class ZBaseVC: UIViewController {
    
    private weak var delegate: ZKeyboardDelegate?
    let disposeBag = DisposeBag()

    
    // MARK: - KEYBOARD HANDLER
    public func handleKeyboard(with delegate: ZKeyboardDelegate?) {
        self.delegate = delegate
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc private func keyboardWillShow(_ sender: NSNotification) {
        var model: ZKeyboard.attributes = .init(animationDuration: 0.3, curve: 0, frame: .zero)
        if let keyboardFrame = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            model.frame = keyboardFrame
        }
        if let duration = sender.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            model.animationDuration = duration
        }
        if let curve = sender.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int {
            model.curve = curve
        }
        delegate?.keyboard(self, willShowWith: model)
    }
    
    @objc private func keyboardWillHide(_ sender: NSNotification) {
        var model: ZKeyboard.attributes = .init(animationDuration: 0.3, curve: 0, frame: .zero)
        if let keyboardFrame = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            model.frame = keyboardFrame
        }
        if let duration = sender.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            model.animationDuration = duration
        }
        if let curve = sender.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int {
            model.curve = curve
        }
        delegate?.keyboard(self, willHideWith: model)
    }
    
    // MARK: - TAP HANDLER
    public func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

}
