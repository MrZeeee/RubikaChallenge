//
//  Overview.vc.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/10/22.
//

import Foundation
import UIKit



extension Overview {
    
    class vc: ZBaseVC {
        
        private var sv: UIScrollView!
        private var contentView: UIView!
        private var titleLabel: UILabel!
        private var card: Card!
        private var st: UIStackView!
        private var btnBG: Card!
        private var brewBtn: UIButton!
        
        private var vm: Overview.vm
        
        init(vm: Overview.vm) {
            self.vm = vm
            super.init(nibName: nil, bundle: nil)
            self.initialize()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.ui()
        }
        
        // MARK: - FUNCTIONS
        private func initialize() {
            
            vm.errorChanged.subscribe(onNext: {[weak self] err in
                guard let this = self else { return }
                guard let e = err else { return }
                this.handle(err: e)
            }).disposed(by: self.disposeBag)
            vm.loadingChanged.subscribe(onNext: {[weak self] show in
                guard let this = self else { return }
                show ? this.view.beginLoading() : this.view.endLoading()
            }).disposed(by: self.disposeBag)
            vm.body.subscribe(onNext: {[weak self] body in
                guard let this = self else { return }
                this.reload(with: body)
            }).disposed(by: self.disposeBag)
            
        }
        
        private func ui() {
            self.title = "Brew with Lex"
            self.view.backgroundColor = .white
            
            sv = UIScrollView()
            sv.contentInset.bottom = UIDevice.current.bottomNotch + 20 + AppConstant.k.btnHeight + AppConstant.k.margin
            sv.backgroundColor = .white
            self.view.addSubview(sv)
            sv.constrain(to: self.view).leadingTrailingTopBottom()
            
            contentView = UIView()
            contentView.backgroundColor = .white
            self.sv.addSubview(contentView)
            contentView.constrain(to: self.sv).leadingTrailingTopBottom()
            contentView.constrain(to: self.view).width()
            
            titleLabel = UILabel()
            titleLabel.text = "Overview"
            titleLabel.font = .boldSystemFont(ofSize: 18)
            titleLabel.textColor = .black
            self.contentView.addSubview(titleLabel)
            titleLabel.constrain(to: self.contentView).leading(constant: AppConstant.k.margin).top(constant: AppConstant.k.margin)
            
            card = Card()
            self.contentView.addSubview(card)
            card.constrain(to: self.titleLabel).yAxis(.top, to: .bottom, constant: AppConstant.k.margin)
            card.constrain(to: self.contentView).leadingTrailing().bottom()
            
            st = UIStackView()
            st.axis = .vertical
            st.alignment = .fill
            st.distribution = .fill
            st.spacing = AppConstant.k.lowMargin
            self.card.contentView.addSubview(st)
            st.constrain(to: self.card.contentView).leadingTrailingTopBottom(constant: AppConstant.k.margin)
            
            btnBG = Card()
            self.view.addSubview(btnBG)
            btnBG.constrain(to: self.view).leadingTrailing(constant: AppConstant.k.margin).bottom(constant: AppConstant.k.margin + UIDevice.current.bottomNotch)
            btnBG.constrainSelf().height(constant: AppConstant.k.btnHeight)
            
            brewBtn = UIButton()
            brewBtn.backgroundColor = .clear
            brewBtn.setTitle("Brew your coffee", for: .normal)
            brewBtn.setTitleColor(.white, for: .normal)
            brewBtn.titleLabel?.font = .systemFont(ofSize: 14)
            brewBtn.addTarget(self, action: #selector(brewBtnTapped(_:)), for: .touchUpInside)
            self.btnBG.addSubview(brewBtn)
            brewBtn.constrain(to: self.btnBG).leadingTrailing(constant: AppConstant.k.margin).topBottom()
            
        }
        
        @objc private func brewBtnTapped(_ sender: UIButton) {
            self.handle(err: NSError.init(domain: "Your coffee will be there soon!", code: 200, userInfo: nil))
        }
        
        private func reload(with data: Model.request.feature, animated: Bool = true) {
            UIView.animate(withDuration: animated ? 0.3 : 0, animations: {
                self.card.alpha = 0.2
                self.card.transform = .init(scaleX: 0.2, y: 0.2)
            })
            for subview in self.st.arrangedSubviews {
                subview.removeFromSuperview()
                self.st.removeArrangedSubview(subview)
            }
            guard let type = data.type, let typeDetail = self.vm.typeDetail(for: type) else { return }
            guard let size = data.size, let sizeDetail = self.vm.sizeDetail(for: size) else { return }
            let typeItem = Item.init(canEdit: false)
            typeItem.configure(with: typeDetail.0, title: typeDetail.1, type: .style)
            typeItem.alpha = 0
            typeItem.addTarget(self, action: #selector(editTapped(_:)), for: .touchUpInside)
            self.st.addArrangedSubview(typeItem)
            self.st.addArrangedSubview(createSeprator())
            let sizeItem = Item.init(canEdit: true)
            sizeItem.configure(with: sizeDetail.0, title: sizeDetail.1, type: .size)
            sizeItem.alpha = 0
            sizeItem.addTarget(self, action: #selector(editTapped(_:)), for: .touchUpInside)
            self.st.addArrangedSubview(sizeItem)
            let gp = self.vm.group(from: data.extras)
            if !gp.isEmpty {
                self.st.addArrangedSubview(createSeprator())
                for (key, values) in gp {
                    if let detail = self.vm.extraDetails(for: key._id) {
                        let item = Item.init(canEdit: true)
                        item.configure(with: detail.0, title: detail.1, type: .extra)
                        item.alpha = 0
                        item.addTarget(self, action: #selector(editTapped(_:)), for: .touchUpInside)
                        self.st.addArrangedSubview(item)
                        self.st.addArrangedSubview(createSeprator())
                        for (index,value) in values.enumerated() {
                            if let subDetail = self.vm.subDetail(for: value._id) {
                                let subItem = Option.init(title: subDetail, selected: true)
                                subItem.alpha = 0
                                self.st.addArrangedSubview(subItem)
                                if index < values.count - 1 || UInt(gp.distance(from: gp.index(forKey: key)!, to: gp.startIndex)) < gp.count-1 {
                                    self.st.addArrangedSubview(createSeprator())
                                }
                            }
                        }
                    }
                }
            }
            UIView.animate(withDuration: animated ? 0.3 : 0, animations: {
                self.card.alpha = 1
                self.card.transform = .identity
                self.st.arrangedSubviews.forEach({$0.alpha = 1})
            })
        }
        
        private func createSeprator() -> UIView {
            let sep = UIView()
            sep.backgroundColor = .white
            sep.constrainSelf().height(constant: 1)
            return sep
        }
        
        @objc private func editTapped(_ sender: UIButton) {
            guard let view = sender.superview as? Item else { return }
            guard let type = view.type else { return }
            let vc = self.vm.edit(for: type)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
