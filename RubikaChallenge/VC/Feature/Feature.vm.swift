//
//  Feature.vm.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/9/22.
//

import Foundation
import RxCocoa
import RxSwift


protocol FeatureVMDelegate: NSObject {
    
    func vm(_ vm: Feature.vm, didChange body: Model.request.feature)
}

extension Feature {
    
    class vm: ZBaseVM {
        
        private(set) var _type: type
        private var body: Model.request.feature
        private var types: [Model.response.type] = []
        private var sizes: [Model.response.size] = []
        private var extras: [Model.response.extra] = []
        private var isEdit = false
        
        public weak var delegate: FeatureVMDelegate?
        
        init(type: type, body: Model.request.feature, isEdit: Bool = false) {
            self._type = type
            self.body = body
            self.isEdit = isEdit
            super.init()
            self.initialize()
        }
        
        // MARK: - FUNCTIONS
        private func initialize() {
            switch _type {
            case .style:
                self.types = AppConstant.datasource.datasource.types
            case .size:
                guard let style = self.body.type else {
                    self.errorChanged.accept(NSError.init(domain: "No type selected.", code: 500, userInfo: nil))
                    return
                }
                guard let type = AppConstant.datasource.type(with: style) else {
                    self.errorChanged.accept(NSError.init(domain: "No type founded.", code: 500, userInfo: nil))
                    return
                }
                self.sizes = AppConstant.datasource.sizes(with: type.sizes)
            case .extra:
                guard let style = self.body.type else {
                    self.errorChanged.accept(NSError.init(domain: "No type selected.", code: 500, userInfo: nil))
                    return
                }
                guard let type = AppConstant.datasource.type(with: style) else {
                    self.errorChanged.accept(NSError.init(domain: "No type founded.", code: 500, userInfo: nil))
                    return
                }
                self.extras = AppConstant.datasource.extras(with: type.extras)
            }
        }
        
        public func data(at index: Int) -> (UIImage?, String, [String], String?) {
            switch _type {
            case .style:
                return (nil, self.types[index].name, [], nil)
            case .size:
                return (nil, self.sizes[index].name, [], nil)
            case .extra:
                let item = self.extras[index]
                return (nil, item.name, item.subselections.map({$0.name}), item.subselections.first(where: { subs in self.body.extras.contains(where: {$0 == subs._id}) }).map({$0.name}))
            }
        }
        
        public func quantity() -> Int {
            switch _type {
            case .style:
                return self.types.count
            case .size:
                return self.sizes.count
            case .extra:
                return self.extras.count
            }
        }
        
        public func didSelect(itemAt index: Int) -> ZBaseVC? {
            switch _type {
            case .style:
                self.body.type = self.types[index]._id
                if self.isEdit {
                    self.delegate?.vm(self, didChange: self.body)
                    return nil
                } else {
                    let vm = Feature.vm.init(type: .size, body: self.body, isEdit: self.isEdit)
                    return Feature.vc.init(vm: vm)
                }
            case .size:
                self.body.size = self.sizes[index]._id
                if self.isEdit {
                    self.delegate?.vm(self, didChange: self.body)
                    return nil
                } else {
                    let vm = Feature.vm.init(type: .extra, body: self.body, isEdit: self.isEdit)
                    return Feature.vc.init(vm: vm)
                }
            case .extra:
                return nil
            }
        }
        
        public func select(sub: String) {
            guard let sub = AppConstant.datasource.sub(with: sub) else { return }
            self.body.extras.append(sub._id)
        }
        
        public func deselect(sub: String) {
            guard let sub = AppConstant.datasource.sub(with: sub) else { return }
            guard let index = self.body.extras.firstIndex(where: {$0 == sub._id}) else { return }
            self.body.extras.remove(at: index)
        }
        
        public func finilize() -> ZBaseVC? {
            if self.isEdit {
                self.delegate?.vm(self, didChange: self.body)
                return nil
            } else {
                let vm = Overview.vm.init(body: self.body)
                let vc = Overview.vc.init(vm: vm)
                return vc
            }
        }
    }
    
}
