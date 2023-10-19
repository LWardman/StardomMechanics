
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath}
using { /Verse.org/Assets }


dance_track_lane := class(creative_device):

    @editable
    NoteProp : creative_prop_asset := DefaultCreativePropAsset

    @editable
    CatchIndicator : creative_prop_asset := DefaultCreativePropAsset

    @editable
    NoteSpawnRegion : vector3 = vector3{}

    @editable
    NoteCatchRegion : vector3 = vector3{}

    @editable
    NoteDestructRegion : vector3 = vector3{}

    @editable
    NoteTimeToTravel : float = 2.0

    var Timer : float = 0.0


    OnBegin<override>()<suspends> : void =

        SpawnedCatchIndicator := SpawnProp(CatchIndicator, NoteCatchRegion, IdentityRotation())
    

    SpawnNote() : void =

        SpawnedProp := SpawnProp(NoteProp, NoteSpawnRegion, IdentityRotation())
        Prop := SpawnedProp(0)

        if (Note := Prop?):
            spawn{Note.MoveTo(NoteDestructRegion, IdentityRotation(), NoteTimeToTravel)}

    # Get closest note in the lane
    # Calculate it's score
    # Update the Note's score variable
    CatchNote() : void = 
        {}


    