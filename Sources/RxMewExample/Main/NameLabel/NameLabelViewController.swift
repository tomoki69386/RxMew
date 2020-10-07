//
//  NameLabelViewController.swift
//  RxMewExample
//
//  Created by 築山朋紀 on 2020/10/07.
//

import Mew
import UIKit
import RxMew
import RxSwift
import RxCocoa

class NameLabelViewController: UIViewController, Injectable, Instantiatable {
    typealias Environment = EnvironmentMock
    
    struct Input {
        let name: String
    }
    
    var input: Input
    var environment: EnvironmentMock
    
    @IBOutlet var nameLabel: UILabel!
    
    required init(with input: Input, environment: EnvironmentMock) {
        self.input = input
        self.environment = environment
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateAll()
    }
    
    func input(_ input: Input) {
        self.input = input
        updateAll()
    }
    
    func updateAll() {
        nameLabel.text = input.name
    }
}
