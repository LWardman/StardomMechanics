
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath}


dance_track := class(creative_device):

    OnBegin<override>()<suspends> : void =

        BeginDanceTrackButton.InteractedWithEvent.Subscribe(HandleButtonInteraction)

        SignalRemoteGrey.PrimarySignalEvent.Subscribe(HandleRemotePrimary)
        SignalRemoteGrey.SecondarySignalEvent.Subscribe(HandleRemoteSecondary)

        InitialiseMovements()


    @editable
    BeginDanceTrackButton<private> : button_device = button_device{}

    @editable
    LaneLeft<private> : dance_track_lane = dance_track_lane{}

    @editable
    LaneRight<private> : dance_track_lane = dance_track_lane{}

    @editable
    SignalRemoteGrey<private> : signal_remote_manager_device = signal_remote_manager_device{}


    ScoreWidget<private> : text_block = text_block{DefaultTextColor := NamedColors.White}
    ScoreText<localizes><private>(Score : float) : message = "{Score}"

    var MaybeUIPerPlayer<private> : [player]?canvas = map{}
    var PlayerAgent<private> : ?agent := false

    var Movements<private> : []dance_note = array{}


    HandleButtonInteraction<private>(Agent : agent) : void =

        set PlayerAgent = option{Agent}
        spawn{CycleThroughMovements()}
        

    HandleRemotePrimary<private>(Agent : agent) : void =
        
        LaneLeft.CatchNote()

 
    HandleRemoteSecondary<private>(Agent : agent) : void = 

        LaneRight.CatchNote()


    InitialiseMovements<private>() : void = 
        
        for (NoteID := 1..30):
            if (Mod[NoteID, 3] = 0):
                set Movements += array{MakeDanceNote("R", 0.6)}
            else:
                set Movements += array{MakeDanceNote("L", 0.4)}

    
    CycleThroughMovements<private>()<suspends> : void = 
        
        for (Movement : Movements):

            if (Movement.Lane = "L"):
                LaneLeft.SpawnNote()

            if (Movement.Lane = "R"):
                LaneRight.SpawnNote()

            Sleep(Movement.TimeUntilNextNote)

        Sleep(2.0)
        ScoreWidget.SetText(ScoreText(GetFinishedScore()))
        InitialiseScoreUI()


    GetFinishedScore<private>() : float =

        OverallScore : float = (LaneLeft.CalculateOverallScore() + LaneRight.CalculateOverallScore()) / GetFloatLengthOfMovements()


    GetFloatLengthOfMovements<private>() : float =

        var Result : float = 0.0

        for (Movement : Movements):
            set Result += 1.0

        return Result

    
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
