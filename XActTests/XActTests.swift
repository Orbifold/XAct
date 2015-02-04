//
//  XActTests.swift
//  XActTests
//
//  Created by Francois Vanderseypen on 1/28/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import UIKit
import XCTest

class FunctionTests : XCTestCase
{
    let Accuracy = 1e-6
    
    func testBetaRegularized()
    {
        XCTAssertEqualWithAccuracy(0.651473, Functions.BetaRegularized(0.1, b: 0.22, x: 0.33), Accuracy);
        XCTAssertEqualWithAccuracy(0.470091, Functions.BetaRegularized(0.55, b: 0.77, x: 0.33), Accuracy);
    }
    
    func testGammas(){
        XCTAssertEqualWithAccuracy(1.50856818610322, Functions.GammaLn(3.76835145950317), Accuracy)
        XCTAssertEqualWithAccuracy(1.52395510070524, Functions.GammaLn(3.78128070831299), Accuracy);
        XCTAssertEqualWithAccuracy(3.51639004045872, Functions.GammaLn(5.22110624313355), Accuracy);
        XCTAssertEqualWithAccuracy(1.05593856001418, Functions.GammaLn(3.36578979492187), Accuracy);
        XCTAssertEqualWithAccuracy(2.93885210191772, Functions.GammaLn(4.83925867080688), Accuracy);
        XCTAssertEqualWithAccuracy(0.513590205904634, Functions.GammaLn(2.79629344940186), Accuracy);
        XCTAssertEqualWithAccuracy(0.429146817643342, Functions.GammaLn(2.69286489486694), Accuracy);
        XCTAssertEqualWithAccuracy(2.59403131257292, Functions.GammaLn(4.60012321472168), Accuracy);
        XCTAssertEqualWithAccuracy(9.01512217041147E-02, Functions.GammaLn(2.18743028640747), Accuracy);
        XCTAssertEqualWithAccuracy(1.78957799295296, Functions.GammaLn(3.9982629776001), Accuracy);
        
        XCTAssertEqualWithAccuracy(39.3398841872, Functions.GammaLn(20), Accuracy);
        XCTAssertEqualWithAccuracy(365.123, Functions.GammaLn(101.3), 0.01);
        XCTAssertEqualWithAccuracy(1.82781, Functions.GammaLn(0.15), 0.01);
        
        
        XCTAssertEqualWithAccuracy(2.41605085099579, Functions.Gamma(3.19672372937202), Accuracy);
        XCTAssertEqualWithAccuracy(13.8825126879496, Functions.Gamma(4.62595878839493), Accuracy);
        XCTAssertEqualWithAccuracy(2.13271882732642, Functions.Gamma(0.415676707029343), Accuracy);
        XCTAssertEqualWithAccuracy(3.69810387443817, Functions.Gamma(3.59550366401672), Accuracy);
        XCTAssertEqualWithAccuracy(1.77273235949519, Functions.Gamma(2.86533065438271), Accuracy);
        XCTAssertEqualWithAccuracy(0.948430702927698, Functions.Gamma(1.85917609930038), Accuracy);
        XCTAssertEqualWithAccuracy(4.55022977456423, Functions.Gamma(3.77391051650047), Accuracy);
        XCTAssertEqualWithAccuracy(5.44572548650429, Functions.Gamma(3.92214500904083), Accuracy);
        XCTAssertEqualWithAccuracy(0.901097590334103, Functions.Gamma(1.65637829899788), Accuracy);
        XCTAssertEqualWithAccuracy(0.918635851663489, Functions.Gamma(1.74811812639236), Accuracy);
        
        XCTAssertEqualWithAccuracy(0.864664716763, Functions.GammaRegularized(1, x: 2), Accuracy);
        XCTAssertEqualWithAccuracy(0.999477741950, Functions.GammaRegularized(3, x: 12), Accuracy);
        XCTAssertEqualWithAccuracy(0.714943499683, Functions.GammaRegularized(5, x: 6), Accuracy);
        
        
    }
    
    func testErvInverse(){
        XCTAssertEqualWithAccuracy(0.2724627147267544, Functions.ErfInverse(0.3), Accuracy)
        XCTAssertEqualWithAccuracy(0.6040031879352371, Functions.ErfInverse(0.607), Accuracy)
        XCTAssertEqualWithAccuracy(0.1418558907268814, Functions.ErfInverse(0.159), Accuracy)
        XCTAssertEqualWithAccuracy(1.701751973779214, Functions.ErfInverse(0.9839), Accuracy)
        
    }
    
    func testInverseGammaRegularized(){
        //XCTAssertEqualWithAccuracy(1.523473212136419, Functions.InverseGammaRegularized(2, y0: 0.55), Accuracy)
        XCTAssertEqualWithAccuracy(7.642669868404227, Functions.InverseGammaRegularized(5, y0: 0.122), Accuracy)
//        XCTAssertEqualWithAccuracy(0.1418558907268814, Functions.ErfInverse(0.159), Accuracy)
//        XCTAssertEqualWithAccuracy(1.701751973779214, Functions.ErfInverse(0.9839), Accuracy)
        
    }
    
    func testFibonacci(){
        XCTAssertEqual(5358359254990966640871840, Functions.Fibonacci(120))
    }
    
    func testFibonacciPerformance(){
        return;
        self.measureBlock() {
            let f =  Functions.Fibonacci(130) // 5secs +/- 10%
        }
    }
    
    func testFactorial(){
        XCTAssertEqualWithAccuracy(479001600, Functions.Factorial(12), Accuracy);
        XCTAssertEqualWithAccuracy(355687428096000, Functions.Factorial(17), Accuracy);
        XCTAssertEqualWithAccuracy(40320, Functions.Factorial(8), Accuracy);
        
        XCTAssertEqualWithAccuracy(19.9872144957, Functions.FactorialLn(12), Accuracy);
        XCTAssertEqualWithAccuracy(932.555207148, Functions.FactorialLn(213), Accuracy);
        XCTAssertEqualWithAccuracy(8.52516136107, Functions.FactorialLn(7), Accuracy);
    }
}

class NumberTests :XCTestCase{
    
    func testIsEven(){
        XCTAssertTrue(Numbers.IsEven(244),"244 is even I'd think.");
        XCTAssertTrue(!Numbers.IsEven(42901),"42901 isn't even.");
        XCTAssertTrue(!Numbers.IsEven(Int.max),"Max isn't even, it's undefined.");
    }
    
    func testIsOdd(){
        XCTAssertTrue(Numbers.IsOdd(-15301),"-15301 is odd.");
        XCTAssertTrue(!Numbers.IsOdd(40008),"40008 isn't even.");
        XCTAssertTrue(!Numbers.IsOdd(Int.max),"Max isn't even, it's undefined.");
    }
    
    func testIsPowerOfTwo(){
        XCTAssertFalse(Numbers.IsPowerOfTwo(-8),"-8 is not a power of two.");
        XCTAssertTrue(Numbers.IsPowerOfTwo(32),"32 is a power of two.");
        
    }
    
    func testTruncate(){
        XCTAssertEqual(Numbers.Truncate(2.3), 2.0,"Truncate(2.3) = 2")
        XCTAssertEqual(Numbers.Truncate(12.53), 12.0,"Truncate(12.53) = 13")
        XCTAssertEqual(Numbers.Truncate(-77.03), -77.0,"Truncate(-77.03) = -77")
    }
    func testCeilingToPowerOfTwo(){
        XCTAssertEqual(Numbers.CeilingToPowerOfTwo(Int32(3)), Int32(4))
        XCTAssertEqual(Numbers.CeilingToPowerOfTwo(Int32(20)), Int32(32))
        
    }
    
    func testGCD(){
        XCTAssertEqual(Numbers.GreatestCommonDivisor(144, 55708), 4);
        // an interesting bracket property of Fibonacci and GCD
        XCTAssertEqual(
            Numbers.GreatestCommonDivisor(
                Int(Functions.Fibonacci(13)),
                Int(Functions.Fibonacci(26))
            ),
            Int(Functions.Fibonacci(Numbers.GreatestCommonDivisor(13, 26)))
        );
    }
    
    func testLCM(){
        XCTAssertEqual(Numbers.LeastCommonMultiple(2,3,5), 30);
        XCTAssertEqual(Numbers.LeastCommonMultiple( -3, 4 - 2, 3, 16), 48);
        XCTAssertEqual(Numbers.LeastCommonMultiple( 122,33,7,195,323), 591681090);
    }
    
    func testAlmostEqual(){
        XCTAssertTrue(Numbers.AlmostEqual(2.334400000000000091, b: 2.3344, numberOfDigits: 5))
        XCTAssertTrue(Numbers.AlmostEqual(2.334, b: 2.334000000001, numberOfDigits: 3))
    }
}

class MultiplyWithCarryRandomGeneratorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        MultiplyWithCarryRandomGenerator.SetSeedFromSystemTime()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        
        var ar = [Double]();
        for(var i = 0; i<100; i++){
            ar.append(MultiplyWithCarryRandomGenerator.GetUniform())
            XCTAssertTrue(ar[i]<1.0,"Number \(ar[i]) failed.")
            println(ar[i])
        }
        //NSLog("Created normal number \(n)")
        
    }
    
    func testUniform(){
        RandomGeneratorTester.KolmogorovSmirnov();
    }
    
    func testDistributions(){
        RandomGeneratorTester.TestDistributions()
    }
    
    func testPerformanceExample() {
        
        self.measureBlock() {
            for (var i = 0; i < 1000; ++i)
            {
                MultiplyWithCarryRandomGenerator.GetGamma(10, scale: 2);
            }
            
        }
    }
    
}

public class RandomGeneratorTester
{
    /// Kolmogorov-Smirnov test for distributions.  See Knuth volume 2, page 48-51 (third edition).
    /// This test should *fail* on average one time in 1000 runs.
    /// That's life with random number generators: if the test passed all the time,
    /// the source wouldn't be random enough!  If the test were to fail more frequently,
    /// the most likely explanation would be a bug in the code.
    
    class func KolmogorovSmirnov(){
        MultiplyWithCarryRandomGenerator.SetSeedFromSystemTime()
        
        let numReps = 1000;
        let failureProbability = 0.001; // probability of test failing with normal input
        var j:Int;
        var samples = [Double]()  ;
        
        for (j = 0; j != numReps; ++j){
            samples.append(MultiplyWithCarryRandomGenerator.GetUniform());
        }
        
        samples = samples.sorted({$0<=$1})
        
        var CDF:Double;
        var temp:Double;
        var j_minus = 0, j_plus = 0;
        var K_plus:Double = -Double.infinity;
        var K_minus:Double = -Double.infinity;
        
        for (j = 0; j != numReps; ++j)
        {
            CDF = samples[j];
            temp = (Double(j) + 1.0) / Double(numReps) - CDF;
            if (K_plus < temp)
            {
                K_plus = temp;
                j_plus = j;
            }
            temp = CDF - (Double(j) + 0.0) / Double(numReps);
            if (K_minus < temp)
            {
                K_minus = temp;
                j_minus = j;
            }
        }
        
        
        var sqrtNumReps = sqrt(Double(numReps));
        K_plus *= sqrtNumReps;
        K_minus *= sqrtNumReps;
        
        // We divide the failure probability by four because we have four tests:
        // left and right tests for K+ and K-.
        var p_low = 0.25 * failureProbability;
        var p_high = 1.0 - 0.25 * failureProbability;
        var cutoff_low = sqrt(0.5 * log(1.0 / (1.0 - p_low))) - 1.0 / (6.0 * sqrtNumReps);
        var cutoff_high = sqrt(0.5 * log(1.0 / (1.0 - p_high))) - 1.0 / (6.0 * sqrtNumReps);
        
        
        println("K+ statistic: \(K_plus)");
        println("K+ statistic: \(K_minus)");
        println("Acceptable interval: [\(cutoff_low), \(cutoff_high)]" );
        println("K+ max at \(j_plus) \(samples[j_plus])");
        println("K- max at \(j_minus) \(samples[j_minus])");
        
        if (cutoff_low <= K_plus && K_plus <= cutoff_high && cutoff_low <= K_minus && K_minus <= cutoff_high){
            println("\nAll is well\n");
        }
        else
        {
            println("\nKS test failed\n");
            XCTFail("Statistically this failure should happen sometimes. Don't worry too much, unless it occurs often.")
        }
        
    }
    
    
    // Tests the distributions based on the couple of core methods.
    class func TestDistributions()
    {
        let accuracy = 1e-5;
        let numSamples = 100000;
        var mean:Double, variance:Double, stdev:Double, shape:Double, scale:Double, degreesOfFreedom:Double;
        var rs =   RunningStat();
        
        // Gamma distribution
        rs.Clear();
        shape = 10; scale = 2;
        for (var i = 0; i < numSamples; ++i)
        {
            rs.Push(MultiplyWithCarryRandomGenerator.GetGamma(shape, scale: scale));
        }
        
        PrintResults("gamma", expectedMean: shape*scale, expectedVariance: shape*scale*scale, computedMean: rs.Mean(), computedVariance: rs.Variance());
        
        // Normal distribution
        rs.Clear();
        mean = 2; stdev = 5;
        for (var i = 0; i < numSamples; ++i)
        {
            rs.Push(MultiplyWithCarryRandomGenerator.GetNormal(2, standardDeviation: 5));
        }
        XCTAssertEqualWithAccuracy(mean,rs.Mean(),0.1,"Normal mean failed.");
        XCTAssertEqualWithAccuracy(stdev*stdev,rs.Variance(),0.2,"Normal variance failed.");
        //PrintResults("normal", expectedMean: mean, expectedVariance: stdev*stdev, computedMean: rs.Mean(), computedVariance: rs.Variance());
        
        // Student t distribution
        rs.Clear();
        degreesOfFreedom = 6;
        for (var i = 0; i < numSamples; ++i){
            rs.Push(MultiplyWithCarryRandomGenerator.GetStudentT(6));
        }
        XCTAssertEqualWithAccuracy(0,rs.Mean(),0.2,"Student mean failed.");
        XCTAssertEqualWithAccuracy(degreesOfFreedom / (degreesOfFreedom - 2.0),rs.Variance(),0.2,"Student variance failed.");
        //PrintResults("Student t", expectedMean: 0, expectedVariance: degreesOfFreedom / (degreesOfFreedom - 2.0), computedMean: rs.Mean(), computedVariance: rs.Variance());
        
        // Weibull distribution
        rs.Clear();
        shape = 2; scale = 3;
        mean = 3*sqrt(Math.Pi)/2;
        variance = 9*(1 - Math.Pi/4);
        for (var i = 0; i < numSamples; ++i){
            rs.Push(MultiplyWithCarryRandomGenerator.GetWeibull(shape, scale: scale));
        }
        XCTAssertEqualWithAccuracy(mean,rs.Mean(),0.2,"Weibull mean failed.");
        XCTAssertEqualWithAccuracy(variance,rs.Variance(),0.2,"Weibull variance failed.");
        //PrintResults("Weibull", expectedMean: mean, expectedVariance: variance, computedMean: rs.Mean(), computedVariance: rs.Variance());
        
        // Beta distribution
        rs.Clear();
        var a = 7.0, b = 2.0;
        mean = a / (a + b);
        variance = mean*(1 - mean) / (a + b + 1);
        for (var i = 0; i < numSamples; ++i){
            rs.Push(MultiplyWithCarryRandomGenerator.GetBeta(a, b: b));
        }
        XCTAssertEqualWithAccuracy(mean,rs.Mean(),0.2,"Beta mean failed.");
        XCTAssertEqualWithAccuracy(variance,rs.Variance(),0.2,"Beta variance failed.");
        //PrintResults("Beta", expectedMean: mean, expectedVariance: variance, computedMean: rs.Mean(), computedVariance: rs.Variance());
    }
    class func PrintResults
        (
        name:String,
        expectedMean:Double,
        expectedVariance:Double,
        computedMean:Double,
        computedVariance:Double
        )
    {
        println("Testing \(name)");
        println("Expected mean:     \(expectedMean), computed mean:     \(computedMean)" );
        println("Expected variance: \(expectedVariance), computed variance: \(computedVariance)" );
        println("");
    }
}

public class RunningStat
{
    var m_n:Int;
    var m_oldM:Double, m_newM:Double, m_oldS:Double, m_newS:Double;
    
    init()
    {
        self.m_n = 0;
        self.m_oldM = 0
        self.m_newM = 0;
        self.m_oldS = 0;
        self.m_newS=0;
    }
    
    public func Clear()
    {
        m_n = 0;
    }
    
    public func Push( x:Double)
    {
        m_n++;
        
        // See Knuth TAOCP vol 2, 3rd edition, page 232
        if (m_n == 1)
        {
            m_newM = x;
            m_oldM =  x;
            m_oldS = 0.0;
        }
        else
        {
            m_newM = m_oldM + (x - m_oldM)/Double(m_n);
            m_newS = m_oldS + (x - m_oldM)*(x - m_newM);
            
            // set up for next iteration
            m_oldM = m_newM;
            m_oldS = m_newS;
        }
    }
    
    public func NumDataValues()->Int
    {
        return m_n;
    }
    
    public func Mean()->Double
    {
        return (m_n > 0) ? m_newM : 0.0;
    }
    
    public func Variance()->Double
    {
        return ( (m_n > 1) ? m_newS/(Double(m_n) - 1) : 0.0 );
    }
    
    public func StandardDeviation()->Double
    {
        return sqrt( Variance() );
    }
}
