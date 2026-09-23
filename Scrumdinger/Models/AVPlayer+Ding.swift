//
//  AVPlayer+Ding.swift
//  Scrumdinger
//  
//  Created by endlmk on 2026/09/23
//  
//

import Foundation
import AVFoundation

extension AVPlayer {
    /// Returns an instance of `AVPlayer`, loaded to play the `ding` sound.
    static func dingPlayer() -> AVPlayer {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else {
            fatalError("Failed to find sound file.")
        }
        return AVPlayer(url: url)
    }
}
