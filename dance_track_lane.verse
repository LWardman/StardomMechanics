
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

    var Notes : []creative_prop = array{}


    OnBegin<override>()<suspends> : void =

        SpawnedCatchIndicator := SpawnProp(CatchIndicator, NoteCatchRegion, IdentityRotation())
    

    SpawnNote() : void =

        SpawnedProp := SpawnProp(NoteProp, NoteSpawnRegion, IdentityRotation())
        Prop := SpawnedProp(0)

        if (Note := Prop?):
            set Notes += array{Note}
            spawn{Note.MoveTo(NoteDestructRegion, IdentityRotation(), NoteTimeToTravel)}

    
    CatchNote() : void = 
        
        ClosestNote : tuple(creative_prop, float) = GetClosestNote()
        Note := ClosestNote(0)
        DistanceSquare := ClosestNote(1)

        NoteScore : float = CalculateScoreOfCaughtNote(DistanceSquare)
        # Update the Note's score variable


    GetClosestNote() : tuple(creative_prop, float) =
        
        var ClosestNote : creative_prop = creative_prop{}
        var ClosestDistanceSquare : float = 1000000.0               # Set high so that any note will always pass this test.

        for (Note : Notes):

            NoteLocation : vector3 = Note.GetTransform().Translation

            Delta : vector3 = NoteLocation - NoteCatchRegion

            DistanceSquare : float = SquareMagnitude(Delta)

            if (DistanceSquare < ClosestDistanceSquare):
                set ClosestNote = Note
                set ClosestDistanceSquare = DistanceSquare

        return (ClosestNote, ClosestDistanceSquare)

    
    SquareMagnitude(Vector : vector3) : float =

        MagnitudeSquared : float = Vector.X * Vector.X + Vector.Y * Vector.Y + Vector.Z * Vector.Z
        return MagnitudeSquared

    CalculateScoreOfCaughtNote(DistanceSquare : float) : float =
        Print("{0.0}")
        return 0.0
    