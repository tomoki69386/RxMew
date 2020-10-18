//
//  NameButtonViewController.swift
//  RxMewExample
//
//  Created by 築山朋紀 on 2020/10/07.
//

import Mew
import UIKit
import RxMew
import RxSwift
import RxCocoa

class NameButtonViewController: UIViewController, Injectable, Instantiatable, Interactable {
    typealias Environment = EnvironmentMock
    
    struct Input {
        let name: String
    }
    enum Output {
        case name(String)
    }
    
    var input: Input
    var handler: ((Output) -> Void)?
    var environment: EnvironmentMock
    
    required init(with input: Input, environment: EnvironmentMock) {
        self.input = input
        self.environment = environment
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func input(_ input: Input) {
        self.input = input
    }
    
    func output(_ handler: ((Output) -> Void)?) {
        self.handler = handler
    }
    
    @IBAction func tappedButton(_ sender: UIButton) {
        let name = input.name
        handler?(.name(name))
    }
}
