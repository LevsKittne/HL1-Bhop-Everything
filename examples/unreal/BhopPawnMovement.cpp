#include "BhopPawnMovement.h"
#include "bhop_core.hpp"
#include "Components/CapsuleComponent.h"
#include "Engine/World.h"
#include "GameFramework/Pawn.h"

UBhopPawnMovement::UBhopPawnMovement() { PrimaryComponentTick.bCanEverTick=true; }
void UBhopPawnMovement::TickComponent(float Dt,ELevelTick TickType,FActorComponentTickFunction* Fn)
{
    Super::TickComponent(Dt,TickType,Fn);
    if (!PawnOwner || !UpdatedComponent || ShouldSkipUpdate(Dt) || Dt<=0) return;
    // Production multiplayer must use the game's prediction/authority path.
    if (GetWorld()->GetNetMode()!=NM_Standalone) return;
    UCapsuleComponent* Capsule=Cast<UCapsuleComponent>(UpdatedComponent);
    if (!Capsule) return;
    FCollisionQueryParams Query(SCENE_QUERY_STAT(BhopGround),false,PawnOwner);
    FHitResult Floor;
    const FVector Origin=UpdatedComponent->GetComponentLocation();
    const float Probe=Capsule->GetScaledCapsuleHalfHeight()+3;
    const bool HitFloor=GetWorld()->LineTraceSingleByChannel(Floor,Origin,Origin-FVector(0,0,Probe),ECC_Visibility,Query);
    const bool Grounded=HitFloor && Floor.ImpactNormal.Z>=0.7f && Velocity.Z<=0;
    const bool Jump=Grounded && bJumpHeld;
    const FVector Input=ConsumeInputVector().GetClampedToMaxSize(1);
    const float Scale=FMath::Max(GSUnitsPerCentimeter,0.0001f);
    hl1_bhop::Settings Settings;Settings.stock_bunny_limit=bStockBunnyLimit;
    auto Next=hl1_bhop::step({float(Velocity.X*Scale),float(Velocity.Y*Scale)},
        {float(Input.X*MaxSpeedUPS),float(Input.Y*MaxSpeedUPS)},Dt,MaxSpeedUPS,Grounded,Jump,Settings);
    Velocity.X=Next.x/Scale;Velocity.Y=Next.y/Scale;
    if (Jump) Velocity.Z=FMath::Sqrt(2*Gravity*JumpHeight);
    else if (Grounded) Velocity.Z=-20;
    Velocity.Z-=Gravity*Dt;
    FHitResult Hit;
    const FVector Delta=Velocity*Dt;
    SafeMoveUpdatedComponent(Delta,UpdatedComponent->GetComponentQuat(),true,Hit);
    if (Hit.IsValidBlockingHit())
    {
        HandleImpact(Hit,Dt,Delta);
        SlideAlongSurface(Delta,1-Hit.Time,Hit.Normal,Hit,true);
        if ((Hit.Normal.Z>0.7f && Velocity.Z<0) || (Hit.Normal.Z<-.7f && Velocity.Z>0)) Velocity.Z=0;
    }
    const FVector Actual=(UpdatedComponent->GetComponentLocation()-Origin)/Dt;
    Velocity.X=Actual.X;Velocity.Y=Actual.Y;
    CurrentUPS=Actual.Size2D()*Scale;
    UpdateComponentVelocity();
}
