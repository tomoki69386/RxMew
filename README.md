# RxMew

[RxSwift](https://github.com/ReactiveX/RxSwift) extensions for [Mew](https://github.com/mercari/Mew).

## Installation

### Carthage

```
github "tomoki69386/RxMew"
```

## Example

All the reactive extensions are encapsulated in the rx property of an ContainerView.Container.

```Swift
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

nameButtonContainer.rx.output.subscribe(onNext: { output in
    guard case let .name(name) = output else {
        assertionFailure("not match")
        return
    }
    print(name)
}).disposed(by: disposeBag)

```
