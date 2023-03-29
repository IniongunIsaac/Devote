//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Isaac Iniongun on 29/03/2023.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                
            configuration.label
        }
        .onTapGesture {
            configuration.isOn.toggle()
            feedback.notificationOccurred(.success)
            playSound(sound: configuration.isOn ? "sound-rise" : "sound-tap", type: "mp3")
        }
    }
}

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Placeholder Label", isOn: .constant(false))
            .toggleStyle(CheckboxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
