using { /Verse.org/Assets }

MakeDanceNote<constructor>(_Lane : string, _TimeUntilNextNote : float) := dance_note: 

    Lane := _Lane
    TimeUntilNextNote := _TimeUntilNextNote

dance_note<public> := class<final>:

    Lane<public> : string

    TimeUntilNextNote<public> : float
