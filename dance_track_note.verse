
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }

MakeDanceTrackNote<constructor>(_Start : vector2, _End : vector2, _Agent : agent) := dance_track_note:

        Start := _Start
        End := _End
        Agent := option{_Agent}

dance_track_note := class(creative_device):

    Start : vector2 = vector2{}
    End : vector2 = vector2{}
    var CurrentPosition : vector2 = vector2{}

    TimeToComplete : float = 1.0
    var CurrentTime : float = 0.0

    # A mapping between the Player and the widget that may have been added to their UI
    var MaybeUIPerPlayer : [player]?canvas = map{}

    Agent : ?agent = false

    OnBegin<override>()<suspends> : void =

        set CurrentPosition = Start

        InitialiseNoteUI()
        
        Tick(DeltaTime:float = 0.016)

    # e.g Tick(0.016) gives 60FPS behaviour.
    Tick(DeltaTime : float)<suspends> : void = 
        
        Velocity : vector2 = (End - Start) / TimeToComplete

        loop:
            LerpCurrentPosition(CurrentTime / TimeToComplete, Velocity)
            UpdateUIPosition(CurrentPosition)

            if (CurrentTime >= TimeToComplete):
                break

            set CurrentTime += DeltaTime

            Sleep(DeltaTime)

    # Progress takes a value between 0 and 1.
    LerpCurrentPosition(Progress : float, Velocity : vector2)<suspends> : void =
        
        set CurrentPosition = Start + (Velocity * CurrentTime)

    # This should be called right after a dance_track_note is initialised
    InitialiseNoteUI() : void =

        if (InPlayer := player[ValidAgent := Agent?], PlayerUI := GetPlayerUI[InPlayer]):
            
            NoteUI := CreateNoteUI()
            PlayerUI.AddWidget(NoteUI)
            if (set MaybeUIPerPlayer[InPlayer] = option{NoteUI}) {}


    UpdateUIPosition(Position : vector2)<suspends> : void =
        {}
        # TODO : Reposition the UI representation of the note.

    # Creates a UI representation of the note
    CreateNoteUI() : canvas =
        Canvas : canvas = canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    SizeToContent := false
                    Widget := texture_block:
                        DefaultImage := Textures.Note
                        DefaultDesiredSize := vector2{X := 128.0, Y := 128.0}

        return Canvas

