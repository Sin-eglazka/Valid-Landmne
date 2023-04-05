//
//  MusicPlayer.swift
//  eeakstHW3
//
//  Created by Kate on 28.03.2023.
//

import Foundation
import AVFoundation

class MusicPlayer{
    static let shared = MusicPlayer()
    
    var audioPlayer: AVAudioPlayer?
    
    func startBackgroundMusic(music: Music){
        
        if let bundle = Bundle.main.path(forResource: music.rawValue, ofType: "mp3") {
                    
                    let backgroundMusic = NSURL(fileURLWithPath: bundle)
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                        guard let audioPlayer = audioPlayer else { return }
                        audioPlayer.numberOfLoops = -1
                        audioPlayer.prepareToPlay()
                        audioPlayer.play()
                    } catch {
                        print(error)
                    }
                }
    }
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
}
