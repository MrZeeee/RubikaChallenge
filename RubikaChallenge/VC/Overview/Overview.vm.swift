//
//  Overview.vm.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/10/22.
//

import Foundation
import RxRelay



extension Overview {
    
    class vm: ZBaseVM, FeatureVMDelegate {
        
        private(set) var body: BehaviorRelay<Model.request.feature>!
        
        
        init(body: Model.request.feature) {
            self.body = .init(value: body)
            super.init()
        }
        
        // MARK: - FUNCTIONS
        public func edit(for type: Feature.type) -> ZBaseVC {
            let vm = Feature.vm.init(type: type, body: self.body.value, isEdit: true)
            vm.delegate = self
            let vc = Feature.vc.init(vm: vm)
            return vc
        }
        
        public func typeDetail(for typeId: String) -> (UIImage?, String)? {
            guard let item = AppConstant.datasource.type(with: typeId) else { return nil }
            return (nil, item.name)
        }
        
        public func sizeDetail(for sizeId: String) -> (UIImage?, String)? {
            guard let item = AppConstant.datasource.sizes(with: [sizeId]).first else { return nil }
            return (nil, item.name)
        }
        
        public func extraDetail(for subId: String) -> (UIImage?, String)? {
            guard let item = AppConstant.datasource.extra(with: subId) else { return nil }
            return (nil, item.name)
        }
        
        public func extraDetails(for id: String) -> (UIImage?, String)? {
            guard let item = AppConstant.datasource.extras(with: [id]).first else { return nil }
            return (nil, item.name)
        }
        
        public func subDetail(for subId: String) -> String? {
            guard let item = AppConstant.datasource.sub(from: subId) else { return nil }
            return item.name
        }
        
        public func group(from subIds: [String]) -> [Model.response.extra: [Model.response.extra.sub]] {
            var res: [Model.response.extra: [Model.response.extra.sub]] = [:]
            for id in subIds {
                guard let ex = AppConstant.datasource.extra(with: id) else { continue }
                guard let su = AppConstant.datasource.sub(from: id) else { continue }
                if res[ex] == nil {
                    res[ex] = [su]
                } else {
                    res[ex]?.append(su)
                }
            }
            return res
        }
        
        // MARK: - FEATURE VIEW MODEL DELEGATE
        func vm(_ vm: Feature.vm, didChange body: Model.request.feature) {
            self.body.accept(body)
        }
        
    }
    
}
