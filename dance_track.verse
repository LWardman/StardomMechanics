
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath}


dance_track := class(creative_device):

    @editable
    BeginDanceTrackButton : button_device = button_device{}

    OnBegin<override>()<suspends> : void =
        BeginDanceTrackButton.InteractedWithEvent.Subscribe(HandleButtonInteraction)

    HandleButtonInteraction(Agent : agent) : void =

        dance_track_lane1 := dance_track_lane{TrackAnchors := anchors{Minimum := vector2{X := 0.15, Y := 0.47}, Maximum := vector2{X := 0.85, Y := 0.53}}}
        dance_track_lane1.InitialiseLaneUI(Agent);
