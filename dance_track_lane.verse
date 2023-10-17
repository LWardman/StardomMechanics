
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath}


MakeDanceTrackLane<constructor>(_TrackAnchors : anchors, _Agent : agent) := dance_track_lane:
    TrackAnchors := _TrackAnchors
    Agent := option{_Agent}


dance_track_lane := class(creative_device):

    # TODO : Declare which key the lane will use to activate a note. 

    # The anchors for the dance track lane, should be passed through in a constructor
    TrackAnchors : anchors = anchors{}

    # A mapping between the Player and the widget that may have been added to their UI
    var MaybeUIPerPlayer : [player]?canvas = map{}

    # Keeps a reference to the agent who started the dance track.
    Agent : ?agent := false

    OnBegin<override>()<suspends> : void =

        InitialiseLaneUI()


    # This should be called right after a dance_track_lane is initialised
    InitialiseLaneUI() : void =

        if (InPlayer := player[ValidAgent := Agent?], PlayerUI := GetPlayerUI[InPlayer]):
            
            LaneUI := CreateLaneUI()
            PlayerUI.AddWidget(LaneUI)
            if (set MaybeUIPerPlayer[InPlayer] = option{LaneUI}) {}

    # TODO : Implement SpawnNote
    # 1. Get center position of the spawn area.
    # 2. Get center position of the destruction area.
    # 3. Spawn a note passing in the Spawn as Start and Destruction as End
    # 4. Initialise Note UI
    #
    # OR, just spawn the note and trigger a constructor, let the note deal with it's implementation.
    SpawnNote() : void =
        {}
    
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

                canvas_slot:   
                    Anchors := anchors{Minimum := vector2{X := TrackAnchors.Maximum.X - 0.05, Y := TrackAnchors.Minimum.Y}, Maximum := TrackAnchors.Maximum}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    SizeToContent := true
                    Widget := color_block:
                        DefaultColor := NamedColors.CornflowerBlue

                canvas_slot:   
                    Anchors := anchors{Minimum := vector2{X := TrackAnchors.Minimum.X + 0.05, Y := TrackAnchors.Minimum.Y}, Maximum := vector2{X := TrackAnchors.Minimum.X + 0.1, Y := TrackAnchors.Maximum.Y}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    SizeToContent := true
                    Widget := color_block:
                        DefaultColor := NamedColors.ForestGreen

                canvas_slot:   
                    Anchors := anchors{Minimum := TrackAnchors.Minimum, Maximum := vector2{X := TrackAnchors.Minimum.X + 0.05, Y := TrackAnchors.Maximum.Y}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    SizeToContent := true
                    Widget := color_block:
                        DefaultColor := NamedColors.Crimson


        return Canvas
