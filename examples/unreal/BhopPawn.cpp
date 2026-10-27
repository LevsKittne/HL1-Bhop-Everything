#include "BhopPawn.h"
#include "BhopPawnMovement.h"
#include "Components/CapsuleComponent.h"
#include "Components/InputComponent.h"
#include "Camera/CameraComponent.h"

ABhopPawn::ABhopPawn()
{
    Capsule=CreateDefaultSubobject<UCapsuleComponent>(TEXT("Capsule"));
    Capsule->InitCapsuleSize(34,88);
    Capsule->SetCollisionProfileName(TEXT("Pawn"));
    SetRootComponent(Capsule);
    Camera=CreateDefaultSubobject<UCameraComponent>(TEXT("Camera"));
    Camera->SetupAttachment(Capsule);
    Camera->SetRelativeLocation(FVector(0,0,64));
    Camera->bUsePawnControlRotation=true;
    Movement=CreateDefaultSubobject<UBhopPawnMovement>(TEXT("BhopMovement"));
    Movement->SetUpdatedComponent(Capsule);
    bUseControllerRotationYaw=true;
    AutoPossessPlayer=EAutoReceiveInput::Player0;
}
UPawnMovementComponent* ABhopPawn::GetMovementComponent() const { return Movement; }
void ABhopPawn::MoveForward(float V) { AddMovementInput(GetActorForwardVector(),V); }
void ABhopPawn::MoveRight(float V) { AddMovementInput(GetActorRightVector(),V); }
void ABhopPawn::StartJump() { Movement->bJumpHeld=true; }
void ABhopPawn::EndJump() { Movement->bJumpHeld=false; }
void ABhopPawn::SetupPlayerInputComponent(UInputComponent* Input)
{
    Super::SetupPlayerInputComponent(Input);
    Input->BindAxis("MoveForward",this,&ABhopPawn::MoveForward);
    Input->BindAxis("MoveRight",this,&ABhopPawn::MoveRight);
    Input->BindAxis("Turn",this,&APawn::AddControllerYawInput);
    Input->BindAxis("LookUp",this,&APawn::AddControllerPitchInput);
    Input->BindAction("Jump",IE_Pressed,this,&ABhopPawn::StartJump);
    Input->BindAction("Jump",IE_Released,this,&ABhopPawn::EndJump);
}
