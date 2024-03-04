# About

The Arabic Number to Roman Numeral conversion algorithm was given to me during an in-person, group iOS engineering interview.
I didn't get to see my implementation through and I was still thinking about it when I left and wanting to test the recursive 
implementation I was imagining. I figured it would be a good opportunity to practice building a quick Single View Application using 
SwiftUI.

# Discussion

## Recusive Implementation

To me, the recursive implementation felt like the best option. The additive or subtractive nature of each term and the natural
way I would convert them in my head led me to this conclusion. It did not feel like an expensive algorithm because the longest
Roman Numeral is nine symbols.

## Singleton Class

In deciding how I would modularize the conversion logic I created a RomanNumeral class. The class has two main methods, one that
converts from a Roman Numeral to an Arabic number and one that does the opposite. I chose a Singleton becuase there was never 
more than one Roman Numeral being converted and it allowed for future class-based modifications. It could also be achieved using
static methods in the same way.

## Statefulness

This was an excersice for me in SwiftUI and primarily designing a Stateful application. I chose only two States, the variable 
that holds the number or roman numeral that is entered by the user and the conversion type either to Roman Numeral or to Arabic
Number. All UI variations are a function of these two states.
