//
//  VideoPreviewerViewController.swift
//  Video Player
//
//  Created by Madesh on 26/04/23.
//

import UIKit
import AVKit

class VideoPreviewerViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //  Declaring the variable for Initialize
    var animal = Photos()
    
    var videoLink = String()
    
    @objc var player = AVPlayer()
    
    var playerLayer = AVPlayerLayer()
    
    var currentvalue = 0
    
    // Outlet for View for VideoPlayer
    var VideoView:UIView = UIView()
    
    var nextButtonOutlet:UIButton = UIButton()
    
    var pauseButtonOutlet:UIButton = UIButton()
    
    var playButtonOutlet:UIButton = UIButton()
    
    var PreviousOutlet : UIButton = UIButton()
    
    var stackView : UIStackView = UIStackView()
    
    var videoSlider:UISlider = UISlider()
    
    var videoCurrentTimeLabel:UILabel = UILabel()
    
    var videoDurationTimeLabel:UILabel = UILabel()
    
    var playerCustomStactView:UIStackView = UIStackView()
    
    var dur = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        singleTap()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(backToMainVC))
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "speaker.wave.3"), style: .plain, target: self, action: #selector(volumeMute))
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .systemBackground
//        let duration = player.currentItem?.duration.seconds ?? 0
//        videoSlider.maximumValue = Float(player.currentItem?.duration)

        videoSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { [weak self] time in
            guard let self = self else { return }
            let duration = CMTimeGetSeconds(self.player.currentItem?.duration ?? CMTime.zero)
//            print(duration)
            let elapsedTime = CMTimeGetSeconds(time)
//            print(elapsedTime)
            let progress = Float(elapsedTime / duration)
            
            self.videoSlider.value = progress
            
            let currentTime = Int(elapsedTime)
            let minutes = currentTime / 60
            let seconds = currentTime % 60
            let timeString = String(format: "%02d:%02d", minutes, seconds)
            self.videoCurrentTimeLabel.text = timeString
            
            let totalTime = Int(CMTimeGetSeconds(self.player.currentItem?.duration ?? CMTime.zero))
            let totalMinutes1 = totalTime / 60
            let totalSeconds1 = totalTime % 60
            let durStart = NSString(format: "%d:%02d", totalMinutes1, totalSeconds1) as String
            self.dur = durStart
            self.videoDurationTimeLabel.text = durStart
//            let new = String(format
//            activityIndicator.stopAnimating()
//            activityIndicator.removeFromSuperview()
        }
        
    }
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if animal.details == "video"{
            print("Hello")
        }
        else{
            activityIndicator.center = view.center
            view.addSubview(activityIndicator)
            
            // Start the activity indicator
            activityIndicator.startAnimating()}
    }

    
    @objc func sliderValueChanged(_ slider: UISlider) {
        let duration = CMTimeGetSeconds(player.currentItem?.duration ?? CMTime.zero)
//        print(duration)
        let elapsedTime = Float(duration) * slider.value

        // Update the video player's current time
        let time = CMTimeMakeWithSeconds(Float64(elapsedTime), preferredTimescale: 1)
        player.seek(to: time)
    }

    // Declaring the function for Custom AVPlayer
    func avplayerControl(){
        
        if animal.details == "video"{
            //            guard let videoURL = URL(string: videoLink) else { return }
            guard let videoURL = Bundle.main.url(forResource: animal.PhotoImages, withExtension: "mp4") else { return }
            
            player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = view.bounds
            playerLayer.videoGravity = .resizeAspect
            //        view.layer.addSublayer(playerLayer)
            VideoView.layer.addSublayer(playerLayer)
            player.play()
            hidingControls()
            
        }
        else{
            guard let videoURL = URL(string: videoLink) else { return }
            player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = view.bounds
            playerLayer.videoGravity = .resizeAspect
            //        view.layer.addSublayer(playerLayer)
            VideoView.layer.addSublayer(playerLayer)
            player.play()
//            player.addObserver(self, forKeyPath: #keyPath(AVPlayer.status), options: [.new], context: nil)

            hidingControls()
//            player.addObserver(self, forKeyPath: "status", options: .new, context: nil)
            player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)


//            activityIndicator.stopAnimating()
//            activityIndicator.removeFromSuperview()
        }
    }


    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus",
        let change = change,
        let newValue = change[NSKeyValueChangeKey.newKey] as? Int,
        let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
        let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
//            print(oldValue)
            print("This is new value\(newValue)")
            print("This is old value \(oldValue)")
            print("This is the old status\(oldStatus)")
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            print("This is the new status\(newStatus)")
            if newStatus != oldStatus {
                print("Status not equal")
                DispatchQueue.main.async {[weak self] in
                    if newStatus == .playing || newStatus == .paused {
                        self?.activityIndicator.isHidden = true
                    } else {
                        self?.activityIndicator.isHidden = false
                    }
                }
            }
        }
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//      if keyPath == #keyPath(AVPlayer.status),
//        let statusNumber = change?[.newKey] as? NSNumber,
//         let status = AVPlayer.Status(rawValue: statusNumber.intValue) {
//          switch status {
//            case .readyToPlay:
//              // Player is ready to play - hide the loader view
//              print("Hello")
////              activityIndicator.stopAnimating()
////              activityIndicator.removeFromSuperview()
//            case .failed, .unknown:
//              // Handle errors or unknown status
////              view.addSubview(activityIndicator)
//              activityIndicator.removeFromSuperview()
////              activityIndicator.startAnimating()
//              break
//            @unknown default:
//              break
//          }
//      }
//    }

    
    func setup(){
        avplayerControl()
        
        VideoView.translatesAutoresizingMaskIntoConstraints = false
        VideoView.backgroundColor = .black  
        self.view.addSubview(VideoView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        self.view.addSubview(stackView)
        nextButtonOutlet.translatesAutoresizingMaskIntoConstraints = false
        nextButtonOutlet.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        stackView.addArrangedSubview(PreviousOutlet)
        stackView.addArrangedSubview(playButtonOutlet)
//        stackView.addArrangedSubview(pauseButtonOutlet)
        stackView.addArrangedSubview(nextButtonOutlet)
        PreviousOutlet.addTarget(self, action: #selector(PreviousTenSecondPass), for: .touchUpInside)
        nextButtonOutlet.addTarget(self, action: #selector(nextTenSecondPass), for: .touchUpInside)

        
        playButtonOutlet.addTarget(self, action: #selector(PauseButtonTapped), for: .touchUpInside)
        pauseButtonOutlet.addTarget(self, action: #selector(PauseButtonTapped), for: .touchUpInside)
        
        videoSlider.translatesAutoresizingMaskIntoConstraints = false
        videoSlider.isUserInteractionEnabled = true
//        self.view.addSubview(videoSlider)
        
        
        
        
        PreviousOutlet.translatesAutoresizingMaskIntoConstraints = false
        PreviousOutlet.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
        playButtonOutlet.translatesAutoresizingMaskIntoConstraints = false
        playButtonOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        pauseButtonOutlet.translatesAutoresizingMaskIntoConstraints = false
        pauseButtonOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        
        videoCurrentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        videoDurationTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        playerCustomStactView.translatesAutoresizingMaskIntoConstraints = false
        
        playerCustomStactView.addArrangedSubview(videoCurrentTimeLabel)
        playerCustomStactView.addArrangedSubview(videoSlider)
        playerCustomStactView.addArrangedSubview(videoDurationTimeLabel)
        
        self.view.addSubview(playerCustomStactView)
        
        
        
        
        NSLayoutConstraint.activate([VideoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                                     VideoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                                     VideoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                                     VideoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                                     stackView.bottomAnchor.constraint(equalTo: VideoView.bottomAnchor, constant: -30),
                                     stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
                                     stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     videoSlider.heightAnchor.constraint(equalToConstant: 30),videoSlider.widthAnchor.constraint(equalToConstant: 250),
                                     videoSlider.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -30),
                                     videoSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                                     videoCurrentTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),videoCurrentTimeLabel.bottomAnchor.constraint(equalTo: videoSlider.topAnchor, constant: -20),
                                     playerCustomStactView.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 0),
                                     playerCustomStactView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     playerCustomStactView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),playerCustomStactView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20)])
        
    }
    
    @objc func backToMainVC(){
//        dismiss(animated: true,completion: nil)
        self.navigationController?.popViewController(animated: true)
        player.pause()
        
        
    }
    
    @objc func PreviousTenSecondPass(){
        // Seek 10 seconds forward
//        let currentTime = player.currentTime()
//        let targetTime = CMTimeAdd(currentTime, CMTime(seconds: 10, preferredTimescale: currentTime.timescale))
//        player.seek(to: targetTime)

        // Seek 10 seconds backward
        let currentTime = player.currentTime()
        let targetTime = CMTimeSubtract(currentTime, CMTime(seconds: 10, preferredTimescale: currentTime.timescale))
        player.seek(to: targetTime)

    }
    
    @objc func nextTenSecondPass(){
        let currentTime = player.currentTime()
        let targetTime = CMTimeAdd(currentTime, CMTime(seconds: 10, preferredTimescale: currentTime.timescale))
        player.seek(to: targetTime)
    }
    @objc func volumeMute(){
        if player.volume == 0{
            player.volume = 1
//            self.navigationItem.rightBarButtonItem.setImage(UIImage(systemName: "speaker.wave.1"), for: .normal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "speaker.wave.3"), style: .plain, target: self, action: #selector(volumeMute))
        }
        else{
            player.volume = 0
//            self.navigationItem.rightBarButtonItem.setImage(UIImage(systemName: "speaker.wave.1"), for: .normal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "speaker.wave.1"), style: .plain, target: self, action: #selector(volumeMute))
        }
    }
    @objc func PlayButtonTapped(_ sender: Any) {
        player.play()
    }
    
    @objc func PauseButtonTapped(_ sender: Any) {
        if player.timeControlStatus == .playing{
            player.pause()
            playButtonOutlet.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else{
            player.play()
            playButtonOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)

        }
    }
    @objc func hidingPlayerControl(_ gesture: UITapGestureRecognizer){
        hidingControls()
    }
    func hidingControls(){
        print("ButtonTapped")
        if currentvalue == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 10){self.hidingControls()}
            currentvalue += 1
            PreviousOutlet.isHidden = false
            playButtonOutlet.isHidden = false
            nextButtonOutlet.isHidden = false
            pauseButtonOutlet.isHidden = false
            videoSlider.isHidden = false
            videoDurationTimeLabel.isHidden = false
            self.navigationController?.navigationBar.isHidden = false
            videoCurrentTimeLabel.isHidden = false
        }
        else {
            currentvalue -= 1
            PreviousOutlet.isHidden = true
            playButtonOutlet.isHidden = true
            nextButtonOutlet.isHidden = true
            pauseButtonOutlet.isHidden = true
            videoSlider.isHidden = true
            videoDurationTimeLabel.isHidden = true
            videoCurrentTimeLabel.isHidden = true
            self.navigationController?.navigationBar.isHidden = true
        }
        
    }
    func singleTap(){
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(hidingPlayerControl(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.delaysTouchesBegan = true
        singleTap.delegate = self
        view.addGestureRecognizer(singleTap)
            
    }
}

