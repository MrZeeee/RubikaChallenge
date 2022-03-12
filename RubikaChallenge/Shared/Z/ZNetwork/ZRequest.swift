//
//  ZRequest.swift
//  Eddi-Bike
//
//  Created by MohammadReza Zamanieh on 8/11/21.
//

import Foundation
import RxSwift

fileprivate var httpsScheme: String = "https"

class ZRequest: NSObject {
    
    typealias HTTPHeaders = [String: String]
    
    open var scheme: String {
        return httpsScheme
    }
    
    open var host: String {
        fatalError("ZRequest: host must be overriden.")
    }
    
    
    
    @discardableResult public func get(path: String, queries: [URLQueryItem] = [], headers: HTTPHeaders? = nil, option: ZNetwork.options) -> Single<Data> {
        let tempBody: String? = nil
        return Z.network.request(path: self.url(with: path, queries: queries), method: .get, body: tempBody, headers: headers, option: option)
    }

    @discardableResult public func post<T: Encodable>(path: String, queries: [URLQueryItem] = [], body: T, headers: HTTPHeaders? = nil, option: ZNetwork.options) -> Single<Data> {
        return Z.network.request(path: self.url(with: path, queries: queries), method: .post, body: body, headers: headers, option: option)
    }

    @discardableResult public func put<T: Encodable>(path: String, queries: [URLQueryItem] = [], body: T, headers: HTTPHeaders? = nil, option: ZNetwork.options) -> Single<Data> {
        return Z.network.request(path: self.url(with: path, queries: queries), method: .put, body: body, headers: headers, option: option)
    }

    @discardableResult public func delete<T: Encodable>(path: String, queries: [URLQueryItem] = [], body: T? = nil, headers: HTTPHeaders? = nil, option: ZNetwork.options) -> Single<Data> {
        return Z.network.request(path: self.url(with: path, queries: queries), method: .delete, body: body, headers: headers, option: option)
    }
    
    private func url(with path: String, queries: [URLQueryItem] = []) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = self.configure(path: path)
        if !queries.isEmpty {
            urlComponents.queryItems = []
            for q in queries {
                if let _ = q.value {
                    urlComponents.queryItems?.append(q)
                }
            }
        }
        return urlComponents.url!
    }
    
    private func configure(path: String) -> String {
        var p = path
        if p.first != "/" {
            p.insert("/", at: p.startIndex)
        }
        if let encoded = p.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            return encoded
        }
        return p
    }
    
    
}
