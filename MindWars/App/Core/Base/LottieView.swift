//
//  LottieView.swift
//  MindWars
//
//  Created by Yiğit Tilki on 20.12.2024.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    var animationFileName: String
    let loopMode: LottieLoopMode

    func updateUIView(_: UIViewType, context _: Context) {}

    func makeUIView(context _: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: animationFileName)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.contentMode = .scaleAspectFill
        return animationView
    }
}
