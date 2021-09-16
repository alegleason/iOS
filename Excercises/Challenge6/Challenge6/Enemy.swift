//
//  Enemy.swift
//  Challenge6
//
//  Created by Alejandro Gleason on 15/09/21.
//

import UIKit
import SpriteKit

// This class will hold the behavior for each enemy
class Enemy: SKNode {
    var charNode: SKSpriteNode!
    
    var isVisible = false
    var isHit = false
    
    func configure(at position: CGPoint, right to: Bool) {
        self.position = position
        

        if Int.random(in: 0...2) == 0 {
            charNode = SKSpriteNode(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode = SKSpriteNode(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        charNode.name = "character"
        charNode.xScale = 1.3
        charNode.yScale = 1.3
        
        addChild(charNode)
        
    }
    
    func show(hideTime: Double) {
        if isVisible { return } // if the node is already visible then quit
        
        charNode.xScale = 1
        charNode.yScale = 1

        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        /* DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) {
            [weak self] in
            self?.hide()
        } */
    }
    
    func hide() {
        if !isVisible { return }
        
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
    }
    
    func hit() {
        isHit = true
        
        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        if let mudNode = SKEmitterNode(fileNamed: "Mud") {
            mudNode.position = charNode.position
            addChild(mudNode)
        }
        let notVisible = SKAction.run { [weak self] in self?.isVisible = false }
        let sequence = SKAction.sequence([delay, hide, notVisible])
        charNode.run(sequence)
    }
}
