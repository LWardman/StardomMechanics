
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath}


MakeDanceTrackLane<constructor>(_Agent : agent) := dance_track_lane:

    Agent := option{_Agent}


dance_track_lane := class(creative_device):

    @editable
    NoteProp : creative_prop_asset := DefaultCreativePropAsset

    @editable
    NoteSpawnRegion : vector3 = vector3{}

    @editable
    NoteCatchRegion : vector3 = vector3{}

    @editable
    NoteDestructRegion : vector3 = vector3{}

    @editable
    NoteTimeToTravel : float = 1.0

    # Keeps a reference to the agent who started the dance track, potentially invalid so must be checked when used.
    Agent : ?agent := false

    OnBegin<override>()<suspends> : void =

        loop:
            SpawnNote()
            Sleep(1.0)


    SpawnNote()<suspends> : void =

        SpawnedProp := SpawnProp(NoteProp, NoteSpawnRegion, IdentityRotation())
        Prop := SpawnedProp(0)

        if (Note := Prop?):
            Note.MoveTo(NoteDestructRegion, IdentityRotation(), NoteTimeToTravel)

    





