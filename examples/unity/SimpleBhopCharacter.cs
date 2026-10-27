using UnityEngine;
using Hl1Bhop;

// Local CharacterController teaching example. Integrate with the existing
// controller instead of attaching this beside another movement component.
[RequireComponent(typeof(CharacterController))]
public sealed class SimpleBhopCharacter : MonoBehaviour
{
    [Min(.001f)] public float GoldSrcUnitsPerWorldUnit=40;
    public float MaxSpeedUPS=300;
    public float Gravity=20;
    public float JumpHeight=.75f;
    public bool AutoJump=true;
    public bool StockBunnyLimit=false;
    public bool ReadLegacyInput=true;
    public Transform View;
    public float MouseSensitivity=2;
    CharacterController body;
    Vector3 velocity;
    Vector2 moveInput;
    bool held,pressed;
    float pitch;
    GUIStyle meter;

    void Awake() { body=GetComponent<CharacterController>(); }
    // Connect the project's real InputActions here when not using legacy input.
    public void SubmitInput(Vector2 movement,bool jumpHeld)
    {
        moveInput=Vector2.ClampMagnitude(movement,1);
        pressed |= jumpHeld && !held;
        held=jumpHeld;
    }
    void Update()
    {
#if ENABLE_LEGACY_INPUT_MANAGER
        if (ReadLegacyInput)
        {
            SubmitInput(new Vector2(Input.GetAxisRaw("Horizontal"),Input.GetAxisRaw("Vertical")),Input.GetButton("Jump"));
            transform.Rotate(0,Input.GetAxisRaw("Mouse X")*MouseSensitivity,0);
            pitch=Mathf.Clamp(pitch-Input.GetAxisRaw("Mouse Y")*MouseSensitivity,-89,89);
            if (View) View.localRotation=Quaternion.Euler(pitch,0,0);
        }
#endif
    }
    void FixedUpdate()
    {
        float dt=Time.fixedDeltaTime,scale=Mathf.Max(.001f,GoldSrcUnitsPerWorldUnit);
        bool ground=body.isGrounded;
        bool jump=ground && (AutoJump ? held : pressed);
        pressed=false;
        Vector3 forward=Vector3.ProjectOnPlane(transform.forward,Vector3.up).normalized;
        Vector3 right=Vector3.Cross(Vector3.up,forward);
        Vector3 wish=(right*moveInput.x+forward*moveInput.y)*MaxSpeedUPS;
        Planar next=BhopMath.Step(new Planar(velocity.x*scale,velocity.z*scale),
            new Planar(wish.x,wish.z),dt,MaxSpeedUPS,ground,jump,StockBunnyLimit);
        velocity.x=next.X/scale;velocity.z=next.Y/scale;
        if (jump) velocity.y=Mathf.Sqrt(2*Gravity*JumpHeight);
        else if (ground && velocity.y<0) velocity.y=-2;
        velocity.y-=Gravity*dt;
        CollisionFlags hit=body.Move(velocity*dt);
        if ((hit & CollisionFlags.Above)!=0 && velocity.y>0) velocity.y=0;
        if ((hit & CollisionFlags.Below)!=0 && velocity.y<0) velocity.y=-2;
        // Feed wall-constrained horizontal motion back into the next step.
        velocity.x=body.velocity.x;velocity.z=body.velocity.z;
    }
    void OnGUI()
    {
        if (Event.current.type!=EventType.Repaint) return;
        if (meter==null)
        {
            meter=new GUIStyle(GUI.skin.label) { alignment=TextAnchor.MiddleCenter,fontStyle=FontStyle.Bold };
            meter.normal.textColor=Color.white;
        }
        meter.fontSize=Mathf.Clamp(Screen.height/300,2,8)*20;
        float ups=new Vector2(body.velocity.x,body.velocity.z).magnitude*GoldSrcUnitsPerWorldUnit;
        string label=Mathf.Clamp(Mathf.FloorToInt(ups),0,999999).ToString();
        Rect rect=new Rect(0,Screen.height-meter.fontSize-30,Screen.width,meter.fontSize+10);
        Color saved=GUI.color;
        GUI.color=new Color(0,0,0,.75f);GUI.Label(new Rect(rect.x+2,rect.y+2,rect.width,rect.height),label,meter);
        GUI.color=new Color(1,160f/255,0,1);GUI.Label(rect,label,meter);
        GUI.color=saved;
    }
}
