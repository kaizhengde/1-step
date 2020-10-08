//
//  DismissableObservableObject.swift
//  1 Step
//
//  Created by Kai Zheng on 08.10.20.
//

import SwiftUI
import Combine 

class DismissableObservableObject: ObservableObject {

    @Published var enteredText = ""
    var isValid = false

    var cancellable: AnyCancellable?

    
    init() {
        print("[>>] created")
        cancellable = textValidatedPublisher.receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
    }

    
    func invalidate() {
        cancellable?.cancel()
        cancellable = nil
        print("[<<] invalidated")
    }

    
    deinit {
        print("[x] done")
    }

    
    var textValidatedPublisher: AnyPublisher<Bool, Never> {
        $enteredText.map {
            $0.count > 1
        }.eraseToAnyPublisher()
    }
}
