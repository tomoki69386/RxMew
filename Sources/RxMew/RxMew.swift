import Mew
import UIKit
import RxSwift
import RxCocoa

public extension ContainerView.Container {
    var rx: Reactive<ContainerView.Container<Content, Parent>> {
        return Reactive(self)
    }
    struct Reactive<Base: ContainerView.Container<Content, Parent>> {
        let base: Base
        public init(_ base: Base) {
            self.base = base
        }
    }
}

public extension ContainerView.Container.Reactive where Content: Injectable {
    var input: Binder<Base.Input> {
        return Binder(self.base) { base, input in
            base.input(input)
        }
    }
    var inputs: Binder<[Base.Input]> {
        return Binder(self.base) { base, inputs in
            base.inputs(inputs.compactMap { $0 })
        }
    }
}

public extension ContainerView.Container.Reactive where Content: Interactable {
    var output: Observable<Base.Output> {
        return Observable<Base.Output>.create { [base] observer in
            base.output({ output in
                observer.onNext(output)
            })
            return Disposables.create()
        }
    }
}
