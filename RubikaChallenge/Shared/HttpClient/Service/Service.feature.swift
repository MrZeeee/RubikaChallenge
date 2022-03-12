//
//  Service.feature.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/11/22.
//

import Foundation
import RxSwift



extension Service {
    
    class feature: HttpClient.request {
        
        func list() -> Single<[String]> {
            self.get(path: HttpClient.routes.feature.list).flatMap({ resp -> PrimitiveSequence<SingleTrait, [String]> in
                return Single.just(resp)
            })
        }
        
    }
    
}
