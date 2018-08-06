/**
 * Copyright IBM Corporation 2017, 2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import UIKit

class ProgressBar: UIView {
    private var innerProgress: CGFloat = 0.0
    var progress: CGFloat {
        set (newProgress) {
            if newProgress > 1.0 {
                innerProgress = 1.0
            } else if newProgress < 0.0 {
                innerProgress = 0
            } else {
                innerProgress = newProgress
            }
            setNeedsDisplay()
        }
        get {
            return max(innerProgress * bounds.width, bounds.height)
        }
    }
    
    override func draw(_ rect: CGRect) {
        drawProgressBar(frame: bounds, progress: progress)
    }
    
    func drawProgressBar(frame: CGRect = CGRect(x: 0, y: 1, width: 288, height: 12), progress: CGFloat = 274) {
        // Color Declarations
        let green = UIColor(red: 100/255, green: 221/255, blue: 23/255, alpha: 1.0)
        let yellow = UIColor(red: 255/255, green: 171/255, blue: 0/255, alpha: 1.0)
        let red = UIColor(red: 244/255, green: 67/255, blue: 54/255, alpha: 1.0)
        
        let progressOutlinePath = UIBezierPath(roundedRect: CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height), cornerRadius: frame.height / 2)
        if progress / bounds.width <= 0.66666 {
            red.withAlphaComponent(0.2).setFill()
        } else if progress / bounds.width <= 0.83333 {
            yellow.withAlphaComponent(0.2).setFill()
        } else {
            green.withAlphaComponent(0.2).setFill()
        }
        progressOutlinePath.fill()
        
        // Progress Active Drawing
        let progressActivePath = UIBezierPath(roundedRect: CGRect(x: frame.minX, y: frame.minY, width: progress, height: frame.height), cornerRadius: frame.height / 2)
        if progress / bounds.width <= 0.66666 {
            red.setFill()
        } else if progress / bounds.width <= 0.83333 {
            yellow.setFill()
        } else {
            green.setFill()
        }
        progressActivePath.fill()
    }
}
