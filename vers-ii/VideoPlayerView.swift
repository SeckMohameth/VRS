//
//  VideoPlayerView.swift
//  vers-ii
//
//  Created by Mohameth Seck on 5/4/23.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let url: URL
    @State private var player: AVPlayer?

    var body: some View {
        VStack {
            if let player = player {
                VideoPlayer(player: player)
                    .onAppear {
                        player.play()
                    }
                    .onDisappear {
                        player.pause()
                    }
            }
        }
        .onAppear {
            player = AVPlayer(url: url)
        }
        .onDisappear {
            player = nil
        }
    }
}

//
//struct VideoPlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoPlayerView()
//    }
//}
