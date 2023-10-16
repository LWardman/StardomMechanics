
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }


dance_track_note := class(creative_device):

    Start : vector2 = vector2{}
    End : vector2 = vector2{}
    var CurrentPosition : vector2 = vector2{}

    TimeToComplete : float = 1.0
    var CurrentTime : float = 0.0

    # Self-defined tick. e.g Tick(0.016) gives 60FPS behaviour.
    Tick(DeltaTime : float)<suspends> : void = 
        
        Velocity : vector2 = (End - Start) / TimeToComplete

        loop:
            LerpCurrentPosition(CurrentTime / TimeToComplete, Velocity)

            if (CurrentTime >= TimeToComplete):
                break

            set CurrentTime += DeltaTime

    # Progress takes a value between 0 and 1.
    LerpCurrentPosition(Progress : float, Velocity : vector2)<suspends> : void =
        
        set CurrentPosition = Start + (Velocity * CurrentTime)

    UpdateUIPosition(Position : vector2)<suspends> : void =

        # Needs a UI representation before it can be updated

