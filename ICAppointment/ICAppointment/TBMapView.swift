//
//  TBMapView.swift
//  ICAppointment
//
//  Created by ICloud on 2018/5/25.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class TBMapView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
 */
    override func draw(_ rect: CGRect) {
        // Drawing code
        let scale: CGFloat = self.frame.width / 750
        let width: CGFloat = 655 * scale
        let height: CGFloat = 690 * scale
        
        let color = UIColor.hexColor("#33663b")
        color.set()
        
        let cycle1: [(CGFloat, CGFloat)] = [(652, 282), (654, 286), (657, 300), (658, 322), (655, 347),
                                            (654, 371), (654, 396), (656, 420), (656, 444), (657, 468),
                                            (657, 493), (658, 517), (660, 542), (661, 566), (661, 590),
                                            (663, 615), (664, 639), (663, 662), (654, 677), (638, 679),
                                            (616, 675), (591, 674), (566, 675), (541, 676), (517, 677),
                                            (492, 678), (467, 678), (442, 679), (417, 679), (397, 679),
                                            (384, 679), (367, 680), (343, 680), (318, 681), (293, 682),
                                            (268, 683), (243, 683), (218, 684), (193, 685), (168, 687),
                                            (143, 688), (118, 688), (93,  689),( 69,  690), (46,  685),
                                            (32,  668), (30,  643), (31,  617), (29,  592), (27, 566),
                                            (25,  540), (23,  515), (22,  489), (21,  467), (20, 452),
                                            (19, 435), (17, 411), (16, 385), (15, 360), (13, 334),
                                            (11, 309), (10, 283), (8, 257), (7, 232), (5, 209),
                                            (4, 190), (3, 167), (1, 141), (0, 115), (0, 90),
                                            (8, 70), (19, 64), (30, 64), (49, 65), (71, 64),
                                            (88, 62), (102, 59), (123, 56), (148, 53), (173, 50),
                                            (198, 47), (224, 44), (249, 42),( 274, 40), (299, 37),
                                            (324, 34), (349, 31), (369, 29),( 383, 27), (400, 25),
                                            (424, 21), (449, 18), (474, 15),( 499, 12), (524, 9),
                                            (549, 6),  (575,  2),  (600, 0), ( 622, 3),  ( 635, 20),
                                            (638, 44), (638, 69), (640, 93), (644, 118), (647, 142),
                                            (649, 162), (651, 172)]
        
        let bezierPath1 = UIBezierPath()
        bezierPath1.move(to: CGPoint(x: cycle1[0].0 * scale, y: height - cycle1[0].1 * scale))
        for point in cycle1 {
            bezierPath1.addLine(to: CGPoint(x: point.0 * scale, y: height - point.1 * scale))
        }
        
        bezierPath1.lineWidth = 1.0;
        bezierPath1.lineCapStyle = .round; //线条拐角
        bezierPath1.lineJoinStyle = .round; //终点处理
        
        
        let cycle2: [(CGFloat, CGFloat)] = [(281, 270),(281, 272),(274, 286),(266, 301),(258, 314),
                                            (249, 336),(242, 356),(237, 369),(238, 385),(243, 397),
                                            (255, 408),(267, 420),(276, 436),(286, 456),(294, 468),
                                            (306, 482),(327, 486),(352, 480),(374, 476),(386, 461),
                                            (389, 446),(393, 434),(400, 411),(408, 386),(413, 368),
                                            (416, 356),(416, 346),(402, 334),(390, 323),(384, 311),
                                            (372, 286),(364, 273),(354, 255)]
        
        
        bezierPath1.move(to: CGPoint(x: cycle2[0].0 * scale, y: height - cycle2[0].1 * scale))
        for point in cycle2 {
            bezierPath1.addLine(to: CGPoint(x: point.0 * scale, y: height - point.1 * scale))
        }
        bezierPath1.fill()
       
    }
 

}
