//
//  Feature.vc.swift
//  RubikaChallenge
//
//  Created by MohammadReza Zamanieh on 3/9/22.
//

import Foundation
import UIKit



extension Feature {
    
    class vc: ZBaseVC, UITableViewDelegate, UITableViewDataSource, FeatureVCCellDelegate {
        
        private var doneBtn: UIBarButtonItem!
        private var table: UITableView!
        
        private var vm: Feature.vm
        
        init(vm: Feature.vm) {
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
            
        }
        
        private func ui() {
            self.title = "Brew with Lex"
            
            if self.vm._type == .extra {
                doneBtn = .init(title: "Done", style: .plain, target: self, action: #selector(doneTapped(_:)))
                self.navigationItem.rightBarButtonItem = doneBtn
            }
            
            table = UITableView()
            table.delegate = self
            table.dataSource = self
            table.register(Feature.vc.cell.self, forCellReuseIdentifier: Feature.vc.cell.reuseIdentifier())
            table.register(header.self, forHeaderFooterViewReuseIdentifier: header.reuseIdentifier())
            table.separatorStyle = .none
            table.contentInset.bottom = UIDevice.current.bottomNotch
            table.contentInset.bottom = UIDevice.current.bottomNotch + 20
            table.rowHeight = UITableView.automaticDimension
            self.view.addSubview(table)
            table.constrain(to: self.view).leadingTrailingTopBottom()
            
            table.reloadData()
        }
        
        @objc private func doneTapped(_ sender: UIButton) {
            if let vc = self.vm.finilize() {
                let nav = UINavigationController.init(rootViewController: vc)
                Z.ui.switch(window: nav)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        // MARK: - TABLE DELEGATE, DATASOURCE
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.vm.quantity()
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: Feature.vc.cell.reuseIdentifier()) as! cell
            cell.delegate = self
            let item = self.vm.data(at: indexPath.row)
            cell.configure(image: item.0, name: item.1, subs: item.2, selected: item.3)
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let cell = tableView.cellForRow(at: indexPath) as? Feature.vc.cell else { return }
            switch self.vm._type {
            case .style, .size:
                if let vc = self.vm.didSelect(itemAt: indexPath.row) {
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            case .extra:
                DispatchQueue.main.async {
                    tableView.beginUpdates()
                    cell.toggleExpand()
                    tableView.endUpdates()
                }
            }
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: header.reuseIdentifier()) as! header
            switch self.vm._type {
            case .style:
                view.configure(title: "Select your style")
            case .size:
                view.configure(title: "Select your size")
            case .extra:
                view.configure(title: "Select your extras")
            }
            return view
        }
        
        // MARK: - CELL DELEGATE
        func cell(_ cell: cell, didSelect sub: String) {
            self.vm.select(sub: sub)
        }
        
        func cell(_ cell: cell, didDeselect sub: String) {
            self.vm.deselect(sub: sub)
        }
        
    }
    
}
