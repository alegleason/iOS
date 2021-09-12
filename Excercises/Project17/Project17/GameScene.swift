//
//  GameScene.swift
//  Project17
//
//  Created by Alejandro Gleason on 11/09/21.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    var possibleEnemies = ["ball", "hammer", "tv"]
    var gameTimer: Timer?
    var isGameOver = false
    var enemies = 0
    var enemyTime = 0.5
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        // Prefill our screen
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size) // this creates a phyisics body "drawn" around the texture of the player
        player.physicsBody?.contactTestBitMask = 1 // 1 will match the category bit mask of the objects we want to collide with
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        
        physicsWorld.gravity = .zero // no gravity
        physicsWorld.contactDelegate = self // tell us when contact happens
        
        gameTimer = Timer.scheduledTimer(timeInterval: enemyTime, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
    }
    
    @objc func createEnemy() {
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0) // pushing the object to the left
        sprite.physicsBody?.angularVelocity = 5 // make the object spin
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
        
        enemies += 1
    }
    
    override func update(_ currentTime: TimeInterval) {
        // called before each frame is rendered
        for node in children {
            // object is off screen
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        
        if !isGameOver {
            score += 1
        } else {
            gameTimer?.invalidate()
        }
        
        if enemies >= 20 {
            enemyTime -= 0.1
            enemies = 0
            // make the game harder
            gameTimer?.invalidate()
            gameTimer = Timer.scheduledTimer(timeInterval: enemyTime, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        }
        
    }
    
    // method called whenever touches are performed
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        
        // avoid the player to touch elsewhere from the ship
        if (location.x > player.position.x + player.size.width || location.x < player.position.x - player.size.width) && (location.y > player.position.y + player.size.height || location.y < player.position.y - player.size.height) {
            return
        }
        
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
        
        player.position = location
    }
    
    // method called whenever collisions begin
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)

        player.removeFromParent()

        isGameOver = true
    }
}
