//
//  XActTests.swift
//  XActTests
//
//  Created by Francois Vanderseypen on 1/28/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import UIKit
import XCTest

class XActTests: XCTestCase {
    
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
