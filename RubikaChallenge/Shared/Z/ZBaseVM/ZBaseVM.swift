//
//  ZBaseVM.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/9/22.
//

import Foundation
import RxSwift
import RxCocoa



class ZBaseVM: NSObject {
    
    private(set) var errorChanged: BehaviorRelay<Error?> = .init(value: nil)
    private(set) var loadingChanged: BehaviorRelay<Bool> = .init(value: false)
    
}
