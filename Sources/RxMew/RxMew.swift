import Mew
import UIKit
import RxSwift
import RxCocoa

// TODO: Property names will be changed later.

public extension ContainerView.Container where Content: Injectable {
    var _input: Binder<Content.Input?> {
        return Binder<Content.Input?>(self) { base, input in
            base.input(input)
        }
    }
    var inputs: Binder<[Content.Input]> {
        return Binder<[Content.Input]>(self) { base, inputs in
            base.inputs(inputs)
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
