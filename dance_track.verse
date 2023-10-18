
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

    OnBegin<override>()<suspends> : void =

        BeginDanceTrackButton.InteractedWithEvent.Subscribe(HandleButtonInteraction)

        SignalRemoteGrey.PrimarySignalEvent.Subscribe(HandleRemotePrimary)
        SignalRemoteGrey.SecondarySignalEvent.Subscribe(HandleRemoteSecondary)


    HandleButtonInteraction(Agent : agent) : void =

        Print("Button Pressed")
        

    # TODO : Implement this function    
    HandleRemotePrimary(Agent : agent) : void =
        Print("Primary bound")


    # TODO : Implement this function    
    HandleRemoteSecondary(Agent : agent) : void = 
        Print("Secondary bound")

        
