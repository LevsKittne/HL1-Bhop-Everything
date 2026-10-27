#pragma once
#include "CoreMinimal.h"
#include "GameFramework/Pawn.h"
#include "BhopPawn.generated.h"
class UBhopPawnMovement;
class UCapsuleComponent;
class UCameraComponent;

UCLASS()
class ABhopPawn : public APawn
{
    GENERATED_BODY()
public:
    ABhopPawn();
    virtual UPawnMovementComponent* GetMovementComponent() const override;
    virtual void SetupPlayerInputComponent(UInputComponent* Input) override;
    UFUNCTION(BlueprintCallable,Category="Bhop") void MoveForward(float Value);
    UFUNCTION(BlueprintCallable,Category="Bhop") void MoveRight(float Value);
    UFUNCTION(BlueprintCallable,Category="Bhop") void StartJump();
    UFUNCTION(BlueprintCallable,Category="Bhop") void EndJump();
    UPROPERTY(VisibleAnywhere,BlueprintReadOnly,Category="Bhop") TObjectPtr<UBhopPawnMovement> Movement;
    UPROPERTY(VisibleAnywhere,BlueprintReadOnly,Category="Bhop") TObjectPtr<UCapsuleComponent> Capsule;
    UPROPERTY(VisibleAnywhere,BlueprintReadOnly,Category="Bhop") TObjectPtr<UCameraComponent> Camera;
};
