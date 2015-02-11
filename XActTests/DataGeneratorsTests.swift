//
//  Data generators.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/11/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//


import UIKit
import XCTest

class MarkovChainTests: XCTestCase {
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
