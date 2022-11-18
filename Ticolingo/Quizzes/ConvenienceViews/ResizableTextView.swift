//
//  ResizableTextView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 3/11/22.
//

import SwiftUI

struct ResizableTextView: View {
    @Binding private var text: String
    @Binding private var largestFont: Font?
    @Binding private var minimumScaleFactor: CGFloat

    init(_ text: Binding<String>,
         largestFont: Binding<Font?> = .constant(.largeTitle),
         minimumScaleFactor: Binding<CGFloat> = .constant(0.4)) {
        self._text = text
        self._largestFont = largestFont
        self._minimumScaleFactor = minimumScaleFactor
    }

    var body: some View {
        Text(text)
            .multilineTextAlignment(.center)
            .foregroundColor(ColorManager.shared.tertiaryTextColour)
            .font(largestFont)
            .fixedSize(horizontal: false, vertical: false)
            .minimumScaleFactor(minimumScaleFactor)
    }
}

struct ResizableTextView_Previews: PreviewProvider {
    static var previews: some View {
        ResizableTextView(.constant("Hi"))
    }
}
