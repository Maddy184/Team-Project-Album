//
//  MusicPlayerViewController.swift
//  Video Player
//
//  Created by Madesh on 11/04/23.
//

import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {
    
    var imageView : UIImageView = UIImageView()
    var musicLabel: UILabel = UILabel()
    var durationStartTrack:UILabel = UILabel()
    var durationEndTrack:UILabel = UILabel()
    var Slider:UISlider = UISlider()
    var stackView:UIStackView = UIStackView()
    var durationStack:UIStackView = UIStackView()
    var previousButton:UIButton = UIButton()
    var playButton:UIButton = UIButton()
    var nextButton:UIButton = UIButton()
    var volumeSlider:UISlider = UISlider()
    
    
    var audioPlayer = AVAudioPlayer()
    var musicName:String?
    var musicNextTrack:String?
    var currentIndex = 0
    var audioFiles:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setup()
//        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        print(currentIndex)
        MusicFiles()
        print("MusicPlaying")
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(musicPlayerTimeUpdater), userInfo: nil, repeats: true)
        
//        Slider.maximumValue = Float(audioPlayer.duration)
        //        PlayPause.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        volumeSlider.value = audioPlayer.volume ?? 0.5
        volumeSlider.addTarget(self, action: #selector(volumeSliderChanged(_:)), for: .valueChanged)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        setupImageiView()
        navigationItem.title = "Playing Now"
        playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        
        let duration = Int((audioPlayer.duration))
        let minutes2 = duration/60
        let seconds2 = duration - minutes2 * 60
        var durStart =  NSString(format: "%02d:%02d", minutes2,seconds2) as String
        
        let totalTime = Int(audioPlayer.duration)
        let totalMinutes = totalTime / 60
        let totalSeconds = totalTime % 60
        durationEndTrack.text = String(format: "%d:%02d", totalMinutes, totalSeconds)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            audioPlayer.stop()
        }
    }
    func setupImageiView(){
        
        // this is for testing
        
//                let duration = Int((audioPlayer?.duration)!)
//                let minutes2 = duration/60
//                let seconds2 = duration - minutes2 * 60
//                var durStart =  NSString(format: "%02d:%02d", minutes2,seconds2) as String
        //
        //        let totalTime = Int(audioPlayer.duration)
        //        let totalMinutes = totalTime / 60
        //        let totalSeconds = totalTime % 60
        //        durationEndTrack.text = String(format: "%d:%02d", totalMinutes, totalSeconds)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Image")
        self.view.addSubview(imageView)
        
        musicLabel.translatesAutoresizingMaskIntoConstraints = false
        musicLabel.textAlignment = .center
        musicLabel.text = musicName
        
        self.view.addSubview(musicLabel)
        
        Slider.translatesAutoresizingMaskIntoConstraints = false
        self.Slider.isUserInteractionEnabled = true
        Slider.addTarget(self, action: #selector(ChangingActionTime), for: .touchUpInside)
        
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        self.volumeSlider.isUserInteractionEnabled = true
        self.view.addSubview(Slider)
        
        durationStack.translatesAutoresizingMaskIntoConstraints = false
        //        durationStartTrack.text = durEnd
        //        durationEndTrack.text = durStart
        self.view.addSubview(durationStack)
        durationStack.addArrangedSubview(durationStartTrack)
        durationStack.addArrangedSubview(Slider)
        durationStack.addArrangedSubview(durationEndTrack)
        
        
        
        
        
        
        
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.setImage(UIImage(systemName: "arrowshape.left"), for: .normal)
        previousButton.addTarget(self, action: #selector(previousTrackButtonTapped), for: .touchUpInside)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.addTarget(self, action: #selector(MusicPlayButtonTapped), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setImage(UIImage(systemName: "arrowshape.right"), for: .normal)
        nextButton.addTarget(self, action: #selector(NextTrackButtonTapped), for: .touchUpInside)
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(nextButton)
        self.view.addSubview(stackView)
        self.view.addSubview(volumeSlider)
        
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:0),
            //        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            musicLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            musicLabel.heightAnchor.constraint(equalToConstant: 30),
            musicLabel.widthAnchor.constraint(equalToConstant: 150),
            musicLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            Slider.heightAnchor.constraint(equalToConstant: 30),
            Slider.widthAnchor.constraint(equalToConstant: 250),
            durationStack.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            durationStack.topAnchor.constraint(equalTo: musicLabel.bottomAnchor,constant: 50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            //            stackView.heightAnchor.constraint(equalToConstant: 40),
            //            stackView.widthAnchor.constraint(equalToConstant: 200),
            //            stackView.topAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 70),
            stackView.widthAnchor.constraint(equalToConstant: 250),
            stackView.topAnchor.constraint(equalTo: Slider.bottomAnchor, constant: 60),
            volumeSlider.heightAnchor.constraint(equalToConstant: 30),
            volumeSlider.widthAnchor.constraint(equalToConstant: 250),
            volumeSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            volumeSlider.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 10),])
    }
    
    @objc func musicPlayerTimeUpdater(_ sender:Any){
        let currentTime1 = Int((audioPlayer.currentTime))
        let minutes = currentTime1/60
        let seconds = currentTime1 - minutes * 60
        var durEnd =  NSString(format: "%02d:%02d", minutes,seconds) as String
        durationStartTrack.text = durEnd
    }
    
    
    @objc func MusicPlayButtonTapped(_ sender: Any) {
        if (audioPlayer.isPlaying == true){
            audioPlayer.stop()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else{
            audioPlayer.play()
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @objc func ChangingActionTime(_ sender: UISlider) {
        audioPlayer.stop()
        audioPlayer.currentTime = TimeInterval(Slider.value)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @IBAction func MusicPauseButtonTapped(_ sender: Any) {
        audioPlayer.pause()
        print("Music Paused")
    }
    
    func MusicFiles(){
        let files = Bundle.main
        guard let music = files.path(forResource: musicName, ofType: "mp3") else {return}
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: music))
            audioPlayer.play()
            print("sound found")
        }
        catch{
            print("Sound Not found\(error.localizedDescription)")
        }
        
    }
    @objc func updateSlider(){
        sliderTime()
    }
    func sliderTime (){
        Slider.value = Float(audioPlayer.currentTime ?? 0 )
        Slider.maximumValue = Float(audioPlayer.duration)

        
        
    }
    @objc func volumeSliderChanged(_ sender: UISlider) {
        audioPlayer.volume = sender.value
    }
    func loadAudioFile() {
        let url = Bundle.main.url(forResource: audioFiles![currentIndex], withExtension: "mp3")!
        musicLabel.text = self.audioFiles![currentIndex]
        print(audioFiles![currentIndex])
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print("Could not load audio file")
        }
    }
    
    @objc func previousTrackButtonTapped(_ sender: UIButton) {
        audioPlayer.stop()
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = audioFiles!.count - 1
        }
        print(currentIndex)
        loadAudioFile()
        sliderTime()
        updateInMusicTimer()
//        sliderTime()
        
        
    }
    @objc func NextTrackButtonTapped(_ sender: UIButton) {
        audioPlayer.stop()
        currentIndex += 1
        if currentIndex >= audioFiles!.count {
            currentIndex = 0
        }
        print(currentIndex)
        loadAudioFile()
        updateInMusicTimer()
        sliderTime()
    }
    
    func updateInMusicTimer(){
        let duration = Int((audioPlayer.duration))
        let minutes2 = duration/60
        let seconds2 = duration - minutes2 * 60
        var durStart =  NSString(format: "%02d:%02d", minutes2,seconds2) as String
        print ("Hello")
        let totalTime = Int(audioPlayer.duration)
        let totalMinutes = totalTime / 60
        let totalSeconds = totalTime % 60
        durationEndTrack.text = String(format: "%d:%02d", totalMinutes, totalSeconds)
    }
    //    var musicView : UIView
    //
    //    func setup(){
    //        musicView = UIView(frame: view.bounds)
    //        musicView.backgroundColor = .brown
    //        view.addSubview(musicView)
    //    }
}

