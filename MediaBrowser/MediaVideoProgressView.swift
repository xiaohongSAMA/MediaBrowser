//
//  MediaVideoProgressView.swift
//  MediaBrowser
//
//  Created by Red on 2021/6/29.
//  Copyright © 2021 Seungyoun Yi. All rights reserved.
//

import UIKit
import AVKit

class MediaVideoProgressView: UIView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func makeUI() {
        addSubview(playButton)
        addSubview(nowTimeLabel)
        addSubview(allTimeLabel)
        addSubview(progress)
    }
    
    func setPlayingOrPause(isPlaying: Bool) {
        playButton.isSelected = isPlaying
    }
    
    func setTime(now: CMTime, all: Float64) {
        if all < 1.0 {
            return
        }
        nowTimeLabel.text = formatPlayTime(seconds: CMTimeGetSeconds(now))
        allTimeLabel.text = formatPlayTime(seconds: all)
        let pro = CMTimeGetSeconds(now) / all
        progress.progress = Float(pro)
    }
    
    // 将秒转成时间字符串的方法
    func formatPlayTime(seconds: Float64) -> String {
        let min = Int(seconds / 60)
        let sec = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", min, sec)
    }
    
    // MARK:- UI
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "playButton_play", in: Bundle(for: MediaBrowser.self), compatibleWith: nil), for: .normal)
        button.setImage(UIImage(named: "playButton_pause", in: Bundle(for: MediaBrowser.self), compatibleWith: nil), for: .selected)
        button.frame = CGRect(x: 0, y: 10, width: 30, height: 30)
        return button
    }()
    
    lazy var nowTimeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 50, y: 0, width: 60, height: 50)
        label.text = "00:00"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var allTimeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: UIScreen.main.bounds.size.width - 15 - 60, y: 0, width: 60, height: 50)
        label.text = "00:00"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var progress: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.frame = CGRect(x: 105, y: 23, width: UIScreen.main.bounds.size.width - 30 - 105 - 65, height: 50)
        progress.trackTintColor = UIColor(white: 1, alpha: 0.5)
        progress.progressTintColor = .white
        progress.progress = 0
        return progress
    }()
}
