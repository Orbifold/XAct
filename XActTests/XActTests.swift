//
//  XActTests.swift
//  XActTests
//
//  Created by Francois Vanderseypen on 1/28/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import UIKit
import XCTest

class MathTests : XCTestCase{
    
    func testRandom(){
        for _ in 1...50{
            var x = Math.Random()
            XCTAssertTrue(x > 0 && x < 1, "Number \(x) is not really random.")
        }
        
        for _ in 1...50{
            var x = Math.Random(1,max: 100)
            XCTAssertTrue(x >= 1  && x < 100, "Number \(x) is not really random within the (1, 100) interval.")
        }
    }
}

class DataStructuresTests : XCTestCase{
    
    func testQueueSimple(){
        var q = Queue<Int>();
        q.enQueue(34)
        q.enQueue(-2)
        q.enQueue(0)
        XCTAssertEqual(34,q.deQueue()!)
        XCTAssertEqual(-2,q.deQueue()!)
        XCTAssertEqual(0,q.deQueue()!)
    }
    
    func testQueueSequence(){
        var q = Queue<Character>()
        var s = "p-adic number theory";
        q.enQueue(SequenceOf<Character>(Array(s)))
        XCTAssertEqual(Character("p"), q.peek()!)
        XCTAssertEqual(s.length,q.count)
    }
    func testQueueGenerator(){
        
        var q = Queue<Int>();
        q.enQueue(SequenceOf<Int>(1...50))
        var c = 1
        for x in q{
            XCTAssertEqual(c, x)
            c++
        }
        var p = Queue<String>(array: ["a", "b", "c"]);
        var a = [String]()
        for s in p{
            a.append(s)
        }
        XCTAssertEqual(a, ["a", "b", "c"])
    }
}

class MarkovTests: XCTestCase {
    func testSimple(){
        var sample = split("Note: the hash value is not guaranteed to be stable across different invocations of the same program. Do not persist the hash value across program runs. Because a Slice presents a view onto the storage of some larger array even after the original array's lifetime ends, storing the slice may prolong the lifetime of elements that are no longer accessible, which can manifest as apparent memory and object leakage. To prevent this effect, use Slice only for transient computation.") {$0 == " "}
        var chain = MarkovChain<String>(rootInstance: "", input: SequenceOf(sample), length: 5)
        XCTAssertEqual(60, chain.Root.links.count);
        XCTAssertEqual(79, chain.Root.ChildOccurances);
        XCTAssertEqual(5, chain.Root.links["Note:"]!.count);
        XCTAssertEqual(5, chain.Root.links["Note:"]!.Occurances);
        XCTAssertEqual(4, chain.Root.links["Note:"]!.ChildOccurances);
        XCTAssertEqual(1, chain.Root.links["use"]!.count);
        XCTAssertEqual(2, chain.Root.links["a"]!.links.count);
        XCTAssertEqual(2, chain.Root.links["a"]!.ChildOccurances);
    }
    func testDocumentTitles(){
        var titles = split("We may carry this farther, and remark, not only that two objects are" +
            "connected by the relation of cause and effect, when the one produces" +
            "a motion or any action in the other, but also when it has a power" +
            "of producing it. And this we may observe to be the source of all the" +
            "relation, of interest and duty, by which men influence each other in" +
            "society, and are placed in the ties of government and subordination. A" +
            "master is such-a-one as by his situation, arising either from force or" +
            "agreement, has a power of directing in certain particulars the actions" +
            "of another, whom we call servant. A judge is one, who in all disputed" +
            "cases can fix by his opinion the possession or property of any thing" +
            "betwixt any members of the society. When a person is possessed of any" +
            "power, there is no more required to convert it into action, but the" +
            "exertion of the will; and that in every case is considered as possible," +
            "and in many as probable; especially in the case of authority, where the" +
            "obedience of the subject is a pleasure and advantage to the superior." +
            
            "These are therefore the principles of union or cohesion among our simple" +
            "ideas, and in the imagination supply the place of that inseparable" +
            "connexion, by which they are united in our memory. Here is a kind" +
            "of ATTRACTION, which in the mental world will be found to have as" +
            "extraordinary effects as in the natural, and to shew itself in as many" +
            "and as various forms. Its effects are every where conspicuous; but as to" +
            "its causes, they are mostly unknown, and must be resolved into original" +
            "qualities of human nature, which I pretend not to explain. Nothing is" +
            "more requisite for a true philosopher, than to restrain the intemperate" +
            "desire of searching into causes, and having established any doctrine" +
            "upon a sufficient number of experiments, rest contented with that, when" +
            "he sees a farther examination would lead him into obscure and uncertain" +
            "speculations. In that case his enquiry would be much better employed in" +
            "examining the effects than the causes of his principle." +
            
            "Amongst the effects of this union or association of ideas, there are" +
            "none more remarkable, than those complex ideas, which are the common" +
            "subjects of our thoughts and reasoning, and generally arise from some" +
            "principle of union among our simple ideas. These complex ideas may be" +
            "divided into Relations, Modes, and Substances. We shall briefly examine" +
            "each of these in order, and shall subjoin some considerations concerning" +
            "our general and particular ideas, before we leave the present subject," +
            "which may be considered as the elements of this philosophy." +
            "Thirdly, it is a principle generally received in philosophy that" +
            "everything in nature is individual, and that it is utterly absurd to" +
            "suppose a triangle really existent, which has no precise proportion of" +
            "sides and angles. If this therefore be absurd in fact and reality, it" +
            "must also be absurd in idea; since nothing of which we can form a clear" +
            "and distinct idea is absurd and impossible. But to form the idea of an" +
            "object, and to form an idea simply, is the same thing; the reference" +
            "of the idea to an object being an extraneous denomination, of which in" +
            "itself it bears no mark or character. Now as it is impossible to form an" +
            "idea of an object, that is possest of quantity and quality, and yet" +
            "is possest of no precise degree of either; it follows that there is an" +
            "equal impossibility of forming an idea, that is not limited and confined" +
            "in both these particulars. Abstract ideas are therefore in themselves" +
            "individual, however they may become general in their representation." +
            "The image in the mind is only that of a particular object, though the" +
            "application of it in our reasoning be the same, as if it were universal." +
            
            "This application of ideas beyond their nature proceeds from our" +
            "collecting all their possible degrees of quantity and quality in such an" +
            "imperfect manner as may serve the purposes of life, which is the second" +
            "proposition I proposed to explain. When we have found a resemblance" +
            "[Footnote 2.] among several objects, that often occur to us, we apply" +
            "the same name to all of them, whatever differences we may observe in the" +
            "degrees of their quantity and quality, and whatever other differences" +
            "may appear among them. After we have acquired a custom of this kind, the" +
            "hearing of that name revives the idea of one of these objects, and makes" +
            "the imagination conceive it with all its particular circumstances and" +
            "proportions. But as the same word is supposed to have been frequently" +
            "applied to other individuals, that are different in many respects from" +
            "that idea, which is immediately present to the mind; the word not being" +
            "able to revive the idea of all these individuals, but only touches the" +
            "soul, if I may be allowed so to speak, and revives that custom, which we" +
            "have acquired by surveying them. They are not really and in fact present" +
            "to the mind, but only in power; nor do we draw them all out distinctly" +
            "in the imagination, but keep ourselves in a readiness to survey any of" +
            "them, as we may be prompted by a present design or necessity. The word" +
            "raises up an individual idea, along with a certain custom; and that" +
            "custom produces any other individual one, for which we may have" +
            "occasion. But as the production of all the ideas, to which the name may" +
            "be applied, is in most eases impossible, we abridge that work by a more" +
            "partial consideration, and find but few inconveniences to arise in our" +
            "reasoning from that abridgment.") {$0 == " "}
            var chain = MarkovChain<String>(rootInstance: "", input: SequenceOf(titles), length: 3)
            var gen = chain.Generate(20);
            var rgen = join(" ", Array(gen))
            println(rgen)
    }
}

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
        XCTAssertEqualWithAccuracy(10, Functions.InverseGammaRegularized(0.5, y0: 0.99999225578356895592), Accuracy);
        XCTAssertEqualWithAccuracy(1, Functions.InverseGammaRegularized(1, y0: 0.63212055882855767840), Accuracy);
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
