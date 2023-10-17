
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
    SignalRemoteGrey : signal_remote_manager_device = signal_remote_manager_device{}

    OnBegin<override>()<suspends> : void =

        BeginDanceTrackButton.InteractedWithEvent.Subscribe(HandleButtonInteraction)

        SignalRemoteGrey.PrimarySignalEvent.Subscribe(HandleRemotePrimary)
        SignalRemoteGrey.SecondarySignalEvent.Subscribe(HandleRemoteSecondary)


    HandleButtonInteraction(Agent : agent) : void =

        MakeDanceTrackLane(TrackAnchors := anchors{Minimum := vector2{X := 0.15, Y := 0.47}, Maximum := vector2{X := 0.85, Y := 0.53}}, Agent)


    # TODO : Implement this function    
    HandleRemotePrimary(Agent : agent) : void =
        Print("Primary bound")


    # TODO : Implement this function    
    HandleRemoteSecondary(Agent : agent) : void = 
        Print("Secondary bound")

        
