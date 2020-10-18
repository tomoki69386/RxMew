import Mew
import UIKit
import RxSwift
import RxCocoa

public extension ContainerView.Container where Content: Injectable {
    var rx: Reactive<ContainerView.Container<Content, Parent>> {
        return Reactive<ContainerView.Container>(self)
    }
    struct Reactive<Base: ContainerView.Container<Content, Parent>> {
        let base: Base
        public init(_ base: Base) {
            self.base = base
        }
        
        public var input: Binder<Base.Input> {
            return Binder(self.base) { base, input in
                base.input(input)
            }
        }
        public var inputs: Binder<[Base.Input]> {
            return Binder(self.base) { base, inputs in
                base.inputs(inputs.compactMap { $0 })
            }
        }
    }
}

public extension ContainerView.Container where Content: Interactable {
    var _output: Observable<Content.Output> {
        return Observable<Content.Output>.create { [weak self] observer in
            self?.output({ (output) in
                observer.onNext(output)
            })
            return Disposables.create()
        }
    }
}
