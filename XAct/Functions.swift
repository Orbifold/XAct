//
//  Functions.swift
//  XAct
//
//  Created by Francois Vanderseypen on 1/31/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation

/**
Epsilon extensions of the Double type.
*/
public extension Double{
    /**
    Returns whether the number is close to zero.
    
    :param: accuracy The threshold within which the number is considered zero. Default is Epsilon.
    */
    public func IsZero(accuracy:Double = Constants.Epsilon) -> Bool{
        return abs(self) < accuracy;
    }
    
    /**
    Returns whether the number is considered of measure zero.
    */
    public func IsVerySmall() -> Bool{
        return abs(self) < Constants.Epsilon;
    }
    
    /**
    Returns whether the number is equal to the given number in an Epsilon sense.
    */
    public func IsEqualTo(value:Double) -> Bool
    {
        return abs(self - value) < Constants.Epsilon;
    }
    
    /**
    Returns whether the number is close to the given one in an Epsilon sense.
    */
    public func AreClose(value:Double) -> Bool
    {
        return self.IsEqualTo(value) || Double.IsVerySmall(self - value)();
    }
    
    /**
    Returns whether the number is not close to the given one in an Epsilon sense.
    */
    public func AreNotClose(value:Double) -> Bool
    {
        return !self.AreClose(value)
    }
    
    /**
    Returns whether the number is less than or close to the given one in an Epsilon sense.
    */
    public func IsLessThanOrClose(value:Double) -> Bool
    {
        return self < value || self.AreClose(value);
    }
}

/**
Collects a variety of mathematical functions.
*/
public class Functions
{
    struct Static{
        static var ErfcChebCoef = [-1.3026537197817094,
            6.4196979235649026e-1, 1.9476473204185836e-2,
            -9.561514786808631e-3, -9.46595344482036e-4,
            3.66839497852761e-4, 4.2523324806907e-5,
            -2.0278578112534e-5, -1.624290004647e-6
        ];
        
        init(){
            // Swift compiler has a problem with long lines, shame...
            Static.ErfcChebCoef += [ 1.303655835580e-6, 1.5626441722e-8, -8.5238095915e-8,
                6.529054439e-9, 5.059343495e-9, -9.91364156e-10,
                -2.27365122e-10, 9.6467911e-11, 2.394038e-12
            ]
            Static.ErfcChebCoef += [-6.886027e-12, 8.94487e-13, 3.13092e-13,
                -1.12708e-13, 3.81e-16, 7.106e-15, -1.523e-15,
                -9.4e-17, 1.21e-16, -2.8e-17]
        }
        static var ErfInvA = [
            -3.969683028665376e+01, 2.209460984245205e+02,
            -2.759285104469687e+02, 1.383577518672690e+02,
            -3.066479806614716e+01, 2.506628277459239e+00
        ];
        
        static var   ErfInvB = [
            -5.447609879822406e+01, 1.615858368580409e+02,
            -1.556989798598866e+02, 6.680131188771972e+01,
            -1.328068155288572e+01
        ];
        
        static var ErfInvC = [
            -7.784894002430293e-03, -3.223964580411365e-01,
            -2.400758277161838e+00, -2.549732539343734e+00,
            4.374664141464968e+00, 2.938163982698783e+00
        ];
        
        static var ErfInvD = [
            7.784695709041462e-03, 3.224671290700398e-01,
            2.445134137142996e+00, 3.754408661907416e+00
        ];
        
        static var FactorialLnCache = [Int:Double]()
        static var FibonacciPrecomp:[Double] = [
            0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765,10946,17711,28657,46368,75025,121393,196418,317811,514229,832040,1346269,2178309,3524578,5702887,9227465,14930352,24157817,39088169,63245986,102334155,165580141,267914296,433494437,701408733,1134903170,1836311903,2971215073,4807526976,7778742049,12586269025,20365011074,32951280099,53316291173,86267571272,139583862445,225851433717,365435296162,591286729879,956722026041,1548008755920,2504730781961,4052739537881,6557470319842,10610209857723,17167680177565,27777890035288,44945570212853,72723460248141,117669030460994,190392490709135,308061521170129,498454011879264,806515533049393,1304969544928657,2111485077978050,3416454622906707,5527939700884757,8944394323791464,14472334024676221,23416728348467685,37889062373143906,61305790721611591,99194853094755497,160500643816367088,259695496911122585,420196140727489673,679891637638612258,1100087778366101931,1779979416004714189,2880067194370816120,4660046610375530309,7540113804746346429,12200160415121876738,19740274219868223167,31940434634990099905,51680708854858323072,83621143489848422977,135301852344706746049,218922995834555169026,354224848179261915075
        ]
        
        static var FactorialPrecomp:[Double] =  [
            /*0*/1,
            /*1*/1,
            /*2*/2,
            /*3*/6,
            /*4*/24,
            /*5*/120,
            /*6*/720,
            /*7*/5040,
            /*8*/40320,
            /*9*/362880,
            /*10*/3628800,
            /*11*/39916800,
            /*12*/479001600,
            /*13*/6227020800,
            /*14*/87178291200,
            /*15*/1307674368000,
            /*16*/20922789888000,
            /*17*/355687428096000,
            /*18*/6402373705728000,
            /*19*/121645100408832000,
            /*20*/2432902008176640000,
            /*21*/51090942171709440000,
            /*22*/1124000727777607680000,
            /*23*/25852016738884976640000,
            /*24*/620448401733239439360000,
            /*25*/15511210043330985984000000,
            /*26*/403291461126605635584000000,
            /*27*/10888869450418352160768000000,
            /*28*/304888344611713860501504000000,
            /*29*/8841761993739701954543616000000,
            /*30*/265252859812191058636308480000000,
            /*31*/8222838654177922817725562880000000,
            /*32*/263130836933693530167218012160000000,
            /*33*/8683317618811886495518194401280000000,
            /*34*/295232799039604140847618609643520000000,
            /*35*/10333147966386144929666651337523200000000,
            /*36*/371993326789901217467999448150835200000000,
            /*37*/13763753091226345046315979581580902400000000,
            /*38*/523022617466601111760007224100074291200000000,
            /*39*/20397882081197443358640281739902897356800000000,
            /*40*/815915283247897734345611269596115894272000000000,
            /*41*/33452526613163807108170062053440751665152000000000,
            /*42*/1405006117752879898543142606244511569936384000000000,
            /*43*/60415263063373835637355132068513997507264512000000000,
            /*44*/2658271574788448768043625811014615890319638528000000000,
            /*45*/119622220865480194561963161495657715064383733760000000000,
            /*46*/5502622159812088949850305428800254892961651752960000000000,
            /*47*/258623241511168180642964355153611979969197632389120000000000,
            /*48*/12413915592536072670862289047373375038521486354677760000000000,
            /*49*/608281864034267560872252163321295376887552831379210240000000000,
            /*50*/30414093201713378043612608166064768844377641568960512000000000000,
            /*51*/1551118753287382280224243016469303211063259720016986112000000000000,
            /*52*/80658175170943878571660636856403766975289505440883277824000000000000,
            /*53*/4274883284060025564298013753389399649690343788366813724672000000000000,
            /*54*/230843697339241380472092742683027581083278564571807941132288000000000000,
            /*55*/12696403353658275925965100847566516959580321051449436762275840000000000000,
            /*56*/710998587804863451854045647463724949736497978881168458687447040000000000000,
            /*57*/40526919504877216755680601905432322134980384796226602145184481280000000000000,
            /*58*/2350561331282878571829474910515074683828862318181142924420699914240000000000000,
            /*59*/138683118545689835737939019720389406345902876772687432540821294940160000000000000,
            /*60*/8320987112741390144276341183223364380754172606361245952449277696409600000000000000,
            /*61*/507580213877224798800856812176625227226004528988036003099405939480985600000000000000,
            /*62*/31469973260387937525653122354950764088012280797258232192163168247821107200000000000000,
            /*63*/1982608315404440064116146708361898137544773690227268628106279599612729753600000000000000,
            /*64*/126886932185884164103433389335161480802865516174545192198801894375214704230400000000000000,
            /*65*/8247650592082470666723170306785496252186258551345437492922123134388955774976000000000000000,
            /*66*/544344939077443064003729240247842752644293064388798874532860126869671081148416000000000000000,
            /*67*/36471110918188685288249859096605464427167635314049524593701628500267962436943872000000000000000,
            /*68*/2480035542436830599600990418569171581047399201355367672371710738018221445712183296000000000000000,
            /*69*/171122452428141311372468338881272839092270544893520369393648040923257279754140647424000000000000000,
            /*70*/11978571669969891796072783721689098736458938142546425857555362864628009582789845319680000000000000000,
            /*71*/850478588567862317521167644239926010288584608120796235886430763388588680378079017697280000000000000000,
            /*72*/61234458376886086861524070385274672740778091784697328983823014963978384987221689274204160000000000000000,
            /*73*/4470115461512684340891257138125051110076800700282905015819080092370422104067183317016903680000000000000000,
            /*74*/330788544151938641225953028221253782145683251820934971170611926835411235700971565459250872320000000000000000,
            /*75*/24809140811395398091946477116594033660926243886570122837795894512655842677572867409443815424000000000000000000,
            /*76*/1885494701666050254987932260861146558230394535379329335672487982961844043495537923117729972224000000000000000000,
            /*77*/145183092028285869634070784086308284983740379224208358846781574688061991349156420080065207861248000000000000000000,
            /*78*/11324281178206297831457521158732046228731749579488251990048962825668835325234200766245086213177344000000000000000000,
            /*79*/894618213078297528685144171539831652069808216779571907213868063227837990693501860533361810841010176000000000000000000,
            /*80*/71569457046263802294811533723186532165584657342365752577109445058227039255480148842668944867280814080000000000000000000,
            /*81*/5797126020747367985879734231578109105412357244731625958745865049716390179693892056256184534249745940480000000000000000000,
            /*82*/475364333701284174842138206989404946643813294067993328617160934076743994734899148613007131808479167119360000000000000000000,
            /*83*/39455239697206586511897471180120610571436503407643446275224357528369751562996629334879591940103770870906880000000000000000000,
            /*84*/3314240134565353266999387579130131288000666286242049487118846032383059131291716864129885722968716753156177920000000000000000000,
            /*85*/281710411438055027694947944226061159480056634330574206405101912752560026159795933451040286452340924018275123200000000000000000000,
            /*86*/24227095383672732381765523203441259715284870552429381750838764496720162249742450276789464634901319465571660595200000000000000000000,
            /*87*/2107757298379527717213600518699389595229783738061356212322972511214654115727593174080683423236414793504734471782400000000000000000000,
            /*88*/185482642257398439114796845645546284380220968949399346684421580986889562184028199319100141244804501828416633516851200000000000000000000,
            /*89*/16507955160908461081216919262453619309839666236496541854913520707833171034378509739399912570787600662729080382999756800000000000000000000,
            /*90*/1485715964481761497309522733620825737885569961284688766942216863704985393094065876545992131370884059645617234469978112000000000000000000000,
            /*91*/135200152767840296255166568759495142147586866476906677791741734597153670771559994765685283954750449427751168336768008192000000000000000000000,
            /*92*/12438414054641307255475324325873553077577991715875414356840239582938137710983519518443046123837041347353107486982656753664000000000000000000000,
            /*93*/1156772507081641574759205162306240436214753229576413535186142281213246807121467315215203289516844845303838996289387078090752000000000000000000000,
            /*94*/108736615665674308027365285256786601004186803580182872307497374434045199869417927630229109214583415458560865651202385340530688000000000000000000000,
            /*95*/10329978488239059262599702099394727095397746340117372869212250571234293987594703124871765375385424468563282236864226607350415360000000000000000000000,
            /*96*/991677934870949689209571401541893801158183648651267795444376054838492222809091499987689476037000748982075094738965754305639874560000000000000000000000,
            /*97*/96192759682482119853328425949563698712343813919172976158104477319333745612481875498805879175589072651261284189679678167647067832320000000000000000000000,
            /*98*/9426890448883247745626185743057242473809693764078951663494238777294707070023223798882976159207729119823605850588608460429412647567360000000000000000000000,
            /*99*/933262154439441526816992388562667004907159682643816214685929638952175999932299156089414639761565182862536979208272237582511852109168640000000000000000000000,
            /*100*/93326215443944152681699238856266700490715968264381621468592963895217599993229915608941463976156518286253697920827223758251185210916864000000000000000000000000,
        ]
    }
    
    /**
    Returns the n-th Fibonacci number.
    
    :see: http://en.wikipedia.org/wiki/Fibonacci_number
    */
    public class func Fibonacci(n:Int) -> Double
    {
        if(n<=100){
            return Static.FibonacciPrecomp[n]
        }
        return Fibonacci(n-1) + Fibonacci(n-2);
    }
    
    /**
    Returns the gamma function of the given value.
    
    :see: http://en.wikipedia.org/wiki/Gamma_function
    */
    public class func Gamma(x:Double) -> Double
    {
        if(abs(x - 1) < Constants.Epsilon){
            return 1.0;}
        if(x < 0){
            NSException(name:"Gamma error", reason:"The Gamma function implementation does not handle negative arguments.", userInfo:nil).raise()
        }
        
        var intx:Int? = nil;
        if( Numbers.AlmostInteger(x, n: &intx)) {
            return Factorial(intx! - 1);
        }
        return exp(GammaLn(x));
    }
    
    /**
    Returns the natural logarithm of the gamma function for a real value larger than 0.
    */
    public class func GammaLn( x:Double) -> Double
    {
        var coef = [57.1562356658629235,
            -59.5979603554754912,
            14.1360979747417471,
            -0.491913816097620199,
            0.339946499848118887E-4,
            0.465236289270485756E-4,
            -0.983744753048795646E-4,
            0.158088703224912494E-3,
            -0.210264441724104883E-3,
            0.217439618115212643E-3,
            -0.164318106536763890E-3,
            0.844182239838527433E-4,
            -0.261908384015814087E-4,
            0.368991826595316234E-5
        ];
        
        var denominator = x;
        var series = 0.999999999999997092;
        var temp = x + 5.24218750000000000;
        temp = (x + 0.5) * log(temp) - temp;
        for(var j = 0; j < 14; j++){
            series += coef[j] / ++denominator;
        }
        return (temp + log(2.5066282746310005 * series / x));
    }
    
    /**
    Returns the factorial n! of the given integer n.
    
    :see: http://en.wikipedia.org/wiki/Factorial
    */
    public class func Factorial(n:Int) -> Double{
        if(n < 0)
        {
            NSException(name:"Factorial error", reason:"The Factorial function is not defined for negative arguments.", userInfo:nil).raise()
        }
        if(n == 0){
            return 1.0;}
        if(n == 1){
            return 1.0;}
        return n >= Static.FactorialPrecomp.count ? exp(GammaLn(Double(n) + 1.0)) : Static.FactorialPrecomp[n];
    }
    
    /**
    Returns the natural logarithm of the factorial of the given number.
    */
    public class func  FactorialLn(value:Int) -> Double
    {
        if(value < 0){
            NSException(name:"FactorialLN error", reason:"The FactorialLN function is not defined for negative arguments.", userInfo:nil).raise()}
        if(value <= 1){
            return 0;}
        let FactorialLnCacheSize = 2 * Static.FactorialPrecomp.count
        if(value >= FactorialLnCacheSize){
            return GammaLn(Double(value) + 1.0);}
        if let val = Static.FactorialLnCache[value] {
            return val
        }
        else{
            Static.FactorialLnCache[value] = GammaLn(Double(value) + 1.0) ;
            return  GammaLn(Double(value) + 1.0)
        }
        
    }
    /**
    Returns the regularized lower incomplete beta function.
    The regularized incomplete beta function (or regularized beta function for short) is defined in terms of the incomplete beta function and the complete beta function.
    
    */
    public class func BetaRegularized(var a:Double,var b:Double, var x:Double) -> Double
    {
        let MaxIterations = 100;
        if(a < 0.0)
        {
            NSException(name:"BetaRegularized error", reason:"The first argument cannot be a negative arguments.", userInfo:nil).raise()}
        
        if(b < 0.0)
        {
            NSException(name:"BetaRegularized error", reason:"The second argument cannot be a negative arguments.", userInfo:nil).raise()
        }
        if(x < 0.0 || x > 1.0)
        {NSException(name:"BetaRegularized error", reason:"The third argument must be in the (0,1) interval.", userInfo:nil).raise()
        }
        
        var bt = 0.0
        
        if(abs(x) >= Constants.Epsilon && abs(x - 1.0) >= Constants.Epsilon){
            bt =  exp(GammaLn(a + b) - GammaLn(a) - GammaLn(b) + a * log(x) + b * log(1.0 - x));
        }
        
        var symmetryTransformation = x >= (a + 1.0) / (a + b + 2.0);
        var eps = Constants.RelativeAccuracy;
        var fpmin = Constants.SmallestNumberGreaterThanZero / eps;
        if(symmetryTransformation) {
            x = 1.0 - x;
            var swap = a;
            a = b;
            b = swap;
        }
        
        var qab = a + b;
        var qap = a + 1.0;
        var qam = a - 1.0;
        var c = 1.0;
        var d = 1.0 - qab * x / qap;
        if(abs(d) < fpmin)
        {
            d = fpmin;
        }
        d = 1.0 / d;
        var h = d;
        
        for(var m = 1, m2 = 2; m <= MaxIterations; m++, m2 += 2) {
            var aa = Double(m) * (b - Double(m)) * x / ((qam + Double(m2)) * (a + Double(m2)));
            d = 1.0 + aa * d;
            
            if(abs(d) < fpmin)
            {d = fpmin;}
            
            c = 1.0 + aa / c;
            if(abs(c) < fpmin)
            {c = fpmin;}
            
            d = 1.0 / d;
            h *= d * c;
            aa = -(a + Double(m)) * (qab + Double(m)) * x / ((a + Double(m2)) * (qap + Double(m2)));
            d = 1.0 + aa * d;
            
            if(abs(d) < fpmin)
            { d = fpmin;}
            
            c = 1.0 + aa / c;
            
            if(abs(c) < fpmin)
            {c = fpmin;}
            
            d = 1.0 / d;
            var del = d * c;
            h *= del;
            
            if(abs(del - 1.0) <= eps){
                return symmetryTransformation ? 1.0 - bt * h / a : bt * h / a;
            }
        }
        
        NSException(name:"BetaRegularized error", reason:"The combination of parameters failed..", userInfo:nil).raise()
        return 0.0 // compiler does not see NSException as exit point
    }
    
    /**
    Returns the regularized lower incomplete gamma function
    P(a,x) = 1/Gamma(a) * int(exp(-t)t^(a-1),t=0..x) for real a > 0 and x > 0.
    */
    public class func GammaRegularized(  a:Double,   x:Double)-> Double
    {
        let   MaxIterations = 100;
        var eps = Constants.RelativeAccuracy;
        var fpmin = Constants.SmallestNumberGreaterThanZero / eps;
        
        if(a < 0.0 || x < 0.0){
            NSException(name:"GammaRegularized error", reason:"The The arguments should be positive numbers.", userInfo:nil).raise()
        }
        var gln = GammaLn(a);
        if(x < a + 1.0) {
            if(x <= 0.0){
                return 0.0;}
            var ap = a;
            var del:Double = 1.0 / a, sum:Double   = 1.0 / a;
            
            for(var n = 0; n < MaxIterations; n++) {
                ++ap;
                del *= x / ap;
                sum += del;
                if(abs(del) < abs(sum) * eps){
                    return sum * exp(-x + a * log(x) - gln);}
            }
        } else {
            // Continued fraction representation
            var b = x + 1.0 - a;
            var c = 1.0 / fpmin;
            var d = 1.0 / b;
            var h = d;
            
            for(var i = 1; i <= MaxIterations; i++) {
                var an = -Double(i) * (Double(i) - a);
                b += 2.0;
                d = an * d + b;
                if(abs(d) < fpmin){
                    d = fpmin;}
                
                c = b + an / c;
                if(abs(c) < fpmin){
                    c = fpmin;}
                d = 1.0 / d;
                var del = d * c;
                h *= del;
                
                if(abs(del - 1.0) <= eps){
                    return 1.0 - exp(-x + a * log(x) - gln) * h;}
            }
        }
        
        NSException(name:"GammaRegularized error", reason:"The The arguments should be positive numbers.", userInfo:nil).raise()
        return Double.NaN
    }
    
    /**
    Returns the inverse error function obtained as the solution for z in s=erf(z). 
    */
    public class func ErfInverse(var x:Double) -> Double
    {
        
        x = 0.5 * (x + 1.0);
        
        // Define break-points.
        let Plow = 0.02425;
        let Phigh = 1 - Plow;
        
        var q:Double;
        
        
        var A0 = Static.ErfInvA[0]
        var A1 = Static.ErfInvA[1]
        var A2 = Static.ErfInvA[2]
        var A3 = Static.ErfInvA[3]
        var A4 = Static.ErfInvA[4]
        var A5 = Static.ErfInvA[5]
        
        var B0 = Static.ErfInvB[0]
        var B1 = Static.ErfInvB[1]
        var B2 = Static.ErfInvB[2]
        var B3 = Static.ErfInvB[3]
        var B4 = Static.ErfInvB[4]
        
        var C0 = Static.ErfInvC[0]
        var C1 = Static.ErfInvC[1]
        var C2 = Static.ErfInvC[2]
        var C3 = Static.ErfInvC[3]
        var C4 = Static.ErfInvC[4]
        var C5 = Static.ErfInvC[5]
        
        var D0 = Static.ErfInvD[0]
        var D1 = Static.ErfInvD[1]
        var D2 = Static.ErfInvD[2]
        var D3 = Static.ErfInvD[3]
        
        // Rational approximation for lower region:
        if(x < Plow) {
            q = sqrt(-2 * log(x));
            return (((((C0 * q + C1) * q + C2) * q + C3) * q + C4) * q + C5) / ((((D0 * q + D1) * q + D2) * q + D3) * q + 1) * Constants.Sqrt1Over2;
        }
        
        // Rational approximation for upper region:
        if(Phigh < x) {
            q = sqrt(-2 * log(1 - x));
            var nom = -1 * (((((C0 * q + C1) * q + C2) * q + C3) * q + C4) * q + C5)
            return  nom / ((((D0 * q + D1) * q + D2) * q + D3) * q + 1) * Constants.Sqrt1Over2;
        }
        
        // Rational approximation for central region:
        q = x - 0.5;
        var r = q * q;
        var nom = (((((A0 * r + A1) * r + A2) * r + A3) * r + A4) * r + A5) * q
        return nom / (((((B0 * r + B1) * r + B2) * r + B3) * r + B4) * r + 1) * Constants.Sqrt1Over2;
    }
    
    
    func ErfcCheb(x:Double) -> Double
    {
        
        var d = 0.0;
        var dd = 0.0;
        
        if(x < 0.0){
            NSException(name:"ErfcCheb error", reason:"The parameter should be a positive number.", userInfo:nil).raise()
        }
        
        var t = 2.0 / (2.0 + x);
        var ty = 4.0 * t - 2.0;
        
        for(var j = Static.ErfcChebCoef.count - 1; j > 0; j--) {
            var tmp = d;
            d = ty * d - dd + Static.ErfcChebCoef[j];
            dd = tmp;
        }
        return t * exp(-x * x + 0.5 * (Static.ErfcChebCoef[0] + ty * d) - dd);
    }
    
    public class func InverseGammaRegularized(  a:Double, var  y0:Double) -> Double
    {
        let Epsilon = 0.000000000000001;
        let BigNumber = 4503599627370496.0;
        let Threshold = 5 * Epsilon;
        
        
        if(a < 0 || a.IsZero() || y0 < 0 || y0 > 1) {
            return Double.NaN;
        }
        
        if(y0.IsZero()) {
            return 0;
        }
        
        if(y0.IsEqualTo(1)) {
            return Double.infinity;
        }
        
        y0 = 1 - y0;
        
        var xUpper = BigNumber;
        var xLower = 0.0;
        var yUpper = 1.0;
        var yLower = 0.0;
        
        // Initial Guess
        var d = 1 / (9 * a);
        var y = 1 - d - (0.98 * Constants.Sqrt2 * ErfInverse((2.0 * y0) - 1.0) * sqrt(d));
        var x = a * y * y * y;
        var lgm = GammaLn(a);
        
        for(var i = 0; i < 10; i++) {
            if(x < xLower || x > xUpper) {
                d = 0.0625;
                break;
            }
            
            y = 1 - GammaRegularized(a, x: x);
            if(y < yLower || y > yUpper) {
                d = 0.0625;
                break;
            }
            
            if(y < y0) {
                xUpper = x;
                yLower = y;
            } else {
                xLower = x;
                yUpper = y;
            }
            
            d = ((a - 1) * log(x)) - x - lgm;
            if(d < -709.78271289338399) {
                d = 0.0625;
                break;
            }
            
            d = -exp(d);
            d = (y - y0) / d;
            if(abs(d / x) < Epsilon) {
                return x;
            }
            
            if((d > (x / 4)) && (y0 < 0.05)) {
                // Naive heuristics for cases near the singularity
                d = x / 10;
            }
            
            x -= d;
        }
        
        if(xUpper == BigNumber) {
            if(x <= 0) {
                x = 1;
            }
            
            while(xUpper == BigNumber) {
                x = (1 + d) * x;
                y = 1 - GammaRegularized(a, x: x);
                if(y < y0) {
                    xUpper = x;
                    yLower = y;
                    break;
                }
                
                d = d + d;
            }
        }
        
        var dir = 0;
        d = 0.5;
        for(var i = 0; i < 400; i++) {
            x = xLower + (d * (xUpper - xLower));
            y = 1 - GammaRegularized(a, x: x);
            lgm = (xUpper - xLower) / (xLower + xUpper);
            if(abs(lgm) < Threshold) {
                return x;
            }
            
            lgm = (y - y0) / y0;
            if(abs(lgm) < Threshold) {
                return x;
            }
            
            if(x <= 0.0) {
                return 0.0;
            }
            
            if(y >= y0) {
                xLower = x;
                yUpper = y;
                if(dir < 0) {
                    dir = 0;
                    d = 0.5;
                } else {
                    if(dir > 1) {
                        d = (0.5 * d) + 0.5;
                    } else {
                        d = (y0 - yLower) / (yUpper - yLower);
                    }
                }
                
                dir = dir + 1;
            } else {
                xUpper = x;
                yLower = y;
                if(dir > 0) {
                    dir = 0;
                    d = 0.5;
                } else {
                    if(dir < -1) {
                        d = 0.5 * d;
                    } else {
                        d = (y0 - yLower) / (yUpper - yLower);
                    }
                }
                
                dir = dir - 1;
            }
        }
        
        return x;
    }
}