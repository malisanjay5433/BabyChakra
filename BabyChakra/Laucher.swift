////
////  Laucher.swift
////  BabyChakra
////
////  Created by Sanjay Mali on 03/10/17.
////  Copyright © 2017 Sanjay Mali. All rights reserved.
////
//
//import Foundation
//import UIKit
//import AVFoundation
//class VideoPlayerView: UIView {
//    let activityIndicatorView: UIActivityIndicatorView = {
//        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
//        aiv.translatesAutoresizingMaskIntoConstraints = false
//        aiv.startAnimating()
//        return aiv
//    }()
//    var volumeUpDownButton: UIButton = {
//        let button = UIButton(type: .system)
//        let image = UIImage(named: "volume_off")
//        button.setImage(image, for: UIControlState())
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.tintColor = .white
//        button.isHidden = false
//        button.addTarget(self, action: #selector(handleVolume), for: .touchUpInside)
//        return button
//    }()
//    @objc func handleVolume() {
//        if is_Muted {
//            player?.isMuted = true
//            volumeUpDownButton.setImage(UIImage(named: "volume_off"), for: UIControlState())
//        } else {
//            player?.isMuted = false
//            volumeUpDownButton.setImage(UIImage(named: "volume_on"), for: UIControlState())
//        }
//        is_Muted = !is_Muted
//    }
//    var pausePlayButton: UIButton = {
//        let button = UIButton(type: .system)
//        let image = UIImage(named: "pause")
//        button.setImage(image, for: UIControlState())
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.tintColor = .white
//        button.isHidden = true
//        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
//        return button
//    }()
//
//    var isPlaying = false
//    var is_Muted = false
//    @objc func handlePause() {
//        if isPlaying {
//            player?.pause()
//            pausePlayButton.setImage(UIImage(named: "play"), for: UIControlState())
//        } else {
//            player?.play()
//            pausePlayButton.setImage(UIImage(named: "pause"), for: UIControlState())
//        }
//        isPlaying = !isPlaying
//    }
//
//    let controlsContainerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.lightGray
//        return view
//    }()
//
//    let videoLengthLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "00:00"
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 13)
//        label.textAlignment = .right
//        return label
//    }()
//
//    let currentTimeLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "00:00"
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 13)
//        return label
//    }()
//    lazy var videoSlider: UISlider = {
//        let slider = UISlider()
//        slider.translatesAutoresizingMaskIntoConstraints = false
//        slider.minimumTrackTintColor = .red
//        slider.maximumTrackTintColor = .white
//        slider.setThumbImage(UIImage(named: "thumb"), for: UIControlState())
//        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
//        return slider
//    }()
//    @objc func handleSliderChange() {
//        print(videoSlider.value)
//        if let duration = player?.currentItem?.duration {
//            let totalSeconds = CMTimeGetSeconds(duration)
//            let value = Float64(videoSlider.value) * totalSeconds
//            let seekTime = CMTime(value: Int64(value), timescale: 1)
//            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
//                //perhaps do something later here
//            })
//        }
//    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupPlayerView()
//        setupGradientLayer()
//        controlsContainerView.frame = frame
//        addSubview(controlsContainerView)
//
//        controlsContainerView.addSubview(activityIndicatorView)
//        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//
//        controlsContainerView.addSubview(volumeUpDownButton)
//        volumeUpDownButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
//        volumeUpDownButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
//        volumeUpDownButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        volumeUpDownButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//        controlsContainerView.addSubview(pausePlayButton)
//        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//
//
//        controlsContainerView.addSubview(videoLengthLabel)
//        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
//        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
//        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
//
//        controlsContainerView.addSubview(currentTimeLabel)
//        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
//        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
//        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
//
//        controlsContainerView.addSubview(videoSlider)
//        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
//        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
//        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        backgroundColor = .black
//    }
//    var player: AVPlayer?
//    func setupPlayerView() {
//        //warning: use your own video url here, the bandwidth for google firebase storage will run out as more and more people use this file
//                let urlString = "https://devstreax/ming-cdn.apple.com/videos/tutorials/20170912/603lp0b4npn5r/metal_threadgroup_image_blocks/hls_vod_mvp.m3u8"
////        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
//        if let url = URL(string: urlString) {
//            player = AVPlayer(url: url)
//            let playerLayer = AVPlayerLayer(player: player)
//            self.layer.addSublayer(playerLayer)
//            playerLayer.frame = self.frame
//            player?.play()
////            player?.isMuted = true
//            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
//            //track player progress
//            let interval = CMTime(value: 1, timescale: 2)
//            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
//                let seconds = CMTimeGetSeconds(progressTime)
//                let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
//                let minutesString = String(format: "%02d", Int(seconds / 60))
//                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
//                //lets move the slider thumb
//                if let duration = self.player?.currentItem?.duration {
//                    let durationSeconds = CMTimeGetSeconds(duration)
//                    self.videoSlider.value = Float(seconds / durationSeconds)
//                }
//            })
//        }
//    }
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        //this is when the player is ready and rendering frames
//        if keyPath == "currentItem.loadedTimeRanges" {
//            activityIndicatorView.stopAnimating()
//            controlsContainerView.backgroundColor = .clear
//            pausePlayButton.isHidden = false
//            isPlaying = true
//            if let duration = player?.currentItem?.duration {
//                if duration.isIndefinite{
//                    return
//                }
//                let seconds = CMTimeGetSeconds(duration)
//                let secondsText = Int(seconds) % 60
//                let minutesText = String(format: "%02d", Int(seconds) / 60)
//                videoLengthLabel.text = "\(minutesText):\(secondsText)"
//            }
//        }
//    }
//    fileprivate func setupGradientLayer() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = bounds
//        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        gradientLayer.locations = [0.7, 1.2]
//        controlsContainerView.layer.addSublayer(gradientLayer)
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

