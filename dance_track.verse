
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath}


dance_track := class(creative_device):

    # Called at the beginning of play.
    OnBegin<override>()<suspends> : void =

        BeginDanceTrackButton.InteractedWithEvent.Subscribe(HandleBeginDanceTrackButtonInteraction)

        SignalRemoteGrey.PrimarySignalEvent.Subscribe(HandleRemotePrimary)
        SignalRemoteGrey.SecondarySignalEvent.Subscribe(HandleRemoteSecondary)

        InitialiseMovements()


    @editable
    BeginDanceTrackButton<private> : button_device = button_device{}
    

    # Lane left and Lane right are the lane's where dance_notes will be sent down for the player to catch.
    @editable
    LaneLeft<private> : dance_track_lane = dance_track_lane{}

    @editable
    LaneRight<private> : dance_track_lane = dance_track_lane{}


    # The player must use a signal_remote to hit the notes. NOTE : This restricts the dance track to a maximum of two possible lanes.
    @editable
    SignalRemoteGrey<private> : signal_remote_manager_device = signal_remote_manager_device{}

    # Score widget and it's text will be displayed after the dance track is completed.
    ScoreWidget<private> : text_block = text_block{DefaultTextColor := NamedColors.White}
    ScoreText<localizes><private>(Score : float) : message = "{Score}"

    # MaybeUIPerPlayer and PlayerAgent are only used to display the score to the player.
    var MaybeUIPerPlayer<private> : [player]?canvas = map{}
    var PlayerAgent<private> : ?agent := false

    # Storage used to feed notes into each lane.
    var Movements<private> : []dance_note = array{}


    HandleBeginDanceTrackButtonInteraction<private>(Agent : agent) : void =

        set PlayerAgent = option{Agent}
        spawn{CycleThroughMovementsThenShowScore()}
        

    HandleRemotePrimary<private>(Agent : agent) : void =
        
        LaneLeft.CatchNote()

 
    HandleRemoteSecondary<private>(Agent : agent) : void = 

        LaneRight.CatchNote()


    # Here is where to change the pattern that the notes come out in. 
    InitialiseMovements<private>() : void = 
        
        # Creates a "L", "L" , "R" pattern and repeats it 10 times.
        for (NoteID := 1..30):
            if (Mod[NoteID, 3] = 0):
                set Movements += array{MakeDanceNote("R", 0.6)}
            else:
                set Movements += array{MakeDanceNote("L", 0.4)}

    
    CycleThroughMovementsThenShowScore<private>()<suspends> : void = 
        
        for (Movement : Movements):

            if (Movement.Lane = "L"):
                LaneLeft.SpawnNote()

            if (Movement.Lane = "R"):
                LaneRight.SpawnNote()

            Sleep(Movement.TimeUntilNextNote)

        Sleep(2.0) # Waits two seconds before displaying the score.

        ScoreWidget.SetText(ScoreText(GetFinishedScore()))
        InitialiseScoreUI()

    # Score is calculated as the arithmetic mean that the player scored on all their notes.
    GetFinishedScore<private>() : float =

        return (LaneLeft.CalculateOverallScore() + LaneRight.CalculateOverallScore()) / (Movements.Length * 1.0)    

    
    InitialiseScoreUI<private>() : void =

        if (InPlayer := player[ValidAgent := PlayerAgent?], PlayerUI := GetPlayerUI[InPlayer]):
            
            LaneUI := CreateScoreUI()
            PlayerUI.AddWidget(LaneUI)
            if (set MaybeUIPerPlayer[InPlayer] = option{LaneUI}) {}

    
    CreateScoreUI<private>() : canvas =
        Canvas : canvas = canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors:
                        Minimum := vector2{X := 0.5, Y := 0.05}
                        Maximum := vector2{X := 0.5, Y := 0.05}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    SizeToContent := true
                    Widget := ScoreWidget
                
        return Canvas
