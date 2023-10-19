
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath}


dance_track := class(creative_device):

    @editable
    BeginDanceTrackButton : button_device = button_device{}

    @editable
    LaneLeft : dance_track_lane = dance_track_lane{}

    @editable
    LaneRight : dance_track_lane = dance_track_lane{}

    @editable
    SignalRemoteGrey : signal_remote_manager_device = signal_remote_manager_device{}

    var Movements : []dance_note = array{}


    OnBegin<override>()<suspends> : void =

        BeginDanceTrackButton.InteractedWithEvent.Subscribe(HandleButtonInteraction)

        SignalRemoteGrey.PrimarySignalEvent.Subscribe(HandleRemotePrimary)
        SignalRemoteGrey.SecondarySignalEvent.Subscribe(HandleRemoteSecondary)

        InitialiseMovements()

        CycleThroughMovements()


    HandleButtonInteraction(Agent : agent) : void =

        Print("Button Pressed")
        

    HandleRemotePrimary(Agent : agent) : void =
        
        LaneLeft.CatchNote()

 
    HandleRemoteSecondary(Agent : agent) : void = 

        LaneRight.CatchNote()


    InitialiseMovements() : void = 
        
        for (NoteID := 1..30):
            if (Mod[NoteID, 3] = 0):
                set Movements += array{MakeDanceNote("R", 0.5)}
            else:
                set Movements += array{MakeDanceNote("L", 0.3)}

    
    CycleThroughMovements()<suspends> : void = 
        
        for (Movement : Movements):

            if (Movement.Lane = "L"):
                LaneLeft.SpawnNote()

            if (Movement.Lane = "R"):
                LaneRight.SpawnNote()

            Sleep(Movement.TimeUntilNextNote)
        
