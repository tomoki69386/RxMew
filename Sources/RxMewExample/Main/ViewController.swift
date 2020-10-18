//
//  ViewController.swift
//  RxMewExample
//
//  Created by 築山朋紀 on 2020/10/07.
//

import Mew
import UIKit
import RxMew
import RxSwift
import RxCocoa

class ViewController: UIViewController, Injectable, Instantiatable {
    typealias Input = Void
    typealias Environment = EnvironmentMock
    
    var environment: EnvironmentMock
    
    var disposeBag = DisposeBag()
    
    @IBOutlet var containerView: ContainerView!
    
    lazy var nameLabelContainer = containerView.makeContainer(
        for: NameLabelViewController.self,
        parentViewController: self,
        with: NameLabelViewController.Input(name: "tomoki_sun"))
    
    lazy var nameButtonContainer = containerView.makeContainer(
        for: NameButtonViewController.self,
        parentViewController: self,
        with: NameButtonViewController.Input(name: "tomoki_sun")
    )
    
    required init(with input: Void, environment: EnvironmentMock) {
        self.environment = environment
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameObserver = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .compactMap(String.init)
            .share(replay: 1)
        
        let nameLabelInput = nameObserver
            .map { NameLabelViewController.Input(name: $0) }
        
        let nameButtonInput = nameObserver
            .map { NameButtonViewController.Input(name: $0) }
        
        nameLabelInput
            .bind(to: nameLabelContainer.rx.input)
            .disposed(by: disposeBag)
        
        nameButtonInput
            .bind(to: nameButtonContainer.rx.input)
            .disposed(by: disposeBag)
        
        nameButtonContainer._output.subscribe(onNext: { output in
            guard case let .name(name) = output else {
                assertionFailure("not match")
                return
            }
            print(name)
        }).disposed(by: disposeBag)
    }
}
