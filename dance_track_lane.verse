
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath}

dance_track_lane := class(creative_device):

    # TODO : Declare which key the lane will use to activate a note. 

    # The anchors for the dance track lane, should be passed through in a constructor
    TrackAnchors : anchors = anchors{}

    # A mapping between the Player and the widget that may have been added to their UI
    var MaybeUIPerPlayer : [player]?canvas = map{}

    # This should be called right after a dance_track_lane is initialised
    InitialiseLaneUI(Agent : agent) : void =
        if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):
            
            LaneUI := CreateLaneUI()
            PlayerUI.AddWidget(LaneUI)
            if (set MaybeUIPerPlayer[InPlayer] = option{LaneUI}) {}

    
    # TODO : Add a visual for where the player should press the lanes note key.
    # A canvas widget that displays a color_block which acts as a track lane
    CreateLaneUI() : canvas =
        Canvas : canvas = canvas:
            Slots := array:
                canvas_slot:
                    Anchors := TrackAnchors
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    SizeToContent := true
                    Widget := color_block:
                        DefaultColor := NamedColors.LightGray

        return Canvas
