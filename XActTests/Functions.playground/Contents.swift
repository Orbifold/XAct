//: ![XAct Numerics](XAct.png)
/*:
# XAct Functions

The framework contains a wide variety of mathematical functions in the Functions class.
*/

import Foundation
import XCPlayground
import XAct


//: For example, the beta-regularize functions looks like the following;

let r = map(1...100,{Functions.BetaRegularized(0.1, b: 0.52, x: Double($0)/30.0)})


//: A normal random variable with increasing and standard deviation

let s = map(1...100, {MultiplyWithCarryRandomGenerator.GetNormal(2, standardDeviation: Double($0))});
