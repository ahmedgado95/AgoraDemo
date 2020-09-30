//
//  ViewController.swift
//  AgoraDemo
//
//  Created by ahmed gado on 9/29/20.
//  Copyright © 2020 ahmed gado. All rights reserved.
//

import UIKit

import AgoraRtcEngineKit
class ViewController: UIViewController {
    @IBOutlet weak var callEndLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var leaveButton: UIButton!
    @IBOutlet weak var remoteView: UIView!
    @IBOutlet weak var localVideo: UIView!
    let appID = ""
    let token = ""
    var agoraKit : AgoraRtcEngineKit?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func initializeAgoraEngine() {
        remoteView.isHidden = false
        localVideo.isHidden = false
        leaveButton.isHidden = false
        // Initialize the AgoraRtcEngineKit object.
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: appID, delegate: self)
    }
    
    func setupLocalVideo() {
        // Enable the video
        agoraKit?.enableVideo()
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.view = localVideo
        videoCanvas.renderMode = .hidden
        // Set the local video view.
        agoraKit?.setupLocalVideo(videoCanvas)
    }
    
    func leaveChannel() {
        // Leave the channel.
        agoraKit?.leaveChannel(nil)
        localVideo.isHidden = true
        leaveButton.isHidden = true
        remoteView.isHidden = true
        callButton.isHidden = true
        callEndLabel.isHidden = false
    }
    
    func joinChannel(){
        agoraKit?.joinChannel(byToken: token, channelId: "Gado", info: nil, uid: 0, joinSuccess: { (channel, uid, elapsed) in
            print("Success Joined\(channel)")
        })
        
        
    }
    
    @IBAction func leaveButtonPressed(_ sender: Any) {
        leaveChannel()

    }
    
    @IBAction func callButtonPresses(_ sender: Any) {
        initializeAgoraEngine()
        setupLocalVideo()
        joinChannel()
    }
    
}
extension ViewController : AgoraRtcEngineDelegate {

    func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid:UInt, size:CGSize, elapsed:Int) {
            let videoCanvas = AgoraRtcVideoCanvas()
            videoCanvas.uid = uid
            videoCanvas.view = remoteView
            videoCanvas.renderMode = .hidden
            // Set the remote video view.
        agoraKit?.setupRemoteVideo(videoCanvas)
        }
    
}
