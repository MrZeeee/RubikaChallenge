//
//  HttpClient + Request.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/11/22.
//

import Foundation
import RxSwift


extension HttpClient {
    
    class request: ZRequest {
        
        override var host: String {
            return HttpClient.routes.base.host.rawValue
        }
        
        open func option() -> ZNetwork.options {
            return .init()
        }
        
        open func headers() -> HTTPHeaders {
            let h: HTTPHeaders = ["Content-Type": "application/json"]
            return h
        }
        
        public func get<T: Decodable, Y: RawRepresentable>(path: Y, queries: [URLQueryItem] = [], option: ZNetwork.options? = nil) -> Single<T> where Y.RawValue == String {
            return self.get(path: path.rawValue, queries: queries, headers: self.headers(), option: option ?? self.option()).observe(on: MainScheduler.instance).flatMap({ data -> PrimitiveSequence<SingleTrait, T> in
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    return Single.just(decoded)
                } catch (let err) {
                    return Single.error(err)
                }
            })
        }
        
        public func post<T: Encodable, P: Decodable, Y: RawRepresentable>(path: Y, queries: [URLQueryItem] = [], body: T, shouldLogin: Bool = false, option: ZNetwork.options? = nil) -> Single<P> where Y.RawValue == String {
            return self.post(path: path.rawValue, queries: queries, body: body, headers: self.headers(), option: option ?? self.option()).flatMap({ data -> PrimitiveSequence<SingleTrait, P> in
                do {
                    let decoded = try JSONDecoder().decode(P.self, from: data)
                    return Single.just(decoded)
                } catch (let err) {
                    return Single.error(err)
                }
            })
        }
        
        @discardableResult public func put<T: Encodable, P: Decodable, Y: RawRepresentable>(path: Y, queries: [URLQueryItem] = [], body: T, shouldLogin: Bool = false, option: ZNetwork.options? = nil) -> Single<P> where Y.RawValue == String {
            return self.put(path: path.rawValue, queries: queries, body: body, headers: self.headers(), option: option ?? self.option()).flatMap({ data -> PrimitiveSequence<SingleTrait, P> in
                do {
                    let decoded = try JSONDecoder().decode(P.self, from: data)
                    return Single.just(decoded)
                } catch (let err) {
                    return Single.error(err)
                }
            })
        }

        @discardableResult public func delete<T: Encodable, P: Decodable, Y: RawRepresentable>(path: Y, queries: [URLQueryItem] = [], body: T? = nil, shouldLogin: Bool = false, option: ZNetwork.options? = nil) -> Single<P> where Y.RawValue == String {
            return self.delete(path: path.rawValue, queries: queries, body: body, headers: self.headers(), option: option ?? self.option()).flatMap({ data -> PrimitiveSequence<SingleTrait, P> in
                do {
                    let decoded = try JSONDecoder().decode(P.self, from: data)
                    return Single.just(decoded)
                } catch (let err) {
                    return Single.error(err)
                }
            })
        }
        
    }
    
}
