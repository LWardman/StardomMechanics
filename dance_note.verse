
using { /Verse.org/Assets }


MakeDanceNote<constructor>(_Lane : string, _TimeUntilNextNote : float) := dance_note: 

    Lane := _Lane
    TimeUntilNextNote := _TimeUntilNextNote


dance_note<public> := class<final>:

    Lane<public> : string                       # Decides whether the note will enter through the left or right lane.

    TimeUntilNextNote<public> : float           # Determines how long the program will sleep for before sending another Note it's corresponding lane.
