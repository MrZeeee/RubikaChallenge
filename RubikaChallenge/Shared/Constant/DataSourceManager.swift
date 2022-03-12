//
//  DataSourceManager.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/12/22.
//

import Foundation



class DataSourceManager: NSObject {
    
    private(set) var datasource: Model.response.base!
    
    override init() {
        super.init()
        self.fetch()
    }
    
    // MARK: - FUNCTIONS
    private func fetch() {
        guard let path = Bundle.main.url(forResource: AppConstant.k.datasourceFileName, withExtension: "json") else { return }
        guard let data = try? Data.init(contentsOf: path) else { return }
        guard let datasource = try? JSONDecoder().decode(Model.response.base.self, from: data as Data) else { return }
        self.datasource = datasource
    }
    
    public func type(with id: String) -> Model.response.type? {
        return self.datasource.types.first(where: {$0._id == id})
    }
    
    public func sizes(with ids: [String]) -> [Model.response.size] {
        return self.datasource.sizes.filter({ size in
            ids.contains(where: {$0 == size._id})
        })
    }
    
    public func extras(with ids: [String]) -> [Model.response.extra] {
        return self.datasource.extras.filter({ extra in
            ids.contains(where: {$0 == extra._id})
        })
    }
    
    public func extra(with subId: String) -> Model.response.extra? {
        return self.datasource.extras.first(where: { extra in
            return extra.subselections.contains(where: { sub in
                sub._id == subId
            })
        })
    }
    
    public func sub(with name: String) -> Model.response.extra.sub? {
        return self.datasource.extras.first(where: { extra in
            return extra.subselections.contains(where: { sub in
                sub.name == name
            })
        })?.subselections.first(where: {sub in
            sub.name == name
        })
    }
    
    public func sub(from id: String) -> Model.response.extra.sub? {
        return self.extra(with: id)?.subselections.first(where: { sub in
            sub._id == id
        })
    }
    
}
