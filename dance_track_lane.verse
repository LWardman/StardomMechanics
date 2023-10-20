
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath}
using { /Verse.org/Assets }


dance_track_lane := class(creative_device):

    OnBegin<override>()<suspends> : void =

        SpawnedCatchIndicator := SpawnProp(CatchIndicator, NoteCatchRegion, IdentityRotation())
    

    CalculateOverallScore<public>() : float =

        var OverallScore : float = 0.0

        FillOutEmptyScores()

        for (Score : Scores):
            set OverallScore += Score

        return OverallScore


    SpawnNote<public>() : void =

        SpawnedProp := SpawnProp(NoteProp, NoteSpawnRegion, IdentityRotation())
        Prop := SpawnedProp(0)

        if (Note := Prop?):
            set Notes += array{Note}
            spawn{Note.MoveTo(NoteDestructRegion, IdentityRotation(), NoteTimeToTravel)}

    
    CatchNote<public>() : void = 
        
        ClosestNote : tuple(creative_prop, float) = GetClosestNote()
        Note := ClosestNote(0)
        DistanceSquare := ClosestNote(1)

        NoteScore : float = CalculateScoreOfCaughtNote(DistanceSquare)
        set Scores += array{NoteScore}



    @editable
    NoteProp<private> : creative_prop_asset := DefaultCreativePropAsset

    @editable
    CatchIndicator<private> : creative_prop_asset := DefaultCreativePropAsset

    @editable
    NoteSpawnRegion<private> : vector3 = vector3{}

    @editable
    NoteCatchRegion<private> : vector3 = vector3{}

    @editable
    NoteDestructRegion<private> : vector3 = vector3{}

    @editable
    NoteTimeToTravel<private> : float = 2.0

    var Notes<private> : []creative_prop = array{}

    var Scores<private> : []float = array{}


    GetClosestNote<private>() : tuple(creative_prop, float) =
        
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


    CalculateScoreOfCaughtNote<private>(DistanceSquare : float) : float =

        var Score : float = 100.0

        Penalty : float = DistanceSquare * 0.02

        set Score = Max(Score - Penalty, 0.0)

        return Score
        
    
    FillOutEmptyScores<private>() : void =

        if (Scores.Length < Notes.Length):
            for (X := 1..(Notes.Length - Scores.Length)):
                set Scores += array{0.0}                    # Appends an empty score for each note missed.


    SquareMagnitude<private>(Vector : vector3) : float =

        MagnitudeSquared : float = Vector.X * Vector.X + Vector.Y * Vector.Y + Vector.Z * Vector.Z
        return MagnitudeSquared   
        