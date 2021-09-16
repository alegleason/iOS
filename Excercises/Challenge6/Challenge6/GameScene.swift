//
//  GameScene.swift
//  Challenge6
//
//  Created by Alejandro Gleason on 15/09/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var scoreLabel: SKLabelNode!
    var timeLabel: SKLabelNode!
    var reloadNode: SKSpriteNode!
    var isGameOver = false
    var ammo = 6
    var timer: Timer?
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var time = 60 {
        didSet {
            timeLabel.text = "Time left: \(time)"
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "shelfBg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        background.size.height = self.size.height
        background.size.width = self.size.width
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 992, y: 726)
        scoreLabel.horizontalAlignmentMode = .right
        addChild(scoreLabel)
        
        timeLabel = SKLabelNode(fontNamed: "Chalkduster")
        timeLabel.position = CGPoint(x: 992, y: 680)
        timeLabel.horizontalAlignmentMode = .right
        timeLabel.text = "Time left: \(time)"
        addChild(timeLabel)
        
        score = 0
        
        reloadNode = SKSpriteNode(imageNamed: "reload")
        reloadNode.position = CGPoint(x: 64, y: 704)
        reloadNode.xScale = 0.7
        reloadNode.yScale = 0.7
        addChild(reloadNode)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        for i in 0..<5 { createEnemy(at: CGPoint(x: 112 + (i * 192), y: 130), to: false)}
        for i in 0..<5 { createEnemy(at: CGPoint(x: 112 + (i * 192), y: 376)) }
        for i in 0..<5 { createEnemy(at: CGPoint(x: 112 + (i * 192), y: 620)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    @objc
    func updateTimer() {
        if time > 0 {
            time -= 1
        } else {
            // Finish game
            isGameOver = true
            let ac = UIAlertController(title: "GAME OVER", message: nil, preferredStyle: .alert)
            let reloadAction = UIAlertAction(title: "Restart", style: .default) {
                [weak self, weak ac] _ in
                self?.reloadGame(ac!)
            }
            ac.addAction(reloadAction)
            view?.window?.rootViewController?.present(ac, animated: true)
        }
    }
    
    func reloadGame(_ ac: UIAlertController) {
        ac.dismiss(animated: true, completion: nil)

        isGameOver = false
        
        time = 60
        
        timer?.invalidate()
    }
    
    func createEnemy(at position: CGPoint, right to: Bool) {
        let enemy = Enemy()
        enemy.configure(at: position, right: to)
        addChild(enemy)
    }
    
}
