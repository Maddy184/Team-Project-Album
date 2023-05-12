//
//  AudioViewController.swift
//  Video Player
//
//  Created by Madesh on 10/04/23.
//

import UIKit
import CoreData
import AVFoundation

class AudioViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    // Insialize the Music asset and Audio Player
    
    var audioplayer = AVAudioPlayer()
    var musicone = String()
    var count = 0
    
    var tableView:UITableView = UITableView()
    
    let music = ["Adiya","Ale","All","Amma","Anbe","Anbil","Music","Anjali","Arabic-kuthu","Bgm","Ayyo","bae","bodhai","bodhai-music"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.register(UINib(nibName: "MusicCellVC", bundle: nil), forCellReuseIdentifier: "MusicCell")
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        self.view.addSubview(tableView)
        self.navigationItem.title = "Music"
        tabBarController?.tabBar.isHidden = false
        //        self.view.backgroundColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return music.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCellVC
        cell.MusicTitle.text = self.music[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let mc = MusicPlayerViewController()
        mc.musicName = music[indexPath.row]
        mc.audioFiles = music
        mc.currentIndex = indexPath.row
        self.navigationController?.pushViewController(mc, animated: true)
    }
}


