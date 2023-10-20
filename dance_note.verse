using { /Verse.org/Assets }

MakeDanceNote<constructor>(_Lane : string, _TimeUntilNextNote : float) := dance_note: 

    Lane := _Lane
    TimeUntilNextNote := _TimeUntilNextNote

dance_note := class:

    Lane : string

    TimeUntilNextNote : float
