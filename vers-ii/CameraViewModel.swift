//
//  CameraViewModel.swift
//  vers-ii
//
//  Created by Mohameth Seck on 5/4/23.
//

import Foundation
import AVFoundation
import AVKit

class CameraViewModel: NSObject, ObservableObject {
    
    @Published var prepareCaptureSession: (() -> Void)?
    @Published var stopCaptureSession: (() -> Void)?

    
    // AVCaptureSession manages data flow between input and output devices
    // so setting up to capure video and audo from the device's camera
    let captureSession = AVCaptureSession()
    
    // AVCaptureDevice represents the physical camera
    private var currentDevice: AVCaptureDevice!
    
    // AVCaptureMovieFileOutput captures video and audio to the file
    var videoFileOutput: AVCaptureMovieFileOutput!
    
    // AVCaptureVideoPreviewLayer displays the live camera feed as a layer
    private var cameraPreviewLayer: AVCaptureVideoPreviewLayer!
    
    // Properties for flash and recording state
    @Published var flashEnabled = false
    @Published var isRecording = false
    
    // Properties for countdown timer and video playback controls
    @Published var showCountdown = false
    @Published var countdown = 5
    @Published var videoRecorded = false
    
    // Other properties (access to microphone and camera, screen flipping, and closing camera)
    // will be implemented in separate functions
    
    
    
    //MARK: Functions
    
    
    //MARK: Might not be needed. Could just place in info list
    
//    Function to request access to the camera and microphone
//        func requestAccess() {
//            AVCaptureDevice.requestAccess(for: .video) { granted in
//                if granted {
//                    AVCaptureDevice.requestAccess(for: .audio) { granted in
//                        if granted {
//                            DispatchQueue.main.async {
//                                self.setupCaptureSession()
//                            }
//                        }
//                    }
//                }
//            }
//        }
    
    
    // Function to set up the AVCaptureSession
    func setupCaptureSession(){
        // Set session preset to the high-quality video
        captureSession.sessionPreset = .high //low for 3G | from AppCoda? -> AVCaptureSession.Preset.high
        
        // set up camera input
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            currentDevice = device
            if let input = try? AVCaptureDeviceInput(device: currentDevice) {
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                }
            }
            
        }
        
        // Set up microphone input
        if let audioDevice = AVCaptureDevice.default(for: .audio),
           let audioInput = try? AVCaptureDeviceInput(device: audioDevice) {
            if captureSession.canAddInput(audioInput) {
                captureSession.addInput(audioInput)
            }
        }
        
        // Set up video output
        videoFileOutput = AVCaptureMovieFileOutput()
        if captureSession.canAddOutput(videoFileOutput) {
            captureSession.addOutput(videoFileOutput)
        }
        
        //Set up preview layer
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer.videoGravity = .resizeAspectFill
        
        
        // Start the capture session
        captureSession.stopRunning()
        
        
    } //end of capture session setup function
    
    
    // Function to flip the camera
    func flipCamera() {
        if let input = captureSession.inputs.first as? AVCaptureDeviceInput {
            captureSession.removeInput(input)
            var newDevice: AVCaptureDevice!
            if input.device.position == .back {
                newDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            } else {
                newDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            }
            currentDevice = newDevice
            if let newInput = try? AVCaptureDeviceInput(device: newDevice) {
                if captureSession.canAddInput(newInput) {
                    captureSession.addInput(newInput)
                }
            }
        }
    }
    
    
    // Function to toggle flash
    func toggleFlash() {
        flashEnabled.toggle()
        if currentDevice.hasTorch {
            do {
                try currentDevice.lockForConfiguration()
                if flashEnabled {
                    currentDevice.torchMode = .on
                } else {
                    currentDevice.torchMode = .off
                }
                currentDevice.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    
    // Function to start recording
    // for timer????
    func startRecording() {
        isRecording = true
        showCountdown = true
        startCountdown()
        
        let outputPath = NSTemporaryDirectory() + "output.mov"
        let outputFileURL = URL(fileURLWithPath: outputPath)
        videoFileOutput.startRecording(to: outputFileURL, recordingDelegate: self)
    }
    
    
    // Function to stop recording
    func stopRecording() {
        isRecording = false
        showCountdown = false
        videoFileOutput.stopRecording()
    }
    
    
    
    // Function to start the countdown timer
    private func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.isRecording {
                if self.countdown > 0 {
                    self.countdown -= 1
                } else {
                    timer.invalidate()
                    self.stopRecording()
                }
            } else {
                timer.invalidate()
            }
        }
    }
    
    
    
    
    // Function to get the preview layer for the camera
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        return cameraPreviewLayer
    }
    }

    // AVCaptureFileOutputRecordingDelegate methods
    extension CameraViewModel: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
    guard error == nil else {
    print(error ?? "")
    return
    }
    videoRecorded = true
    }
    
    
        func updatePreviewFrame(_ frame: CGRect) {
            cameraPreviewLayer?.frame = frame
        }

    
    
    
} //MARK: end of class


/*
 This `CameraViewModel` class has detailed comments explaining each line of code. It includes
 the methods for setting up the camera and microphone, flipping the camera, toggling the flash, and
 managing the recording process.
 The countdown timer logic is also included.
 Please read through the comments to understand how each part works.
 */


