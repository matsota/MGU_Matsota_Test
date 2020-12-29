//
//  EntrypointViewController.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import UIKit
import AVFoundation

class EntrypointViewController: UIViewController, Loadable {

    override func viewDidLoad() {
        super.viewDidLoad()
        appearanceAnimation()
    }

    //MARK: - Private Implementation
    private var audioPlayer = AVAudioPlayer()
    
    /// - `ImageView`
    @IBOutlet private weak var imageView: UIImageView!
}









//MARK: - Private Methods
private extension EntrypointViewController {
    
    func temporaryView() -> UIImageView {
        let imageFrame = imageView.frame
        let imagePosition = imageView.convert(imageView.bounds.origin,
                                              to: self.view)
        
        let temporaryView = UIImageView()
        view.addSubview(temporaryView)
        temporaryView.frame = CGRect(x: imagePosition.x,
                                     y: imagePosition.y,
                                     width: imageFrame.size.width,
                                     height: imageFrame.size.height)
        temporaryView.rounding().image = imageView.image
        return temporaryView
    }
    
    func appearanceAnimation() {
        let temporaryView = self.temporaryView()
        let rollTime = TimeInterval(0.75)
        UIView.animate(withDuration: rollTime) {
            temporaryView.animationRoted(angle: CGFloat(Double.pi))
            temporaryView.frame.origin.x = self.view.bounds.width / 4 - temporaryView.bounds.width / 2
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + rollTime / 2) {
            UIView.animate(withDuration: rollTime) {
                temporaryView.animationRoted(angle: CGFloat(Double.pi))
                temporaryView.frame.origin.x = self.view.bounds.width / 2 - temporaryView.bounds.width / 2
            } completion: { (_) in
                self.kissAnimation(temporaryView)
            }
        }
    }
    
    func kissAnimation(_ temporaryView: UIImageView) {
        let rollTime = TimeInterval(0.25)
        playSaveSound()
        UIView.animate(withDuration: rollTime) {
            self.tranform(temporaryView, 1.05, Double.pi / 2)
        } completion: { (_) in
            UIView.animate(withDuration: rollTime + 0.05) {
                self.tranform(temporaryView, 0.9, 3 * Double.pi / 2)
            } completion: { (_) in
                UIView.animate(withDuration: rollTime - 0.05) {
                    self.tranform(temporaryView, 1.1, Double.pi / 2)
                } completion: { (_) in
                    UIView.animate(withDuration: rollTime ) {
                        self.tranform(temporaryView, 0.95, 3 * Double.pi / 2)
                    } completion: { (_) in
                        UIView.animate(withDuration: rollTime) {
                            self.tranform(temporaryView, 1.125, Double.pi / 2)
                        } completion: { (_) in
                            UIView.animate(withDuration: rollTime) {
                                self.tranform(temporaryView, 0.925, 3 * Double.pi / 2)
                            } completion: { (_) in
                                UIView.animate(withDuration: rollTime) {
                                    self.tranform(temporaryView, 1.1, Double.pi / 2)
                                } completion: { (_) in
                                    UIView.animate(withDuration: rollTime) {
                                        self.tranform(temporaryView, 0.9, 3 * Double.pi / 4)
                                    } completion: { (_) in
                                        UIView.animate(withDuration: rollTime + 0.1) {
                                            self.tranform(temporaryView, 1.3, 2 * Double.pi)
                                        } completion: { (_) in
                                            UIView.animate(withDuration: rollTime) {
                                                self.tranform(temporaryView, 1, 2 * Double.pi)
                                            } completion: { (_) in
                                                self.disAppearanceAnimation(temporaryView)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func tranform(_ temporaryView: UIImageView, _ scale: CGFloat, _ rotate: Double) {
        temporaryView.animationZoom(scaleX: scale, y: scale)
        temporaryView.animationRoted(angle: CGFloat(rotate))
    }
    
    func disAppearanceAnimation(_ temporaryView: UIImageView) {
        UIView.animate(withDuration: 1) {
            temporaryView.animationRoted(angle: CGFloat(Double.pi))
            temporaryView.frame.origin.x = self.view.bounds.width
        } completion: { (_) in
            self.enterApp()
        }
    }
    
    func enterApp() {
        UIRouter.instance.enter()
    }
    
    func playSaveSound(){
        guard let path = Bundle.main.path(forResource: "oll-tv-enter-sound", ofType: "mp3") else {return}
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            print("couldn't load the file")
        }
    }
    
    
}

