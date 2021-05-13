//
//  GameScene.swift
//  Project11
//
//  Created by Alejandro Gleason on 12/05/21.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        // In UI Kit, the center would be x: 0, y: 0, but here, it is half of the coordinates
        background.position = CGPoint(x: 512, y: 384)
        // .replace option means "just draw it, ignoring any alpha values
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        
    }
    
    func makeBouncer(at position: CGPoint) {
        // Add the bouncer to the screen
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        // With this prop as false, the body will still collide but be fixed in place
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
        
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Retrieve the first touch from the touch event
        guard let touch = touches.first else { return }
        // Get where the touch was in the whole of the game scene
        let location = touch.location(in: self)
        
        let ball = SKSpriteNode(imageNamed: "ballRed")
        // Give the physics body a "ball" form
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        // Restitution is the bounciness!
        ball.physicsBody?.restitution = 0.4
        ball.position = location
        addChild(ball)
        
        /* Code for cubes, but we will be using images:
        // We will create a box in that location
        let box = SKSpriteNode(color: .red, size: CGSize(width: 64, height: 64))
        // Give the box a physics body that matches exactly the box thing
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
        box.position = location
        addChild(box)
         */
    }
}
