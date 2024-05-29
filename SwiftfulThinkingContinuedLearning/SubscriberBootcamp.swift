//
//  SubscriberBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Griffin Baker on 5/28/24.
//

import SwiftUI

@Observable class SubscriberViewModel {
   var count = 0
    
    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink
    }
}

struct SubscriberBootcamp: View {
    @State var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
        }
    }
}

#Preview {
    SubscriberBootcamp()
}
