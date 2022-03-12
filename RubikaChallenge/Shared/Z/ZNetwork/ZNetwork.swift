//
//  ZNetwork.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/10/22.
//

import Foundation
import RxSwift
import AVFoundation

class ZNetwork: NSObject {
    

    typealias progressHandler = (ZNetwork.progress) -> Void
    
    
    @discardableResult open func request<T: Encodable>(path: URL, method: HTTPMethod, body: T? = nil, headers: [String: String]? = nil, option: ZNetwork.options = .init()) -> Single<Data> {
        debugPrint("ZNetwork is requesting to:", path, option, "\n")
        var backup = ZNetwork.request<T>.init(path: path, method: method, body: body, headers: headers, option: option)
        let result = Single<Data>.create(subscribe: { observer -> Disposable in
            let disposable = CompositeDisposable()
            let request = backup.create()
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                if let e = error {
                    observer(.failure(e))
                }
                guard let resp = response as? HTTPURLResponse else { return }
                switch resp.statusCode {
                case 200..<300:
                    guard let data = data else { observer(.failure(ZNetwork.error.init(statusCode: resp.statusCode, response: resp, description: nil))); return }
                    observer(.success(data))
                default:
                    guard !option.otherStatusCodesToSkipRetry.contains(resp.statusCode) else {
                        observer(.failure(ZNetwork.error.init(statusCode: resp.statusCode, response: resp, description: nil)))
                        return
                    }
                    guard option.shouldRetry else {
                        observer(.failure(ZNetwork.error.init(statusCode: resp.statusCode, response: resp, description: nil)))
                        return
                    }
                }
            })
            task.resume()
            _ = disposable.insert(Disposables.create {
                task.cancel()
            })
            return disposable
        }).timeout(DispatchTimeInterval.seconds(Int(backup.option.timeoutInterval)), scheduler: MainScheduler.instance).retry(when: { errors in
            return errors.flatMap({ (error) -> Observable<Int> in
                backup.option = self.configure(for: backup.option)
                if option.currentRetry < option.retryCount {
                    return Observable<Int>.timer(.seconds(Int(option.retryDelayInterval)), scheduler: MainScheduler.instance).take(1)
                } else {
                    return Observable.error(error)
                }
            })
        })
        return result
    }
    
    private func configure(for option: ZNetwork.options) -> ZNetwork.options {
        var new_opt = option
        new_opt.currentRetry += 1
        new_opt.retryDelayInterval = Double(Z.math.fib(new_opt.currentRetry))
        return new_opt
    }
    
}
