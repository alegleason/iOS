//
//  GameScene.swift
//  Project11
//
//  Created by Alejandro Gleason on 12/05/21.
//

import SpriteKit

// To detect collisions, we need to first conform to the SKPhysicsContactDelegate protocol
class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreLabel: SKLabelNode!

    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!
    
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    let ballNames = ["ballBlue", "ballCyan", "ballGreen", "ballPurple", "ballRed", "ballYellow"]
    
    var availableBalls = 5
        
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        // In UI Kit, the center would be x: 0, y: 0, but here, it is half of the coordinates
        background.position = CGPoint(x: 512, y: 384)
        // .replace option means "just draw it, ignoring any alpha values
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Avenir Black")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        editLabel = SKLabelNode(fontNamed: "Avenir Black")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        // Assign the contact delegate to our game frame
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
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
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotGlow.position = position
        slotBase.position = position
        
        // Adding a physics body to the slot base
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        // Rotate angle by pi (halve a circle), 10 seconds and make it run forever
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        // Assign the action with run method
        slotGlow.run(spinForever)
    }
    
    // Method to know who is colliding with who (the order)
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
            availableBalls += 1
            return
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
            return
        }
        
        // Remove obstacles that are not balls
        if object.name != "ball" {
            object.removeFromParent()
        }
    }
    
    // SKNode is the parent class of the SpriteKitNode
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // We will try to retrieve the node first to avoid "ghost" collisions
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        
        // If the first body is the ball, then we call collision between the ball and anything else
        if contact.bodyA.node?.name == "ball" {
            collision(between: nodeA, object: nodeB)
        // Else, call the method backwards
        } else if contact.bodyB.node?.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Retrieve the first touch from the touch event
        guard let touch = touches.first else { return }
        // Get where the touch was in the whole of the game scene
        var location = touch.location(in: self)
        // What nodes exist at this location?
        let objects = nodes(at: location)
        
        if objects.contains(editLabel) {
            editingMode.toggle() // This method flips the value of a boolean
        } else {
            if editingMode {
                // create a box
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                // Rotating a random number of radians (between 0 and 3), which means around 180 degrees
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                addChild(box)
            } else {
                if availableBalls > 0 {
                    let ball = SKSpriteNode(imageNamed: ballNames.randomElement()!)
                    // Give the physics body a "ball" form
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                    // Restitution is the bounciness!
                    ball.physicsBody?.restitution = 0.4
                    /*
                     collisionBitMask: tells us which nodes should I bump into, by default it is set to everything
                     contactTestBitMask: tells which collisions we want to worry about, by default is set to nothing
                     the nil coalesing is needed because we might not have a physics body
                     */
                    ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                    // Force the position to be at the top of the screen
                    if location.y < 700 {
                        location.y = 700
                    }
                    ball.position = location
                    ball.name = "ball"
                    addChild(ball)
                    availableBalls -= 1
                }
            }
        }
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
