//
//  Constants.swift
//  XAct
//
//  Created by Francois Vanderseypen on 1/29/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation

/**
A collection of mathematical, numeric and other constants.
*/
public struct Constants
{
    /** 
    The epsilon aka infinitesimal; a small value to compare to floating numbers. 
    */
    public static let Epsilon = 1E-8;
    
    /**
        The Catalan number.
        See http://en.wikipedia.org/wiki/Catalan's_constant
    */
    public static let Catalan = 0.9159655941772190150546035149323841107741493742816721342664981196217630197762547694794;
    
    /** 
        The Euler constant.
        See http://en.wikipedia.org/wiki/E_%28mathematical_constant%29 
    */
    public static let Euler = 2.7182818284590452353602874713526624977572470937000;
    
    /** 
        The Euler-Mascheroni constant.
        See http://en.wikipedia.org/wiki/Euler_constant 
    */
    public static let EulerGamma = 0.5772156649015328606065120900824024310421593359399235988057672348849;
    
    /**
        Glaisher-Kinkelin constant.
        See http://en.wikipedia.org/wiki/Glaisher%E2%80%93Kinkelin_constant 
    */
    public static let Glaisher = 1.2824271291006226368753425688697917277676889273250011920637400217404063088588264611297;
    
    /** 
        The golden ratio; (1+Sqrt[5])/2.
        See http://en.wikipedia.org/wiki/Golden_ratio 
    */
    public static let GoldenRatio = 1.6180339887498948482045868343656381177203091798057628621354486227052604628189024497072;
    
    /** 
        The inverse of the Euler constant; 1/[e]. 
    */
    public static let InverseEuler = 0.36787944117144232159552377016146086744581113103176;
    
    /** 
        The inverse of Pi; 1/[Pi]. 
    */
    public static let InversePi = 0.31830988618379067153776752674502872406891929148091;
    
    /** 
        The inverse of the square root of twice Pi; 1/Sqrt[2*Pi]. 
    */
    public static let InvSqrt2Pi = 0.39894228040143267793994605993438186847585863116492;
    
    /** 
        The inverse of the square root of Pi; 1/Sqrt[Pi]. 
    */
    public static let InvSqrtPi = 0.56418958354775628694807945156077258584405062932899;
    
    /** 
        The Khinchin constant.
        See http://en.wikipedia.org/wiki/Khinchin_constant 
    */
    public static let Khinchin = 2.6854520010653064453097148354817956938203822939944629530511523455572188595371520028011;
    
    /** 2^(-53)  */
    // not sure here
    //public static let RelativeAccuracy = Functions.EpsilonOf(1.0);
    
    /** 2^(-1074)  */
    public static let SmallestNumberGreaterThanZero = 1e-50;
    
    /**
        The logorithm of <c>E</c> in base 2; log[2](e).  
    */
    public static let Log2E = 1.4426950408889634073599246810018921374266459541530;
    
    /** 
        The logorithm of 2 in base <c>e</c>; log[e](2). 
    */
    public static let Ln2 = 0.69314718055994530941723212145817656807550013436026;
    
    /** 
        The logorithm of <c>10</c> in base e; log[e](10).  
    */
    public static let Ln10 = 2.3025850929940456840179914546843642076011014886288;
    
    /** 
        The logorithm of <c>Pi</c> in base e; log[e](10).  
    */
    public static let LnPi = 1.1447298858494001741434273513530587116472948129153;
    
    /** 
        The well-know Pi constant.
    */
    public static let Pi = 3.14159265358979323846264338327950288419716939937510582097494459230781640628620899862803482534211706798214808651328230664709384460955058223172535940813;
    
    /** 
        Pi over 180; Pi/180.  
    */
    public static let PiOver180 = 0.017453292519943295769236907684886127134428718885417;
    
    /** 
        Pi over 2; [Pi]/2.  
    */
    public static let PiOver2 = 1.5707963267948966192313216916397514420985846996876;
    
    /** 
        Pi over 4; [Pi]/4. 
    */
    public static let PiOver4 = 0.78539816339744830961566084581987572104929234984378;
    
    /** 
        The square root of 1/2.  
    */
    public static let Sqrt1Over2 = 0.70710678118654752440084436210484903928483593768845;
    
    /**
        The square root of two.
    */
    public static let Sqrt2 = 1.4142135623730950488016887242096980785696718753769;

    /** 
        The square root of two time Pi; Sqrt[2*Pi].  
    */
    public static let Sqrt2Pi = 2.5066282746310005024157652848110452530069867406099;
    
    /**
        The square root of 3, divided by two; Sqrt[3]/2.
    */
    public static let Sqrt3DividedBy2 = 0.86602540378443864676372317075293618347140262690520;
    
    /**
        The square root of Pi; Sqrt[Pi].  
    */
    public static let SqrtPi = 1.7724538509055160272981674833411451827975494561224;
    
    /** 
        The speed of light (in vacuum) in [m s^-1].
        See http://en.wikipedia.org/wiki/Speed_of_light
    */
    public static let SpeedOfLight = 2.99792458e8;
    
    /**
        The Planck's constant in [J s = m^2 kg s^-1].
        See http://en.wikipedia.org/wiki/Planck_constant
    */
    public static let PlancksConstant = 6.62606896e-34;
    
    /** 
        The Planck length in [h_bar/(m_p*c_0)].
        See http://en.wikipedia.org/wiki/Plancks_length
    */
    public static let PlancksLength = 1.616253e-35;
    
    /** 
        The Newtonian constant in [m^3 kg^-1 s^-2].
        See http://en.wikipedia.org/wiki/Gravitational_Constant
    */
    public static let GravitationalConstant = 6.67429e-11;
    
    /** 
        The magnetic permeability (in vacuum) in [kg m s^-2 A^-2].
        See http://en.wikipedia.org/wiki/Magnetic_Permeability
    */
    public static let MagneticPermeability = 1.2566370614359172953850573533118011536788677597500e-6;
    
    
    /** 
        The electric permittivity (in vacuum) in [s^4 kg^-1 A^2 m^-3].
        See http://en.wikipedia.org/wiki/Electric_Permittivity 
    */
    public static let ElectricPermittivity = 8.8541878171937079244693661186959426889222899381429e-12;
}