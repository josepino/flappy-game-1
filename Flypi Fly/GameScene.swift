//
//  GameScene.swift
//  Flypi Fly
//
//  Created by Jose Pino on 19/9/17.
//  Copyright © 2017 Jose Pino. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var mosca = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        
        let texturaMosca = SKTexture(imageNamed: "fly1.png")
        mosca = SKSpriteNode(texture: texturaMosca)
        mosca.position = CGPoint(x:0.0, y:0.0)
        
        self.addChild(mosca)
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    
    override func update(_ currentTime: TimeInterval) {

    }
}
