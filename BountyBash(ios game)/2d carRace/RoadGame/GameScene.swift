//
//  GameScene.swift
//  RoadGame
//
//  Created by uics7 on 4/8/15.
//  Copyright (c) 2015 uics7. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
      // music player
    var superPowerTimer = NSTimer()
    var superPower:Bool = false
    
    
    var backgroundMusicPlayer:AVAudioPlayer = AVAudioPlayer()
    var explosionMusicPlayer : AVAudioPlayer = AVAudioPlayer()
    var tingMusicPlayer : AVAudioPlayer = AVAudioPlayer()
    var music = true
   
    var player: Player!
    var gameOver = false
    var gameover:SKLabelNode = SKLabelNode(fontNamed: "Calibari")
   
    // sk nodes
    
    let fireParticles = SKEmitterNode(fileNamed: "MyParticle.sks")
    let coinParticles = SKEmitterNode(fileNamed: "coinParticle.sks")
    let car = SKSpriteNode(imageNamed: "car.png")
    

    
    var lastYieldTimeIntervalCar:NSTimeInterval = NSTimeInterval()
    var lastUpdateTimeIntervalCar:NSTimeInterval = NSTimeInterval()
    
    var lastYieldTimeIntervalCoin:NSTimeInterval = NSTimeInterval()
    var lastUpdateTimeIntervalCoin:NSTimeInterval = NSTimeInterval()
    
    var lastYieldTimeIntervalStar:NSTimeInterval = NSTimeInterval()
    var lastUpdateTimeIntervalStar:NSTimeInterval = NSTimeInterval()
    
    // play play buttons
    
    let pause = SKSpriteNode(imageNamed: "pause.png")
    let play = SKSpriteNode(imageNamed: "play.png")
    let Mpause = SKSpriteNode(imageNamed: "nomusic.png")
    let Mplay = SKSpriteNode(imageNamed: "music.png")
    
    
    var enemy : NSMutableArray = NSMutableArray()

    
    //countdowns and scores
    var score = 0
    var highscore = 0
    var scoreLabel = SKLabelNode()
    var scoreDisplay = SKLabelNode()
    var highscoreLabel = SKLabelNode()
    var reload = SKSpriteNode (imageNamed: "reload.png")
    var timer = NSTimer()
    var timer2 = NSTimer()
    var countDownText = SKLabelNode()
    var countDown = 5
    var label:SKLabelNode = SKLabelNode(fontNamed: "Calibari")
    var exit = SKSpriteNode(imageNamed: "exit.jpg")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
       
        // add bg
        self.addbg()
        //add score label
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel.fontName = "CalibariBold"
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.position = CGPointMake(self.frame.size.width/2 - 150, self.frame.size.height/2 + 300)
        addChild(scoreLabel)
        
        //score Display
        scoreDisplay.fontName = "CalibariBold"
        scoreDisplay.fontColor = SKColor.whiteColor()
        scoreDisplay.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 10)
        scoreDisplay.hidden = true
        addChild(scoreDisplay)
        
        //reload button
        reload.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 100)
        addChild(reload)
        reload.name = "reload"
        reload.hidden = true
        
        // add countDown
        countDownText = SKLabelNode(text: "5")
        countDownText.fontName = "CalibariBold"
        countDownText.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 80)
        addChild(countDownText)
        countDownText.hidden = true
        
        //game over label
        
        gameover.text = "Game Over!!"
        gameover.fontColor = SKColor.whiteColor()
        gameover.fontSize = 40
        gameover.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 180)
        gameover.hidden = true
        self.addChild(gameover)
        
        // HighScorelabel
        highscoreLabel.fontName = "CalibariBold"
        highscoreLabel.fontColor = SKColor.whiteColor()
        highscoreLabel.fontSize = 30
        highscoreLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 30)
        highscoreLabel.hidden = true
        addChild(highscoreLabel)
        
        // exit game
        
        exit.position = CGPointMake(self.frame.size.width/2 , self.frame.size.height/2 - 160)
        exit.name = "exit"
        exit.hidden = true
        addChild(exit)
        
        
        if (countDown == 5){
            // adding left right button
            self.addbutton()
            
            //add player to the view
            self.addPlayer()
            self.playMusic()
          
        }
    }
    

   
    
    func addbutton(){
        //play pause for game

        pause.name = "pauseButton"
        pause.position = CGPointMake(self.frame.size.width/2 + 140, self.frame.size.height/2 + 300)
         self.addChild(pause)
        
        
        play.name = "playButton"
        play.position = CGPointMake(self.frame.size.width/2 + 140, self.frame.size.height/2 + 300)
       
        //play pause for music

        Mpause.name = "MpauseButton"
        Mpause.position = CGPointMake(self.frame.size.width/2 + 140, self.frame.size.height/2 + 235)
        self.addChild(Mpause)

        Mplay.name = "MplayButton"
        Mplay.position = CGPointMake(self.frame.size.width/2 + 140, self.frame.size.height/2 + 235)
        
        
      }
    
    // collision detection collider type
    
    enum ColliderType : UInt32 {
        case car = 1
        case enemy = 8
        case bounty1 = 16
        case bounty2 = 32
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        //touch the coin and hide it
        coinParticles.hidden = true
        // colliison with enemy
        if (contact.bodyA.categoryBitMask == ColliderType.enemy.rawValue) {
            
            
            if(self.superPower){
            
            }
            else{
                            self.view?.paused = true
                if (music == true){
                    println("in the music true")
                            explosionMusic()
                }
                        fireParticles.hidden = false
            
                        let fadeandblink = SKAction.group([SKAction.fadeOutWithDuration(0.2)])
                        let fadein = SKAction.group([SKAction.fadeInWithDuration(0.2)])
                        car.runAction(SKAction.sequence([fadeandblink , fadein]))
                        gameOver = true
                        backgroundMusicPlayer.pause()
                        gameover.hidden = false
                        exit.hidden = false
                        reload.hidden = false
                        scoreDisplay.hidden = false
                        scoreDisplay.text = "Your Score : " + String(score)
                        scoreLabel.hidden = true
                        storeScores()
                        highscoreLabel.hidden = false
                
                        label.hidden = false
            print("IT WORKS")
            }
            
            
        }
        
        if (contact.bodyB.categoryBitMask == ColliderType.enemy.rawValue) {
            
            
            if(self.superPower){
                
            }
            else{
            self.view?.paused = true
            if (music == true){
            explosionMusic()
            }
            fireParticles.hidden = false
            
            let fadeandblink = SKAction.group([SKAction.fadeOutWithDuration(0.2)])
            let fadein = SKAction.group([SKAction.fadeInWithDuration(0.2)])
            car.runAction(SKAction.sequence([fadeandblink , fadein]))
            gameOver = true
            gameover.hidden = false
            exit.hidden = false
            reload.hidden = false
            scoreDisplay.hidden = false
            scoreDisplay.text = "Your Score : " + String(score)
            scoreLabel.hidden = true
            highscoreLabel.hidden = false
            storeScores()
            label.hidden = false

            print("It Works too")
            }
        }
        
        // colliison with coin
        
        if (contact.bodyA.categoryBitMask == ColliderType.bounty1.rawValue) {
            println("bounty collided")
            if(music == true){
            tingMusic()
            }
            coinParticles.hidden = false
            contact.bodyA.node?.removeFromParent()
            score = score + 10
            self.runAction(SKAction.waitForDuration(0.5), completion: { self.coinParticles.hidden = true })
            
        }
        
        if (contact.bodyB.categoryBitMask == ColliderType.bounty1.rawValue) {
            if(music == true){
                tingMusic()
            }

             coinParticles.hidden = false
             contact.bodyB.node?.removeFromParent()
            score = score + 10

            self.runAction(SKAction.waitForDuration(0.5), completion: { self.coinParticles.hidden = true })

        }
        
        // collision with star
        
        if (contact.bodyA.categoryBitMask == ColliderType.bounty2.rawValue) {
            println("bounty collided")
            
            coinParticles.hidden = false
            contact.bodyA.node?.removeFromParent()
            score = score + 25

            self.superPower = true
            
            
            var fadeandblink = SKAction.group([SKAction.fadeOutWithDuration(0.2)])
            var fadein = SKAction.group([SKAction.fadeInWithDuration(0.2)])
            
            
            
            var carLoop = SKAction.repeatAction(SKAction.sequence([fadeandblink , fadein]),count:25)
            
            
            
            
            car.runAction(carLoop)
            
            
            superPowerTimer.invalidate()
            superPowerTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "superPowerTimerFinished:", userInfo: nil, repeats: false)
                print("Star captured")
            
            
            
        }
        
        if (contact.bodyB.categoryBitMask == ColliderType.bounty2.rawValue) {
            coinParticles.hidden = false
            contact.bodyB.node?.removeFromParent()
            score = score + 25
            
            self.superPower = true
            
            
            var fadeandblink = SKAction.group([SKAction.fadeOutWithDuration(0.2)])
            var fadein = SKAction.group([SKAction.fadeInWithDuration(0.2)])
            
           
            
            var carLoop = SKAction.repeatAction(SKAction.sequence([fadeandblink , fadein]),count:25)
            
            
          
            car.runAction(carLoop)
           
            superPowerTimer.invalidate()
            superPowerTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "superPowerTimerFinished:", userInfo: nil, repeats: false)
            print("Star captured")
            
        }
        

}
    
    




    
    func addPlayer(){
        
        
        car.position = CGPointMake(self.frame.size.width/2, car.size.height/2 + 40)
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        car.physicsBody = SKPhysicsBody(rectangleOfSize: car.size)
        car.physicsBody!.categoryBitMask = 0
        car.physicsBody!.contactTestBitMask = ColliderType.enemy.rawValue
        car.physicsBody?.collisionBitMask = 0 //ColliderType.enemy.rawValue
        car.physicsBody?.contactTestBitMask = ColliderType.enemy.rawValue | ColliderType.bounty1.rawValue | ColliderType.bounty2.rawValue
        
        //emitting effect
        
        fireParticles.hidden = true
        coinParticles.hidden = true
        
        
        player = Player(player: car, particles: fireParticles)
        player = Player(player: car, particles: coinParticles)
        car.addChild(fireParticles)
        car.addChild(coinParticles)
        
        self.addChild(car)
    }
    
    
    func addBounty(){
        
        var bounty1 = SKSpriteNode(imageNamed: "bounty1.png")
        
        // Create enemy sprite
                bounty1.frame
        bounty1.physicsBody = SKPhysicsBody(rectangleOfSize: bounty1.size)
        bounty1.physicsBody?.dynamic = true
        bounty1.physicsBody?.collisionBitMask = 0
        bounty1.physicsBody!.categoryBitMask = ColliderType.bounty1.rawValue
        bounty1.physicsBody?.contactTestBitMask = ColliderType.car.rawValue
        
        
        // Where to create enemies along the x-axis
        let minX = bounty1.size.width/2 + 45
        let maxX = self.frame.size.width - 45 - bounty1.size.width/2
        let rangeX = maxX - minX
        let position:CGFloat = CGFloat(Int(arc4random_uniform(UInt32(UInt(rangeX ))))) + minX
        
        // Bring Enemies of screen
        bounty1.position = CGPointMake(position, self.frame.size.height+bounty1.size.height)
        
        self.addChild(bounty1)
        
        
        // enemy Animation Duration
        
        let minDuration = 2
        let maxDurcation = 4
        let rangeDuration = maxDurcation - minDuration
        
        let duration = (Int(arc4random()) % Int(rangeDuration)) + Int(minDuration)
        
        
        
        // Create actions to animate
        
        var actionArray:NSMutableArray = NSMutableArray()
        
        actionArray.addObject(SKAction.moveTo(CGPointMake(position, -bounty1.size.height), duration: NSTimeInterval(duration)))
        actionArray.addObject((SKAction.runBlock({
          //  var transition:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
            
            //var gameOverScene:SKScene = GameOverScene(size: self.size, won: false)
            //self.view.presentScene(gameOverScene, transition: transition)
        })))
        
        actionArray.addObject(SKAction.removeFromParent())
        
        bounty1.runAction(SKAction.sequence(actionArray as [AnyObject]))
        
        
    }
    func addBounty2(){
        
        var bounty2 = SKSpriteNode(imageNamed: "starbounty.png")
        
        // Create star sprite
        bounty2.frame
        bounty2.physicsBody = SKPhysicsBody(rectangleOfSize: bounty2.size)
        bounty2.physicsBody?.dynamic = true
        
        bounty2.physicsBody?.collisionBitMask = 0
        bounty2.physicsBody!.categoryBitMask = ColliderType.bounty2.rawValue
        bounty2.physicsBody?.contactTestBitMask = ColliderType.car.rawValue
        
        
        // Where to create star along the x-axis
        let minX = bounty2.size.width/2 - 30 //bounty2.size.width/2 + 15
        let maxX = self.frame.size.width + 30 - bounty2.size.width/2
        let rangeX = maxX - minX
        let position:CGFloat = CGFloat(Int(arc4random_uniform(UInt32(UInt(rangeX ))))) + minX
        
        // Bring Enemies of screen
        bounty2.position = CGPointMake(position, self.frame.size.height+bounty2.size.height)
        
        self.addChild(bounty2)
        
        // enemy Animation Duration
        
        let minDuration = 2
        let maxDurcation = 4
        let rangeDuration = maxDurcation - minDuration
        
        let duration = (Int(arc4random()) % Int(rangeDuration)) + Int(minDuration)
        
        
        
        // Create actions to animate
        
        var actionArray:NSMutableArray = NSMutableArray()
        
        actionArray.addObject(SKAction.moveTo(CGPointMake(position, -bounty2.size.height), duration: NSTimeInterval(duration)))
        actionArray.addObject((SKAction.runBlock({
            //  var transition:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
            
            //var gameOverScene:SKScene = GameOverScene(size: self.size, won: false)
            //self.view.presentScene(gameOverScene, transition: transition)
        })))
        
        actionArray.addObject(SKAction.removeFromParent())
        
        bounty2.runAction(SKAction.sequence(actionArray as [AnyObject]))
        
        
    }
    
    // rotating background
    
     func addbg(){
        
        
        var backgroundTexture = SKTexture(imageNamed: "bg14.png")
        
        
        var shiftBackground = SKAction.moveToY(-self.frame.size.height, duration: 9)
        var replaceBackground = SKAction.moveToY(self.frame.size.height, duration: 0)
        var movingAndReplacingBackground = SKAction.repeatActionForever(SKAction.sequence([shiftBackground,replaceBackground]))
        
        
        
        let background=SKSpriteNode(texture:backgroundTexture)
        background.size = CGSizeMake(self.frame.size.width, backgroundTexture.size().height + self.frame.size.height)
        background.position = CGPointMake(self.frame.size.width/2,self.frame.size.height )
        background.runAction(movingAndReplacingBackground)
        addChild(background)
            
      
    }

    
    func addEnemy(){
        
        // Create enemy sprite
        var enemy:SKSpriteNode = SKSpriteNode(imageNamed: "ememy.png")
        enemy.frame
        enemy.physicsBody = SKPhysicsBody(rectangleOfSize: enemy.size)
        enemy.physicsBody?.dynamic = true
        enemy.physicsBody?.collisionBitMask =  0 //ColliderType.car.rawValue
        enemy.physicsBody!.categoryBitMask = ColliderType.enemy.rawValue
        enemy.physicsBody?.contactTestBitMask = ColliderType.car.rawValue
        
        
        // Where to create enemies along the x-axis
        let minX = enemy.size.width/2 + 45 //enemy.size.width/2 + 15
        let maxX = self.frame.size.width - 45 - enemy.size.width/2
        let rangeX = maxX - minX
        let position:CGFloat = CGFloat(Int(arc4random_uniform(UInt32(UInt(rangeX ))))) + minX
        
        // Bring Enemies of screen
        enemy.position = CGPointMake(position, self.frame.size.height+enemy.size.height)
        
        self.addChild(enemy)
        
        // enemy Animation Duration
        
        let minDuration = 2
        let maxDurcation = 6
        let rangeDuration = maxDurcation - minDuration
        let duration = (Int(arc4random()) % Int(rangeDuration)) + Int(minDuration)
         updateScore()
        
        // Create actions to animate
        
        var actionArray:NSMutableArray = NSMutableArray()
        
        actionArray.addObject(SKAction.moveTo(CGPointMake(position, -enemy.size.height), duration: NSTimeInterval(duration)))
        actionArray.addObject((SKAction.runBlock({
            var transition:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
            
        })))
        
        actionArray.addObject(SKAction.removeFromParent())
        
        enemy.runAction(SKAction.sequence(actionArray as [AnyObject]))
        
        
    }
    
    func reloadGame(){
        println("reloading")
        self.view?.paused = false
        
        reload.hidden = true
        countDownText.hidden = false
        backgroundMusicPlayer.pause()
        let gamescene = GameScene(size : size)
        gamescene.scaleMode = scaleMode
        let transitionType = SKTransition.flipHorizontalWithDuration(0.2)
        view?.presentScene(gamescene, transition: transitionType)
        println("in the home scene")
         timer = NSTimer.scheduledTimerWithTimeInterval( 1,target : self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        

        }
    
    func exitGame() {
        println("exit press")
        self.view?.paused = false
        backgroundMusicPlayer.pause()
        let gamescene = homeScene(size : size)
        gamescene.scaleMode = scaleMode
        let transitionType = SKTransition.flipHorizontalWithDuration(0.3)
        view?.presentScene(gamescene, transition: transitionType)
        println("in the home scene")
        

    }
    
    func updateTimer(){
        
        if countDown > 0 {
            countDown--
            countDownText.text = String(countDown)
        }
        else{
            countDown = 5
            countDownText.text = String(countDown)
            countDownText.hidden = true
            timer.invalidate()
            
            
        }
        
    }
    // controlling movement of car and bounties
    
    func updateWithTimeSinceLastUpdateCar(timeSinceLastUpdate:CFTimeInterval){
        lastYieldTimeIntervalCar += timeSinceLastUpdate
        if (lastYieldTimeIntervalCar > 1.0){
            lastYieldTimeIntervalCar = 0
            self.addEnemy()
            
        }
    
        
    }
    
    
    func updateWithTimeSinceLastUpdateCoin(timeSinceLastUpdate:CFTimeInterval){
        lastYieldTimeIntervalCoin += timeSinceLastUpdate
        if (lastYieldTimeIntervalCoin > 1){
            lastYieldTimeIntervalCoin = 0
            
            self.addBounty()
        }
        
        
    }
    
    
    func updateWithTimeSinceLastUpdateStar(timeSinceLastUpdate:CFTimeInterval){
        lastYieldTimeIntervalStar += timeSinceLastUpdate
        if (lastYieldTimeIntervalStar > 15){
            lastYieldTimeIntervalStar = 0
            
            self.addBounty2()
        }
        
        
    }
    
    
    
    
    override func update(currentTime: CFTimeInterval) {
        car.physicsBody!.linearDamping = 15.0
        car.physicsBody!.angularDamping = 15.0
        
        //controling the movement of car through touch and hold
        if let touch = lastTouch {
           
            car.physicsBody?.applyImpulse(CGVectorMake((touch.x - car.position.x + 30) - 30, 0))
        }
        else if !car.physicsBody!.resting {
            car.physicsBody?.applyImpulse(CGVector(dx: car.physicsBody!.velocity.dx * -0.5, dy: 0))
        }
     
        var timeSinceLastUpdateCar = currentTime - lastUpdateTimeIntervalCar
        lastUpdateTimeIntervalCar = currentTime
        
        var timeSinceLastUpdateCoin = currentTime - lastUpdateTimeIntervalCoin
        lastUpdateTimeIntervalCoin = currentTime
        
        var timeSinceLastUpdateStar = currentTime - lastUpdateTimeIntervalStar
        lastUpdateTimeIntervalStar = currentTime
        
        if (timeSinceLastUpdateCar > 1.5){// More than a second since last update
            timeSinceLastUpdateCar = 1/60
            lastUpdateTimeIntervalCar = currentTime
            
        }
        
        if (timeSinceLastUpdateStar > 15){// More than a second since last update
            timeSinceLastUpdateStar = 1/60
            lastUpdateTimeIntervalStar = currentTime
            
        }
        
        if (timeSinceLastUpdateCoin > 1){// More than a second since last update
            timeSinceLastUpdateCoin = 1/60
            lastUpdateTimeIntervalCoin = currentTime
            
        }
        self.updateWithTimeSinceLastUpdateCar(timeSinceLastUpdateCar)
        self.updateWithTimeSinceLastUpdateCoin(timeSinceLastUpdateCoin)
        self.updateWithTimeSinceLastUpdateStar(timeSinceLastUpdateStar)
        
    }
    
    func pauseGame(){
        
        
        self.view?.paused = true
        
        
    }
    
    
    
    
    
    func playMusic() {
        
        var bgMusicURL:NSURL = NSBundle.mainBundle().URLForResource("bgmusic", withExtension: "mp3")!
        backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL, error: nil)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    }
    
    func explosionMusic() {
        
        var bgMusicURL:NSURL = NSBundle.mainBundle().URLForResource("boom", withExtension: "m4a")!
        explosionMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL, error: nil)
        //backgroundMusicPlayer.numberOfLoops = 0
        explosionMusicPlayer.prepareToPlay()
        explosionMusicPlayer.play()
        
        
    }
    
    func tingMusic() {
        
        var bgMusicURL:NSURL = NSBundle.mainBundle().URLForResource("clink_sound", withExtension: "mp3")!
        tingMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL, error: nil)
        //backgroundMusicPlayer.numberOfLoops = 0
        tingMusicPlayer.prepareToPlay()
        tingMusicPlayer.play()
        
        
    }
    
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: (UIEvent!)) {
        
        var touch : UITouch
        
        
        for touch: AnyObject in touches {
        
         let location :CGPoint = touch.locationInNode(self)
            lastTouch = location
    }
    }

    override func touchesEnded(touches: Set<NSObject> , withEvent event: UIEvent) {
        lastTouch = nil
        car.physicsBody?.velocity = CGVectorMake(0, 0)
    }
    
    // cartouch movement
    var lastTouch: CGPoint? = nil
  
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    
        
        /* Called when a touch begins */
        
        var touch : UITouch
       
        
        for touch: AnyObject in touches {
            if gameOver {
          
    
                self.view?.paused = true
                let location :CGPoint = touch.locationInNode(self)
                lastTouch = location
                var sprites = nodesAtPoint(location)
                for sprite in sprites {
                    if let spritenode = sprite as? SKSpriteNode{
                        if spritenode.name != nil {
                            if spritenode.name == "reload"{
                                reloadGame()
                            }
                            
                            if (spritenode.name == "exit"){
                                
                                exitGame()
                            
                            }

                        }
                    }
                }
            }
            let location :CGPoint = touch.locationInNode(self)
            let node : SKNode = self.nodeAtPoint(location)
            
            if (node.name == "pauseButton"){
                println("pause pressed")
                pause.removeFromParent()
                addChild(play)
                self.runAction(SKAction.runBlock(self.pauseGame))
                
                
            }
            
            if (node.name == "playButton") {
                play.removeFromParent()
                self.view?.paused = false
                addChild(pause)
                
            }
            
            if (node.name == "MpauseButton"){
                println("music pause pressed")
                music = false
                backgroundMusicPlayer.pause()
                Mpause.removeFromParent()
                addChild(Mplay)
                
                
            }
            
            if (node.name == "MplayButton") {
                Mplay.removeFromParent()
                music = true
                self.runAction(SKAction.runBlock(self.playMusic))
                addChild(Mpause)
                
            }
            
            
        }
    }
    
    func updateScore(){
        score++
        scoreLabel.text = String(score)
    }
    
    func superPowerTimerFinished(timer: NSTimer) {
        
        self.superPower = false
        print("Its been 10 seconds")
        
    }
    
    func blinkCarTimer(n: Int){
        
        if(n == 0){
        
            let fadeandblink = SKAction.group([SKAction.fadeOutWithDuration(0.2)])
            let fadein = SKAction.group([SKAction.fadeInWithDuration(0.2)])
            car.runAction(SKAction.sequence([fadeandblink , fadein]))
        
        }
        

        
        print("Blink Car")
    }
    
    func blinkCar(){
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "superPowerTimerFinished:", userInfo: nil, repeats: false)
    }
    
// Saving high scores in NSUserdefaults
    
    func storeScores(){
         var defaults=NSUserDefaults.standardUserDefaults()
        
       
       
            highscore = defaults.integerForKey("highscore")
            print(score)
            print(highscore)
            if(score > highscore)
            {
        
                self.view?.paused = false
                defaults.setInteger(score, forKey: "highscore")
                defaults.synchronize()
                let gamescene = highestScore(size : size)
                gamescene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(0.3)
                view?.presentScene(gamescene, transition: transitionType)
                println("in the home scene")

            }
            else{
                highscoreLabel.text = "Highest Score " + String(highscore)
            }
        
  }
}

