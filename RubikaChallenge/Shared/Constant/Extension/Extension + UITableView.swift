//
//  Extension + UITableView.swift
//  Unite
//
//  Created by MohammadReza Zamanieh on 6/10/21.
//

import Foundation
import UIKit


extension UITableView {
    
    func showMoreLoading() {
        let ind = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
        ind.frame = .init(x: 0, y: 0, width: self.frame.size.width, height: 44)
        ind.startAnimating()
        self.tableFooterView = ind
    }
    
    func hideMoreLoading() {
        self.tableFooterView = nil
    }
    
    func insertPaginated<T: Codable>( ds: inout [T], resp: [T], completion: (() -> Void)? = nil) {
        if ds.isEmpty {
            ds = resp
            DispatchQueue.main.async {
                UIView.transition(with: self, duration: 0.3, options: .showHideTransitionViews, animations: {
                    self.reloadData()
                }, completion: { finished in
                    if !finished { return }
                    completion?()
                })
            }
        } else {
            let new = ds
            ds.append(contentsOf: resp)
            DispatchQueue.main.async {
                self.beginUpdates()
                var indexPath: [IndexPath] = []
                for i in 0..<(resp.count) {
                    indexPath.append(IndexPath.init(row: new.count + i, section: 0))
                }
                self.insertRows(at: indexPath, with: .automatic)
                self.endUpdates()
                completion?()
            }
        }
    }
}
