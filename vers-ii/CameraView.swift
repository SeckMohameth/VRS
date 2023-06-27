//
//  CameraView.swift
//  vers-ii
//
//  Created by Mohameth Seck on 5/3/23.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject private var cameraViewModel = CameraViewModel()
    @State private var isShowingPlayback = false
    @State private var videoURL: URL?

    var body: some View {
        ZStack(alignment: .bottom) {

            //MARK: Camera View
            GeometryReader { geometry in
                if let previewLayer = cameraViewModel.getPreviewLayer() {
                    CameraPreview(cameraPreviewLayer: previewLayer)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                            Color.clear
                                .onAppear {
                                    cameraViewModel.updatePreviewFrame(geometry.frame(in: .global))
                                }
                        )
                } else {
                    Color.black
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .edgesIgnoringSafeArea(.all)
                }
            }
            .onAppear {
                cameraViewModel.prepareCaptureSession?()
            }
            .onDisappear {
                cameraViewModel.stopCaptureSession?()
            }

            //MARK: Controls
            VStack {
                HStack {
                    Button {
                        cameraViewModel.flipCamera()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .font(.system(size: 24))
                            .padding()
                    }

                    Spacer()

                    Button {
                        cameraViewModel.toggleFlash()
                    } label: {
                        Image(systemName: cameraViewModel.flashEnabled ? "bolt.fill" : "bolt.slash.fill")
                            .font(.system(size: 24))
                            .padding()
                    }
                }
                .padding(.top)

                Spacer()

                ZStack {
                    Button {
                        if !cameraViewModel.isRecording {
                            cameraViewModel.startRecording()
                        } else {
                            cameraViewModel.stopRecording()
                        }
                    } label: {
                        Image(systemName: cameraViewModel.isRecording ? "stop.circle.fill" : "video.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.red)
                    }
                    .padding(.bottom)

                    if cameraViewModel.showCountdown {
                        Text("\(cameraViewModel.countdown)")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()

            if cameraViewModel.videoRecorded {
                VStack {
                    Spacer()

                    Button {
                        isShowingPlayback = true
                        videoURL = cameraViewModel.videoFileOutput.outputFileURL
                    } label: {
                        Text("Preview")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isShowingPlayback) {
            if let url = videoURL {
                VideoPlayerView(url: url)
            }
        }
        .onAppear {
            cameraViewModel.setupCaptureSession()
        }
        .onDisappear {
            cameraViewModel.captureSession.stopRunning()
        }
        //.preferredColorScheme(.dark)
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}

struct CameraPreview: UIViewRepresentable {
    let cameraPreviewLayer: AVCaptureVideoPreviewLayer

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        cameraPreviewLayer.frame = view.bounds
        view.layer.addSublayer(cameraPreviewLayer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}


//import SwiftUI
//
//struct CameraView: View {
//    var body: some View {
//        ZStack(alignment: .bottom) {
//
//            //MARK: Camera View
//
//            //MARK: Controls
//            ZStack {
//
//
//                Button {
//
//                } label: {
//                    Image("VideoCam")
//                        .frame(maxHeight: .infinity, alignment: .bottom)
//                        .padding(.bottom,30)
//
//                }
//            }
//
//        }
//        //.preferredColorScheme(.dark)
//    }
//}
//
//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}
//
