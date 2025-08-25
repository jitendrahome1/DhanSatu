//
//  ResendTimerManager.swift
//  DhanSetu
//
//  Created by Jitendra Agarwal on 25/08/25.
//

import SwiftUI

class ResendTimerManager: ObservableObject {
    @Published var secondsRemaining: Int = 0
    private var timer: Timer?

    func start(seconds: Int = 30) {
        stop()
        secondsRemaining = seconds
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] t in
            guard let self = self else { return }
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
            } else {
                t.invalidate()
            }
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
