' Comet / IPD No. 548 / June, 1985 / 4 Players
' Original table done by Bord
' VR Room Mods, implementation of Fleep sounds, dynamic shadows, and other features for Version 2.0 by UnclePaulie
' 	Testing and feedback provided by Rawd, PinStratsDan, Rothbauerw, Bord, Apophis, Sixtoe, Fluffhead, Wylte, Remdwaas, and RIK

'******** Revisions done on VR version 1.0 by UnclePaulie *********
' - Added all the VR Cab primatives (Used from Defender VR and Space Shuttle VR, as similar Williams Table); adjusted as appropriate
' - Matched cabinet colors for flipper buttons (normally black, but also over a metal side rail, so made them red)
' - Score alphanumeric displays and code Used from Fathom VR Table and rearranged 
' - Backglass Image from Hauntfreak's B2S file... Note:  ONLY the image.  The rest of display done in code.
' - Added plunger primary and code for movement
' - Added two different VR room environments
' - Moved ball shadows back under the apron, as you could see them in VR
' - Added GI to backglass
' - Ramp 15 and 16 removed
' - Rotated the 10 lane triggers 180 degrees, lowered the suface height by 8, and changed the width to 0.75; except for sw46
' - Moved the lane triggers forward to align with plywood holes
' - Rotated the million triggers to 190 to align with plywood hole insets better.  Also moved sw26 foreward a little to align.
' - SW46 moved down a bit, made visible, and changed wire thickness to 0.1
' - Changed playfeild shadow layers to z height of .03 to avoide a z fighting issue.  
' - Added an apron Wall
' - Moved the plunger back a little, so ball sits right before launch.  Also increased mechanical strength to 1.2
' - Changed the ball image and added jp_scratches for decal to enhance the ball rolling realism
' - Increased light intensity from 14 to 100 for the four down lanes (1986)... they were a little hard to see through back ramp.  
' - Increased the z height of the plastics_prim to 4 (from 0).  The white peg holders and screws were too high, and needed to move a little.
' - Sixtoe made one mod to the bumper material to be plastic with image opacity.  Made the bumpers look more realistic
' v1.1: Added the interactive backglass (game over, tilt, ball in play, etc.).  Primary and several flashers were added GI was added for backglass light flashers

'******** Revisions done by UnclePaulie on Hybrid version 0.1 - 2.0 *********
' v0.1: Enabled desktop, VR, and cabinet modes
' 		Added LUT options with save option (all modes)
' 		Added lighter ball images provided by hauntfreaks and g5k ball scratches, changeable in script 
'		Added an optional VR Clock, 
'		Animated the plunger, flippers, and start button for VR mode
'		Glass and scratches options added for VR mode (Rawd solution).  Not used for cab or desktop
'		Added new image for desktop mode backglass. 
'		Updated VR backglass to have dynamic off color for LED displays
' v0.2:	Added interactive flashers to backglass for VR
' v0.3: Enabled show mesh on the lights on layer 6.  This looks better in VR.
'		Added plywood holes under sling1 and 2.  Changed sling1 and 2 to better primitives.  More realistic, and hang below playfield.
'		Changed flipper buttons to yellow, like real table.
' v0.4: Added Fleep Sounds (part implemented), nFozzy / Roth physics and flippers.
'		Added VPW Dynamic Ball Shadows to the solution done Iakki, Apophis, and Wylte
'		Increased the visibility of the dynamic ball shadows. 
'		Bord provided updated flippers, plunger, and playfield friction
' v0.5:	Fleep Sounds finished with Bord's physics primitives
' v0.6:	Replaced drop target to the solution done by Rothbauerw, also enabled drop target shadows.
' 		Updated ramprolling sounds by fluffhead35 as well as ballroll and ramproll amplication sounds 
'		Made the plastics collidable to prevent a bounced ball from going in.  (not sure if needed, but just in case large ball bounce.)
' v0.7 	bord - bumped flipper strength slightly, added Roth's flipper dampening script (replaces Rubberizer)
' v0.8 	Added a wall near the drop target and standup target.  Wylte found a corner condition that if the ball slow rolls near target after drop is dropped, it pops up through plastic, or could get stuck behind target.
'		The wall still allows it to pop above the plastic, but doesn't fall behind, so play continues.  Mostly a corner condition.  Might add something more...
' v0.8a	Changed the desktop text to EM Reels to prevent not seeing correctly on 4k monitors.  Bord provided advice based off @scottacus prior solutions
' v0.9	Added wall 0.1 under playfield by flippers to prevent ball from dropping below playfield when ball hung on an end of flipper.  (rothbauerw suggestion)
'		Added Ramp shooter lane grooves and ball release wall to better emulate ball in shooter lane (rothbauerw suggestion)
'		Adjusted the friction, elasticity, and falloff of the corcscrew ramp to just allow the ball to go through from a right flipper cradle.  (should be hard, not impossible)
'		also had to bump the flipper strength up slightly to get ball up corkscrew.
'		Adjusted friction of plastic ramp slightly.  Ball went a little too fast on it.
' v0.10	Added code to correct corner condition where ball can get stuck on corkscrew. (Rothbauerw provided code)
'		Changed z height of metalrails_prim to 0.5.  There was a slight z fighting issue with the playfield.  
'		Increased height of physical wall of plastic ramp by 25.  Corner condition, one time ball jumped over the ramp when entered really fast.
' v0.11	Adjusted the height of the rubbers on posts slightly for better visual placement.
'		Moved outerwalls_prim forward by one vp unit.  Slight "Y" fighting visual issue on back wall.
' v0.12	Added an optional topper for VR.  Thanks to JoePicasso for the image.
'		Fixed issue with rabbit bonus being collected when coming out of million ramp (thanks Rothbauerw for fixing, and PinStratsDan for finding)
' v0.13	Added a difficutly setting for the left outlane post.  IRL, it can be moved to help nudge the ball back into the playfield.  (thanks to PinStratsDan for finding)
' v0.14	Added additional tweaks to the backglass in VR.
' v0.15	Removed collidable on window glass on layer 11.
'		RIK found an issue with rabbit collection bonus not working.  Corrected issue in sw24_UnHit and sw25_UnHit removing bsSaucer calls
' v0.16 Rawd mentioned that tilt sensitivity for keyboard nudging takes too many times to enable.  Changed sensitivity to 1.
'		Removed original gate3.  Ball rolled out weird.  (RIK, Wylte helped)
'		Added a visible gate (you can see a gate IRL).  Adjusted gate4 postion and size.  This was essential to getting the ball to come out correctly.
'		Changed friction of right ramp to 0.275.  It slowed down too much going up. (RIK)
'		Adjusted the saucer24 kickout angle, force, and variability.  It wasn't coming out correctly, should come out to right flipper slowly
' v0.17	Changed the windowglass on layer 11 to a toy as it seemed it was still colliding with the million ramp shot.
'		Lowered the elasticity of gate4 to .45.  Better bounce and slightly more variable roll out of gate.
' v2.0	Official Release
' v2.1	Astronasty indicatd that there was a flipper nudge code update needed, as the ball would hover, or get atypical bounces or roll too far on flippers.  It was recently done on Indy.
' v2.2	Rothbauerw suggested changing the height of the invisible playfield flipper wall to .01.  It''ll avoid the slight nudge Astronasty reported
' v2.3	Herwah noticed the plunger trigger activated when the plunger pulled back, not when ball releasd.  Trigger in wrong location.  Moved back 10 vp units.
' 		Put the million ramp to friction of .285.  Still could get corner condition of the ball to jump slightly over.


Option Explicit
Randomize


'*******************************************
' OPTIONS
'*******************************************

'----- Difficulty Options -----

const leftoutlanepost = 1 '0 = hard, 1 = normal (default).  Just moves a post such that it will allow for nudging the ball back into playfield if hit just right.  The real table allows for this setting.

'----- Desktop, VR, or Full Cabinet Options -----

const VR_Room = 0 ' 0 is desktop or cab mode, 1 is VR Room
const cab_mode = 1 ' 1 is set for cabinet mode to turn off the desktop version of the backglass score lights 
const BallBrightness = 1 '0 = dark, 1 = brighter, 2 = brightest

' *** If using VR Room:

const CustomWalls = 0 	'set to 0 for Modern Minimal Walls, floor, and roof, 1 for Sixtoe's original walls and floor
const WallClock = 0	  	'1 Shows the clock in the VR room only   
Const Glass = 0			'0 = Off 1 = On - Glass visible in VR Room
Const Scratches = 0		'0 = Off 1 = On - Glass scratches visible in VR Room
const topper = 0		'0 = Off 1= On - Topper visible in VR Room only


'----- Shadow Options -----
Const DynamicBallShadowsOn = 0		'0 = no dynamic ball shadow ("triangles" near slings and such), 1 = enable dynamic ball shadow
Const AmbientBallShadowOn = 0		'0 = Static shadow under ball ("flasher" image, like JP's)
									'1 = Moving ball shadow ("primitive" object, like ninuzzu's)
									'2 = flasher image shadow, but it moves like ninuzzu's
Const fovY					= 0		'Offset y position under ball to account for layback or inclination (more pronounced need further back)
Const DynamicBSFactor 		= 1 	'0 to 1, higher is darker (default is 0.95)
Const AmbientBSFactor 		= 1		'0 to 1, higher is darker (default is 0.7)
Const AmbientMovement		= 2		'1 to 4, higher means more movement as the ball moves left and right
Const Wideness				= 20	'Sets how wide the dynamic ball shadows can get (20 +5 thinness should be most realistic for a 50 unit ball)
Const Thinness				= 5		'Sets minimum as ball moves away from source

'----- General Sound Options -----
Const VolumeDial = 0.8				' Recommended values should be no greater than 1.

'/////////////////////-----BallRoll Sound Amplification -----/////////////////////
Const BallRollAmpFactor = 1 ' 0 = no amplification, 1 = 2.5db amplification, 2 = 5db amplification, 3 = 7.5db amplification, 4 = 9db amplification (aka: Tie Fighter)


'-----RampRoll Sound Amplification -----/////////////////////
Const RampRollAmpFactor = 3 ' 0 = no amplification, 1 = 2.5db amplification, 2 = 5db amplification, 3 = 7.5db amplification, 4 = 9db amplification (aka: Tie Fighter)


'----- Phsyics Mods -----
Const RubberizerEnabled = 0			'0 = normal flip rubber, 1 = more lively rubber for flips, 2 = a different rubberizer
Const FlipperCoilRampupMode = 2   	'0 = fast, 1 = medium, 2 = slow (tap passes should work)
Const TargetBouncerEnabled = 1 		'0 = normal standup targets, 1 = bouncy targets, 2 = orig TargetBouncer
Const TargetBouncerFactor = 0.7 	'Level of bounces. Recommmended value of 0.7 when TargetBouncerEnabled=1, and 1.1 when TargetBouncerEnabled=2


'*******************************************
' LUT setup and options
'*******************************************

Dim LUTset, DisableLUTSelector, LutToggleSound, LutToggleSoundLevel

LutToggleSound = True
LutToggleSoundLevel = .1
DisableLUTSelector = 0  ' Disables the ability to change LUT option with magna saves in game when set to 1

LoadLUT
'LUTset = 17			' Override saved LUT for debug
SetLUT
ShowLUT_Init


'*******************************************
' Table Setup, Constants, and Global Variables
'*******************************************

On Error Resume Next
ExecuteGlobal GetTextFile("controller.vbs")
If Err Then MsgBox "You need the controller.vbs in order to run this table, available in the vp10 package"
On Error Goto 0

Const cGameName="comet_l5"
Const UseSolenoids=2
Const UseLamps=0
Const UseGI=0
Const SSolenoidOn="SolOn"
Const SSolenoidOff="SolOff"

Const UsingROM = True
Const BallSize = 50
Const BallMass = 1
Const tnob = 2 ' total number of balls
Const lob = 0   'number of locked balls


Dim tablewidth: tablewidth = Table1.width
Dim tableheight: tableheight = Table1.height
Dim BIPL : BIPL = False				'Ball in plunger lane

LoadVPM "01560000", "S11.VBS", 3.26


'*******************************************
'  Solenoid Call backs
'*******************************************

SolCallback(1) = "bsTrough.SolOut"
SolCallback(2) = "SolDT29" 		'Drop Target 
SolCallback(3) = "bsSaucer.SolOut"
SolCallback(4) = "Setlamp 104,"	'Corkscrew Flash
SolCallback(5) = "Setlamp 105,"	'Cycle Flash
SolCallback(6) = "bsCycleSaucer.SolOut"
SolCallback(7) = "Sol7"		'BG Left Fireworks
SolCallback(8) = "Sol8"		'BG Top Fireworks
SolCallback(9) = "Sol9"		'BG Bottom Fireworks
SolCallback(10) = "Sol10"	'BG Right Fireworks
SolCallback(13) = "Sol13"	'BG General Illumination lights
SolCallback(11) = "PFGI"
SolCallback(15) = "SolKnocker" 'Knocker
SolCallback(23) = "vpmNudge.SolGameOn"
  
SolCallback(sLRFlipper) = "SolRFlipper"
SolCallback(sLLFlipper) = "SolLFlipper"


'*******************************************
'  Timers
'*******************************************

' The game timer interval is 10 ms
Sub GameTimer_Timer()
	Cor.Update 						'update ball tracking
	RollingUpdate					'update rolling sounds
	DoDTAnim 						'handle drop target animations
	UpdateGates
End Sub

' The frame timer interval is -1, so executes at the display frame rate
Sub FrameTimer_Timer()
	FlipperVisualUpdate				'update flipper shadows and primitives
	If DynamicBallShadowsOn Or AmbientBallShadowOn Then DynamicBSUpdate
End Sub


'*******************************************
'  Flipper Shadow and Gate Subs
'*******************************************

' This subroutine updates the flipper shadows and visual primitives
Sub FlipperVisualUpdate
	batleftshadow.RotZ = LeftFlipper.currentangle
	batrightshadow.RotZ = RightFlipper.currentangle
	lflip.rotz = LeftFlipper.currentangle
	rflip.rotz = RightFlipper.currentangle
End Sub

Sub UpdateGates
	rampgate_prim.RotX = GateSw50.CurrentAngle
	rampexitgate_prim.RotX = Gatesw28.CurrentAngle+90
	corkscrewgate_prim.RotX = GateSw19.CurrentAngle
	plungegate_prim.RotX = Gate4.CurrentAngle + 90
End Sub


'*******************************************
'  Playfield GI 
'*******************************************

dim GIIsOff

Sub PFGI(Enabled)

    Dim opacityoff, opacityon
	opacityoff=100
	opacityon=200

	If Enabled Then
		GiOFF
		dim xx
        PlaySound "fx_relay"
		GIIsOff=true
	Else
		GiON
        PlaySound "fx_relay"
		GIIsOff=false
	end if 
End Sub

Sub GiON
	Dim x
	For each x in Gi:x.State = 1:Next
	FLasher1.visible=1
	Flasher3.visible=0
	If dtup = 1 Then	
		Flasher5.visible=1  'lights are on, and droptarget is up then want shadow.
	Else
		Flasher5.visible=0  'droptarget is down.  No shadow.
	End If

End Sub

Sub GiOFF
	Dim x
	For each x in Gi:x.State = 0:Next
	FLasher1.visible=0
	Flasher3.visible=1
	Flasher5.visible=0

End Sub




'*******************************************
'  Initiate Table
'*******************************************

Dim bsTrough, bsSaucer, bsCycleSaucer

Sub Table1_Init
	vpmInit Me
	On Error Resume Next
		With Controller
		.GameName = cGameName
		If Err Then MsgBox "Can't start Game" & cGameName & vbNewLine & Err.Description : Exit Sub
		.SplashInfoLine = "Comet"&chr(13)&"Williams 1985"
		.HandleMechanics=0
		.HandleKeyboard=0
		.ShowDMDOnly=1
		.ShowFrame=0
		.ShowTitle=0
         On Error Resume Next
         .Run GetPlayerHWnd
         If Err Then MsgBox Err.Description
         On Error Goto 0
     End With
     On Error Goto 0
 
    PinMAMETimer.Interval = PinMAMEInterval
    PinMAMETimer.Enabled = 1

  	vpmNudge.TiltSwitch=1
  	vpmNudge.Sensitivity=.1
  	vpmNudge.TiltObj=Array(Bumper1,Bumper2,Bumper3,LeftSlingshot,RightSlingshot)

   Set bsTrough = New cvpmBallStack
       bsTrough.InitSw 0,45,0,0,0,0,0,0
       bsTrough.InitKick BallRelease, 90, 8
       bsTrough.Balls = 1
 
   Set bsSaucer = New cvpmBallStack
       bsSaucer.InitSaucer sw24,24, 190, 8
       bsSaucer.KickForceVar = 0.5
       bsSaucer.KickAngleVar = 0.5
 
  Set bsCycleSaucer = New cvpmBallStack
      bsCycleSaucer.InitSaucer sw25,25, 260, 8
      bsCycleSaucer.KickForceVar = 2
      bsCycleSaucer.KickAngleVar = 2
 
	if VR_Room = 1 Then
		setup_backglass()
		SetBackglass
	End If

	PinCab_Backglass.blenddisablelighting = .8

End Sub

Sub table1_exit
	SaveLUT
	Controller.stop
End Sub


'*******************************************
'  VR Plunger Code
'*******************************************

Sub TimerVRPlunger_Timer
  If PinCab_Shooter.Y < -280 then
       PinCab_Shooter.Y = PinCab_Shooter.Y + 5
  End If
End Sub

Sub TimerVRPlunger1_Timer
  PinCab_Shooter.Y = -373 + (5* Plunger.Position) -20
End Sub


'*******************************************
'  Table Keys
'*******************************************

Sub Table1_KeyDown(ByVal KeyCode)

	If keycode = LeftFlipperKey Then 
		VRFlipperButtonLeft.X = 2105.087 + 10
		FlipperActivate LeftFlipper, LFPress
		SolLFlipper True
	End If

	If keycode = RightFlipperKey Then 
		VRFlipperButtonRight.X = 2112.018 - 10
		FlipperActivate RightFlipper, RFPress
		SolRFlipper True	
	End If

	If KeyCode = PlungerKey Then
		Plunger.PullBack
		Plunger.Pullback:SoundPlungerPull()
		TimerVRPlunger.Enabled = True
		TimerVRPlunger1.Enabled = False
		PinCab_Shooter.Y = -373
	End If

	If keycode = LeftTiltKey Then Nudge 90, 5 : SoundNudgeLeft
	If keycode = RightTiltKey Then Nudge 270, 5 : SoundNudgeRight
	If keycode = CenterTiltKey Then Nudge 0, 3 : SoundNudgeCenter

	If keycode = RightMagnaSave Then 'AXS 'Fleep
		if DisableLUTSelector = 0 then
			If LutToggleSound Then
				Playsound "click", 0, LutToggleSoundLevel * VolumeDial, 0, 0.2, 0, 0, 0, 1
			End If
            LUTSet = LUTSet  + 1
			if LutSet > 17 then LUTSet = 0
			SetLUT
			ShowLUT
		end if
	end if

	If keycode = LeftMagnaSave Then
		if DisableLUTSelector = 0 then
			If LutToggleSound Then
				Playsound "click", 0, LutToggleSoundLevel * VolumeDial, 0, 0.2, 0, 0, 0, 1
			End If
			LUTSet = LUTSet - 1
			if LutSet < 0 then LUTSet = 17
			SetLUT
			ShowLUT
		end if
	end if

	If keycode = StartGameKey Then
		StartButton.y = 787.454 - 5
		SoundStartButton
	End If

	'If keycode = keyInsertCoin1 or keycode = keyInsertCoin2 or keycode = keyInsertCoin3 or keycode = keyInsertCoin4 Then 'Use this for ROM based games
	If keycode = AddCreditKey or keycode = AddCreditKey2 Then
		Select Case Int(rnd*3)
			Case 0: PlaySound ("Coin_In_1"), 0, CoinSoundLevel, 0, 0.25
			Case 1: PlaySound ("Coin_In_2"), 0, CoinSoundLevel, 0, 0.25
			Case 2: PlaySound ("Coin_In_3"), 0, CoinSoundLevel, 0, 0.25
		End Select
	End If

    If vpmKeyDown(keycode) Then Exit Sub

End Sub

Sub Table1_KeyUp(ByVal KeyCode)

	If keycode = PlungerKey Then 
		Plunger.Fire
		If BIPL = 1 Then
			SoundPlungerReleaseBall()			'Plunger release sound when there is a ball in shooter lane
		Else
			SoundPlungerReleaseNoBall()			'Plunger release sound when there is no ball in shooter lane
		End If
		TimerVRPlunger.Enabled = False
        TimerVRPlunger1.Enabled = True
		PinCab_Shooter.Y = -373
	End If

	If keycode = LeftFlipperKey Then 
		FlipperDeActivate LeftFlipper, LFPress
		SolLFlipper False	
		VRFlipperButtonLeft.X = 2105.087
	End If

	If keycode = RightFlipperKey Then 
		VRFlipperButtonRight.X = 2112.018
		FlipperDeActivate RightFlipper, RFPress
		SolRFlipper False	
	End If

	If keycode = StartGameKey Then
		StartButton.y = 787.454
	End If

	if vpmKeyUp(keycode) Then Exit Sub

End Sub

'*******************************************
'  Flippers
'*******************************************

Const ReflipAngle = 20

' Flipper Solenoid Callbacks (these subs mimics how you would handle flippers in ROM based tables)
Sub SolLFlipper(Enabled)
	If Enabled Then
		LF.Fire  'leftflipper.rotatetoend
		If leftflipper.currentangle < leftflipper.endangle + ReflipAngle Then 
			RandomSoundReflipUpLeft LeftFlipper
		Else 
			SoundFlipperUpAttackLeft LeftFlipper
			RandomSoundFlipperUpLeft LeftFlipper
		End If		
	Else
		LeftFlipper.RotateToStart
		If LeftFlipper.currentangle < LeftFlipper.startAngle - 5 Then
			RandomSoundFlipperDownLeft LeftFlipper
		End If
		FlipperLeftHitParm = FlipperUpSoundLevel
	End If
End Sub

Sub SolRFlipper(Enabled)
	If Enabled Then
		RF.Fire 'rightflipper.rotatetoend

		If rightflipper.currentangle > rightflipper.endangle - ReflipAngle Then
			RandomSoundReflipUpRight RightFlipper
		Else 
			SoundFlipperUpAttackRight RightFlipper
			RandomSoundFlipperUpRight RightFlipper
		End If
	Else
		RightFlipper.RotateToStart
		If RightFlipper.currentangle > RightFlipper.startAngle + 5 Then
			RandomSoundFlipperDownRight RightFlipper
		End If	
		FlipperRightHitParm = FlipperUpSoundLevel
	End If
End Sub


' Flipper collide subs
Sub LeftFlipper_Collide(parm)
	CheckLiveCatch Activeball, LeftFlipper, LFCount, parm
	LeftFlipperCollide parm
	if RubberizerEnabled = 1 then Rubberizer(parm)
	if RubberizerEnabled = 2 then Rubberizer2(parm)
End Sub

Sub RightFlipper_Collide(parm)
	CheckLiveCatch Activeball, RightFlipper, RFCount, parm
	RightFlipperCollide parm
	if RubberizerEnabled = 1 then Rubberizer(parm)
	if RubberizerEnabled = 2 then Rubberizer2(parm)
End Sub


'*******************************************
'  Slings
'*******************************************

Dim RStep, Lstep   ' Rstep and Lstep  are the variables that increment the animation

Sub RightSlingShot_Slingshot
	vpmTimer.PulseSw 48
	RandomSoundSlingshotRight SLING2
    RSling.Visible = 0
    RSling1.Visible = 1
    sling1.RotX = 26
    RStep = 0
    RightSlingShot.TimerEnabled = 1
End Sub

Sub RightSlingShot_Timer
    Select Case RStep
        Case 3:RSLing1.Visible = 0:RSLing2.Visible = 1:sling1.RotX = 14
        Case 4:RSLing2.Visible = 0:RSLing.Visible = 1:sling1.RotX = -20:RightSlingShot.TimerEnabled = 0:
    End Select
    RStep = RStep + 1
End Sub

Sub LeftSlingShot_Slingshot
	vpmTimer.PulseSw 47
	RandomSoundSlingshotLeft SLING2
    LSling.Visible = 0
    LSling1.Visible = 1
    sling2.RotX = 26
    LStep = 0
    LeftSlingShot.TimerEnabled = 1
End Sub

Sub LeftSlingShot_Timer
    Select Case LStep
        Case 3:LSLing1.Visible = 0:LSLing2.Visible = 1:sling2.RotX = 14
        Case 4:LSLing2.Visible = 0:LSLing.Visible = 1:sling2.RotX = -20:LeftSlingShot.TimerEnabled = 0:
    End Select
    LStep = LStep + 1
End Sub


'*******************************************
' Rubbers, sound is done in the collection
'*******************************************

Sub sw33_Hit:vpmTimer.PulseSw 33:End Sub 
Sub sw34_Hit:vpmTimer.PulseSw 34:End Sub 
Sub sw35_Hit:vpmTimer.PulseSw 35:End Sub 
Sub sw36_Hit:vpmTimer.PulseSw 36:End Sub 
Sub sw37_Hit:vpmTimer.PulseSw 37:End Sub 
Sub sw38_Hit:vpmTimer.PulseSw 38:End Sub 
Sub sw39_Hit:vpmTimer.PulseSw 39:End Sub 

'*******************************************
'  Bumpers
'*******************************************

Sub Bumper1_Hit
	vpmTimer.PulseSw 40
	RandomSoundBumperTop Bumper1
End Sub

Sub Bumper2_Hit
	vpmTimer.PulseSw 41
	RandomSoundBumperMiddle Bumper2
End Sub

Sub Bumper3_Hit
	vpmTimer.PulseSw 42
	RandomSoundBumperBottom Bumper3
End Sub


'*******************************************
'  Kickers, Saucers
'*******************************************


Sub Drain_Hit
	bsTrough.addball me
	RandomSoundDrain Drain
End Sub

Sub sw24_Hit
	bsSaucer.AddBall 0
	SoundSaucerLock
End Sub

Sub sw24_UnHit
	SoundSaucerKick 1, sw24
End Sub

Sub sw25_Hit
	bsCycleSaucer.AddBall 0
	SoundSaucerLock
End Sub

Sub sw25_UnHit
	SoundSaucerKick 1, sw25
End Sub

Sub Ballrelease_UnHit
	RandomSoundBallRelease Ballrelease
End Sub


'*******************************************
'Rollovers
'*******************************************

Sub sw9_Hit:Controller.Switch(9) = 1:End Sub
Sub sw9_UnHit:Controller.Switch(9) = 0:End Sub

Sub sw20_Hit:Controller.Switch(20) = 1:End Sub
Sub sw20_UnHit:Controller.Switch(20) = 0:End Sub

Sub sw21_Hit:Controller.Switch(21) = 1:End Sub
Sub sw21_UnHit:Controller.Switch(21) = 0:End Sub

Sub sw22_Hit:Controller.Switch(22) = 1:End Sub
Sub sw22_UnHit:Controller.Switch(22) = 0:End Sub

Sub sw23_Hit:Controller.Switch(23) = 1:End Sub
Sub sw23_UnHit:Controller.Switch(23) = 0:End Sub

Sub sw26_Hit:Controller.Switch(26) = 1:End Sub
Sub sw26_UnHit:Controller.Switch(26) = 0:End Sub

Sub sw27_Hit:Controller.Switch(27) = 1:End Sub
Sub sw27_UnHit:Controller.Switch(27) = 0:End Sub

Sub sw31_Hit:Controller.Switch(31) = 1:End Sub
Sub sw31_UnHit:Controller.Switch(31) = 0:End Sub

Sub sw32_Hit:Controller.Switch(32) = 1:End Sub
Sub sw32_UnHit:Controller.Switch(32) = 0:End Sub

Sub sw43_Hit:Controller.Switch(43) = 1:End Sub
Sub sw43_UnHit:Controller.Switch(43) = 0:End Sub

Sub sw44_Hit:Controller.Switch(44) = 1:End Sub
Sub sw44_UnHit:Controller.Switch(44) = 0:End Sub

Sub sw46_Hit:Controller.Switch(46) = 1:End Sub
Sub sw46_UnHit:Controller.Switch(46) = 0:End Sub


'*******************************************
'Drop Targets   
'*******************************************

dim dtup  ' variable used for drop shadows

Sub sw29_Hit
	DTHit 29
	TargetBouncer Activeball, 1
	dtup=0
	Flasher5.visible=0
End Sub

' Drop Target 29 Solenoid
Sub SolDT29(enabled)
	If enabled Then
		PlaySoundAt SoundFX(DTResetSound,DOFContactors), sw29p
		DTRaise 29
		dtup=1
		Flasher5.visible=1
	End If
End Sub


'********************************************
'Standup Targets
'********************************************

Sub sw10_Hit
	vpmTimer.PulseSw 10
	TargetBouncer Activeball, 1
End Sub

Sub sw11_Hit
	vpmTimer.PulseSw 11
	TargetBouncer Activeball, 1
End Sub

Sub sw12_Hit
	vpmTimer.PulseSw 12
	TargetBouncer Activeball, 1
End Sub

Sub sw13_Hit
	vpmTimer.PulseSw 13
	TargetBouncer Activeball, 1
End Sub

Sub sw14_Hit
	vpmTimer.PulseSw 14
	TargetBouncer Activeball, 1
End Sub

Sub sw15_Hit
	vpmTimer.PulseSw 15
	TargetBouncer Activeball, 1
End Sub

Sub sw16_Hit
	vpmTimer.PulseSw 16
	TargetBouncer Activeball, 1
End Sub

Sub sw17_Hit
	vpmTimer.PulseSw 17
	TargetBouncer Activeball, 1
End Sub

Sub sw18_Hit
	vpmTimer.PulseSw 18
	TargetBouncer Activeball, 1
End Sub


'*******************************************
'  Ramp Triggers
'*******************************************

Sub sw19_Hit
	vpmTimer.PulseSw 19
	WireRampOn True 'Play Plastic Ramp Sound
End Sub

Sub sw28_Hit
	vpmTimer.PulseSw 28
	WireRampOff ' Turn off the Plastic Ramp Sound
End Sub

Sub sw52_Hit
	PlaySoundAt "WireRamp_Stop", sw52
End Sub

Sub sw50_Hit
	vpmTimer.PulseSw 50
	WireRampOn True 'Play Plastic Ramp Sound
End Sub

Sub sw51_Hit
	WireRampOn True 'Play Plastic Ramp Sound
End Sub


'*******************************************
'  Knocker
'*******************************************

Sub SolKnocker(Enabled)
	If enabled Then
		KnockerSolenoid
	End If
End Sub


'*******************************************
'  JP's VP10 Fading Lamps & Flashers
'    - Based on PD's Fading Light System
' SetLamp 0 is Off
' SetLamp 1 is On
' fading for non opacity objects is 4 steps
'*******************************************

Dim LampState(200), FadingLevel(200)
Dim FlashSpeedUp(200), FlashSpeedDown(200), FlashMin(200), FlashMax(200), FlashLevel(200)
Dim ChangeBGLamps(200)

InitLamps()             ' turn off the lights and flashers and reset them to the default parameters
LampTimer.Interval = 5 'lamp fading speed
LampTimer.Enabled = 1

' Lamp & Flasher Timers



Sub LampTimer_Timer()
    Dim chgLamp, num, chg, ii
    chgLamp = Controller.ChangedLamps
    If Not IsEmpty(chgLamp) Then
        For ii = 0 To UBound(chgLamp)
            LampState(chgLamp(ii, 0) ) = chgLamp(ii, 1)       'keep the real state in an array
            FadingLevel(chgLamp(ii, 0) ) = chgLamp(ii, 1) + 4 'actual fading step
            ChangeBGLamps(chgLamp(ii, 0)) = chgLamp(ii, 1)
        Next
    End If
    UpdateLamps

    If VR_Room = 0 and cab_mode = 0 Then
        UpdateLeds
    End If

	If VR_Room=1 Then
		DisplayTimer
		Update_BGFlashers
	End If

End Sub


Sub Update_BGFlashers


' backdrop lights
	NumLamp 1, f1bg 'game over
	NumLamp 2, f2bg 'match
	NumLamp 3, f3bg 'tilt
	NumLamp 4, f4bg 'highscore
	NumLamp 5, f5bg 'shoots again
	NumLamp 6, f6bg 'ball in play
End Sub


Sub UpdateLamps


  	'FadeR 1, 'GameOver
   	'FadeR 2, 'Match
   	'FadeR 3, 'Tilt
   	'FadeR 4, 'HS
   	'FadeR 5, 'Ride Again 2x
   	'FadeR 6, 'BIP
   	'FadeR 7, 'Comet Eyes
   	'FadeR 8, 'Comet Eyes
 
   	NFadeLm 9, l9
   	NFadeLm 9, l9a
   	NFadeLm 9, l9z
   	NFadeLm 10, l10
   	NFadeLm 10, l10a
   	NFadeLm 10, l10z
   	NFadeLm 11, l11
   	NFadeLm 11, l11a
   	NFadeLm 11, l11z
   	NFadeLm 12, l12
   	NFadeLm 12, l12a
   	NFadeLm 12, l12z
   	NFadeLm 13, l13
   	NFadeLm 13, l13a
   	NFadeLm 13, l13z
   	NFadeLm 14, l14
   	NFadeLm 14, l14a
   	NFadeLm 14, l14z
   	NFadeLm 15, l15
   	NFadeLm 15, l15a
   	NFadeLm 15, l15z
   	NFadeLm 16, l16
   	NFadeLm 16, l16a
    NFadeLm 16, l16z
   	NFadeLm 17, l17
   	NFadeLm 17, l17a
   	NFadeLm 17, l17z
   	NFadeLm 18, l18
   	NFadeLm 18, l18a
   	NFadeLm 18, l18z
   	NFadeLm 19, l19
   	NFadeLm 19, l19a
   	NFadeLm 19, l19z
   	NFadeLm 20, l20
   	NFadeLm 20, l20a
   	NFadeLm 20, l20z
	Flash 20, f20
   	NFadeLm 21, l21
   	NFadeLm 21, l21a
   	NFadeLm 21, l21z
	Flash 21, f21
   	NFadeLm 22, l22
   	NFadeLm 22, l22a
   	NFadeLm 22, l22z
	Flash 22, f22
   	NFadeLm 23, l23
   	NFadeLm 23, l23a
   	NFadeLm 23, l23z
	Flash 23, f23
   	NFadeLm 24, l24
   	NFadeLm 24, l24a
   	NFadeLm 24, l24z 
   	NFadeLm 25, l25
   	NFadeLm 25, l25a
   	NFadeLm 25, l25z
   	NFadeLm 26, l26
   	NFadeLm 26, l26a
   	NFadeLm 26, l26z
   	NFadeLm 27, l27
   	NFadeLm 27, l27a
   	NFadeLm 27, l27z
   	NFadeLm 28, l28
   	NFadeLm 28, l28a
   	NFadeLm 28, l28z
   	NFadeLm 29, l29
   	NFadeLm 29, l29a
   	NFadeLm 29, l29z
   	NFadeLm 30, l30
   	NFadeLm 30, l30a
   	NFadeLm 30, l30z
   	NFadeLm 31, l31
   	NFadeLm 31, l31a
   	NFadeLm 31, l31z
   	NFadeLm 32, l32
   	NFadeLm 32, l32a
    NFadeLm 32, l32z
   	NFadeLm 33, l33
   	NFadeLm 33, l33a
   	NFadeLm 33, l33z
   	NFadeLm 34, l34
   	NFadeLm 34, l34a
   	NFadeLm 34, l34z
   	NFadeLm 35, l35
   	NFadeLm 35, l35a
   	NFadeLm 35, l35z
   	NFadeLm 36, l36
   	NFadeLm 36, l36a
   	NFadeLm 36, l36z
   	NFadeLm 37, l37
   	NFadeLm 37, l37a
   	NFadeLm 37, l37z
   	NFadeLm 38, l38
   	NFadeLm 38, l38a
   	NFadeLm 38, l38z
   	NFadeLm 39, l39
   	NFadeLm 39, l39a
   	NFadeLm 39, l39z
   	NFadeLm 40, l40
   	NFadeLm 40, l40a
   	NFadeLm 40, l40z
   	NFadeLm 41, l41
   	NFadeLm 41, l41a
   	NFadeLm 41, l41z
   	NFadeLm 42, l42
   	NFadeLm 42, l42a
   	NFadeLm 42, l42z
   	NFadeLm 43, l43
   	NFadeLm 43, l43a
   	NFadeLm 43, l43z
   	NFadeLm 44, l44
   	NFadeLm 44, l44a
   	NFadeLm 44, l44z
   	NFadeLm 45, l45
   	NFadeLm 45, l45a
   	NFadeLm 45, l45z
   	NFadeLm 46, l46
   	NFadeLm 46, l46a
   	NFadeLm 46, l46z
   	NFadeLm 47, l47
   	NFadeLm 47, l47a
   	NFadeLm 47, l47z
   	NFadeLm 48, l48
   	NFadeLm 48, l48a
    NFadeLm 48, l48z
   	NFadeLm 49, l49
   	NFadeLm 49, l49a
   	NFadeLm 49, l49z
   	NFadeLm 50, l50
   	NFadeLm 50, l50a
   	NFadeLm 50, l50z
   	NFadeLm 51, l51
   	NFadeLm 51, l51a
   	NFadeLm 51, l51z
   	NFadeLm 52, l52
   	NFadeLm 52, l52a
   	NFadeLm 52, l52z
   	NFadeLm 53, l53
   	NFadeLm 53, l53a
   	NFadeLm 53, l53z
   	NFadeLm 54, l54
   	NFadeLm 54, l54a
   	NFadeLm 54, l54z
   	NFadeLm 55, l55
   	NFadeLm 55, l55a
   	NFadeLm 55, l55z
   	NFadeLm 56, l56
   	NFadeLm 56, l56a
    NFadeLm 56, l56z
	NFadeLm 57, l57
	
   	NFadeLm 60, l60
   	NFadeLm 60, l60a
   	NFadeLm 60, l60z
   	NFadeLm 61, l61
   	NFadeLm 61, l61a
   	NFadeLm 61, l61z
   	NFadeLm 62, l62
   	NFadeLm 62, l62a
   	NFadeLm 62, l62z
   	NFadeLm 63, l63
   	NFadeLm 63, l63a
   	NFadeLm 63, l63z
   	NFadeLm 64, l64
   	NFadeLm 64, l64a
   	NFadeLm 64, l64z

 	'Solenoid Controlled Flashers
	NFadeLm 104, f104c
	NFadeLm 104, f104d
	Nfadelm 104, i104dummy
	Flashm 104, Flasher6
	
	NFadeLm 105, f105c
	NFadeLm 105, f105d
	Nfadelm 105, i105dummy
 	Flashm 105, Flasher7


	If GIIsOff=false Then
		corkscrew_prim.image = "corkscrew_gi"
		CorkscrewTube_prim.image = "Flashtube_gi"
		woodguides_prim.image = "woodguides_gi"
		cometbrackets_prim.image = "brackets_gi"
		plasticsedges_prim.image="plasticedgesGIOn"
		millionbackglass_prim.image = "millionbackglass_gi"
		metalrails_prim.image = "metals_gi"
		millionplastic_prim.image = "millionplastic_GI"
		millionbackbox_prim.image = "millionbackbox_gi"
		outerwalls_prim.image = "outer_gi"

		If l57.state = 1 Then
'			FadeObjm 150, millionbackglass_prim, "millionbackglass_rightflash", "millionbackglass_rightflash", "millionbackglass_rightflash", "millionbackglass_gi"
			FadeObjm 150, millionbackglass_prim, "millionbackglass_flash", "millionbackglass_flash", "millionbackglass_flash", "millionbackglass_gi"
			FadeObjm 151, metalrails_prim, "metals_gi_flash", "metals_gi_flash", "metals_gi_flash", "metals_gi"
			FadeObjm 152, millionplastic_prim, "millionplastic_gi_flash", "millionplastic_gi_flash", "millionplastic_gi_flash", "millionplastic_GI"
			FadeObjm 153, millionbackbox_prim, "millionbackbox_gi_flash", "millionbackbox_gi_flash", "millionbackbox_gi_flash", "millionbackbox_gi"
			FadeObjm 154, metalrails_prim, "metals_gi_flash", "metals_gi_flash", "metals_gi_flash", "metals_gi"
			FadeObjm 155, outerwalls_prim, "outer_gi_flash", "outer_gi_flash", "outer_gi_flash", "outer_gi"
		End If
	Else
		corkscrew_prim.image = "corkscrew_off"
		CorkscrewTube_prim.image = "flashtube_off"
		woodguides_prim.image =  "woodguides_gioff"
		cometbrackets_prim.image = "brackets_gioff"
		plasticsedges_prim.image="plasticedgesGIOff"
		millionbackglass_prim.image = "millionbackglass_gioff"
		metalrails_prim.image = "metals_gioff"
		millionplastic_prim.image = "millionplastic_GIoff"
		millionbackbox_prim.image = "millionbackbox_gi"
		outerwalls_prim.image = "outer_gioff"

	end if

		If GIIsOff=false and i105dummy.state = 1 and l57.state = 1 Then
			FadeObjm 161, millionbackglass_prim, "millionbackglass_flash", "millionbackglass_flash", "millionbackglass_flash", "millionbackglass_gi"
			FadeObjm 162, metalrails_prim, "metals_gi_flash", "metals_gi_flash", "metals_gi_flash","metals_gi"
			FadeObjm 163, millionplastic_prim, "millionplastic_GI_flash", "millionplastic_GI_flash", "millionplastic_GI_flash", "millionplastic_GI"
			FadeObjm 164, millionbackbox_prim, "millionbackbox_gi_flash", "millionbackbox_gi_flash", "millionbackbox_gi_flash", "millionbackbox_gi"
		End If

		If GIIsOff=false and i105dummy.state = 1 and l57.state = 0 Then
			FadeObjm 165, millionbackglass_prim, "millionbackglass_rightflash", "millionbackglass_rightflash", "millionbackglass_rightflash", "millionbackglass_gi"
			FadeObjm 166, metalrails_prim, "metals_gi_flashright", "metals_gi_flashright", "metals_gi_flashright", "metals_gi"
			FadeObjm 167, millionplastic_prim, "millionplastic_GI_flashright", "millionplastic_GI_flashright", "millionplastic_GI_flashright", "millionplastic_GI"
			FadeObjm 168, millionbackbox_prim, "millionbackbox_gioff_flashright", "millionbackbox_gioff_flashright", "millionbackbox_gioff_flashright", "millionbackbox_gi"
		End If

		If GIIsoff = false and i105dummy.state = 1 Then	
			FadeObjm 169, outerwalls_prim, "outer_gi_flashright", "outer_gi_flashright", "outer_gi_flashright", "outer_gi"
			FadeObjm 170, cometbrackets_prim, "brackets_gi_flashright", "brackets_gi_flashright", "brackets_gi_flashright", "brackets_gi"
			FadeObjm 188, plasticsedges_prim, "plasticedgesRFlash", "plasticedgesRFlash", "plasticedgesRFlash", "plasticedgesGIOn"
		End If

		If GIIsoff = True and i105dummy.state = 1 and l57.state = 0 Then
			FadeObjm 171, millionbackglass_prim, "millionbackglass_rightflash", "millionbackglass_rightflash", "millionbackglass_rightflash", "millionbackglass_gioff"
			FadeObjm 172, metalrails_prim, "metals_gioff_flashright", "metals_gioff_flashright", "metals_gioff_flashright", "metals_gioff"
			FadeObjm 173, millionplastic_prim, "millionplastic_GIoff_flashright", "millionplastic_GIoff_flashright", "millionplastic_GIoff_flashright", "millionplastic_GIoff"
			FadeObjm 174, millionbackbox_prim, "millionbackbox_gioff_flashright", "millionbackbox_gioff_flashright", "millionbackbox_gioff_flashright", "millionbackbox_gi"
		End If

		If GIIsoff = True and i105dummy.state = 1 Then	
			FadeObjm 175, outerwalls_prim, "outer_gioff_flashright", "outer_gioff_flashright", "outer_gioff_flashright", "outer_gioff"
			FadeObjm 176, cometbrackets_prim, "brackets_gioff_flashright", "brackets_gioff_flashright", "brackets_gioff_flashright", "brackets_gioff"
			FadeObjm 187, plasticsedges_prim, "plasticedgesGIOFFRFlash", "plasticedgesGIOFFRFlash", "plasticedgesGIOFFRFlash", "plasticedgesGIOFF"
		End If

		If GIIsOff=false and i105dummy.state = 1 and l57.state = 1 Then
			FadeObjm 177, millionbackglass_prim, "millionbackglass_flash", "millionbackglass_flash", "millionbackglass_flash", "millionbackglass_gioff"
			FadeObjm 178, metalrails_prim, "metals_gioff_flash", "metals_gioff_flash", "metals_gioff_flash", "metals_gioff"
			FadeObjm 179, millionplastic_prim, "millionplastic_GIoff_flash", "millionplastic_GIoff_flash", "millionplastic_GIoff_flash", "millionplastic_GIoff"
			FadeObjm 180, millionbackbox_prim, "millionbackbox_gioff_flash", "millionbackbox_gioff_flash", "millionbackbox_gioff_flash", "millionbackbox_gi"
		End If

		If GIIsOff=false and i104dummy.state = 1 Then
			FadeObjm 181, corkscrew_prim, "corkscrew_flash", "corkscrew_flash", "corkscrew_flash", "corkscrew_gi"
			FadeObjm 182, CorkscrewTube_prim, "flashtube_flash", "flashtube_flash", "flashtube_flash", "Flashtube_gi"
			FadeObjm 183, outerwalls_prim, "outer_gi_flashleft", "outer_gi_flashleft", "outer_gi_flashleft", "outer_gi"
			FadeObjm 184, metalrails_prim, "metals_gi_flashleft", "metals_gi_flashleft", "metals_gi_flashleft", "metals_gi"
			FadeObjm 185, cometbrackets_prim, "brackets_gi_flashleft", "brackets_gi_flashleft", "brackets_gi_flashleft", "brackets_gi"
			FadeObjm 186, plasticsedges_prim, "plasticedgesLFlash", "plasticedgesLFlash", "plasticedgesLFlash", "plasticedgesGIOn"
		End If
	
End Sub


Sub NumLamp(nr, object)
    Select Case ChangeBGLamps(nr)
        Case 0:object.visible = 0:ChangeBGLamps(nr) = 0
        Case 1:object.visible = 1:ChangeBGLamps(nr) = 1
    End Select
End Sub



' div lamp subs


Sub InitLamps()
    Dim x
    For x = 0 to 200
        LampState(x) = 0        ' current light state, independent of the fading level. 0 is off and 1 is on
        FadingLevel(x) = 4      ' used to track the fading state
        FlashSpeedUp(x) = 0.4   ' faster speed when turning on the flasher
        FlashSpeedDown(x) = 0.2 ' slower speed when turning off the flasher
        FlashMax(x) = 1         ' the maximum value when on, usually 1
        FlashMin(x) = 0         ' the minimum value when off, usually 0
        FlashLevel(x) = 0       ' the intensity of the flashers, usually from 0 to 1
		ChangeBGLamps(x) = 0    ' lamps on backglass
    Next
End Sub

Sub AllLampsOff
    Dim x
    For x = 0 to 200
        SetLamp x, 0
    Next
End Sub

Sub FadePrim(nr, pri, a, b, c, d)
    Select Case FadingLevel(nr)
        Case 2:pri.image = d:FadingLevel(nr) = 0
        Case 3:pri.image = c:FadingLevel(nr) = 2
        Case 4:pri.image = b:FadingLevel(nr) = 3
        Case 5:pri.image = a:FadingLevel(nr) = 1
    End Select
End Sub

Sub SetLamp(nr, value)
    If value <> LampState(nr) Then
        LampState(nr) = abs(value)
        FadingLevel(nr) = abs(value) + 4
    End If
End Sub

' Lights: used for VP10 standard lights, the fading is handled by VP itself

Sub NFadeL(nr, object)
    Select Case FadingLevel(nr)
        Case 4:object.state = 0:FadingLevel(nr) = 0
        Case 5:object.state = 1:FadingLevel(nr) = 1
    End Select
End Sub

Sub NFadeLm(nr, object) ' used for multiple lights
    Select Case FadingLevel(nr)
        Case 4:object.state = 0
        Case 5:object.state = 1
    End Select
End Sub

'Lights, Ramps & Primitives used as 4 step fading lights
'a,b,c,d are the images used from on to off

Sub FadeObj(nr, object, a, b, c, d)
    Select Case FadingLevel(nr)
        Case 4:object.image = b:FadingLevel(nr) = 6                   'fading to off...
        Case 5:object.image = a:FadingLevel(nr) = 1                   'ON
        Case 6, 7, 8:FadingLevel(nr) = FadingLevel(nr) + 1             'wait
        Case 9:object.image = c:FadingLevel(nr) = FadingLevel(nr) + 1 'fading...
        Case 10, 11, 12:FadingLevel(nr) = FadingLevel(nr) + 1         'wait
        Case 13:object.image = d:FadingLevel(nr) = 0                  'Off
    End Select
End Sub

Sub FadeObjm(nr, object, a, b, c, d)
    Select Case FadingLevel(nr)
        Case 4:object.image = b
        Case 5:object.image = a
        Case 9:object.image = c
        Case 13:object.image = d
    End Select
End Sub

Sub NFadeObj(nr, object, a, b)
    Select Case FadingLevel(nr)
        Case 4:object.image = b:FadingLevel(nr) = 0 'off
        Case 5:object.image = a:FadingLevel(nr) = 1 'on
    End Select
End Sub

Sub NFadeObjm(nr, object, a, b)
    Select Case FadingLevel(nr)
        Case 4:object.image = b
        Case 5:object.image = a
    End Select
End Sub

' Flasher objects

Sub Flash(nr, object)
    Select Case FadingLevel(nr)
        Case 4 'off
            FlashLevel(nr) = FlashLevel(nr) - FlashSpeedDown(nr)
            If FlashLevel(nr) < FlashMin(nr) Then
                FlashLevel(nr) = FlashMin(nr)
                FadingLevel(nr) = 0 'completely off
            End if
            Object.IntensityScale = FlashLevel(nr)
        Case 5 ' on
            FlashLevel(nr) = FlashLevel(nr) + FlashSpeedUp(nr)
            If FlashLevel(nr) > FlashMax(nr) Then
                FlashLevel(nr) = FlashMax(nr)
                FadingLevel(nr) = 1 'completely on
            End if
            Object.IntensityScale = FlashLevel(nr)
    End Select
End Sub

Sub Flashm(nr, object) 'multiple flashers, it just sets the flashlevel
    Object.IntensityScale = FlashLevel(nr)
End Sub

 'Reels
Sub FadeReel(nr, reel)
    Select Case FadingLevel(nr)
        Case 2:FadingLevel(nr) = 0
        Case 3:FadingLevel(nr) = 2
        Case 4:reel.Visible = 0:FadingLevel(nr) = 3
        Case 5:reel.Visible = 1:FadingLevel(nr) = 1
    End Select
End Sub

 'Inverted Reels
Sub FadeIReel(nr, reel)
    Select Case FadingLevel(nr)
        Case 2:FadingLevel(nr) = 0
        Case 3:FadingLevel(nr) = 2
        Case 4:reel.Visible = 1:FadingLevel(nr) = 3
        Case 5:reel.Visible = 0:FadingLevel(nr) = 1
    End Select
End Sub


'Texts

Sub NFadeT(nr, object, message)
    Select Case FadingLevel(nr)
        Case 4:object.Text = "":FadingLevel(nr) = 0
        Case 5:object.Text = message:FadingLevel(nr) = 1
    End Select
End Sub

Sub NFadeTm(nr, object, message)
    Select Case FadingLevel(nr)
        Case 4:object.Text = ""
        Case 5:object.Text = message
    End Select
End Sub




'***************************************************************
'****  VPW DYNAMIC BALL SHADOWS by Iakki, Apophis, and Wylte
'***************************************************************

Function DistanceFast(x, y)
	dim ratio, ax, ay
	ax = abs(x)					'Get absolute value of each vector
	ay = abs(y)
	ratio = 1 / max(ax, ay)		'Create a ratio
	ratio = ratio * (1.29289 - (ax + ay) * ratio * 0.29289)
	if ratio > 0 then			'Quickly determine if it's worth using
		DistanceFast = 1/ratio
	Else
		DistanceFast = 0
	End if
end Function

Function max(a,b)
	if a > b then 
		max = a
	Else
		max = b
	end if
end Function


'****** Part C:  The Magic ******
Dim sourcenames, currentShadowCount
sourcenames = Array ("","","")
currentShadowCount = Array (0,0,0)

' *** Trim or extend these to match the number of balls/primitives/flashers on the table!
dim objrtx1(3), objrtx2(3)
dim objBallShadow(3)
Dim BallShadowA


BallShadowA = Array (BallShadowA0,BallShadowA1,BallShadowA2)

DynamicBSInit

sub DynamicBSInit()
	Dim iii

	for iii = 0 to tnob									'Prepares the shadow objects before play begins
		Set objrtx1(iii) = Eval("RtxBallShadow" & iii)
		objrtx1(iii).material = "RtxBallShadow" & iii
		objrtx1(iii).z = iii/1000 + 0.01
		objrtx1(iii).visible = 0

		Set objrtx2(iii) = Eval("RtxBall2Shadow" & iii)
		objrtx2(iii).material = "RtxBallShadow2_" & iii
		objrtx2(iii).z = (iii)/1000 + 0.02
		objrtx2(iii).visible = 0

		currentShadowCount(iii) = 0

		Set objBallShadow(iii) = Eval("BallShadow" & iii)
		objBallShadow(iii).material = "BallShadow" & iii
		UpdateMaterial objBallShadow(iii).material,1,0,0,0,0,0,AmbientBSFactor,RGB(0,0,0),0,0,False,True,0,0,0,0
		objBallShadow(iii).Z = iii/1000 + 0.04
		objBallShadow(iii).visible = 0

		BallShadowA(iii).Opacity = 100*AmbientBSFactor
		BallShadowA(iii).visible = 0
	Next
end sub


Sub DynamicBSUpdate
	Dim falloff:	falloff = 150			'Max distance to light sources, can be changed if you have a reason
	Dim ShadowOpacity, ShadowOpacity2 
	Dim s, Source, LSd, currentMat, AnotherSource, BOT
	BOT = GetBalls

	'Hide shadow of deleted balls
	For s = UBound(BOT) + 1 to tnob
		objrtx1(s).visible = 0
		objrtx2(s).visible = 0
		objBallShadow(s).visible = 0
		BallShadowA(s).visible = 0
	Next

	If UBound(BOT) < lob Then Exit Sub		'No balls in play, exit

'The Magic happens now
	For s = lob to UBound(BOT)

' *** Normal "ambient light" ball shadow
	'Layered from top to bottom. If you had an upper pf at for example 80 and ramps even above that, your segments would be z>110; z<=110 And z>100; z<=100 And z>30; z<=30 And z>20; Else invisible

		If AmbientBallShadowOn = 1 Then			'Primitive shadow on playfield, flasher shadow in ramps
			If BOT(s).Z > 30 Then							'The flasher follows the ball up ramps while the primitive is on the pf
				If BOT(s).X < tablewidth/2 Then
					objBallShadow(s).X = ((BOT(s).X) - (Ballsize/10) + ((BOT(s).X - (tablewidth/2))/(Ballsize/AmbientMovement))) + 5
				Else
					objBallShadow(s).X = ((BOT(s).X) + (Ballsize/10) + ((BOT(s).X - (tablewidth/2))/(Ballsize/AmbientMovement))) - 5
				End If
				objBallShadow(s).Y = BOT(s).Y + BallSize/10 + fovY
				objBallShadow(s).visible = 1

				BallShadowA(s).X = BOT(s).X
				BallShadowA(s).Y = BOT(s).Y + BallSize/5 + fovY
				BallShadowA(s).height=BOT(s).z - BallSize/4		'This is technically 1/4 of the ball "above" the ramp, but it keeps it from clipping
				BallShadowA(s).visible = 1
			Elseif BOT(s).Z <= 30 And BOT(s).Z > 20 Then	'On pf, primitive only
				objBallShadow(s).visible = 1
				If BOT(s).X < tablewidth/2 Then
					objBallShadow(s).X = ((BOT(s).X) - (Ballsize/10) + ((BOT(s).X - (tablewidth/2))/(Ballsize/AmbientMovement))) + 5
				Else
					objBallShadow(s).X = ((BOT(s).X) + (Ballsize/10) + ((BOT(s).X - (tablewidth/2))/(Ballsize/AmbientMovement))) - 5
				End If
				objBallShadow(s).Y = BOT(s).Y + fovY
				BallShadowA(s).visible = 0
			Else											'Under pf, no shadows
				objBallShadow(s).visible = 0
				BallShadowA(s).visible = 0
			end if

		Elseif AmbientBallShadowOn = 2 Then		'Flasher shadow everywhere
			If BOT(s).Z > 30 Then							'In a ramp
				BallShadowA(s).X = BOT(s).X
				BallShadowA(s).Y = BOT(s).Y + BallSize/5 + fovY
				BallShadowA(s).height=BOT(s).z - BallSize/4		'This is technically 1/4 of the ball "above" the ramp, but it keeps it from clipping
				BallShadowA(s).visible = 1
			Elseif BOT(s).Z <= 30 And BOT(s).Z > 20 Then	'On pf
				BallShadowA(s).visible = 1
				If BOT(s).X < tablewidth/2 Then
					BallShadowA(s).X = ((BOT(s).X) - (Ballsize/10) + ((BOT(s).X - (tablewidth/2))/(Ballsize/AmbientMovement))) + 5
				Else
					BallShadowA(s).X = ((BOT(s).X) + (Ballsize/10) + ((BOT(s).X - (tablewidth/2))/(Ballsize/AmbientMovement))) - 5
				End If
				BallShadowA(s).Y = BOT(s).Y + Ballsize/10 + fovY
				BallShadowA(s).height=BOT(s).z - BallSize/2 + 5
			Else											'Under pf
				BallShadowA(s).visible = 0
			End If
		End If

' *** Dynamic shadows
		If DynamicBallShadowsOn Then
			If BOT(s).Z < 30 Then 'And BOT(s).Y < (TableHeight - 200) Then 'Or BOT(s).Z > 105 Then		'Defining when and where (on the table) you can have dynamic shadows
				For Each Source in DynamicSources
					LSd=DistanceFast((BOT(s).x-Source.x),(BOT(s).y-Source.y))	'Calculating the Linear distance to the Source
					If LSd < falloff and Source.state=1 Then	    			'If the ball is within the falloff range of a light and light is on
						currentShadowCount(s) = currentShadowCount(s) + 1		'Within range of 1 or 2
						if currentShadowCount(s) = 1 Then						'1 dynamic shadow source
							sourcenames(s) = source.name
							currentMat = objrtx1(s).material
							objrtx2(s).visible = 0 : objrtx1(s).visible = 1 : objrtx1(s).X = BOT(s).X : objrtx1(s).Y = BOT(s).Y + fovY
	'						objrtx1(s).Z = BOT(s).Z - 25 + s/1000 + 0.01						'Uncomment if you want to add shadows to an upper/lower pf
							objrtx1(s).rotz = AnglePP(Source.x, Source.y, BOT(s).X, BOT(s).Y) + 90
							ShadowOpacity = (falloff-LSd)/falloff									'Sets opacity/darkness of shadow by distance to light
							objrtx1(s).size_y = Wideness*ShadowOpacity+Thinness						'Scales shape of shadow with distance/opacity
							UpdateMaterial currentMat,1,0,0,0,0,0,ShadowOpacity*DynamicBSFactor^2,RGB(0,0,0),0,0,False,True,0,0,0,0
							If AmbientBallShadowOn = 1 Then
								currentMat = objBallShadow(s).material									'Brightens the ambient primitive when it's close to a light
								UpdateMaterial currentMat,1,0,0,0,0,0,AmbientBSFactor*(1-ShadowOpacity),RGB(0,0,0),0,0,False,True,0,0,0,0
							Else
								BallShadowA(s).Opacity = 100*AmbientBSFactor*(1-ShadowOpacity)
							End If

						Elseif currentShadowCount(s) = 2 Then
																	'Same logic as 1 shadow, but twice
							currentMat = objrtx1(s).material
							set AnotherSource = Eval(sourcenames(s))
							objrtx1(s).visible = 1 : objrtx1(s).X = BOT(s).X : objrtx1(s).Y = BOT(s).Y + fovY
	'						objrtx1(s).Z = BOT(s).Z - 25 + s/1000 + 0.01							'Uncomment if you want to add shadows to an upper/lower pf
							objrtx1(s).rotz = AnglePP(AnotherSource.x, AnotherSource.y, BOT(s).X, BOT(s).Y) + 90
							ShadowOpacity = (falloff-(((BOT(s).x-AnotherSource.x)^2+(BOT(s).y-AnotherSource.y)^2)^0.5))/falloff
							objrtx1(s).size_y = Wideness*ShadowOpacity+Thinness
							UpdateMaterial currentMat,1,0,0,0,0,0,ShadowOpacity*DynamicBSFactor^3,RGB(0,0,0),0,0,False,True,0,0,0,0

							currentMat = objrtx2(s).material
							objrtx2(s).visible = 1 : objrtx2(s).X = BOT(s).X : objrtx2(s).Y = BOT(s).Y + fovY
	'						objrtx2(s).Z = BOT(s).Z - 25 + s/1000 + 0.02							'Uncomment if you want to add shadows to an upper/lower pf
							objrtx2(s).rotz = AnglePP(Source.x, Source.y, BOT(s).X, BOT(s).Y) + 90
							ShadowOpacity2 = (falloff-LSd)/falloff
							objrtx2(s).size_y = Wideness*ShadowOpacity2+Thinness
							UpdateMaterial currentMat,1,0,0,0,0,0,ShadowOpacity2*DynamicBSFactor^3,RGB(0,0,0),0,0,False,True,0,0,0,0
							If AmbientBallShadowOn = 1 Then
								currentMat = objBallShadow(s).material									'Brightens the ambient primitive when it's close to a light
								UpdateMaterial currentMat,1,0,0,0,0,0,AmbientBSFactor*(1-max(ShadowOpacity,ShadowOpacity2)),RGB(0,0,0),0,0,False,True,0,0,0,0
							Else
								BallShadowA(s).Opacity = 100*AmbientBSFactor*(1-max(ShadowOpacity,ShadowOpacity2))
							End If
						end if
					Else
						currentShadowCount(s) = 0
						BallShadowA(s).Opacity = 100*AmbientBSFactor
					End If
				Next
			Else									'Hide dynamic shadows everywhere else
				objrtx2(s).visible = 0 : objrtx1(s).visible = 0
			End If
		End If
	Next
End Sub

'****************************************************************
'****  END VPW DYNAMIC BALL SHADOWS by Iakki, Apophis, and Wylte
'****************************************************************



'*******************************************
'  VPW Rubberizer by Iaakki
'*******************************************

' iaakki Rubberizer
sub Rubberizer(parm)
	if parm < 10 And parm > 2 And Abs(activeball.angmomz) < 10 then
		'debug.print "parm: " & parm & " momz: " & activeball.angmomz &" vely: "& activeball.vely
		activeball.angmomz = activeball.angmomz * 1.2
		activeball.vely = activeball.vely * 1.2
		'debug.print ">> newmomz: " & activeball.angmomz&" newvely: "& activeball.vely
	Elseif parm <= 2 and parm > 0.2 and activeball.vely < 0 Then
		'debug.print "* parm: " & parm & " momz: " & activeball.angmomz &" vely: "& activeball.vely
		activeball.angmomz = activeball.angmomz * -1.1
		activeball.vely = activeball.vely * 1.4
		'debug.print "**** >> newmomz: " & activeball.angmomz&" newvely: "& activeball.vely
	end if
end sub


' apophis Rubberizer
sub Rubberizer2(parm)
	if parm < 10 And parm > 2 And Abs(activeball.angmomz) < 10 then
		'debug.print "parm: " & parm & " momz: " & activeball.angmomz &" vely: "& activeball.vely
		activeball.angmomz = -activeball.angmomz * 2
		activeball.vely = activeball.vely * 1.2
		'debug.print ">> newmomz: " & activeball.angmomz&" newvely: "& activeball.vely
	Elseif parm <= 2 and parm > 0.2 and activeball.vely < 0 Then
		'debug.print "* parm: " & parm & " momz: " & activeball.angmomz &" vely: "& activeball.vely
		activeball.angmomz = -activeball.angmomz * 0.5
		activeball.vely = activeball.vely * (1.2 + rnd(1)/3 )
		'debug.print "**** >> newmomz: " & activeball.angmomz&" newvely: "& activeball.vely
	end if
end sub


'******************************************************
' VPW TargetBouncer for targets and posts by Iaakki, Wrd1972, Apophis
'******************************************************

sub TargetBouncer(aBall,defvalue)
    dim zMultiplier, vel, vratio
    if TargetBouncerEnabled = 1 and aball.z < 30 then
        'debug.print "velx: " & aball.velx & " vely: " & aball.vely & " velz: " & aball.velz
        vel = BallSpeed(aBall)
        if aBall.velx = 0 then vratio = 1 else vratio = aBall.vely/aBall.velx
        Select Case Int(Rnd * 6) + 1
            Case 1: zMultiplier = 0.2*defvalue
			Case 2: zMultiplier = 0.25*defvalue
            Case 3: zMultiplier = 0.3*defvalue
			Case 4: zMultiplier = 0.4*defvalue
            Case 5: zMultiplier = 0.45*defvalue
            Case 6: zMultiplier = 0.5*defvalue
        End Select
        aBall.velz = abs(vel * zMultiplier * TargetBouncerFactor)
        aBall.velx = sgn(aBall.velx) * sqr(abs((vel^2 - aBall.velz^2)/(1+vratio^2)))
        aBall.vely = aBall.velx * vratio
        'debug.print "---> velx: " & aball.velx & " vely: " & aball.vely & " velz: " & aball.velz
        'debug.print "conservation check: " & BallSpeed(aBall)/vel
    elseif TargetBouncerEnabled = 2 and aball.z < 30 then
		'debug.print "velz: " & activeball.velz
		Select Case Int(Rnd * 4) + 1
			Case 1: zMultiplier = defvalue+1.1
			Case 2: zMultiplier = defvalue+1.05
			Case 3: zMultiplier = defvalue+0.7
			Case 4: zMultiplier = defvalue+0.3
		End Select
		aBall.velz = aBall.velz * zMultiplier * TargetBouncerFactor
		'debug.print "----> velz: " & activeball.velz
		'debug.print "conservation check: " & BallSpeed(aBall)/vel
	end if
end sub



'******************************************************
' Flippers Polarity (Select appropriate sub based on era) 
'******************************************************

dim LF : Set LF = New FlipperPolarity
dim RF : Set RF = New FlipperPolarity

InitPolarity


'
'
'
''*******************************************
'' Mid 80's
'
Sub InitPolarity()
        dim x, a : a = Array(LF, RF)
        for each x in a
                x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 1        'disabled
                x.AddPoint "Ycoef", 1, RightFlipper.Y-11, 1
                x.enabled = True
                x.TimeDelay = 80
        Next

        AddPt "Polarity", 0, 0, 0
        AddPt "Polarity", 1, 0.05, -3.7        
        AddPt "Polarity", 2, 0.33, -3.7
        AddPt "Polarity", 3, 0.37, -3.7
        AddPt "Polarity", 4, 0.41, -3.7
        AddPt "Polarity", 5, 0.45, -3.7 
        AddPt "Polarity", 6, 0.576,-3.7
        AddPt "Polarity", 7, 0.66, -2.3
        AddPt "Polarity", 8, 0.743, -1.5
        AddPt "Polarity", 9, 0.81, -1
        AddPt "Polarity", 10, 0.88, 0

        addpt "Velocity", 0, 0,     1.1
        addpt "Velocity", 1, 0.16,  1.06
        addpt "Velocity", 2, 0.41,  1.05
        addpt "Velocity", 3, 0.53,  1'0.982
        addpt "Velocity", 4, 0.702, 0.968
        addpt "Velocity", 5, 0.95,  0.968
        addpt "Velocity", 6, 1.03,  0.945

        LF.Object = LeftFlipper        
        LF.EndPoint = EndPointLp
        RF.Object = RightFlipper
        RF.EndPoint = EndPointRp
End Sub



' Flipper trigger hit subs
Sub TriggerLF_Hit() : LF.Addball activeball : End Sub
Sub TriggerLF_UnHit() : LF.PolarityCorrect activeball : End Sub
Sub TriggerRF_Hit() : RF.Addball activeball : End Sub
Sub TriggerRF_UnHit() : RF.PolarityCorrect activeball : End Sub




'******************************************************
'  FLIPPER CORRECTION FUNCTIONS
'******************************************************

Sub AddPt(aStr, idx, aX, aY)        'debugger wrapper for adjusting flipper script in-game
	dim a : a = Array(LF, RF)
	dim x : for each x in a
		x.addpoint aStr, idx, aX, aY
	Next
End Sub

Class FlipperPolarity
	Public DebugOn, Enabled
	Private FlipAt        'Timer variable (IE 'flip at 723,530ms...)
	Public TimeDelay        'delay before trigger turns off and polarity is disabled TODO set time!
	private Flipper, FlipperStart,FlipperEnd, FlipperEndY, LR, PartialFlipCoef
	Private Balls(20), balldata(20)

	dim PolarityIn, PolarityOut
	dim VelocityIn, VelocityOut
	dim YcoefIn, YcoefOut
	Public Sub Class_Initialize 
		redim PolarityIn(0) : redim PolarityOut(0) : redim VelocityIn(0) : redim VelocityOut(0) : redim YcoefIn(0) : redim YcoefOut(0)
		Enabled = True : TimeDelay = 50 : LR = 1:  dim x : for x = 0 to uBound(balls) : balls(x) = Empty : set Balldata(x) = new SpoofBall : next 
	End Sub

	Public Property let Object(aInput) : Set Flipper = aInput : StartPoint = Flipper.x : End Property
	Public Property Let StartPoint(aInput) : if IsObject(aInput) then FlipperStart = aInput.x else FlipperStart = aInput : end if : End Property
	Public Property Get StartPoint : StartPoint = FlipperStart : End Property
	Public Property Let EndPoint(aInput) : FlipperEnd = aInput.x: FlipperEndY = aInput.y: End Property
	Public Property Get EndPoint : EndPoint = FlipperEnd : End Property        
	Public Property Get EndPointY: EndPointY = FlipperEndY : End Property

	Public Sub AddPoint(aChooseArray, aIDX, aX, aY) 'Index #, X position, (in) y Position (out) 
		Select Case aChooseArray
			case "Polarity" : ShuffleArrays PolarityIn, PolarityOut, 1 : PolarityIn(aIDX) = aX : PolarityOut(aIDX) = aY : ShuffleArrays PolarityIn, PolarityOut, 0
			Case "Velocity" : ShuffleArrays VelocityIn, VelocityOut, 1 :VelocityIn(aIDX) = aX : VelocityOut(aIDX) = aY : ShuffleArrays VelocityIn, VelocityOut, 0
			Case "Ycoef" : ShuffleArrays YcoefIn, YcoefOut, 1 :YcoefIn(aIDX) = aX : YcoefOut(aIDX) = aY : ShuffleArrays YcoefIn, YcoefOut, 0
		End Select
		if gametime > 100 then Report aChooseArray
	End Sub 

	Public Sub Report(aChooseArray)         'debug, reports all coords in tbPL.text
		if not DebugOn then exit sub
		dim a1, a2 : Select Case aChooseArray
			case "Polarity" : a1 = PolarityIn : a2 = PolarityOut
			Case "Velocity" : a1 = VelocityIn : a2 = VelocityOut
			Case "Ycoef" : a1 = YcoefIn : a2 = YcoefOut 
				case else :tbpl.text = "wrong string" : exit sub
		End Select
		dim str, x : for x = 0 to uBound(a1) : str = str & aChooseArray & " x: " & round(a1(x),4) & ", " & round(a2(x),4) & vbnewline : next
		tbpl.text = str
	End Sub

	Public Sub AddBall(aBall) : dim x : for x = 0 to uBound(balls) : if IsEmpty(balls(x)) then set balls(x) = aBall : exit sub :end if : Next  : End Sub

	Private Sub RemoveBall(aBall)
		dim x : for x = 0 to uBound(balls)
			if TypeName(balls(x) ) = "IBall" then 
				if aBall.ID = Balls(x).ID Then
					balls(x) = Empty
					Balldata(x).Reset
				End If
			End If
		Next
	End Sub

	Public Sub Fire() 
		Flipper.RotateToEnd
		processballs
	End Sub

	Public Property Get Pos 'returns % position a ball. For debug stuff.
		dim x : for x = 0 to uBound(balls)
			if not IsEmpty(balls(x) ) then
				pos = pSlope(Balls(x).x, FlipperStart, 0, FlipperEnd, 1)
			End If
		Next                
	End Property

	Public Sub ProcessBalls() 'save data of balls in flipper range
		FlipAt = GameTime
		dim x : for x = 0 to uBound(balls)
			if not IsEmpty(balls(x) ) then
				balldata(x).Data = balls(x)
			End If
		Next
		PartialFlipCoef = ((Flipper.StartAngle - Flipper.CurrentAngle) / (Flipper.StartAngle - Flipper.EndAngle))
		PartialFlipCoef = abs(PartialFlipCoef-1)
	End Sub
	Private Function FlipperOn() : if gameTime < FlipAt+TimeDelay then FlipperOn = True : End If : End Function        'Timer shutoff for polaritycorrect

	Public Sub PolarityCorrect(aBall)
		if FlipperOn() then 
			dim tmp, BallPos, x, IDX, Ycoef : Ycoef = 1

			'y safety Exit
			if aBall.VelY > -8 then 'ball going down
				RemoveBall aBall
				exit Sub
			end if

			'Find balldata. BallPos = % on Flipper
			for x = 0 to uBound(Balls)
				if aBall.id = BallData(x).id AND not isempty(BallData(x).id) then 
					idx = x
					BallPos = PSlope(BallData(x).x, FlipperStart, 0, FlipperEnd, 1)
					if ballpos > 0.65 then  Ycoef = LinearEnvelope(BallData(x).Y, YcoefIn, YcoefOut)                                'find safety coefficient 'ycoef' data
				end if
			Next

			If BallPos = 0 Then 'no ball data meaning the ball is entering and exiting pretty close to the same position, use current values.
				BallPos = PSlope(aBall.x, FlipperStart, 0, FlipperEnd, 1)
				if ballpos > 0.65 then  Ycoef = LinearEnvelope(aBall.Y, YcoefIn, YcoefOut)                                                'find safety coefficient 'ycoef' data
			End If

			'Velocity correction
			if not IsEmpty(VelocityIn(0) ) then
				Dim VelCoef
				VelCoef = LinearEnvelope(BallPos, VelocityIn, VelocityOut)

				if partialflipcoef < 1 then VelCoef = PSlope(partialflipcoef, 0, 1, 1, VelCoef)

				if Enabled then aBall.Velx = aBall.Velx*VelCoef
				if Enabled then aBall.Vely = aBall.Vely*VelCoef
			End If

			'Polarity Correction (optional now)
			if not IsEmpty(PolarityIn(0) ) then
				If StartPoint > EndPoint then LR = -1        'Reverse polarity if left flipper
				dim AddX : AddX = LinearEnvelope(BallPos, PolarityIn, PolarityOut) * LR

				if Enabled then aBall.VelX = aBall.VelX + 1 * (AddX*ycoef*PartialFlipcoef)
			End If
		End If
		RemoveBall aBall
	End Sub
End Class

'******************************************************
'  FLIPPER POLARITY AND RUBBER DAMPENER SUPPORTING FUNCTIONS 
'******************************************************

' Used for flipper correction and rubber dampeners
Sub ShuffleArray(ByRef aArray, byVal offset) 'shuffle 1d array
	dim x, aCount : aCount = 0
	redim a(uBound(aArray) )
	for x = 0 to uBound(aArray)        'Shuffle objects in a temp array
		if not IsEmpty(aArray(x) ) Then
			if IsObject(aArray(x)) then 
				Set a(aCount) = aArray(x)
			Else
				a(aCount) = aArray(x)
			End If
			aCount = aCount + 1
		End If
	Next
	if offset < 0 then offset = 0
	redim aArray(aCount-1+offset)        'Resize original array
	for x = 0 to aCount-1                'set objects back into original array
		if IsObject(a(x)) then 
			Set aArray(x) = a(x)
		Else
			aArray(x) = a(x)
		End If
	Next
End Sub

' Used for flipper correction and rubber dampeners
Sub ShuffleArrays(aArray1, aArray2, offset)
	ShuffleArray aArray1, offset
	ShuffleArray aArray2, offset
End Sub

' Used for flipper correction, rubber dampeners, and drop targets
Function BallSpeed(ball) 'Calculates the ball speed
	BallSpeed = SQR(ball.VelX^2 + ball.VelY^2 + ball.VelZ^2)
End Function

' Used for flipper correction and rubber dampeners
Function PSlope(Input, X1, Y1, X2, Y2)        'Set up line via two points, no clamping. Input X, output Y
	dim x, y, b, m : x = input : m = (Y2 - Y1) / (X2 - X1) : b = Y2 - m*X2
	Y = M*x+b
	PSlope = Y
End Function

' Used for flipper correction
Class spoofball 
	Public X, Y, Z, VelX, VelY, VelZ, ID, Mass, Radius 
	Public Property Let Data(aBall)
		With aBall
			x = .x : y = .y : z = .z : velx = .velx : vely = .vely : velz = .velz
			id = .ID : mass = .mass : radius = .radius
		end with
	End Property
	Public Sub Reset()
		x = Empty : y = Empty : z = Empty  : velx = Empty : vely = Empty : velz = Empty 
		id = Empty : mass = Empty : radius = Empty
	End Sub
End Class

' Used for flipper correction and rubber dampeners
Function LinearEnvelope(xInput, xKeyFrame, yLvl)
	dim y 'Y output
	dim L 'Line
	dim ii : for ii = 1 to uBound(xKeyFrame)        'find active line
		if xInput <= xKeyFrame(ii) then L = ii : exit for : end if
	Next
	if xInput > xKeyFrame(uBound(xKeyFrame) ) then L = uBound(xKeyFrame)        'catch line overrun
	Y = pSlope(xInput, xKeyFrame(L-1), yLvl(L-1), xKeyFrame(L), yLvl(L) )

	if xInput <= xKeyFrame(lBound(xKeyFrame) ) then Y = yLvl(lBound(xKeyFrame) )         'Clamp lower
	if xInput >= xKeyFrame(uBound(xKeyFrame) ) then Y = yLvl(uBound(xKeyFrame) )        'Clamp upper

	LinearEnvelope = Y
End Function


'******************************************************
'  FLIPPER TRICKS 
'******************************************************

RightFlipper.timerinterval=1
Rightflipper.timerenabled=True

sub RightFlipper_timer()
	FlipperTricks LeftFlipper, LFPress, LFCount, LFEndAngle, LFState
	FlipperTricks RightFlipper, RFPress, RFCount, RFEndAngle, RFState
	FlipperNudge RightFlipper, RFEndAngle, RFEOSNudge, LeftFlipper, LFEndAngle
	FlipperNudge LeftFlipper, LFEndAngle, LFEOSNudge,  RightFlipper, RFEndAngle
end sub

Dim LFEOSNudge, RFEOSNudge

Sub FlipperNudge(Flipper1, Endangle1, EOSNudge1, Flipper2, EndAngle2)
        Dim BOT, b

        If Flipper1.currentangle = Endangle1 and EOSNudge1 <> 1 Then
                EOSNudge1 = 1
                'debug.print Flipper1.currentangle &" = "& Endangle1 &"--"& Flipper2.currentangle &" = "& EndAngle2
                If Flipper2.currentangle = EndAngle2 Then 
                        BOT = GetBalls
                        For b = 0 to Ubound(BOT)
                                If FlipperTrigger(BOT(b).x, BOT(b).y, Flipper1) Then
                                        'Debug.Print "ball in flip1. exit"
                                         exit Sub
                                end If
                        Next
                        For b = 0 to Ubound(BOT)
                                If FlipperTrigger(BOT(b).x, BOT(b).y, Flipper2) Then
                                        BOT(b).velx = BOT(b).velx / 1.3
                                        BOT(b).vely = BOT(b).vely - 0.5
                                end If
                        Next
                End If
        Else 
                If Abs(Flipper1.currentangle) > Abs(EndAngle1) + 15 then 
                        EOSNudge1 = 0
                end if
        End If
End Sub

'*****************
' Maths
'*****************
Dim PI: PI = 4*Atn(1)

Function dSin(degrees)
	dsin = sin(degrees * Pi/180)
End Function

Function dCos(degrees)
	dcos = cos(degrees * Pi/180)
End Function

Function Atn2(dy, dx)
	If dx > 0 Then
		Atn2 = Atn(dy / dx)
	ElseIf dx < 0 Then
		If dy = 0 Then 
			Atn2 = pi
		Else
			Atn2 = Sgn(dy) * (pi - Atn(Abs(dy / dx)))
		end if
	ElseIf dx = 0 Then
		if dy = 0 Then
			Atn2 = 0
		else
			Atn2 = Sgn(dy) * pi / 2
		end if
	End If
End Function

'*************************************************
'  Check ball distance from Flipper for Rem
'*************************************************

Function Distance(ax,ay,bx,by)
	Distance = SQR((ax - bx)^2 + (ay - by)^2)
End Function

Function DistancePL(px,py,ax,ay,bx,by) ' Distance between a point and a line where point is px,py
	DistancePL = ABS((by - ay)*px - (bx - ax) * py + bx*ay - by*ax)/Distance(ax,ay,bx,by)
End Function

Function Radians(Degrees)
	Radians = Degrees * PI /180
End Function

Function AnglePP(ax,ay,bx,by)
	AnglePP = Atn2((by - ay),(bx - ax))*180/PI
End Function

Function DistanceFromFlipper(ballx, bally, Flipper)
	DistanceFromFlipper = DistancePL(ballx, bally, Flipper.x, Flipper.y, Cos(Radians(Flipper.currentangle+90))+Flipper.x, Sin(Radians(Flipper.currentangle+90))+Flipper.y)
End Function

Function FlipperTrigger(ballx, bally, Flipper)
	Dim DiffAngle
	DiffAngle  = ABS(Flipper.currentangle - AnglePP(Flipper.x, Flipper.y, ballx, bally) - 90)
	If DiffAngle > 180 Then DiffAngle = DiffAngle - 360

	If DistanceFromFlipper(ballx,bally,Flipper) < 48 and DiffAngle <= 90 and Distance(ballx,bally,Flipper.x,Flipper.y) < Flipper.Length Then
		FlipperTrigger = True
	Else
		FlipperTrigger = False
	End If        
End Function


'*************************************************
'  End - Check ball distance from Flipper for Rem
'*************************************************

dim LFPress, RFPress, LFCount, RFCount
dim LFState, RFState
dim EOST, EOSA,Frampup, FElasticity,FReturn
dim RFEndAngle, LFEndAngle

EOST = leftflipper.eostorque
EOSA = leftflipper.eostorqueangle
Frampup = LeftFlipper.rampup
FElasticity = LeftFlipper.elasticity
FReturn = LeftFlipper.return
Const EOSTnew = 1 'EM's to late 80's
Const EOSAnew = .2 					' ***************** VPW default is at 1
Const EOSRampup = 1.5 				' ***************** VPW default is at 0
Dim SOSRampup
Select Case FlipperCoilRampupMode 
	Case 0:
		SOSRampup = 2.5
	Case 1:
		SOSRampup = 6
	Case 2:
		SOSRampup = 8.5
End Select

Const LiveCatch = 8 				' ***************** VPW default is at 16
Const LiveElasticity = 0.45
Const SOSEM = 0.815
Const EOSReturn = 0.035  'mid 80's to early 90's


LFEndAngle = Leftflipper.endangle
RFEndAngle = RightFlipper.endangle

Sub FlipperActivate(Flipper, FlipperPress)
	FlipperPress = 1
	Flipper.Elasticity = FElasticity

	Flipper.eostorque = EOST         
	Flipper.eostorqueangle = EOSA         
End Sub

Sub FlipperDeactivate(Flipper, FlipperPress)
	FlipperPress = 0
	Flipper.eostorqueangle = EOSA
	Flipper.eostorque = EOST*EOSReturn/FReturn


	If Abs(Flipper.currentangle) <= Abs(Flipper.endangle) + 0.1 Then
		Dim b, BOT
		BOT = GetBalls

		For b = 0 to UBound(BOT)
			If Distance(BOT(b).x, BOT(b).y, Flipper.x, Flipper.y) < 55 Then 'check for cradle
				If BOT(b).vely >= -0.4 Then BOT(b).vely = -0.4
			End If
		Next
	End If
End Sub

Sub FlipperTricks (Flipper, FlipperPress, FCount, FEndAngle, FState) 
	Dim Dir
	Dir = Flipper.startangle/Abs(Flipper.startangle)        '-1 for Right Flipper

	If Abs(Flipper.currentangle) > Abs(Flipper.startangle) - 0.05 Then
		If FState <> 1 Then
			Flipper.rampup = SOSRampup 
			Flipper.endangle = FEndAngle - 3*Dir
			Flipper.Elasticity = FElasticity * SOSEM
			FCount = 0 
			FState = 1
		End If
	ElseIf Abs(Flipper.currentangle) <= Abs(Flipper.endangle) and FlipperPress = 1 then
		if FCount = 0 Then FCount = GameTime

		If FState <> 2 Then
			Flipper.eostorqueangle = EOSAnew
			Flipper.eostorque = EOSTnew
			Flipper.rampup = EOSRampup                        
			Flipper.endangle = FEndAngle
			FState = 2
		End If
	Elseif Abs(Flipper.currentangle) > Abs(Flipper.endangle) + 0.01 and FlipperPress = 1 Then 
		If FState <> 3 Then
			Flipper.eostorque = EOST        
			Flipper.eostorqueangle = EOSA
			Flipper.rampup = Frampup
			Flipper.Elasticity = FElasticity
			FState = 3
		End If

	End If
End Sub

Const LiveDistanceMin = 30  'minimum distance in vp units from flipper base live catch dampening will occur
Const LiveDistanceMax = 114  'maximum distance in vp units from flipper base live catch dampening will occur (tip protection)

Sub CheckLiveCatch(ball, Flipper, FCount, parm) 'Experimental new live catch
    Dim Dir
    Dir = Flipper.startangle/Abs(Flipper.startangle)    '-1 for Right Flipper
    Dim LiveCatchBounce                                                                                                                        'If live catch is not perfect, it won't freeze ball totally
    Dim CatchTime : CatchTime = GameTime - FCount

    if CatchTime <= LiveCatch and parm > 6 and ABS(Flipper.x - ball.x) > LiveDistanceMin and ABS(Flipper.x - ball.x) < LiveDistanceMax Then
            if CatchTime <= LiveCatch*0.5 Then                                                'Perfect catch only when catch time happens in the beginning of the window
                    LiveCatchBounce = 0
            else
                    LiveCatchBounce = Abs((LiveCatch/2) - CatchTime)        'Partial catch when catch happens a bit late
            end If

            If LiveCatchBounce = 0 and ball.velx * Dir > 0 Then ball.velx = 0
            ball.vely = LiveCatchBounce * (32 / LiveCatch) ' Multiplier for inaccuracy bounce
            ball.angmomx= 0
            ball.angmomy= 0
            ball.angmomz= 0
    Else
        If Flipper.currentangle = Flipper.endangle Then RubbersD.Dampen Activeball
    End If
End Sub


'******************************************************
'****  END FLIPPER CORRECTIONS
'******************************************************



'******************************************************
'****  PHYSICS DAMPENERS
'******************************************************
'
' These are data mined bounce curves, 
' dialed in with the in-game elasticity as much as possible to prevent angle / spin issues.
' Requires tracking ballspeed to calculate COR



Sub dPosts_Hit(idx) 
	RubbersD.dampen Activeball
	TargetBouncer Activeball, 1
End Sub

Sub dSleeves_Hit(idx) 
	SleevesD.Dampen Activeball
	TargetBouncer Activeball, 0.7
End Sub


dim RubbersD : Set RubbersD = new Dampener        'frubber
RubbersD.name = "Rubbers"
RubbersD.debugOn = False        'shows info in textbox "TBPout"
RubbersD.Print = False        'debug, reports in debugger (in vel, out cor)
'cor bounce curve (linear)
'for best results, try to match in-game velocity as closely as possible to the desired curve
'RubbersD.addpoint 0, 0, 0.935        'point# (keep sequential), ballspeed, CoR (elasticity)
RubbersD.addpoint 0, 0, 0.96        'point# (keep sequential), ballspeed, CoR (elasticity)
RubbersD.addpoint 1, 3.77, 0.96
RubbersD.addpoint 2, 5.76, 0.967        'dont take this as gospel. if you can data mine rubber elasticitiy, please help!
RubbersD.addpoint 3, 15.84, 0.874
RubbersD.addpoint 4, 56, 0.64        'there's clamping so interpolate up to 56 at least

dim SleevesD : Set SleevesD = new Dampener        'this is just rubber but cut down to 85%...
SleevesD.name = "Sleeves"
SleevesD.debugOn = False        'shows info in textbox "TBPout"
SleevesD.Print = False        'debug, reports in debugger (in vel, out cor)
SleevesD.CopyCoef RubbersD, 0.85

Class Dampener
	Public Print, debugOn 'tbpOut.text
	public name, Threshold         'Minimum threshold. Useful for Flippers, which don't have a hit threshold.
	Public ModIn, ModOut
	Private Sub Class_Initialize : redim ModIn(0) : redim Modout(0): End Sub 

	Public Sub AddPoint(aIdx, aX, aY) 
		ShuffleArrays ModIn, ModOut, 1 : ModIn(aIDX) = aX : ModOut(aIDX) = aY : ShuffleArrays ModIn, ModOut, 0
		if gametime > 100 then Report
	End Sub

	public sub Dampen(aBall)
		if threshold then if BallSpeed(aBall) < threshold then exit sub end if end if
		dim RealCOR, DesiredCOR, str, coef
		DesiredCor = LinearEnvelope(cor.ballvel(aBall.id), ModIn, ModOut )
		RealCOR = BallSpeed(aBall) / (cor.ballvel(aBall.id)+0.0000001)
		coef = desiredcor / realcor 
		if debugOn then str = name & " in vel:" & round(cor.ballvel(aBall.id),2 ) & vbnewline & "desired cor: " & round(desiredcor,4) & vbnewline & _
		"actual cor: " & round(realCOR,4) & vbnewline & "ballspeed coef: " & round(coef, 3) & vbnewline 
		if Print then debug.print Round(cor.ballvel(aBall.id),2) & ", " & round(desiredcor,3)

		aBall.velx = aBall.velx * coef : aBall.vely = aBall.vely * coef
		if debugOn then TBPout.text = str
	End Sub

	Public Sub CopyCoef(aObj, aCoef) 'alternative addpoints, copy with coef
		dim x : for x = 0 to uBound(aObj.ModIn)
			addpoint x, aObj.ModIn(x), aObj.ModOut(x)*aCoef
		Next
	End Sub


	Public Sub Report()         'debug, reports all coords in tbPL.text
		if not debugOn then exit sub
		dim a1, a2 : a1 = ModIn : a2 = ModOut
		dim str, x : for x = 0 to uBound(a1) : str = str & x & ": " & round(a1(x),4) & ", " & round(a2(x),4) & vbnewline : next
		TBPout.text = str
	End Sub

End Class



'******************************************************
'  TRACK ALL BALL VELOCITIES
'  FOR RUBBER DAMPENER AND DROP TARGETS
'******************************************************

dim cor : set cor = New CoRTracker

Class CoRTracker
	public ballvel, ballvelx, ballvely

	Private Sub Class_Initialize : redim ballvel(0) : redim ballvelx(0): redim ballvely(0) : End Sub 

	Public Sub Update()	'tracks in-ball-velocity
		dim str, b, AllBalls, highestID : allBalls = getballs

		for each b in allballs
			if b.id >= HighestID then highestID = b.id
		Next

		if uBound(ballvel) < highestID then redim ballvel(highestID)	'set bounds
		if uBound(ballvelx) < highestID then redim ballvelx(highestID)	'set bounds
		if uBound(ballvely) < highestID then redim ballvely(highestID)	'set bounds

		for each b in allballs
			ballvel(b.id) = BallSpeed(b)
			ballvelx(b.id) = b.velx
			ballvely(b.id) = b.vely
		Next
	End Sub
End Class



'******************************************************
'****  END PHYSICS DAMPENERS
'******************************************************



'******************************************************
'****  DROP TARGETS by Rothbauerw
'******************************************************

'******************************************************
'  DROP TARGETS INITIALIZATION
'******************************************************

Class DropTarget
	Private m_primary, m_secondary, m_prim, m_sw, m_animate, m_isDropped
  
	Public Property Get Primary(): Set Primary = m_primary: End Property
	Public Property Let Primary(input): Set m_primary = input: End Property
  
	Public Property Get Secondary(): Set Secondary = m_secondary: End Property
	Public Property Let Secondary(input): Set m_secondary = input: End Property
  
	Public Property Get Prim(): Set Prim = m_prim: End Property
	Public Property Let Prim(input): Set m_prim = input: End Property
  
	Public Property Get Sw(): Sw = m_sw: End Property
	Public Property Let Sw(input): m_sw = input: End Property
  
	Public Property Get Animate(): Animate = m_animate: End Property
	Public Property Let Animate(input): m_animate = input: End Property
  
	Public Property Get IsDropped(): IsDropped = m_isDropped: End Property
	Public Property Let IsDropped(input): m_isDropped = input: End Property
  
	Public default Function init(primary, secondary, prim, sw, animate, isDropped)
	  Set m_primary = primary
	  Set m_secondary = secondary
	  Set m_prim = prim
	  m_sw = sw
	  m_animate = animate
	  m_isDropped = isDropped
  
	  Set Init = Me
	End Function
End Class

'Set array with drop target objects
'
'DropTargetvar = Array(primary, secondary, prim, swtich, animate)
' 	primary: 			primary target wall to determine drop
'	secondary:			wall used to simulate the ball striking a bent or offset target after the initial Hit
'	prim:				primitive target used for visuals and animation
'							IMPORTANT!!! 
'							rotz must be used for orientation
'							rotx to bend the target back
'							transz to move it up and down
'							the pivot point should be in the center of the target on the x, y and at or below the playfield (0) on z
'	switch:				ROM switch number
'	animate:			Arrary slot for handling the animation instrucitons, set to 0
'
'	Values for annimate: 1 - bend target (hit to primary), 2 - drop target (hit to secondary), 3 - brick target (high velocity hit to secondary), -1 - raise target 


Dim DT29

Set DT29 = (new DropTarget)(sw29, sw29a, sw29p, 29, 0, false)

Dim DTArray
DTArray = Array(DT29)


'Configure the behavior of Drop Targets.
Const DTDropSpeed = 110 'in milliseconds
Const DTDropUpSpeed = 40 'in milliseconds
Const DTDropUnits = 44 'VP units primitive drops so top of at or below the playfield
Const DTDropUpUnits = 5 'VP units primitive raises above the up position on drops up
Const DTMaxBend = 8 'max degrees primitive rotates when hit
Const DTDropDelay = 20 'time in milliseconds before target drops (due to friction/impact of the ball)
Const DTRaiseDelay = 100 '40 'time in milliseconds before target drops back to normal up position after the solenoid fires to raise the target
Const DTBrickVel = 30 'velocity at which the target will brick, set to '0' to disable brick

Const DTEnableBrick = 0 'Set to 0 to disable bricking, 1 to enable bricking
Const DTHitSound = "Target_Hit_1" 'Drop Target Hit sound
Const DTDropSound = "DropTarget_Down" 'Drop Target Drop sound
Const DTResetSound = "DropTarget_Up" 'Drop Target reset sound

Const DTMass = 0.2 'Mass of the Drop Target (between 0 and 1), higher values provide more resistance


'******************************************************
'  DROP TARGETS FUNCTIONS
'******************************************************

Sub DTHit(switch)
	Dim i
	i = DTArrayID(switch)

	PlayTargetSound
	DTArray(i).animate =  DTCheckBrick(Activeball,DTArray(i).prim)
	If DTArray(i).animate = 1 or DTArray(i).animate = 3 or DTArray(i).animate = 4 Then
		DTBallPhysics Activeball, DTArray(i).prim.rotz, DTMass
	End If
	DoDTAnim
End Sub

Sub DTRaise(switch)
	Dim i
	i = DTArrayID(switch)

	DTArray(i).animate = -1
	DoDTAnim
End Sub

Sub DTDrop(switch)
	Dim i
	i = DTArrayID(switch)

	DTArray(i).animate = 1
	DoDTAnim
End Sub

Function DTArrayID(switch)
	Dim i
	For i = 0 to uBound(DTArray) 
		If DTArray(i).sw = switch Then DTArrayID = i:Exit Function 
	Next
End Function


sub DTBallPhysics(aBall, angle, mass)
	dim rangle,bangle,calc1, calc2, calc3
	rangle = (angle - 90) * 3.1416 / 180
	bangle = atn2(cor.ballvely(aball.id),cor.ballvelx(aball.id))

	calc1 = cor.BallVel(aball.id) * cos(bangle - rangle) * (aball.mass - mass) / (aball.mass + mass)
	calc2 = cor.BallVel(aball.id) * sin(bangle - rangle) * cos(rangle + 4*Atn(1)/2)
	calc3 = cor.BallVel(aball.id) * sin(bangle - rangle) * sin(rangle + 4*Atn(1)/2)

	aBall.velx = calc1 * cos(rangle) + calc2
	aBall.vely = calc1 * sin(rangle) + calc3
End Sub


'Check if target is hit on it's face or sides and whether a 'brick' occurred
Function DTCheckBrick(aBall, dtprim) 
	dim bangle, bangleafter, rangle, rangle2, Xintersect, Yintersect, cdist, perpvel, perpvelafter, paravel, paravelafter
	rangle = (dtprim.rotz - 90) * 3.1416 / 180
	rangle2 = dtprim.rotz * 3.1416 / 180
	bangle = atn2(cor.ballvely(aball.id),cor.ballvelx(aball.id))
	bangleafter = Atn2(aBall.vely,aball.velx)

	Xintersect = (aBall.y - dtprim.y - tan(bangle) * aball.x + tan(rangle2) * dtprim.x) / (tan(rangle2) - tan(bangle))
	Yintersect = tan(rangle2) * Xintersect + (dtprim.y - tan(rangle2) * dtprim.x)

	cdist = Distance(dtprim.x, dtprim.y, Xintersect, Yintersect)

	perpvel = cor.BallVel(aball.id) * cos(bangle-rangle)
	paravel = cor.BallVel(aball.id) * sin(bangle-rangle)

	perpvelafter = BallSpeed(aBall) * cos(bangleafter - rangle) 
	paravelafter = BallSpeed(aBall) * sin(bangleafter - rangle)

	If perpvel > 0 and  perpvelafter <= 0 Then
		If DTEnableBrick = 1 and  perpvel > DTBrickVel and DTBrickVel <> 0 and cdist < 8 Then
			DTCheckBrick = 3
		Else
			DTCheckBrick = 1
		End If
	ElseIf perpvel > 0 and ((paravel > 0 and paravelafter > 0) or (paravel < 0 and paravelafter < 0)) Then
		DTCheckBrick = 4
	Else 
		DTCheckBrick = 0
	End If
End Function


Sub DoDTAnim()
	Dim i
	For i=0 to Ubound(DTArray)
		DTArray(i).animate = DTAnimate(DTArray(i).primary,DTArray(i).secondary,DTArray(i).prim,DTArray(i).sw,DTArray(i).animate)
	Next
End Sub

Function DTAnimate(primary, secondary, prim, switch,  animate)
	dim transz, switchid
	Dim animtime, rangle

	switchid = switch

	rangle = prim.rotz * PI / 180

	DTAnimate = animate

	if animate = 0  Then
		primary.uservalue = 0
		DTAnimate = 0
		Exit Function
	Elseif primary.uservalue = 0 then 
		primary.uservalue = gametime
	end if

	animtime = gametime - primary.uservalue

	If (animate = 1 or animate = 4) and animtime < DTDropDelay Then
		primary.collidable = 0
	If animate = 1 then secondary.collidable = 1 else secondary.collidable= 0
		prim.rotx = DTMaxBend * cos(rangle)
		prim.roty = DTMaxBend * sin(rangle)
		DTAnimate = animate
		Exit Function
		elseif (animate = 1 or animate = 4) and animtime > DTDropDelay Then
		primary.collidable = 0
		If animate = 1 then secondary.collidable = 1 else secondary.collidable= 0
		prim.rotx = DTMaxBend * cos(rangle)
		prim.roty = DTMaxBend * sin(rangle)
		animate = 2
		PlaySoundAt SoundFX(DTDropSound,DOFDropTargets),prim
	End If

	if animate = 2 Then
		transz = (animtime - DTDropDelay)/DTDropSpeed *  DTDropUnits * -1
		if prim.transz > -DTDropUnits  Then
			prim.transz = transz
		end if

		prim.rotx = DTMaxBend * cos(rangle)/2
		prim.roty = DTMaxBend * sin(rangle)/2

		if prim.transz <= -DTDropUnits Then 
			prim.transz = -DTDropUnits
			secondary.collidable = 0
			if UsingROM then controller.Switch(Switchid) = 1
			primary.uservalue = 0
			DTAnimate = 0
			Exit Function
		Else
			DTAnimate = 2
			Exit Function
		end If 
	End If

	If animate = 3 and animtime < DTDropDelay Then
		primary.collidable = 0
		secondary.collidable = 1
		prim.rotx = DTMaxBend * cos(rangle)
		prim.roty = DTMaxBend * sin(rangle)
	elseif animate = 3 and animtime > DTDropDelay Then
		primary.collidable = 1
		secondary.collidable = 0
		prim.rotx = 0
		prim.roty = 0
		primary.uservalue = 0
		DTAnimate = 0
		Exit Function
	End If

	if animate = -1 Then
		transz = (1 - (animtime)/DTDropUpSpeed) *  DTDropUnits * -1

		If prim.transz = -DTDropUnits Then
			Dim BOT, b
			BOT = GetBalls

			For b = 0 to UBound(BOT)
				If InRotRect(BOT(b).x,BOT(b).y,prim.x, prim.y, prim.rotz, -25,-10,25,-10,25,25,-25,25) and BOT(b).z < prim.z+DTDropUnits+25 Then
					BOT(b).velz = 20
				End If
			Next
		End If

		if prim.transz < 0 Then
			prim.transz = transz
		elseif transz > 0 then
			prim.transz = transz
		end if

		if prim.transz > DTDropUpUnits then 
			DTAnimate = -2
			prim.rotx = 0
			prim.roty = 0
			primary.uservalue = gametime
		end if
		primary.collidable = 0
		secondary.collidable = 1
		if UsingROM then controller.Switch(Switchid) = 0

	End If

	if animate = -2 and animtime > DTRaiseDelay Then
		prim.transz = (animtime - DTRaiseDelay)/DTDropSpeed *  DTDropUnits * -1 + DTDropUpUnits 
		if prim.transz < 0 then
			prim.transz = 0
			primary.uservalue = 0
			DTAnimate = 0

			primary.collidable = 1
			secondary.collidable = 0
		end If 
	End If
End Function


'******************************************************
'  DROP TARGET
'  SUPPORTING FUNCTIONS 
'******************************************************


' Used for drop targets
'*** Determines if a Points (px,py) is inside a 4 point polygon A-D in Clockwise/CCW order
Function InRect(px,py,ax,ay,bx,by,cx,cy,dx,dy)
	Dim AB, BC, CD, DA
	AB = (bx*py) - (by*px) - (ax*py) + (ay*px) + (ax*by) - (ay*bx)
	BC = (cx*py) - (cy*px) - (bx*py) + (by*px) + (bx*cy) - (by*cx)
	CD = (dx*py) - (dy*px) - (cx*py) + (cy*px) + (cx*dy) - (cy*dx)
	DA = (ax*py) - (ay*px) - (dx*py) + (dy*px) + (dx*ay) - (dy*ax)

	If (AB <= 0 AND BC <=0 AND CD <= 0 AND DA <= 0) Or (AB >= 0 AND BC >=0 AND CD >= 0 AND DA >= 0) Then
		InRect = True
	Else
		InRect = False       
	End If
End Function

Function InRotRect(ballx,bally,px,py,angle,ax,ay,bx,by,cx,cy,dx,dy)
    Dim rax,ray,rbx,rby,rcx,rcy,rdx,rdy
    Dim rotxy
    rotxy = RotPoint(ax,ay,angle)
    rax = rotxy(0)+px : ray = rotxy(1)+py
    rotxy = RotPoint(bx,by,angle)
    rbx = rotxy(0)+px : rby = rotxy(1)+py
    rotxy = RotPoint(cx,cy,angle)
    rcx = rotxy(0)+px : rcy = rotxy(1)+py
    rotxy = RotPoint(dx,dy,angle)
    rdx = rotxy(0)+px : rdy = rotxy(1)+py

    InRotRect = InRect(ballx,bally,rax,ray,rbx,rby,rcx,rcy,rdx,rdy)
End Function

Function RotPoint(x,y,angle)
    dim rx, ry
    rx = x*dCos(angle) - y*dSin(angle)
    ry = x*dSin(angle) + y*dCos(angle)
    RotPoint = Array(rx,ry)
End Function


'******************************************************
'****  END DROP TARGETS
'******************************************************





'******************************************************
'****  BALL ROLLING AND DROP SOUNDS
'******************************************************

ReDim rolling(tnob)
InitRolling

Dim DropCount
ReDim DropCount(tnob)

Dim ampFactor

Sub InitRolling
	Dim i
	For i = 0 to tnob
		rolling(i) = False
	Next
	Select Case BallRollAmpFactor
		Case 0
			ampFactor = "_amp0"
		Case 1
			ampFactor = "_amp2_5"
		Case 2
			ampFactor = "_amp5"
		Case 3
			ampFactor = "_amp7_5"
		Case 4
			ampFactor = "_amp9"
		Case Else
			ampFactor = "_amp0"
	End Select
End Sub

Sub RollingUpdate()
	Dim BOT, b
	BOT = GetBalls

	' stop the sound of deleted balls
	For b = UBound(BOT) + 1 to tnob
		If AmbientBallShadowOn = 0 Then BallShadowA(b).visible = 0
		rolling(b) = False
		StopSound("BallRoll_" & b & ampFactor)
	Next

	' exit the sub if no balls on the table
	If UBound(BOT) = -1 Then Exit Sub

	' play the rolling sound for each ball

	For b = 0 to UBound(BOT)
		If BallVel(BOT(b)) > 1 AND BOT(b).z < 30 Then
			rolling(b) = True
			PlaySound ("BallRoll_" & b & ampFactor), -1, VolPlayfieldRoll(BOT(b)) * 1.1 * VolumeDial, AudioPan(BOT(b)), 0, PitchPlayfieldRoll(BOT(b)), 1, 0, AudioFade(BOT(b))

		Else
			If rolling(b) = True Then
				StopSound("BallRoll_" & b & ampFactor)
				rolling(b) = False
			End If
		End If

		' Ball Drop Sounds
		If BOT(b).VelZ < -1 and BOT(b).z < 55 and BOT(b).z > 27 Then 'height adjust for ball drop sounds
			If DropCount(b) >= 5 Then
				DropCount(b) = 0
				If BOT(b).velz > -7 Then
					RandomSoundBallBouncePlayfieldSoft BOT(b)
				Else
					RandomSoundBallBouncePlayfieldHard BOT(b)
				End If				
			End If
		End If
		If DropCount(b) < 5 Then
			DropCount(b) = DropCount(b) + 1
		End If

' Rothbauerw code to correct corner condition where ball can get stuck on the corkscrew 
		if BOT(b).z > 60 and Distance(BOT(b).x, BOT(b).y, 200, 320) <  75 Then  
            if BOT(b).vely < 0 and ballvel(BOT(b)) < 1 Then
                BOT(b).angmomy = BOT(b).angmomy * 2
                BOT(b).angmomx = BOT(b).angmomx * 2
                BOT(b).velx = BOT(b).velx + 0.1
                BOT(b).vely = BOT(b).vely - 0.1
            end if
        End If

		' "Static" Ball Shadows
		If AmbientBallShadowOn = 0 Then
			If BOT(b).Z > 30 Then
				BallShadowA(b).height=BOT(b).z - BallSize/4		'This is technically 1/4 of the ball "above" the ramp, but it keeps it from clipping
			Else
				BallShadowA(b).height=BOT(b).z - BallSize/2 + 5
			End If
			BallShadowA(b).Y = BOT(b).Y + Ballsize/5 + fovY
			BallShadowA(b).X = BOT(b).X
			BallShadowA(b).visible = 1
		End If
	Next
End Sub


'******************************************************
'****  END BALL ROLLING AND DROP SOUNDS
'******************************************************




'******************************************************
'**** RAMP ROLLING SFX
'******************************************************

'Ball tracking ramp SFX 1.0

dim RampMinLoops : RampMinLoops = 4

dim rampAmpFactor

InitRampRolling

Sub InitRampRolling()
	Select Case RampRollAmpFactor
		Case 0
			rampAmpFactor = "_amp0"
		Case 1
			rampAmpFactor = "_amp2_5"
		Case 2
			rampAmpFactor = "_amp5"
		Case 3
			rampAmpFactor = "_amp7_5"
		Case 4
			rampAmpFactor = "_amp9"
		Case Else
			rampAmpFactor = "_amp0"
	End Select
End Sub

' RampBalls
'      Setup:        Set the array length of x in RampBalls(x,2) Total Number of Balls on table + 1:  if tnob = 5, then RammBalls(6,2)
'      Description:  
dim RampBalls(3,2)
'x,0 = ball x,1 = ID,	2 = Protection against ending early (minimum amount of updates)
'0,0 is boolean on/off, 0,1 unused for now
RampBalls(0,0) = False

' RampType
'     Setup: Set this array to the number Total number of balls that can be tracked at one time + 1.  5 ball multiball then set value to 6
'     Description: Array type indexed on BallId and a values used to deterimine what type of ramp the ball is on: False = Wire Ramp, True = Plastic Ramp
dim RampType(3)	

Sub WireRampOn(input)  : Waddball ActiveBall, input : RampRollUpdate: End Sub
Sub WireRampOff() : WRemoveBall ActiveBall.ID	: End Sub


' WaddBall (Active Ball, Boolean)
'     Description: This subroutine is called from WireRampOn to Add Balls to the RampBalls Array
Sub Waddball(input, RampInput)	'Add ball
	' This will loop through the RampBalls array checking each element of the array x, position 1
	' To see if the the ball was already added to the array.
	' If the ball is found then exit the subroutine
	dim x : for x = 1 to uBound(RampBalls)	'Check, don't add balls twice
		if RampBalls(x, 1) = input.id then 
			if Not IsEmpty(RampBalls(x,1) ) then Exit Sub	'Frustating issue with BallId 0. Empty variable = 0
		End If
	Next

	' This will itterate through the RampBalls Array.
	' The first time it comes to a element in the array where the Ball Id (Slot 1) is empty.  It will add the current ball to the array
	' The RampBalls assigns the ActiveBall to element x,0 and ball id of ActiveBall to 0,1
	' The RampType(BallId) is set to RampInput
	' RampBalls in 0,0 is set to True, this will enable the timer and the timer is also turned on
	For x = 1 to uBound(RampBalls)
		if IsEmpty(RampBalls(x, 1)) then 
			Set RampBalls(x, 0) = input
			RampBalls(x, 1)	= input.ID
			RampType(x) = RampInput
			RampBalls(x, 2)	= 0
			'exit For
			RampBalls(0,0) = True
			RampRoll.Enabled = 1	 'Turn on timer
			'RampRoll.Interval = RampRoll.Interval 'reset timer
			exit Sub
		End If
		if x = uBound(RampBalls) then 	'debug
			Debug.print "WireRampOn error, ball queue is full: " & vbnewline & _
			RampBalls(0, 0) & vbnewline & _
			Typename(RampBalls(1, 0)) & " ID:" & RampBalls(1, 1) & "type:" & RampType(1) & vbnewline & _
			Typename(RampBalls(2, 0)) & " ID:" & RampBalls(2, 1) & "type:" & RampType(2) & vbnewline & _
			Typename(RampBalls(3, 0)) & " ID:" & RampBalls(3, 1) & "type:" & RampType(3) & vbnewline & _
			Typename(RampBalls(4, 0)) & " ID:" & RampBalls(4, 1) & "type:" & RampType(4) & vbnewline & _
			Typename(RampBalls(5, 0)) & " ID:" & RampBalls(5, 1) & "type:" & RampType(5) & vbnewline & _
			" "
		End If
	next
End Sub

' WRemoveBall (BallId)
'    Description: This subroutine is called from the RampRollUpdate subroutine 
'                 and is used to remove and stop the ball rolling sounds
Sub WRemoveBall(ID)		'Remove ball
	'Debug.Print "In WRemoveBall() + Remove ball from loop array"
	dim ballcount : ballcount = 0
	dim x : for x = 1 to Ubound(RampBalls)
		if ID = RampBalls(x, 1) then 'remove ball
			Set RampBalls(x, 0) = Nothing
			RampBalls(x, 1) = Empty
			RampType(x) = Empty
			StopSound("RampLoop" & x)
			StopSound("wireloop" & x)
		end If
		'if RampBalls(x,1) = Not IsEmpty(Rampballs(x,1) then ballcount = ballcount + 1
		if not IsEmpty(Rampballs(x,1)) then ballcount = ballcount + 1
	next
	if BallCount = 0 then RampBalls(0,0) = False	'if no balls in queue, disable timer update
End Sub

Sub RampRoll_Timer():RampRollUpdate:End Sub

Sub RampRollUpdate()		'Timer update
	dim x : for x = 1 to uBound(RampBalls)
		if Not IsEmpty(RampBalls(x,1) ) then 
			if BallVel(RampBalls(x,0) ) > 1 then ' if ball is moving, play rolling sound
				If RampType(x) then 
					PlaySound("RampLoop" & x & rampAmpFactor), -1, VolPlayfieldRoll(RampBalls(x,0)) * 1.1 * VolumeDial, AudioPan(RampBalls(x,0)), 0, BallPitchV(RampBalls(x,0)), 1, 0, AudioFade(RampBalls(x,0))				
					StopSound("wireloop" & x & rampAmpFactor)
				Else
					StopSound("RampLoop" & x & rampAmpFactor)
					PlaySound("wireloop" & x & rampAmpFactor), -1, VolPlayfieldRoll(RampBalls(x,0)) * 1.1 * VolumeDial, AudioPan(RampBalls(x,0)), 0, BallPitch(RampBalls(x,0)), 1, 0, AudioFade(RampBalls(x,0))
				End If
				RampBalls(x, 2)	= RampBalls(x, 2) + 1
			Else
				StopSound("RampLoop" & x & rampAmpFactor)
				StopSound("wireloop" & x & rampAmpFactor)
			end if
			if RampBalls(x,0).Z < 30 and RampBalls(x, 2) > RampMinLoops then	'if ball is on the PF, remove  it
				StopSound("RampLoop" & x & rampAmpFactor)
				StopSound("wireloop" & x & rampAmpFactor)
				Wremoveball RampBalls(x,1)
			End If
		Else
			StopSound("RampLoop" & x & rampAmpFactor)
			StopSound("wireloop" & x & rampAmpFactor)
		end if
	next
	if not RampBalls(0,0) then RampRoll.enabled = 0

End Sub

' This can be used to debug the Ramp Roll time.  You need to enable the tbWR timer on the TextBox
Sub tbWR_Timer()	'debug textbox
	me.text =	"on? " & RampBalls(0, 0) & " timer: " & RampRoll.Enabled & vbnewline & _
	"1 " & Typename(RampBalls(1, 0)) & " ID:" & RampBalls(1, 1) & " type:" & RampType(1) & " Loops:" & RampBalls(1, 2) & vbnewline & _
	"2 " & Typename(RampBalls(2, 0)) & " ID:" & RampBalls(2, 1) & " type:" & RampType(2) & " Loops:" & RampBalls(2, 2) & vbnewline & _
	"3 " & Typename(RampBalls(3, 0)) & " ID:" & RampBalls(3, 1) & " type:" & RampType(3) & " Loops:" & RampBalls(3, 2) & vbnewline & _
	"4 " & Typename(RampBalls(4, 0)) & " ID:" & RampBalls(4, 1) & " type:" & RampType(4) & " Loops:" & RampBalls(4, 2) & vbnewline & _
	"5 " & Typename(RampBalls(5, 0)) & " ID:" & RampBalls(5, 1) & " type:" & RampType(5) & " Loops:" & RampBalls(5, 2) & vbnewline & _
	"6 " & Typename(RampBalls(6, 0)) & " ID:" & RampBalls(6, 1) & " type:" & RampType(6) & " Loops:" & RampBalls(6, 2) & vbnewline & _
	" "
End Sub


Function BallPitch(ball) ' Calculates the pitch of the sound based on the ball speed
    BallPitch = pSlope(BallVel(ball), 1, -1000, 60, 10000)
End Function

Function BallPitchV(ball) ' Calculates the pitch of the sound based on the ball speed Variation
	BallPitchV = pSlope(BallVel(ball), 1, -4000, 60, 7000)
End Function



'******************************************************
'**** END RAMP ROLLING SFX
'******************************************************





'******************************************************
'****  FLEEP MECHANICAL SOUNDS
'******************************************************

'///////////////////////////////  SOUNDS PARAMETERS  //////////////////////////////
Dim GlobalSoundLevel, CoinSoundLevel, PlungerReleaseSoundLevel, PlungerPullSoundLevel, NudgeLeftSoundLevel
Dim NudgeRightSoundLevel, NudgeCenterSoundLevel, StartButtonSoundLevel, RollingSoundFactor

CoinSoundLevel = 1														'volume level; range [0, 1]
NudgeLeftSoundLevel = 1													'volume level; range [0, 1]
NudgeRightSoundLevel = 1												'volume level; range [0, 1]
NudgeCenterSoundLevel = 1												'volume level; range [0, 1]
StartButtonSoundLevel = 0.1												'volume level; range [0, 1]
PlungerReleaseSoundLevel = 0.8 											'volume level; range [0, 1]
PlungerPullSoundLevel = 1												'volume level; range [0, 1]
RollingSoundFactor = 1.1/5		

'///////////////////////-----Solenoids, Kickers and Flash Relays-----///////////////////////
Dim FlipperUpAttackMinimumSoundLevel, FlipperUpAttackMaximumSoundLevel, FlipperUpAttackLeftSoundLevel, FlipperUpAttackRightSoundLevel
Dim FlipperUpSoundLevel, FlipperDownSoundLevel, FlipperLeftHitParm, FlipperRightHitParm
Dim SlingshotSoundLevel, BumperSoundFactor, KnockerSoundLevel

FlipperUpAttackMinimumSoundLevel = 0.010           						'volume level; range [0, 1]
FlipperUpAttackMaximumSoundLevel = 0.635								'volume level; range [0, 1]
FlipperUpSoundLevel = 1.0                        						'volume level; range [0, 1]
FlipperDownSoundLevel = 0.45                      						'volume level; range [0, 1]
FlipperLeftHitParm = FlipperUpSoundLevel								'sound helper; not configurable
FlipperRightHitParm = FlipperUpSoundLevel								'sound helper; not configurable
SlingshotSoundLevel = 0.95												'volume level; range [0, 1]
BumperSoundFactor = 4.25												'volume multiplier; must not be zero
KnockerSoundLevel = 1 													'volume level; range [0, 1]

'///////////////////////-----Ball Drops, Bumps and Collisions-----///////////////////////
Dim RubberStrongSoundFactor, RubberWeakSoundFactor, RubberFlipperSoundFactor,BallWithBallCollisionSoundFactor
Dim BallBouncePlayfieldSoftFactor, BallBouncePlayfieldHardFactor, PlasticRampDropToPlayfieldSoundLevel, WireRampDropToPlayfieldSoundLevel, DelayedBallDropOnPlayfieldSoundLevel
Dim WallImpactSoundFactor, MetalImpactSoundFactor, SubwaySoundLevel, SubwayEntrySoundLevel, ScoopEntrySoundLevel
Dim SaucerLockSoundLevel, SaucerKickSoundLevel

BallWithBallCollisionSoundFactor = 3.2									'volume multiplier; must not be zero
RubberStrongSoundFactor = 0.055/5											'volume multiplier; must not be zero
RubberWeakSoundFactor = 0.075/5											'volume multiplier; must not be zero
RubberFlipperSoundFactor = .06 '0.075/5										'volume multiplier; must not be zero
BallBouncePlayfieldSoftFactor = 0.025									'volume multiplier; must not be zero
BallBouncePlayfieldHardFactor = 0.025									'volume multiplier; must not be zero
DelayedBallDropOnPlayfieldSoundLevel = 0.8									'volume level; range [0, 1]
WallImpactSoundFactor = 0.075											'volume multiplier; must not be zero
MetalImpactSoundFactor = 0.075/3
SaucerLockSoundLevel = 0.8
SaucerKickSoundLevel = 0.8

'///////////////////////-----Gates, Spinners, Rollovers and Targets-----///////////////////////

Dim GateSoundLevel, TargetSoundFactor, SpinnerSoundLevel, RolloverSoundLevel, DTSoundLevel

GateSoundLevel = 0.5/5													'volume level; range [0, 1]
TargetSoundFactor = .2 '0.0025 * 10											'volume multiplier; must not be zero
DTSoundLevel = 0.25														'volume multiplier; must not be zero
RolloverSoundLevel = .5 '0.25                              					'volume level; range [0, 1]
SpinnerSoundLevel = 0.5                              					'volume level; range [0, 1]

'///////////////////////-----Ball Release, Guides and Drain-----///////////////////////
Dim DrainSoundLevel, BallReleaseSoundLevel, BottomArchBallGuideSoundFactor, FlipperBallGuideSoundFactor 

DrainSoundLevel = 0.8														'volume level; range [0, 1]
BallReleaseSoundLevel = 1												'volume level; range [0, 1]
BottomArchBallGuideSoundFactor = 0.2									'volume multiplier; must not be zero
FlipperBallGuideSoundFactor = 0.015										'volume multiplier; must not be zero

'///////////////////////-----Loops and Lanes-----///////////////////////
Dim ArchSoundFactor
ArchSoundFactor = 0.025/5													'volume multiplier; must not be zero


'/////////////////////////////  SOUND PLAYBACK FUNCTIONS  ////////////////////////////
'/////////////////////////////  POSITIONAL SOUND PLAYBACK METHODS  ////////////////////////////
' Positional sound playback methods will play a sound, depending on the X,Y position of the table element or depending on ActiveBall object position
' These are similar subroutines that are less complicated to use (e.g. simply use standard parameters for the PlaySound call)
' For surround setup - positional sound playback functions will fade between front and rear surround channels and pan between left and right channels
' For stereo setup - positional sound playback functions will only pan between left and right channels
' For mono setup - positional sound playback functions will not pan between left and right channels and will not fade between front and rear channels

' PlaySound full syntax - PlaySound(string, int loopcount, float volume, float pan, float randompitch, int pitch, bool useexisting, bool restart, float front_rear_fade)
' Note - These functions will not work (currently) for walls/slingshots as these do not feature a simple, single X,Y position
Sub PlaySoundAtLevelStatic(playsoundparams, aVol, tableobj)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelExistingStatic(playsoundparams, aVol, tableobj)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 1, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelStaticLoop(playsoundparams, aVol, tableobj)
	PlaySound playsoundparams, -1, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelStaticRandomPitch(playsoundparams, aVol, randomPitch, tableobj)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), randomPitch, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelActiveBall(playsoundparams, aVol)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ActiveBall), 0, 0, 0, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtLevelExistingActiveBall(playsoundparams, aVol)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ActiveBall), 0, 0, 1, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtLeveTimerActiveBall(playsoundparams, aVol, ballvariable)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ballvariable), 0, 0, 0, 0, AudioFade(ballvariable)
End Sub

Sub PlaySoundAtLevelTimerExistingActiveBall(playsoundparams, aVol, ballvariable)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ballvariable), 0, 0, 1, 0, AudioFade(ballvariable)
End Sub

Sub PlaySoundAtLevelRoll(playsoundparams, aVol, pitch)
	PlaySound playsoundparams, -1, aVol * VolumeDial, AudioPan(tableobj), randomPitch, 0, 0, 0, AudioFade(tableobj)
End Sub

' Previous Positional Sound Subs

Sub PlaySoundAt(soundname, tableobj)
	PlaySound soundname, 1, 1 * VolumeDial, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
End Sub

Sub PlaySoundAtVol(soundname, tableobj, aVol)
	PlaySound soundname, 1, aVol * VolumeDial, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
End Sub

Sub PlaySoundAtBall(soundname)
	PlaySoundAt soundname, ActiveBall
End Sub

Sub PlaySoundAtBallVol (Soundname, aVol)
	Playsound soundname, 1,aVol * VolumeDial, AudioPan(ActiveBall), 0,0,0, 1, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtBallVolM (Soundname, aVol)
	Playsound soundname, 1,aVol * VolumeDial, AudioPan(ActiveBall), 0,0,0, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtVolLoops(sound, tableobj, Vol, Loops)
	PlaySound sound, Loops, Vol * VolumeDial, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
End Sub


'******************************************************
'  Fleep  Supporting Ball & Sound Functions
'******************************************************

Function AudioFade(tableobj) ' Fades between front and back of the table (for surround systems or 2x2 speakers, etc), depending on the Y position on the table. "table1" is the name of the table
  Dim tmp
    tmp = tableobj.y * 2 / tableheight-1

	if tmp > 7000 Then
		tmp = 7000
	elseif tmp < -7000 Then
		tmp = -7000
	end if

    If tmp > 0 Then
		AudioFade = Csng(tmp ^10)
    Else
        AudioFade = Csng(-((- tmp) ^10) )
    End If
End Function

Function AudioPan(tableobj) ' Calculates the pan for a tableobj based on the X position on the table. "table1" is the name of the table
    Dim tmp
    tmp = tableobj.x * 2 / tablewidth-1

	if tmp > 7000 Then
		tmp = 7000
	elseif tmp < -7000 Then
		tmp = -7000
	end if

    If tmp > 0 Then
        AudioPan = Csng(tmp ^10)
    Else
        AudioPan = Csng(-((- tmp) ^10) )
    End If
End Function

Function Vol(ball) ' Calculates the volume of the sound based on the ball speed
	Vol = Csng(BallVel(ball) ^2)
End Function

Function Volz(ball) ' Calculates the volume of the sound based on the ball speed
	Volz = Csng((ball.velz) ^2)
End Function

Function Pitch(ball) ' Calculates the pitch of the sound based on the ball speed
	Pitch = BallVel(ball) * 20
End Function

Function BallVel(ball) 'Calculates the ball speed
	BallVel = INT(SQR((ball.VelX ^2) + (ball.VelY ^2) ) )
End Function

Function VolPlayfieldRoll(ball) ' Calculates the roll volume of the sound based on the ball speed
	VolPlayfieldRoll = RollingSoundFactor * 0.0005 * Csng(BallVel(ball) ^3)
End Function

Function PitchPlayfieldRoll(ball) ' Calculates the roll pitch of the sound based on the ball speed
	PitchPlayfieldRoll = BallVel(ball) ^2 * 15
End Function

Function RndInt(min, max)
	RndInt = Int(Rnd() * (max-min + 1) + min)' Sets a random number integer between min and max
End Function

Function RndNum(min, max)
	RndNum = Rnd() * (max-min) + min' Sets a random number between min and max
End Function

'/////////////////////////////  GENERAL SOUND SUBROUTINES  ////////////////////////////
Sub SoundStartButton()
	PlaySound ("Start_Button"), 0, StartButtonSoundLevel, 0, 0.25
End Sub

Sub SoundNudgeLeft()
	PlaySound ("Nudge_" & Int(Rnd*2)+1), 0, NudgeLeftSoundLevel * VolumeDial, -0.1, 0.25
End Sub

Sub SoundNudgeRight()
	PlaySound ("Nudge_" & Int(Rnd*2)+1), 0, NudgeRightSoundLevel * VolumeDial, 0.1, 0.25
End Sub

Sub SoundNudgeCenter()
	PlaySound ("Nudge_" & Int(Rnd*2)+1), 0, NudgeCenterSoundLevel * VolumeDial, 0, 0.25
End Sub


Sub SoundPlungerPull()
	PlaySoundAtLevelStatic ("Plunger_Pull_1"), PlungerPullSoundLevel, Plunger
End Sub

Sub SoundPlungerReleaseBall()
	PlaySoundAtLevelStatic ("Plunger_Release_Ball"), PlungerReleaseSoundLevel, Plunger	
End Sub

Sub SoundPlungerReleaseNoBall()
	PlaySoundAtLevelStatic ("Plunger_Release_No_Ball"), PlungerReleaseSoundLevel, Plunger
End Sub


'/////////////////////////////  KNOCKER SOLENOID  ////////////////////////////
Sub KnockerSolenoid()
	PlaySoundAtLevelStatic SoundFX("Knocker_1",DOFKnocker), KnockerSoundLevel, KnockerPosition
End Sub

'/////////////////////////////  DRAIN SOUNDS  ////////////////////////////
Sub RandomSoundDrain(drainswitch)
	PlaySoundAtLevelStatic ("Drain_" & Int(Rnd*11)+1), DrainSoundLevel, drainswitch
End Sub

'/////////////////////////////  TROUGH BALL RELEASE SOLENOID SOUNDS  ////////////////////////////

Sub RandomSoundBallRelease(drainswitch)
	PlaySoundAtLevelStatic SoundFX("BallRelease" & Int(Rnd*7)+1,DOFContactors), BallReleaseSoundLevel, drainswitch
End Sub

'/////////////////////////////  SLINGSHOT SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundSlingshotLeft(sling)
	PlaySoundAtLevelStatic SoundFX("Sling_L" & Int(Rnd*10)+1,DOFContactors), SlingshotSoundLevel, Sling
End Sub

Sub RandomSoundSlingshotRight(sling)
	PlaySoundAtLevelStatic SoundFX("Sling_R" & Int(Rnd*8)+1,DOFContactors), SlingshotSoundLevel, Sling
End Sub

'/////////////////////////////  BUMPER SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundBumperTop(Bump)
	PlaySoundAtLevelStatic SoundFX("Bumpers_Top_" & Int(Rnd*5)+1,DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bump
End Sub

Sub RandomSoundBumperMiddle(Bump)
	PlaySoundAtLevelStatic SoundFX("Bumpers_Middle_" & Int(Rnd*5)+1,DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bump
End Sub

Sub RandomSoundBumperBottom(Bump)
	PlaySoundAtLevelStatic SoundFX("Bumpers_Bottom_" & Int(Rnd*5)+1,DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bump
End Sub

'/////////////////////////////  SPINNER SOUNDS  ////////////////////////////
Sub SoundSpinner(spinnerswitch)
	PlaySoundAtLevelStatic ("Spinner"), SpinnerSoundLevel, spinnerswitch
End Sub


'/////////////////////////////  FLIPPER BATS SOUND SUBROUTINES  ////////////////////////////
'/////////////////////////////  FLIPPER BATS SOLENOID ATTACK SOUND  ////////////////////////////
Sub SoundFlipperUpAttackLeft(flipper)
	FlipperUpAttackLeftSoundLevel = RndNum(FlipperUpAttackMinimumSoundLevel, FlipperUpAttackMaximumSoundLevel)
	PlaySoundAtLevelStatic ("Flipper_Attack-L01"), FlipperUpAttackLeftSoundLevel, flipper
End Sub

Sub SoundFlipperUpAttackRight(flipper)
	FlipperUpAttackRightSoundLevel = RndNum(FlipperUpAttackMinimumSoundLevel, FlipperUpAttackMaximumSoundLevel)
	PlaySoundAtLevelStatic ("Flipper_Attack-R01"), FlipperUpAttackLeftSoundLevel, flipper
End Sub

'/////////////////////////////  FLIPPER BATS SOLENOID CORE SOUND  ////////////////////////////
Sub RandomSoundFlipperUpLeft(flipper)
	PlaySoundAtLevelStatic SoundFX("Flipper_L0" & Int(Rnd*9)+1,DOFFlippers), FlipperLeftHitParm, Flipper
End Sub

Sub RandomSoundFlipperUpRight(flipper)
	PlaySoundAtLevelStatic SoundFX("Flipper_R0" & Int(Rnd*9)+1,DOFFlippers), FlipperRightHitParm, Flipper
End Sub

Sub RandomSoundReflipUpLeft(flipper)
	PlaySoundAtLevelStatic SoundFX("Flipper_ReFlip_L0" & Int(Rnd*3)+1,DOFFlippers), (RndNum(0.8, 1))*FlipperUpSoundLevel, Flipper
End Sub

Sub RandomSoundReflipUpRight(flipper)
	PlaySoundAtLevelStatic SoundFX("Flipper_ReFlip_R0" & Int(Rnd*3)+1,DOFFlippers), (RndNum(0.8, 1))*FlipperUpSoundLevel, Flipper
End Sub

Sub RandomSoundFlipperDownLeft(flipper)
	PlaySoundAtLevelStatic SoundFX("Flipper_Left_Down_" & Int(Rnd*7)+1,DOFFlippers), FlipperDownSoundLevel, Flipper
End Sub

Sub RandomSoundFlipperDownRight(flipper)
	PlaySoundAtLevelStatic SoundFX("Flipper_Right_Down_" & Int(Rnd*8)+1,DOFFlippers), FlipperDownSoundLevel, Flipper
End Sub

'/////////////////////////////  FLIPPER BATS BALL COLLIDE SOUND  ////////////////////////////

Sub LeftFlipperCollide(parm)
	FlipperLeftHitParm = parm/10
	If FlipperLeftHitParm > 1 Then
		FlipperLeftHitParm = 1
	End If
	FlipperLeftHitParm = FlipperUpSoundLevel * FlipperLeftHitParm
	RandomSoundRubberFlipper(parm)
End Sub

Sub RightFlipperCollide(parm)
	FlipperRightHitParm = parm/10
	If FlipperRightHitParm > 1 Then
		FlipperRightHitParm = 1
	End If
	FlipperRightHitParm = FlipperUpSoundLevel * FlipperRightHitParm
	RandomSoundRubberFlipper(parm)
End Sub

Sub RandomSoundRubberFlipper(parm)
	PlaySoundAtLevelActiveBall ("Flipper_Rubber_" & Int(Rnd*7)+1), parm  * RubberFlipperSoundFactor
End Sub

'/////////////////////////////  ROLLOVER SOUNDS  ////////////////////////////
Sub RandomSoundRollover()
	PlaySoundAtLevelActiveBall ("Rollover_" & Int(Rnd*4)+1), RolloverSoundLevel
End Sub

Sub Rollovers_Hit(idx)
	RandomSoundRollover
End Sub

'/////////////////////////////  VARIOUS PLAYFIELD SOUND SUBROUTINES  ////////////////////////////
'/////////////////////////////  RUBBERS AND POSTS  ////////////////////////////
'/////////////////////////////  RUBBERS - EVENTS  ////////////////////////////
Sub Rubbers_Hit(idx)
	dim finalspeed
	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
	If finalspeed > 5 then		
		RandomSoundRubberStrong 1
	End if
	If finalspeed <= 5 then
		RandomSoundRubberWeak()
	End If	
End Sub

'/////////////////////////////  RUBBERS AND POSTS - STRONG IMPACTS  ////////////////////////////
Sub RandomSoundRubberStrong(voladj)
	Select Case Int(Rnd*10)+1
		Case 1 : PlaySoundAtLevelActiveBall ("Rubber_Strong_1"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 2 : PlaySoundAtLevelActiveBall ("Rubber_Strong_2"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 3 : PlaySoundAtLevelActiveBall ("Rubber_Strong_3"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 4 : PlaySoundAtLevelActiveBall ("Rubber_Strong_4"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 5 : PlaySoundAtLevelActiveBall ("Rubber_Strong_5"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 6 : PlaySoundAtLevelActiveBall ("Rubber_Strong_6"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 7 : PlaySoundAtLevelActiveBall ("Rubber_Strong_7"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 8 : PlaySoundAtLevelActiveBall ("Rubber_Strong_8"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 9 : PlaySoundAtLevelActiveBall ("Rubber_Strong_9"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 10 : PlaySoundAtLevelActiveBall ("Rubber_1_Hard"), Vol(ActiveBall) * RubberStrongSoundFactor * 0.6*voladj
	End Select
End Sub

'/////////////////////////////  RUBBERS AND POSTS - WEAK IMPACTS  ////////////////////////////
Sub RandomSoundRubberWeak()
	PlaySoundAtLevelActiveBall ("Rubber_" & Int(Rnd*9)+1), Vol(ActiveBall) * RubberWeakSoundFactor
End Sub

'/////////////////////////////  WALL IMPACTS  ////////////////////////////
Sub Walls_Hit(idx)
	RandomSoundWall()      
End Sub

Sub RandomSoundWall()
	dim finalspeed
	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
	If finalspeed > 16 then 
		Select Case Int(Rnd*5)+1
			Case 1 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_1"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 2 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_2"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 3 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_5"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 4 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_7"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 5 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_9"), Vol(ActiveBall) * WallImpactSoundFactor
		End Select
	End if
	If finalspeed >= 6 AND finalspeed <= 16 then
		Select Case Int(Rnd*4)+1
			Case 1 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_3"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 2 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_4"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 3 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_6"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 4 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_8"), Vol(ActiveBall) * WallImpactSoundFactor
		End Select
	End If
	If finalspeed < 6 Then
		Select Case Int(Rnd*3)+1
			Case 1 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_4"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 2 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_6"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 3 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_8"), Vol(ActiveBall) * WallImpactSoundFactor
		End Select
	End if
End Sub

'/////////////////////////////  METAL TOUCH SOUNDS  ////////////////////////////
Sub RandomSoundMetal()
	PlaySoundAtLevelActiveBall ("Metal_Touch_" & Int(Rnd*13)+1), Vol(ActiveBall) * MetalImpactSoundFactor
End Sub

'/////////////////////////////  METAL - EVENTS  ////////////////////////////

Sub Metals_Hit (idx)
	RandomSoundMetal
End Sub

Sub ShooterDiverter_collide(idx)
	RandomSoundMetal
End Sub

'/////////////////////////////  BOTTOM ARCH BALL GUIDE  ////////////////////////////
'/////////////////////////////  BOTTOM ARCH BALL GUIDE - SOFT BOUNCES  ////////////////////////////
Sub RandomSoundBottomArchBallGuide()
	dim finalspeed
	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
	If finalspeed > 16 then 
		PlaySoundAtLevelActiveBall ("Apron_Bounce_"& Int(Rnd*2)+1), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
	End if
	If finalspeed >= 6 AND finalspeed <= 16 then
		Select Case Int(Rnd*2)+1
			Case 1 : PlaySoundAtLevelActiveBall ("Apron_Bounce_1"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("Apron_Bounce_Soft_1"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
		End Select
	End If
	If finalspeed < 6 Then
		Select Case Int(Rnd*2)+1
			Case 1 : PlaySoundAtLevelActiveBall ("Apron_Bounce_Soft_1"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("Apron_Medium_3"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
		End Select
	End if
End Sub

'/////////////////////////////  BOTTOM ARCH BALL GUIDE - HARD HITS  ////////////////////////////
Sub RandomSoundBottomArchBallGuideHardHit()
	PlaySoundAtLevelActiveBall ("Apron_Hard_Hit_" & Int(Rnd*3)+1), BottomArchBallGuideSoundFactor * 0.25
End Sub

Sub Apron_Hit (idx)
	If Abs(cor.ballvelx(activeball.id) < 4) and cor.ballvely(activeball.id) > 7 then
		RandomSoundBottomArchBallGuideHardHit()
	Else
		RandomSoundBottomArchBallGuide
	End If
End Sub

'/////////////////////////////  FLIPPER BALL GUIDE  ////////////////////////////
Sub RandomSoundFlipperBallGuide()
	dim finalspeed
	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
	If finalspeed > 16 then 
		Select Case Int(Rnd*2)+1
			Case 1 : PlaySoundAtLevelActiveBall ("Apron_Hard_1"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("Apron_Hard_2"),  Vol(ActiveBall) * 0.8 * FlipperBallGuideSoundFactor
		End Select
	End if
	If finalspeed >= 6 AND finalspeed <= 16 then
		PlaySoundAtLevelActiveBall ("Apron_Medium_" & Int(Rnd*3)+1),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
	End If
	If finalspeed < 6 Then
		PlaySoundAtLevelActiveBall ("Apron_Soft_" & Int(Rnd*7)+1),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
	End If
End Sub

'/////////////////////////////  TARGET HIT SOUNDS  ////////////////////////////
Sub RandomSoundTargetHitStrong()
	PlaySoundAtLevelActiveBall SoundFX("Target_Hit_" & Int(Rnd*4)+5,DOFTargets), Vol(ActiveBall) * 0.45 * TargetSoundFactor
End Sub

Sub RandomSoundTargetHitWeak()		
	PlaySoundAtLevelActiveBall SoundFX("Target_Hit_" & Int(Rnd*4)+1,DOFTargets), Vol(ActiveBall) * TargetSoundFactor
End Sub

Sub PlayTargetSound()
	dim finalspeed
	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
	If finalspeed > 10 then
		RandomSoundTargetHitStrong()
		RandomSoundBallBouncePlayfieldSoft Activeball
	Else 
		RandomSoundTargetHitWeak()
	End If	
End Sub

Sub Targets_Hit (idx)
	PlayTargetSound	
End Sub

'/////////////////////////////  BALL BOUNCE SOUNDS  ////////////////////////////
Sub RandomSoundBallBouncePlayfieldSoft(aBall)
	Select Case Int(Rnd*9)+1
		Case 1 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_1"), volz(aBall) * BallBouncePlayfieldSoftFactor, aBall
		Case 2 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_2"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.5, aBall
		Case 3 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_3"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.8, aBall
		Case 4 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_4"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.5, aBall
		Case 5 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_5"), volz(aBall) * BallBouncePlayfieldSoftFactor, aBall
		Case 6 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_1"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.2, aBall
		Case 7 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_2"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.2, aBall
		Case 8 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_5"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.2, aBall
		Case 9 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_7"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.3, aBall
	End Select
End Sub

Sub RandomSoundBallBouncePlayfieldHard(aBall)
	PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_" & Int(Rnd*7)+1), volz(aBall) * BallBouncePlayfieldHardFactor, aBall
End Sub

'/////////////////////////////  DELAYED DROP - TO PLAYFIELD - SOUND  ////////////////////////////
Sub RandomSoundDelayedBallDropOnPlayfield(aBall)
	Select Case Int(Rnd*5)+1
		Case 1 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_1_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
		Case 2 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_2_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
		Case 3 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_3_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
		Case 4 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_4_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
		Case 5 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_5_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
	End Select
End Sub

'/////////////////////////////  BALL GATES AND BRACKET GATES SOUNDS  ////////////////////////////

Sub SoundPlayfieldGate()			
	PlaySoundAtLevelStatic ("Gate_FastTrigger_" & Int(Rnd*2)+1), GateSoundLevel, Activeball
End Sub

Sub SoundHeavyGate()
	PlaySoundAtLevelStatic ("Gate_2"), GateSoundLevel, Activeball
End Sub

Sub Gates_hit(idx)
	SoundHeavyGate
End Sub

Sub GatesWire_hit(idx)	
	SoundPlayfieldGate	
End Sub	

'/////////////////////////////  LEFT LANE ENTRANCE - SOUNDS  ////////////////////////////

Sub RandomSoundLeftArch()
	PlaySoundAtLevelActiveBall ("Arch_L" & Int(Rnd*4)+1), Vol(ActiveBall) * ArchSoundFactor
End Sub

Sub RandomSoundRightArch()
	PlaySoundAtLevelActiveBall ("Arch_R" & Int(Rnd*4)+1), Vol(ActiveBall) * ArchSoundFactor
End Sub


Sub Arch1_hit()
	If Activeball.velx > 1 Then SoundPlayfieldGate
	StopSound "Arch_L1"
	StopSound "Arch_L2"
	StopSound "Arch_L3"
	StopSound "Arch_L4"
End Sub

Sub Arch1_unhit()
	If activeball.velx < -8 Then
		RandomSoundRightArch
	End If
End Sub

Sub Arch2_hit()
	If Activeball.velx < 1 Then SoundPlayfieldGate
	StopSound "Arch_R1"
	StopSound "Arch_R2"
	StopSound "Arch_R3"
	StopSound "Arch_R4"
End Sub

Sub Arch2_unhit()
	If activeball.velx > 10 Then
		RandomSoundLeftArch
	End If
End Sub

'/////////////////////////////  SAUCERS (KICKER HOLES)  ////////////////////////////

Sub SoundSaucerLock()
	PlaySoundAtLevelStatic ("Saucer_Enter_" & Int(Rnd*2)+1), SaucerLockSoundLevel, Activeball
End Sub

Sub SoundSaucerKick(scenario, saucer)
	Select Case scenario
		Case 0: PlaySoundAtLevelStatic SoundFX("Saucer_Empty", DOFContactors), SaucerKickSoundLevel, saucer
		Case 1: PlaySoundAtLevelStatic SoundFX("Saucer_Kick", DOFContactors), SaucerKickSoundLevel, saucer
	End Select
End Sub

'/////////////////////////////  BALL COLLISION SOUND  ////////////////////////////
Sub OnBallBallCollision(ball1, ball2, velocity)
	Dim snd
	Select Case Int(Rnd*7)+1
		Case 1 : snd = "Ball_Collide_1"
		Case 2 : snd = "Ball_Collide_2"
		Case 3 : snd = "Ball_Collide_3"
		Case 4 : snd = "Ball_Collide_4"
		Case 5 : snd = "Ball_Collide_5"
		Case 6 : snd = "Ball_Collide_6"
		Case 7 : snd = "Ball_Collide_7"
	End Select

	PlaySound (snd), 0, Csng(velocity) ^2 / 200 * BallWithBallCollisionSoundFactor * VolumeDial, AudioPan(ball1), 0, Pitch(ball1), 0, 0, AudioFade(ball1)
End Sub


'/////////////////////////////////////////////////////////////////
'					End Mechanical Sounds
'/////////////////////////////////////////////////////////////////

'******************************************************
'****  FLEEP MECHANICAL SOUNDS
'******************************************************



'*******************************************
'  Setup Backglass
'*******************************************

const USEEM = 0 ' 0=no EM, 1 = EM enabled, 2 = EM SysGFX enabled ,3=Reels coded, 4 = Start SysGFX Timer
const USESS = 2 ' 0=no SS, 1 = SS enabled, 2 = SS LED's 
const nUSEDMD =0 ' 0=no DMD, 1= DMD 2= DMD +mirror DMD

Dim xoff,yoff,zoff,xrot,zscale, xcen,ycen

Sub setup_backglass()

	xoff = -20
	yoff = 78
	zoff = 699
	xrot = -90

	if USESS > 1 then
		center_digits()
	end if

	if USEEM > 0 then	
		if 	USEEM > 1 then
			center_sysgfx()
		end if

		if USESS = 0 then 
			center_objects_em()
		
			if 	USEEM > 2 then
				For  ix =0 to 4
					SetDrum ix, 1 , 0 
					SetDrum ix, 2 , 0  
					SetDrum ix, 3 , 0  
					SetDrum ix, 4 , 0  
					SetDrum ix, 5 , 0  
				Next 

				cred =reels(4, 0)
				reels(4, 0) = 0
				SetDrum -1,0,  0
				
				SetReel 0,-1,  Credit
				reels(4, 0) = Credit
			end if 'USEEM > 2
		end if 'USESS = 0
		
		if 	USEEM > 3 then
			EMReelTimer.enabled = 1
		end if 'USEEM > 3
	
	end if 'USEEM
	
end sub


'*******************************************
'  1-4 player,credit,bip,+extra 7 segment SETUP CODE
'*******************************************

Sub center_digits()
	Dim ix, xx, yy, yfact, xfact, xobj

	zscale = 0.0000001

	xcen = 0  '(130 /2) - (92 / 2)
	ycen = (780 /2 ) + (203 /2)

	for ix = 0 to 31
		For Each xobj In Digits(ix)

			xx = xobj.x  
				
			xobj.x = (xoff - xcen) + xx
			yy = xobj.y ' get the yoffset before it is changed
			xobj.y = yoff 

			If (yy < 0.) then
				yy = yy * -1
			end if

			xobj.height = (zoff - ycen) + yy - (yy * (zscale))
			xobj.rotx = xrot
		Next
	Next
end sub


Dim Digits(32)
Digits(0) = Array(LED1x0,LED1x1,LED1x2,LED1x3,LED1x4,LED1x5,LED1x6)
Digits(1) = Array(LED2x0,LED2x1,LED2x2,LED2x3,LED2x4,LED2x5,LED2x6)
Digits(2) = Array(LED3x0,LED3x1,LED3x2,LED3x3,LED3x4,LED3x5,LED3x6)
Digits(3) = Array(LED4x0,LED4x1,LED4x2,LED4x3,LED4x4,LED4x5,LED4x6)
Digits(4) = Array(LED5x0,LED5x1,LED5x2,LED5x3,LED5x4,LED5x5,LED5x6)
Digits(5) = Array(LED6x0,LED6x1,LED6x2,LED6x3,LED6x4,LED6x5,LED6x6)
Digits(6) = Array(LED7x0,LED7x1,LED7x2,LED7x3,LED7x4,LED7x5,LED7x6)

Digits(7) = Array(LED8x0,LED8x1,LED8x2,LED8x3,LED8x4,LED8x5,LED8x6)
Digits(8) = Array(LED9x0,LED9x1,LED9x2,LED9x3,LED9x4,LED9x5,LED9x6)
Digits(9) = Array(LED10x0,LED10x1,LED10x2,LED10x3,LED10x4,LED10x5,LED10x6)
Digits(10) = Array(LED11x0,LED11x1,LED11x2,LED11x3,LED11x4,LED11x5,LED11x6)
Digits(11) = Array(LED12x0,LED12x1,LED12x2,LED12x3,LED12x4,LED12x5,LED12x6)
Digits(12) = Array(LED13x0,LED13x1,LED13x2,LED13x3,LED13x4,LED13x5,LED13x6)
Digits(13) = Array(LED14x0,LED14x1,LED14x2,LED14x3,LED14x4,LED14x5,LED14x6)

Digits(14) = Array(LED1x000,LED1x001,LED1x002,LED1x003,LED1x004,LED1x005,LED1x006)
Digits(15) = Array(LED1x100,LED1x101,LED1x102,LED1x103,LED1x104,LED1x105,LED1x106)
Digits(16) = Array(LED1x200,LED1x201,LED1x202,LED1x203,LED1x204,LED1x205,LED1x206)
Digits(17) = Array(LED1x300,LED1x301,LED1x302,LED1x303,LED1x304,LED1x305,LED1x306)
Digits(18) = Array(LED1x400,LED1x401,LED1x402,LED1x403,LED1x404,LED1x405,LED1x406)
Digits(19) = Array(LED1x500,LED1x501,LED1x502,LED1x503,LED1x504,LED1x505,LED1x506)
Digits(20) = Array(LED1x600,LED1x601,LED1x602,LED1x603,LED1x604,LED1x605,LED1x606)

Digits(21) = Array(LED2x000,LED2x001,LED2x002,LED2x003,LED2x004,LED2x005,LED2x006)
Digits(22) = Array(LED2x100,LED2x101,LED2x102,LED2x103,LED2x104,LED2x105,LED2x106)
Digits(23) = Array(LED2x200,LED2x201,LED2x202,LED2x203,LED2x204,LED2x205,LED2x206)
Digits(24) = Array(LED2x300,LED2x301,LED2x302,LED2x303,LED2x304,LED2x305,LED2x306)
Digits(25) = Array(LED2x400,LED2x401,LED2x402,LED2x403,LED2x404,LED2x405,LED2x406)
Digits(26) = Array(LED2x500,LED2x501,LED2x502,LED2x503,LED2x504,LED2x505,LED2x506)
Digits(27) = Array(LED2x600,LED2x601,LED2x602,LED2x603,LED2x604,LED2x605,LED2x606)


Digits(28) = Array(LEDax300,LEDax301,LEDax302,LEDax303,LEDax304,LEDax305,LEDax306)
Digits(29) = Array(LEDbx400,LEDbx401,LEDbx402,LEDbx403,LEDbx404,LEDbx405,LEDbx406)
Digits(30) = Array(LEDcx500,LEDcx501,LEDcx502,LEDcx503,LEDcx504,LEDcx505,LEDcx506)
Digits(31) = Array(LEDdx600,LEDdx601,LEDdx602,LEDdx603,LEDdx604,LEDdx605,LEDdx606)

dim DisplayColor
DisplayColor =  RGB(255,40,1)

Sub DisplayTimer
    Dim ChgLED, ii, jj, num, chg, stat, obj, b, x
    ChgLED=Controller.ChangedLEDs(&Hffffffff, &Hffffffff)
    If Not IsEmpty(ChgLED)Then
       For ii=0 To UBound(chgLED)
          num=chgLED(ii, 0) : chg=chgLED(ii, 1) : stat=chgLED(ii, 2)
			if (num < 32) then
              For Each obj In Digits(num)
'                   If chg And 1 Then obj.visible=stat And 1    'if you use the object color for off; turn the display object visible to not visible on the playfield, and uncomment this line out.
				   If chg And 1 Then FadeDisplay obj, stat And 1	
                   chg=chg\2 : stat=stat\2
                  Next
			Else
			       end if
        Next
    End If
 End Sub

Sub FadeDisplay(object, onoff)
	If OnOff = 1 Then
		object.color = DisplayColor
		Object.Opacity = 12
	Else
		Object.Color = RGB(1,1,1)
		Object.Opacity = 6
	End If
End Sub


Sub InitDigits()
	dim tmp, x, obj
	for x = 0 to uBound(Digits)
		if IsArray(Digits(x) ) then
			For each obj in Digits(x)
				obj.height = obj.height + 18
				FadeDisplay obj, 0
			next
		end If
	Next
End Sub

InitDigits


'*******************************************
'  LEDs Display, Based on Scapino's LEDs
'*******************************************

Dim DTDigits(32)
Dim Patterns(11)
Dim Patterns2(11)

Patterns(0) = 0     'empty
Patterns(1) = 63    '0
Patterns(2) = 6     '1
Patterns(3) = 91    '2
Patterns(4) = 79    '3
Patterns(5) = 102   '4
Patterns(6) = 109   '5
Patterns(7) = 125   '6
Patterns(8) = 7     '7
Patterns(9) = 127   '8
Patterns(10) = 111  '9

Patterns2(0) = 128  'empty
Patterns2(1) = 191  '0
Patterns2(2) = 134  '1
Patterns2(3) = 219  '2
Patterns2(4) = 207  '3
Patterns2(5) = 230  '4
Patterns2(6) = 237  '5
Patterns2(7) = 253  '6
Patterns2(8) = 135  '7
Patterns2(9) = 255  '8
Patterns2(10) = 239 '9

'Assign 6-digit output to reels
Set DTDigits(0) = a0
Set DTDigits(1) = a1
Set DTDigits(2) = a2
Set DTDigits(3) = a3
Set DTDigits(4) = a4
Set DTDigits(5) = a5
Set DTDigits(6) = a6

Set DTDigits(7) = b0
Set DTDigits(8) = b1
Set DTDigits(9) = b2
Set DTDigits(10) = b3
Set DTDigits(11) = b4
Set DTDigits(12) = b5
Set DTDigits(13) = b6

Set DTDigits(14) = c0
Set DTDigits(15) = c1
Set DTDigits(16) = c2
Set DTDigits(17) = c3
Set DTDigits(18) = c4
Set DTDigits(19) = c5
Set DTDigits(20) = c6

Set DTDigits(21) = d0
Set DTDigits(22) = d1
Set DTDigits(23) = d2
Set DTDigits(24) = d3
Set DTDigits(25) = d4
Set DTDigits(26) = d5
Set DTDigits(27) = d6

Set DTDigits(28) = e0
Set DTDigits(29) = e1
Set DTDigits(30) = e2
Set DTDigits(31) = e3

Sub UpdateLeds
    On Error Resume Next
    Dim ChgLED, ii, jj, chg, stat
    ChgLED = Controller.ChangedLEDs(&HFF, &HFFFF)
    If Not IsEmpty(ChgLED)Then
        For ii = 0 To UBound(ChgLED)
            chg = chgLED(ii, 1):stat = chgLED(ii, 2)
            For jj = 0 to 10
                If stat = Patterns(jj)OR stat = Patterns2(jj)then DTDigits(chgLED(ii, 0)).SetValue jj
            Next
        Next
    End IF
End Sub


'*******************************************
'  LUT
'*******************************************

Sub SetLUT  'AXS
	Table1.ColorGradeImage = "LUT" & LUTset
	VRFlashLUT.imageA = "FlashLUT" & LUTset
end sub 

Sub LUTBox_Timer
	LUTBox.TimerEnabled = 0 
	LUTBox.Visible = 0
	VRFlashLUT.opacity = 0
End Sub

Sub ShowLUT
	LUTBox.visible = 1
	VRFlashLUT.opacity = 100
	Select Case LUTSet
		Case 0: LUTBox.text = "Fleep Natural Dark 1"
		Case 1: LUTBox.text = "Fleep Natural Dark 2"
		Case 2: LUTBox.text = "Fleep Warm Dark"
		Case 3: LUTBox.text = "Fleep Warm Bright"
		Case 4: LUTBox.text = "Fleep Warm Vivid Soft"
		Case 5: LUTBox.text = "Fleep Warm Vivid Hard"
		Case 6: LUTBox.text = "Skitso Natural and Balanced"
		Case 7: LUTBox.text = "Skitso Natural High Contrast"
		Case 8: LUTBox.text = "3rdaxis Referenced THX Standard"
		Case 9: LUTBox.text = "CalleV Punchy Brightness and Contrast"
		Case 10: LUTBox.text = "HauntFreaks Desaturated"
  		Case 11: LUTBox.text = "Tomate washed out"
        Case 12: LUTBox.text = "VPW original 1on1"
        Case 13: LUTBox.text = "bassgeige"
        Case 14: LUTBox.text = "blacklight"
        Case 15: LUTBox.text = "B&W Comic Book"
        Case 16: LUTBox.text = "Skitso New Warmer LUT"
        Case 17: LUTBox.text = "Original LUT"
	End Select

	LUTBox.TimerEnabled = 1

End Sub

Sub SaveLUT
	Dim FileObj
	Dim ScoreFile

	Set FileObj=CreateObject("Scripting.FileSystemObject")
	If Not FileObj.FolderExists(UserDirectory) then 
		Exit Sub
	End if

	if LUTset = "" then LUTset = 17 'failsafe to original

	Set ScoreFile=FileObj.CreateTextFile(UserDirectory & "Comet_LUT.txt",True)
	ScoreFile.WriteLine LUTset
	Set ScoreFile=Nothing
	Set FileObj=Nothing
End Sub

Sub LoadLUT
	Dim FileObj, ScoreFile, TextStr
	dim rLine

	Set FileObj=CreateObject("Scripting.FileSystemObject")
	If Not FileObj.FolderExists(UserDirectory) then 
		LUTset=17
		Exit Sub
	End if
	If Not FileObj.FileExists(UserDirectory & "Comet_LUT.txt") then
		LUTset=17
		Exit Sub
	End if
	Set ScoreFile=FileObj.GetFile(UserDirectory & "Comet_LUT.txt")
	Set TextStr=ScoreFile.OpenAsTextStream(1,0)
		If (TextStr.AtEndOfStream=True) then
			Exit Sub
		End if
		rLine = TextStr.ReadLine
		If rLine = "" then
			LUTset=17
			Exit Sub
		End if
		LUTset = int (rLine) 
		Set ScoreFile = Nothing
	    Set FileObj = Nothing
End Sub

Sub ShowLUT_Init
	LUTBox.visible = 0
	VRFlashLUT.opacity = 0
End Sub


'*******************************************
'  Ball brightness code
'*******************************************

if BallBrightness = 0 Then
	Table1.BallImage="ball-dark"
	Table1.BallFrontDecal="JPBall-Scratches"
elseif BallBrightness = 1 Then
	Table1.BallImage="ball-light-hf"
	Table1.BallFrontDecal="g5kscratchedmorelight"
else
	Table1.BallImage="ball-lighter-hf"
	Table1.BallFrontDecal="g5kscratchedmorelight"
End if


'*******************************************
' Hybrid code for VR, Cab, and Desktop
'*******************************************

Dim VRThings

if VR_Room = 0 and cab_mode = 0 Then
	for each VRThings in VRStuff:VRThings.visible = 0:Next
	for each VRThings in VRClock:VRThings.visible = 0:Next
	for each VRThings in VRBackglass:VRThings.visible = 0:Next
	for each VRThings in DTRails:VRThings.visible = 1:Next
Elseif VR_Room = 0 and cab_mode = 1 Then
	for each VRThings in VRStuff:VRThings.visible = 0:Next
	for each VRThings in VRClock:VRThings.visible = 0:Next
	for each VRThings in VRBackglass:VRThings.visible = 0:Next
	for each VRThings in DTBackglass:VRThings.visible = 0: Next
	for each VRThings in DTRails:VRThings.visible = 0:Next
Else
	for each VRThings in VRStuff:VRThings.visible = 1:Next
	for each VRThings in VRClock:VRThings.visible = WallClock:Next
	for each VRThings in DTBackglass:VRThings.visible = 0: Next
	for each VRThings in DTRails:VRThings.visible = 0:Next
'Custom Walls, Floor, and Roof
	if CustomWalls = 1 Then
		VR_Wall_Left.image = "VR_Wall_Left"
		VR_Wall_Right.image = "VR_Wall_Right"
		VR_Floor.image = "VR_Floor"
		VR_Roof.image = "VR_Roof"
	end if

End If


'*******************************************
'  VR Clock 
'*******************************************

Dim CurrentMinute ' for VR clock

Sub ClockTimer_Timer()
	Pminutes.RotAndTra2 = (Minute(Now())+(Second(Now())/100))*6
	Phours.RotAndTra2 = Hour(Now())*30+(Minute(Now())/2)
	Pseconds.RotAndTra2 = (Second(Now()))*6
	CurrentMinute=Minute(Now())
End Sub


'*******************************************
'  VR Glass and Glass Scratches, and Topper
'*******************************************

If VR_Room = 1 Then 

	If Scratches = 1 Then
		GlassImpurities.visible = 1
	Else
		GlassImpurities.visible = 0
	End If

	If Glass = 1 Then
		WindowGlass.visible = 1
	Else
		WindowGlass.visible =0
	End If

	If topper = 1 Then
		Primary_topper.visible = 1
	Else
		Primary_topper.visible = 0
	End If

Else
	GlassImpurities.visible = 0
	WindowGlass.visible = 0
	Primary_topper.visible = 0
End If


'*******************************************
'  LAMP CALLBACK for the bckglass flasher lamps
'*******************************************

if VR_Room = 1 Then
	Set LampCallback = GetRef("UpdateMultipleLamps")
End If

Sub UpdateMultipleLamps()

	If Controller.Lamp(1) = 0 Then: f1bg.visible=0: else: f1bg.visible=1 ' game over
	If Controller.Lamp(2) = 0 Then: f2bg.visible=0: else: f2bg.visible=1 ' match
	If Controller.Lamp(3) = 0 Then: f3bg.visible=0: else: f3bg.visible=1 ' tilt
	If Controller.Lamp(4) = 0 Then: f4bg.visible=0: else: f4bg.visible=1 ' high score
	If Controller.Lamp(5) = 0 Then: f5bg.visible=0: else: f5bg.visible=1 ' ride again
	If Controller.Lamp(6) = 0 Then: f6bg.visible=0: else: f6bg.visible=1 ' ball in play
	If Controller.Lamp(7) = 0 Then: FlBGL7.visible=0: else: FlBGL7.visible=1 ' Left cyclone eye
	If Controller.Lamp(8) = 0 Then: FlBGL8.visible=0: else: FlBGL8.visible=1 ' Right cyclone eye
	If Controller.Lamp(58) = 0 Then: FlBGL58.visible=0: else: FlBGL58.visible=1 ' Top right flasher
End Sub


if VR_Room = 0 and cab_mode = 0 Then
	Set LampCallback = GetRef("UpdateDTLamps")
End If

Sub UpdateDTLamps()
	If Controller.Lamp(1) = 0 Then: GameOverReel.setValue(0):	Else: GameOverReel.setValue(1) 'Game Over
	If Controller.Lamp(2) = 0 Then: MatchReel.setValue(0):		Else: MatchReel.setValue(1) 'Match
	If Controller.Lamp(3) = 0 Then: TiltReel.setValue(0):		Else: TiltReel.setValue(1) 'Tilt
	If Controller.Lamp(4) = 0 Then: HighScoreReel.setValue(0):	Else: HighScoreReel.setValue(1) 'High Score
	If Controller.Lamp(5) = 0 Then: ShootAgainReel.setValue(0):	Else: ShootAgainReel.setValue(1) 'Shoot Again
	If Controller.Lamp(6) = 0 Then: BIPReel.setValue(0):		Else: BIPReel.setValue(1) 'Ball in Play
End Sub



'*******************************************
'  Set Up Backglass Flashers
'*******************************************
' this is for lining up the backglass flashers on top of a backglass image

Sub SetBackglass()
	Dim obj

	For Each obj In VRBackglassFlash
		obj.x = obj.x
		obj.height = - obj.y
		obj.y = 78 'adjusts the distance from the backglass towards the user
	Next


End Sub


'*******************************************
'  Backglass Flasher Objects
'*******************************************

Sub Sol7(Enabled)
	If Enabled Then
		FlBGL7F.visible = 1 
	Else
		FlBGL7F.visible = 0	
	End If 
End Sub

Sub Sol8(Enabled)
	If Enabled Then
		FlBGL8F.visible = 1 
	Else
		FlBGL8F.visible = 0	
	End If 
End Sub

Sub Sol9(Enabled)
	If Enabled Then
		FlBGL9.visible = 1 
	Else
		FlBGL9.visible = 0	
	End If 
End Sub

Sub Sol10(Enabled)
	If Enabled Then
		FlBGL10.visible = 1 
	Else
		FlBGL10.visible = 0	
	End If 
End Sub


Sub Sol13(Enabled) 		'inverted lights
	If Enabled Then
		FlBGL13a.visible = 0 
		FlBGL13b.visible = 0 
		FlBGL13b1.visible = 0 
		FlBGL13b2.visible = 0 
		FlBGL13c.visible = 0 
		FlBGL13d.visible = 0 
		FlBGL13e.visible = 0 
		FlBGL13f.visible = 0 
		FlBGL13g.visible = 0 
		FlBGL13h.visible = 0 
		FlBGL13h1.visible = 0 
		FlBGL13h2.visible = 0 
		FlBGL13h3.visible = 0 
		FlBGL13h4.visible = 0 
		FlBGL13i.visible = 0 
		FlBGL13j.visible = 0 
		FlBGL13k.visible = 0 
		FlBGL13l.visible = 0 
		FlBGL13m.visible = 0 
		FlBGL13n.visible = 0 
		FlBGL13o.visible = 0 
		FlBGL13p.visible = 0 
		FlBGL13q.visible = 0 
		FlBGL13r.visible = 0 
		FlBGL13s.visible = 0 
		FlBGL13t.visible = 0 
		FlBGL13u.visible = 0 
		FlBGL13v.visible = 0 

		FlBGL7.opacity = 300
		FlBGL8.opacity = 300
		FlBGL58.opacity = 800

	Else
		FlBGL13a.visible = 1 
		FlBGL13b.visible = 1 
		FlBGL13b1.visible = 1 
		FlBGL13b2.visible = 1
		FlBGL13c.visible = 1 
		FlBGL13d.visible = 1 
		FlBGL13e.visible = 1 
		FlBGL13f.visible = 1 
		FlBGL13g.visible = 1 
		FlBGL13h.visible = 1 
		FlBGL13h1.visible = 1 
		FlBGL13h2.visible = 1 
		FlBGL13h3.visible = 1 
		FlBGL13h4.visible = 1 
		FlBGL13i.visible = 1 
		FlBGL13j.visible = 1 
		FlBGL13k.visible = 1 
		FlBGL13l.visible = 1 
		FlBGL13m.visible = 1 
		FlBGL13n.visible = 1 
		FlBGL13o.visible = 1 
		FlBGL13p.visible = 1 
		FlBGL13q.visible = 1 
		FlBGL13r.visible = 1 
		FlBGL13s.visible = 1 
		FlBGL13t.visible = 1 
		FlBGL13u.visible = 1
		FlBGL13v.visible = 1

		FlBGL7.opacity = 55
		FlBGL8.opacity = 55
		FlBGL58.opacity = 50

	End If 
End Sub


'*******************************************
'  Left Outlane Post Difficult Code
'*******************************************

If leftoutlanepost = 0 Then
	phy_post_easy.collidable = 0
	PostEasy.visible = 0
	EasyRubber.visible = 0
	Rubber1.visible = 1
Else
	phy_post_easy.collidable = 1
	PostEasy.visible = 1
	EasyRubber.visible = 1
	Rubber1.visible = 0
End If


