#pragma once
#include "CoreMinimal.h"
#include "GameFramework/PawnMovementComponent.h"
#include "BhopPawnMovement.generated.h"

// Standalone teaching controller: not a CMC networking replacement.
UCLASS(ClassGroup=Movement,meta=(BlueprintSpawnableComponent))
class UBhopPawnMovement : public UPawnMovementComponent
{
    GENERATED_BODY()
public:
    UBhopPawnMovement();
    UPROPERTY(EditAnywhere,BlueprintReadWrite,Category="Bhop") float GSUnitsPerCentimeter=0.4f;
    UPROPERTY(EditAnywhere,BlueprintReadWrite,Category="Bhop") float MaxSpeedUPS=300;
    UPROPERTY(EditAnywhere,BlueprintReadWrite,Category="Bhop") float Gravity=2000;
    UPROPERTY(EditAnywhere,BlueprintReadWrite,Category="Bhop") float JumpHeight=75;
    UPROPERTY(EditAnywhere,BlueprintReadWrite,Category="Bhop") bool bStockBunnyLimit=false;
    UPROPERTY(EditAnywhere,BlueprintReadWrite,Category="Bhop") bool bJumpHeld=false;
    UPROPERTY(VisibleAnywhere,BlueprintReadOnly,Category="Bhop") float CurrentUPS=0;
    virtual void TickComponent(float DeltaTime,ELevelTick TickType,FActorComponentTickFunction* ThisTickFunction) override;
};
