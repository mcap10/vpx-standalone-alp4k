'__  ____ ____ _  _    ___ ____    ___ _  _ ____    ____ _  _ ___ _  _ ____ ____ 
'|__] |__| |    |_/      |  |  |     |  |__| |___    |___ |  |  |  |  | |__/ |___ 
'|__] |  | |___ | \_     |  |__|     |  |  | |___    |    |__|  |  |__| |  \ |___ 
'                                                                                 
' Back to the Future Collectors Edition
' Based on Back to the Future / IPD No. 126 / Data East June, 1990 / 4 Players
' 
' VP911 version 1.0 by JPSalas Mars 2011
' v1.0 - Cyberpez, rothbauerw, wrd1972, HauntFreaks, ClarkKent, dark, RustyCardores
' v1.01 - versins77 - nFozzy, Fleep, Upscales, etc.
' v1.05 - TastyWasps - VR hybrid addition with assets from Hauntfreaks, Senseless and DaRDog81

Option Explicit
Randomize

Dim tablewidth: tablewidth = bttf.width 'fleep
Dim tableheight: tableheight = bttf.height 'fleep
Dim LUTset, LutToggleSound 'LUT

Dim Ballsize,BallMass
BallSize = 50
BallMass = 1 

'----- Phsyics Mods -----
Const RubberizerEnabled = 1			'0 = normal flip rubber, 1 = more lively rubber for flips
Const FlipperCoilRampupMode = 0   	'0 = fast, 1 = medium, 2 = slow (tap passes should work)

Const lob = 0	'locked balls on start; might need some fiddling depending on how your locked balls are done

Const VolumeDial = 0.8				'fleep
Const BallRollVolume = 0.5 			'fleep'Level of ball rolling volume. Value between 0 and 1
Const RampRollVolume = 0.5 			'fleep'Level of ramp rolling volume. Value between 0 and 1

Const DynamicBallShadowsOn = 1		'0 = no dynamic ball shadow ("triangles" near slings and such), 1 = enable dynamic ball shadow
Const AmbientBallShadowOn = 1		'0 = Static shadow under ball ("flasher" image, like JP's)
'									'1 = Moving ball shadow ("primitive" object, like ninuzzu's) - This is the only one that shows up on the pf when in ramps and fades when close to lights!
'									'2 = flasher image shadow, but it moves like ninuzzu's

Const VRRoomChoice = 1				' 1 = Mega Room (Hill Valley Clock Tower),  2 = Minimal Room (Sixtoe)
									' LUT Selection will influence brightness of room/playfield so experiment as needed with Magna Saves.

Const SSolenoidOn="solon",SSolenoidOff="soloff",SFlipperOn="FlipperUp",SFlipperOff="FlipperDown",SCoin="" 'fleep


Dim InstructionCardsLeft, InstructionCardsRight, FlipperColor, SolidStateSitcker, BallRadius, GIColorMod, LeftHillValleyMod, RightHillValleyMod, DeloreanColorMod, PlasticProtectors, BallMod, WobblePlastic, HologramUpdateStep, IsItMultiball, HologramPhoto, BallsLocked, BallsInPlay, enableBallControl, musicsnippet, RubberColor
Dim DesktopMode: DesktopMode = bttf.ShowDT

'***************************************************************************
'						PLAYFIELD OPTIONS
'***************************************************************************
		
' Ball Mod
BallMod = 0					' 0 = Normal balls, 1 = Yellow/Orange/Red balls

' GI ColorMod
GIColorMod = 1				' 0 = Random, 1 = normal, 2 = Blue / Yellow, 3 = Blue / Pink

' Hill Valley box ColorMod
LeftHillValleyMod = 0		' 0 = Off, 1 = On
RightHillValleyMod = 0		' 0 = Off, 1 = On

' Delorean ColorMod
DeloreanColorMod = 0		' 0 = White, 1 = Red

'Plastic Protectors
PlasticProtectors = 1		' 0 = Random, 1 = Clear, 2 = BlackLight Yellow, 3 = Blacklight Red, 4 = Blacklight Orange

' Instruction Cards
InstructionCardsLeft = 1	' -1 = No Cards, 0 = Random, 1 = Standard, 2 = Alt1, 3 = Alt2
InstructionCardsRight = 1	' -1 = No Cards, 0 = Random, 1 = Standard, 2 = Alt1, 3 = Alt2

' Hologram Photo (photo on apron changes as balls locked)
HologramPhoto = 0 ' 0 = None, 1 = Show Photo

' Intro music (play music snippet on game load)
MusicSnippet = 0		' 0 = Off, 1 = On

' Wobble Plastic
WobblePlastic = 1		' 0 = No Wobble, 1 = Wobbles

' Rubber Color
RubberColor = 1			' 0 = White, 1 = Black

'  Flipper Colors (Not Used)
'0 = Random
'1 = White Flipper Black Rubber
'2 = White Flipper Red Rubber
'3 = White Flipper Yellow Rubber
'4 = Yellow Flipper Black Rubber
'5 = Yellow Flipper Red Rubber
'6 = Yellow Flipper Yellow Rubber
'7 = Metalic Yellow Flipper Black Rubber
'8 = Metalic Yellow Flipper Red Rubber
'9 = Metalic Yellow Flipper Yellow Rubber

'FlipperColor = 5

' Solid State Sticker (Not Used)
'0 = Random
'1 = None
'2 = Black
'3 = Red
'4 = Yellow

'SolidStateSticker = 1

'***************************************************************************
'					END	PLAYFIELD OPTIONS
'***************************************************************************

'Ball Size and Weight
BallRadius = 25
BallMass = 1

enableBallControl = 0

' ===============================================================================================
' load game controller
' ===============================================================================================

On Error Resume Next
ExecuteGlobal GetTextFile("controller.vbs")
If Err Then MsgBox "You need the controller.vbs in order to run this table, available in the vp10 package"
On Error Goto 0

LoadVPM "01560000", "DE.VBS", 3.26

'********************
'Standard definitions
'********************

Const cGameName = "bttf_a27"
Const UseSolenoids = 2
Const UseLamps = 0
Const UseGI = 1
Const UseSync = 0
Const HandleMech = 0

Dim bsTrough, bsVuk, bsTR, vLock, x, bump1, bump2, bump3, DTBank
Dim MaxBalls, InitTime, EjectTime, TroughEject, TroughCount, iBall, fgBall

'----- VR Room Auto-Detect -----
Const LiveViewVRSim = 0				' 0 = Default, 1 = View table in VR in "Live View Editor"

Dim VRMode, VR_Obj

If RenderingMode = 2 or LiveViewVRSim = 1 Then
	VRMode = True
	Primary_CabBack.Sidevisible = True
	Ramp15.Visible = 0
	Ramp16.Visible = 0
	Cabinet.Visible = 0
	GI_003.Visible = 0
	GI_004.Visible = 0
	GI_061.Visible = 0
	GI_062.Visible = 0
	GI_063.Visible = 0
	l6.Intensity = 15
	l7.Intensity = 15
	l8.Intensity = 15


	For Each VR_Obj in VRCabinet : VR_Obj.Visible = 1 : Next
	If VRRoomChoice = 1 Then
		For Each VR_Obj in VRMegaRoom : VR_Obj.Visible = 1 : Next
	Else
		For Each VR_Obj in VRMinimalRoom : VR_Obj.Visible = 1 : Next
	End If
	SetBackglass
Else
	VRMode = False
	For Each VR_Obj in VRCabinet : VR_Obj.Visible = 0 : Next
	For Each VR_Obj in VRBackglass : VR_Obj.Visible = 0 : Next
	For Each VR_Obj in VRMinimalRoom : VR_Obj.Visible = 0 : Next
	For Each VR_Obj in VRMegaRoom : VR_Obj.Visible = 0 : Next
End If

'*******************************************
' Set Up Backglass Flashers
' This is for lining up the backglass flashers on top of a backglass image
'*******************************************

Sub SetBackglass()
	Dim obj
	For Each obj In VRBackglass
		obj.x = obj.x + 15
		obj.height = - obj.y + 225
		obj.y = -90 'adjusts the distance from the backglass towards the user
		obj.RotX = 90
	Next
End Sub

' ****** LUT overall contrast & brightness setting *******
Dim luts, lutpos

luts = array("LUTVogliadicane80", "LUTVogliadicane70", "1to1", "Fleep Natural Dark 1", "Fleep Natural Dark 2", "Fleep Warm Bright", "Fleep Warm Dark", "3rdaxis Referenced THX Standard", "CalleV Punchy Brightness and Contrast", "Skitso Natural and Balanced", "Skitso Natural High Contrast", "LUTbassgeige1", "LUTbassgeige2", "LUTbassgeigemeddark", "LUTbassgeigemeddarkwhite", "LUTbassgeigeultrdark", "LUTbassgeigeultrdarkwhite", "LUTblacklight", "LUTfleep", "LUTmandolin", "LUTmlager8", "LUTmlager8night", "LUTrobertmstotan0_darker", "luttotan4mhcontrastfilmic2", "LUTtotan1", "LUTtotan2", "LUTtotan4", "LUTtotan5", "LUTtotan6")

Const EnableMagnasave = 1		' 1 - on; 0 - off; if on then the magnasave button let's you rotate all LUT's

LoadLUT 
SetLUT 

'************
' Table init.
'************

Sub bttf_Init
    vpmInit Me
    With Controller
        .GameName = cGameName
        If Err Then MsgBox "Can't start Game " & cGameName & vbNewLine & Err.Description:Exit Sub
        .SplashInfoLine = "Back to the Future Collectors Edition" & vbNewLine & "Data East - 1990"
        ' DMD position and size, example
        '.Games(cGameName).Settings.Value("dmd_pos_x")=500
        '.Games(cGameName).Settings.Value("dmd_pos_y")=2
        '.Games(cGameName).Settings.Value("dmd_width")=400
        '.Games(cGameName).Settings.Value("dmd_height")=90

		.Games(cGameName).Settings.value("sound") = 1 ' - Test table sounds...  disables ROM sounds

        .Games(cGameName).Settings.Value("rol") = 0 'rotate DMD to the left
        .HandleKeyboard = 0
        .ShowTitle = 0
        .ShowDMDOnly = 1
        .ShowFrame = 0
        .HandleMechanics = 0
	  If DesktopMode = true then .hidden = 0 Else .hidden = 0 End If
        .Run GetPlayerHWnd
        If Err Then MsgBox Err.Description
        On Error Goto 0
    End With

    ' Nudging
    vpmNudge.TiltSwitch = swTilt
    vpmNudge.Sensitivity = 1
    vpmNudge.TiltObj = Array(bumper1, bumper2, bumper3, LeftSlingshot, RightSlingshot)


    ' Drop Targets
   	Set DTBank = New cvpmDropTarget  
   	  With DTBank
  		.InitDrop Array(Array(sw41),Array(sw42),Array(sw43)), Array(41,42,43)
		.InitSnd SoundFX("Drop_Target_Down_1",DOFDropTargets),SoundFX("Drop_Target_Reset_1",DOFContactors)
       End With

    ' Top Right Saucer
    Set bsTR = New cvpmBallStack
    With bsTR
        .InitSaucer sw45, 45, 194, 10
        .KickForceVar = 2
        .KickBalls = 1
        .InitExitSnd SoundFX("Saucer_Enter_1",DOFContactors), SoundFX("Solenoid",DOFContactors) 
    End With


    ' Main Timer init
    PinMAMETimer.Interval = PinMameInterval
    PinMAMETimer.Enabled = 1


    bump1 = 0:bump2 = 0:bump3 = 0
    SolGi 1
	CheckInstructionCards
	SetFlipperColor
	SetGIColor
	StartLevel
	SetHillValleyColorMod
	SetDeloreanColorMod
	SetRubberColor
	Backdrop_Init

' ball through system
	MaxBalls=3	
	InitTime=61
	EjectTime=0
	TroughEject=1
	TroughCount=0
	iBall = 3
	fgBall = false

    CreatBalls

	PrevGameOver = 0

	'Digits
	center_digits()

End Sub

Sub center_digits()

	Dim xoff, yoff, zoff, xcen, ycen, ii, xx, yy, xfact, yfact, obj, xrot, zscale

	xoff = 555 ' xoffset of destination (screen coords)
	yoff = -95   ' yoffset of destination (screen coords) 
	zoff = 993 ' zoffset of destination (screen coords)
	xrot = -90
	zscale = 0.08

	xcen = (1133 /2) - (53 / 2)
	ycen = (1183 /2 ) + (133 /2)
	yfact = 40 'y fudge factor (ycen was wrong so fix)
	xfact = 40

	for ii =0 to 31

		For Each obj In Digits(ii)

			xx = obj.x 
			obj.x = (xoff -xcen) + xx +xfact
			yy = obj.y ' get the yoffset before it is changed
			obj.y =yoff 

			If(yy < 0.) then
				yy = yy * -1
			End If

			obj.height =( zoff - ycen) + yy - (yy * zscale) + yfact
	
			obj.rotx = xrot
			obj.visible=0 'make sure all digits are reset to off

		Next
	
	Next

End Sub

Sub bttf_Paused:Controller.Pause = 1:End Sub
Sub bttf_unPaused:Controller.Pause = 0:End Sub

'**********
' Keys
'**********

Sub bttf_KeyDown(ByVal Keycode)

	If keycode = PlungerKey Then
		Plunger.PullBack
		SoundPlungerPull()
   	 	TimerDigitalPlunger.Enabled = True
		TimerAnalogPlunger.Enabled = False
	End If

	If keycode = keyInsertCoin1 or keycode = keyInsertCoin2 or keycode = keyInsertCoin3 or keycode = keyInsertCoin4 Then
		Select Case Int(rnd*3)
			Case 0: PlaySound ("Coin_In_1"), 0, CoinSoundLevel, 0, 0.25
			Case 1: PlaySound ("Coin_In_2"), 0, CoinSoundLevel, 0, 0.25
			Case 2: PlaySound ("Coin_In_3"), 0, CoinSoundLevel, 0, 0.25
		End Select
	End If

    If keycode = LeftTiltKey Then
		LeftNudge 270, 1
	End If

    If keycode = RightTiltKey Then 
		RightNudge 90, 1
	End If

    If keycode = CenterTiltKey Then 
		CenterNudge 0, 2
	End If

	' ****** LUT Keydown ************************
	If keycode = RightMagnaSave and EnableMagnaSave = 1 Then
		lutpos = lutpos + 1 : If lutpos > ubound(luts) Then lutpos = 0 : end if
        call myChangeLut
		playsound "Lut_Toggle"
	End If

	If keycode = LeftMagnaSave and EnableMagnaSave = 1 Then
		lutpos = lutpos - 1 : If lutpos < 0 Then lutpos = ubound(luts) : end if 
        call myChangeLut
		playsound "LUT_Toggle"
    End If

	' ****** LUT Keydown End ********************

	'Flipper nFozzy
	If keycode = LeftFlipperKey Then FlipperActivate LeftFlipper, LFPress:Primary_FlipperButtonLeft.X = Primary_FlipperButtonLeft.X + 10
	If keycode = RightFlipperKey Then FlipperActivate RightFlipper, RFPress:Primary_FlipperButtonRight.X = Primary_FlipperButtonRight.X - 10

	If Keycode = StartGameKey Then	
		Primary_StartButton.y = Primary_StartButton.y - 5
		Primary_StartButton2.y = Primary_StartButton2.y - 5
	End If


	'* Test Kicker
'	If keycode = 37 Then TestKick ' K
'	If keycode = 19 Then return_to_test ' R return ball to kicker
'	If keycode = 46 Then create_testball ' C create ball ball in test kicker
'	If keycode = 205 Then TKickAngle = TKickAngle + 3:fKickDirection.Visible=1:fKickDirection.RotZ=TKickAngle'+90 ' right arrow
'	If keycode = 203 Then TKickAngle = TKickAngle - 3:fKickDirection.Visible=1:fKickDirection.RotZ=TKickAngle'+90 'left arrow
'	If keycode = 200 Then TKickPower = TKickPower + 2:debug.print "TKickPower: "&TKickPower ' up arrow
'	If keycode = 208 Then TKickPower = TKickPower - 2:debug.print "TKickPower: "&TKickPower ' down arrow

	'* Ball Control
	If enableBallControl Then
		if keycode = 46 then	 			' C Key
			If contball = 1 Then
				contball = 0
			Else
				contball = 1
			End If
		End If
		if keycode = 48 then 				'B Key
			If bcboost = 1 Then
				bcboost = bcboostmulti
			Else
				bcboost = 1
			End If
		End If
		if keycode = 203 then bcleft = 1		' Left Arrow
		if keycode = 200 then bcup = 1			' Up Arrow
		if keycode = 208 then bcdown = 1		' Down Arrow
		if keycode = 205 then bcright = 1		' Right Arrow
	End If

    If vpmKeyDown(keycode) Then Exit Sub

	If keycode = 21 then  ''''''''''''''''''''y Key used for testing
		pCRLock.collidable = false
		pCRLock.RotZ = 50
	End If

	If keycode = 22 then  ''''''''''''''''''''u Key used for testing
		WobbleCount = 5
		tWobblePlastic.Enabled = true
	End If

End Sub

Sub bttf_KeyUp(ByVal Keycode)
	
	If KeyCode = PlungerKey Then
		Plunger.Fire
		SoundPlungerReleaseBall()                        
		TimerDigitalPlunger.Enabled = False
		TimerAnalogPlunger.Enabled = True
		Primary_plunger.Y = 880
	End If

	If keycode = LeftFlipperKey Then FlipperDeActivate LeftFlipper, LFPress:Primary_FlipperButtonLeft.X = Primary_FlipperButtonLeft.X - 10 
	If keycode = RightFlipperKey Then FlipperDeActivate RightFlipper, RFPress:Primary_FlipperButtonRight.X = Primary_FlipperButtonRight.X + 10

	'* Test Kicker
'	If keycode = 205 Then fKickDirection.Visible=0 ' right arrow
'	If keycode = 203 Then fKickDirection.Visible=0 'left arrow

	'* Ball Control
	If enableBallControl Then
		if keycode = 203 then bcleft = 0		' Left Arrow
		if keycode = 200 then bcup = 0			' Up Arrow
		if keycode = 208 then bcdown = 0		' Down Arrow
		if keycode = 205 then bcright = 0		' Right Arrow
	End If

	If Keycode = StartGameKey Then		
		Primary_StartButton.y = Primary_StartButton.y + 5
		Primary_StartButton2.y = Primary_StartButton2.y + 5
	End If

	If KeyUpHandler(KeyCode) Then Exit Sub

End Sub

'******************************************************
'					Test Kicker
'******************************************************

Dim TKickAngle, TKickPower, TKickBall
TKickAngle = 0
TKickPower = 10

Sub testkick()
	test.kick TKickAngle,TKickPower
End Sub

Sub create_testball():Set TKickBall = test.CreateBall:End Sub
Sub test_hit():Set TKickBall=ActiveBall:End Sub
Sub return_to_test():TKickBall.velx=0:TKickBall.vely=0:TKickBall.x=test.x:TKickBall.y=test.y-50:test.timerenabled=0:End Sub


'#############################
'  Rotate Primitive Things
'#############################
Const PI = 3.14
Dim Gate3Angle, Gate4Angle

'***********	Ball Control
Sub StartControl_Hit()
	Set ControlBall = ActiveBall
	contballinplay = true
End Sub

Sub StopControl_Hit()
	contballinplay = false
End Sub	

Dim bcup, bcdown, bcleft, bcright, contball, contballinplay, ControlBall, bcboost
Dim bcvel, bcyveloffset, bcboostmulti

bcboost = 1		'Do Not Change - default setting
bcvel = 4		'Controls the speed of the ball movement
bcyveloffset = -0.01 	'Offsets the force of gravity to keep the ball from drifting vertically on the table, should be negative
bcboostmulti = 3	'Boost multiplier to ball veloctiy (toggled with the B key) 
'***********	Ball Control

Dim prevgameover

Sub MyTimer_Timer()


    p_gate1.Rotx = gate1.CurrentAngle + 120
    p_gate2.Rotx = gate2.CurrentAngle
    p_gate3.Rotx = gate3.CurrentAngle' + 90

	Gate3Angle = Int(gate3.CurrentAngle)
	If Gate3Angle > 0 then
	pGate3_switch.ObjRotY = sin( (Gate3Angle * 1) * (2*PI/180)) * 10
	Else
	pGate3_switch.ObjRotY = sin( (Gate3Angle * -1) * (2*PI/180)) * 10
	End If

	Gate4Angle = Int(gate4.CurrentAngle)
	If Gate4Angle > 0 then
	pGate4_switch.ObjRotY = sin( (Gate4Angle * -1) * (2*PI/180)) * 10
	Else
	pGate4_switch.ObjRotY = sin( (Gate4Angle * 1) * (2*PI/180)) * 10
	End If



    p_gate4.Rotx = gate4.CurrentAngle' + 90 

'	pLeftFlipperLogo.Roty = LeftFlipper.Currentangle' + 180
	pLSS.Roty = LeftFlipper.Currentangle - 90 
'	FlipperLSh.RotZ = LeftFlipper.currentangle

'	pRightFlipperLogo.Roty = RightFlipper.Currentangle' + 180
	pRSS.Roty = RightFlipper.Currentangle - 90 
'	FlipperRSh.RotZ = RightFlipper.currentangle

    LFLogo.RotY = LeftFlipper.CurrentAngle
    RFLogo.RotY = RightFlipper.CurrentAngle
	pLeftFlipperShadow.ObjRotZ  = LeftFlipper.CurrentAngle + 1
	pRightFlipperShadow.ObjRotZ = RightFlipper.CurrentAngle + 1

	pSpinner.RotX = sw28.Currentangle * -1

	pSpinnerRod.TransX = sin( (sw28.CurrentAngle+180) * (2*PI/360)) * 5
	pSpinnerRod.TransY = sin( (SW28.CurrentAngle- 90) * (2*PI/360)) * 5

	'***********	Ball Control
	If Contball and ContBallInPlay then
		If bcright = 1 Then
			ControlBall.velx = bcvel*bcboost
		ElseIf bcleft = 1 Then
			ControlBall.velx = - bcvel*bcboost
		Else
			ControlBall.velx=0
		End If

		If bcup = 1 Then
			ControlBall.vely = -bcvel*bcboost
		ElseIf bcdown = 1 Then
			ControlBall.vely = bcvel*bcboost
		Else
			ControlBall.vely= bcyveloffset
		End If
	End If
	'***********	Ball Control




End Sub


''''''''''''''''''''''''
''''Bubble Level
''''''''''''''''''''''''

Dim lBallY, lBallX
Sub StartLevel()

'Y
	kLevel.Enabled = 1
	Set lBallY = kLevel.CreateSizedBallWithMass(4, .008)
	kLevel.kick 0, 0 
	kLevel.Enabled = 0


'X
	kLevel1.Enabled = 1
	Set lBallX = kLevel1.CreateSizedBallWithMass(4, .008)
	kLevel1.kick 0, 0 
	kLevel1.Enabled = 0

End Sub

Sub Level_Timer()


	xBubble.x = lBallX.x
	yBubble.y = lBallY.y

End Sub


Sub LeftNudge(angle, strength)
    Dim a
   lBallX.velx = 2*(RND(1)-RND(1))
End Sub

Sub RightNudge(angle, strength)
    Dim a
   lBallX.velx = 2*(RND(1)-RND(1))

End Sub

Sub CenterNudge(angle, strength)
    Dim a
	kLevel.Enabled = 1
    lBallY.vely = 2*(RND(1)-RND(1))
	PlaySound SoundFX("knocker_1",DOFKnocker)
	kLevel.Enabled = 0
End Sub


'******************************
'  Setup Desktop
'******************************

Sub Backdrop_Init
	Dim bdl
	If DesktopMode = True then

		l56c.visible = true
		l34.visible = true
		l35.visible = true
		l36.visible = true
		l37.visible = true
		l38.visible = true
		l39.visible = true
		l47c.visible = true


''''Delorean Lights

		l25d.BulbHaloHeight = 185
		l26d.BulbHaloHeight = 185
		l27d.BulbHaloHeight = 185
		l28d.BulbHaloHeight = 185
		l29d.BulbHaloHeight = 185
		l30d.BulbHaloHeight = 185
		l31d.BulbHaloHeight = 185
		l32d.BulbHaloHeight = 185

	Else


		l56c.visible = false
		l34.visible = false
		l35.visible = false
		l36.visible = false
		l37.visible = false
		l38.visible = false
		l39.visible = false
		l47c.visible = false


''''Delorean Lights

		l25d.BulbHaloHeight = 175
		l26d.BulbHaloHeight = 175
		l27d.BulbHaloHeight = 175
		l28d.BulbHaloHeight = 175
		l29d.BulbHaloHeight = 175
		l30d.BulbHaloHeight = 175
		l31d.BulbHaloHeight = 175
		l32d.BulbHaloHeight = 175

	End If
End Sub



'''''''''''''''''''''''''''''''''
''''''''''''Set options
'''''''''''''''''''''''''''''''''

'Instruction Cards

Dim InstructionCardsLeftType, InstructionCardsRightType

Sub CheckInstructionCards()

If InstructionCardsLeft = 0 Then
	InstructionCardsLeftType = Int(Rnd*3)+1
Else
	InstructionCardsLeftType = InstructionCardsLeft
End If

	If InstructionCardsLeftType = -1 Then
		pInstructionCardLeft.visible = False
	End If
	If InstructionCardsLeftType = 1 Then
		pInstructionCardLeft.image = "bttf_InstructionCardLeft1"
	End If
	If InstructionCardsLeftType = 2 Then
		pInstructionCardLeft.image = "bttf_InstructionCardLeft2"
	End If
	If InstructionCardsLeftType = 3 Then
		pInstructionCardLeft.image = "bttf_InstructionCardLeft3"
	End If


If InstructionCardsRight = 0 Then
	InstructionCardsRightType = Int(Rnd*3)+1
Else
	InstructionCardsRightType = InstructionCardsRight
End If

	If InstructionCardsRight = -1  Then
		pInstructionCardRight.visible = False
	End If
	If InstructionCardsRightType = 1  Then
		pInstructionCardRight.image = "bttf_InstructionCardRight1"
	End If
	If InstructionCardsRightType = 2  Then
		pInstructionCardRight.image = "bttf_InstructionCardRight2"
	End If
	If InstructionCardsRightType = 3  Then
		pInstructionCardRight.image = "bttf_InstructionCardRight3"
	End If


'Hologram Photo

	If HologramPhoto = 1 then
		pHologram.Visible = True
	Else
		pHologram.Visible = False
	End If


End Sub

''Flipper Color

'Dim FlipperColorType

Sub SetFlipperColor()
'
'If FlipperColor = 0 Then
'	FlipperColorType = Int(Rnd*9)+1
'Else
'	FlipperColorType = FlipperColor
'End If
'
'If FlipperColorType = 1 Then
'	RightFlipper.Material = "Plastic White" 
'	RightFlipper.RubberMaterial = "Rubber Black"
'	pRightFlipperLogo.Material = "Plastic White"
'
'	LeftFlipper.Material = "Plastic White" 
'	LeftFlipper.RubberMaterial = "Rubber Black"
'	pLeftFlipperLogo.Material = "Plastic White"
'End If
'
'If FlipperColorType = 2 Then
'	RightFlipper.Material = "Plastic White" 
'	RightFlipper.RubberMaterial = "Rubber Red"
'	pRightFlipperLogo.Material = "Plastic White"
'
'	LeftFlipper.Material = "Plastic White" 
'	LeftFlipper.RubberMaterial = "Rubber Red"
'	pLeftFlipperLogo.Material = "Plastic White"
'End If
'
'If FlipperColorType = 3 Then
'	RightFlipper.Material = "Plastic White" 
'	RightFlipper.RubberMaterial = "Rubber Yellow"
'	pRightFlipperLogo.Material = "Plastic White"
'
'	LeftFlipper.Material = "Plastic White" 
'	LeftFlipper.RubberMaterial = "Rubber Yellow"
'	pLeftFlipperLogo.Material = "Plastic White"
'End If
'
'If FlipperColorType = 4 Then
'	RightFlipper.Material = "Plastic Yellow" 
'	RightFlipper.RubberMaterial = "Rubber Black"
'	pRightFlipperLogo.Material = "Plastic Yellow"
'
'	LeftFlipper.Material = "Plastic Yellow" 
'	LeftFlipper.RubberMaterial = "Rubber Black"
'	pLeftFlipperLogo.Material = "Plastic Yellow"
'End If
'
'If FlipperColorType = 5 Then
'	RightFlipper.Material = "Plastic Yellow" 
'	RightFlipper.RubberMaterial = "Rubber Red"
'	pRightFlipperLogo.Material = "Plastic Yellow"
'
'	LeftFlipper.Material = "Plastic Yellow" 
'	LeftFlipper.RubberMaterial = "Rubber Red"
'	pLeftFlipperLogo.Material = "Plastic Yellow"
'End If
'
'If FlipperColorType = 6 Then
'	RightFlipper.Material = "Plastic Yellow" 
'	RightFlipper.RubberMaterial = "Rubber Yellow"
'	pRightFlipperLogo.Material = "Plastic Yellow"
'
'	LeftFlipper.Material = "Plastic Yellow" 
'	LeftFlipper.RubberMaterial = "Rubber Yellow"
'	pLeftFlipperLogo.Material = "Plastic Yellow"
'End If
'
'If FlipperColorType = 7 Then
'	RightFlipper.Material = "Plastic Metalic Yellow" 
'	RightFlipper.RubberMaterial = "Rubber Black"
'	pRightFlipperLogo.Material = "Plastic Metalic Yellow"
'
'	LeftFlipper.Material = "Plastic Metalic Yellow" 
'	LeftFlipper.RubberMaterial = "Rubber Black"
'	pLeftFlipperLogo.Material = "Plastic Metalic Yellow"
'End If
'
'If FlipperColorType = 8 Then
'	RightFlipper.Material = "Plastic Metalic Yellow" 
'	RightFlipper.RubberMaterial = "Rubber Red"
'	pRightFlipperLogo.Material = "Plastic Metalic Yellow"
'
'	LeftFlipper.Material = "Plastic Metalic Yellow" 
'	LeftFlipper.RubberMaterial = "Rubber Red"
'	pLeftFlipperLogo.Material = "Plastic Metalic Yellow"
'End If
'
'If FlipperColorType = 9 Then
'	RightFlipper.Material = "Plastic Metalic Yellow" 
'	RightFlipper.RubberMaterial = "Rubber Yellow"
'	pRightFlipperLogo.Material = "Plastic Metalic Yellow"
'
'	LeftFlipper.Material = "Plastic Metalic Yellow" 
'	LeftFlipper.RubberMaterial = "Rubber Yellow"
'	pLeftFlipperLogo.Material = "Plastic Metalic Yellow"
'End If
'
'
'Dim SolidStateSitckerType
'
''Solid State Sitcker
'
'If SolidStateSitcker = 0 Then
'	SolidStateSitckerType = Int(Rnd*4)+1
'Else
'	SolidStateSitckerType = SolidStateSitcker
'End If
'
'If SolidStateSitckerType = 1 Then
'	pLSS.Visible = False
'	pRSS.Visible = False
'
'	pLSS.Image = "SolidStateBlackLeft_texture"
'	pRSS.Image = "SolidStateBlackRight_texture"
'End If
'
'If SolidStateSitckerType = 2 Then
'	pLSS.Visible = true
'	pRSS.Visible = true
'
'	pLSS.Image = "SolidStateBlackLeft_texture"
'	pRSS.Image = "SolidStateBlackRight_texture"
'End If
'
'If SolidStateSitckerType = 3 Then
'	pLSS.Visible = true
'	pRSS.Visible = true
'
'	pLSS.Image = "SolidStateRedLeft_texture"
'	pRSS.Image = "SolidStateRedRight_texture"
'End If
'
'If SolidStateSitckerType = 4 Then
'	pLSS.Visible = true
'	pRSS.Visible = true
'
'	pLSS.Image = "SolidStateYellowLeft_texture"
'	pRSS.Image = "SolidStateYellowRight_texture"
'End If


'Plastic Protectors

Dim PlasticProtectorsType

If PlasticProtectors = 0 Then
	PlasticProtectorsType = Int(Rnd*4)+1
Else
	PlasticProtectorsType = PlasticProtectors
End If

If PlasticProtectorsType = 1 Then
	pPlasticProtectorsA.Material = "AcrylicClear2"
	pPlasticProtectorsA.DisableLighting = False
	pPlasticProtectorsB.Material = "AcrylicClear2"
	pPlasticProtectorsB.DisableLighting = False
End If

If PlasticProtectorsType = 2 Then
	pPlasticProtectorsA.Material = "AcrilicBLYellow"
	pPlasticProtectorsA.DisableLighting = True
	pPlasticProtectorsB.Material = "AcrilicBLYellow"
	pPlasticProtectorsB.DisableLighting = True
End If

If PlasticProtectorsType = 3 Then
	pPlasticProtectorsA.Material = "AcrylicBLRed"
	pPlasticProtectorsA.DisableLighting = True
	pPlasticProtectorsB.Material = "AcrylicBLRed"
	pPlasticProtectorsB.DisableLighting = True
End If

If PlasticProtectorsType = 4 Then
	pPlasticProtectorsA.Material = "AcrylicBLOrange"
	pPlasticProtectorsA.DisableLighting = True
	pPlasticProtectorsB.Material = "AcrylicBLOrange"
	pPlasticProtectorsB.DisableLighting = True
End If

End Sub


''''Rubber Color

Dim xxRubberColor 

Sub SetRubberColor()

If RubberColor = 1 Then

for each xxRubberColor in aRubbers2
xxRubberColor.Material="Rubber Black"
Primitive14.Material="Rubber Black"
next

Else

for each xxRubberColor in aRubbers2
xxRubberColor.Material="Rubber White"
Primitive14.Material="Rubber White"
next

End If

End Sub


''''''''''''''''''''''''''''''''''
''''''  GI Color
''''''''''''''''''''''''''''''''''

Dim RedFull, Red, RedI, PinkFull, Pink, PinkI, WhiteFull, White, WhiteI, BlueFull, Blue, BlueI, YellowFull, Yellow, YellowI, GreenFull, Green, GreenI
Dim GIColorModType


RedFull = rgb(255,0,0) 
Red = rgb(255,0,0)
RedI = 5
PinkFull = rgb(255,0,128)
Pink = rgb(255,0,255)
PinkI = 5
WhiteFull = rgb(255,255,128) 
White = rgb(255,255,255)
WhiteI = 7
BlueFull = rgb(0,128,255)
Blue = rgb(0,255,255)
BlueI = 20
YellowFull = rgb(255,255,128)
Yellow = rgb(255,255,0)
YellowI = 20
GreenFull = rgb(128,255,128)
Green = rgb(0,255,0)
GreenI = 20


Sub SetGIColor()


If GIColorMod = 0 Then
	GIColorModType = Int(Rnd*3)+1
Else
	GIColorModType = GIColorMod
End If

	If GIColorModType = 1 Then

	End If


	If GIColorModType = 2 Then
		gi1a.colorfull = BlueFull 'Blue
		gi1a.color = Blue 'Blue
		gi1b.colorfull = BlueFull 'Blue
		gi1b.color = Blue 'Blue
		gi1c.colorfull = BlueFull 'Blue
		gi1c.color = Blue 'Blue
		gi1a.Intensity = BlueI 'Blue

		gi2a.colorfull = YellowFull 'Yellow
		gi2a.color = Yellow ' Yellow
		gi2b.colorfull = YellowFull 'Yellow
		gi2b.color = Yellow ' Yellow
		gi2c.colorfull = YellowFull 'Yellow
		gi2c.color = Yellow ' Yellow
		gi2a.intensity = YellowI
'		gi2b.intensity = 13

		gi3a.colorfull = YellowFull 'Yellow
		gi3a.color = YellowFull 'Yellow
		gi3b.colorfull = YellowFull 'Yellow
		gi3b.color = Yellow 'Yellow
		gi3a.intensity = YellowI
'		gi3b.intensity = 13
		gi3c.colorfull = YellowFull 'Yellow
		gi3c.color = Yellow 'Yellow

		gi4a.colorfull = BlueFull 'Blue
		gi4a.color = Blue 'Blue
		gi4b.colorfull = BlueFull 'Blue
		gi4b.color = Blue 'Blue
		gi4c.colorfull = BlueFull 'Blue
		gi4c.color = Blue 'Blue
		gi4a.Intensity = BlueI 'Blue

		gi5a.colorfull = YellowFull 'Yellow
		gi5a.color = Yellow ' Yellow
		gi5b.colorfull = YellowFull 'Yellow
		gi5b.color = Yellow ' Yellow
		gi5c.colorfull = YellowFull 'Yellow
		gi5c.color = Yellow ' Yellow
		gi5a.intensity = YellowI

		gi6a.colorfull = YellowFull 'Yellow
		gi6a.color = Yellow ' Yellow
		gi6b.colorfull = YellowFull 'Yellow
		gi6b.color = Yellow ' Yellow
		gi6c.colorfull = YellowFull 'Yellow
		gi6c.color = Yellow ' Yellow
		gi6a.intensity = YellowI

		gi8a.colorfull = YellowFull 'Yellow
		gi8a.color = Yellow ' Yellow
		gi8b.colorfull = YellowFull 'Yellow
		gi8b.color = Yellow ' Yellow
		gi8c.colorfull = YellowFull 'Yellow
		gi8c.color = Yellow ' Yellow
		gi8a.intensity = YellowI

		gi9a.colorfull = YellowFull 'Yellow
		gi9a.color = Yellow ' Yellow
		gi9b.colorfull = YellowFull 'Yellow
		gi9b.color = Yellow ' Yellow
		gi9c.colorfull = YellowFull 'Yellow
		gi9c.color = Yellow ' Yellow
		gi9a.intensity = YellowI

		gi12a.colorfull = RedFull 'Red
		gi12a.color = Red ' Red
		gi12b.colorfull = RedFull 'Red
		gi12b.color = Red ' Red
		gi12c.colorfull = RedFull 'Red
		gi12c.color = Red ' Red
		gi12a.intensity = RedI

		gi13a.colorfull = RedFull 'Red
		gi13a.color = Red ' Red
		gi13b.colorfull = RedFull 'Red
		gi13b.color = Red ' Red
		gi13c.colorfull = RedFull 'Red
		gi13c.color = Red ' Red
		gi13a.intensity = RedI

		gi15.colorfull = rgb(0,128,255) 'Blue
		gi15.color = rgb(0,255,255) 'Blue

		gi16.colorfull = rgb(0,128,255) 'Blue
		gi16.color = rgb(0,255,255) 'Blue

	End If

	If GIColorModType = 3 Then

		gi1a.Color=Blue
		gi1a.ColorFull=BlueFull
		gi1b.Color=Blue
		gi1b.ColorFull=BlueFull
		gi1c.Color=Blue
		gi1c.ColorFull=BlueFull
		gi1a.Intensity = BlueI

		gi2a.Color=Pink
		gi2a.ColorFull=PinkFull
		gi2b.Color=Pink
		gi2b.ColorFull=PinkFull
		gi2c.Color=Pink
		gi2c.ColorFull=PinkFull
		gi2a.Intensity = PinkI

		gi3a.Color=Pink
		gi3a.ColorFull=PinkFull
		gi3b.Color=Pink
		gi3b.ColorFull=PinkFull
		gi3c.Color=Pink
		gi3c.ColorFull=PinkFull
		gi3a.Intensity = PinkI

		gi4a.Color=Blue
		gi4a.ColorFull=BlueFull
		gi4b.Color=Blue
		gi4b.ColorFull=BlueFull
		gi4c.Color=Blue
		gi4c.ColorFull=BlueFull
		gi4a.Intensity = BlueI

		gi5a.Color=Pink
		gi5a.ColorFull=PinkFull
		gi5b.Color=Pink
		gi5b.ColorFull=PinkFull
		gi5c.Color=Pink
		gi5c.ColorFull=PinkFull
		gi5a.Intensity = PinkI

		gi6a.Color=Pink
		gi6a.ColorFull=PinkFull
		gi6b.Color=Pink
		gi6b.ColorFull=PinkFull
		gi6c.Color=Pink
		gi6c.ColorFull=PinkFull
		gi6a.Intensity = PinkI

		gi8a.colorfull = YellowFull 'Yellow
		gi8a.color = Yellow ' Yellow
		gi8b.colorfull = YellowFull 'Yellow
		gi8b.color = Yellow ' Yellow
		gi8c.colorfull = YellowFull 'Yellow
		gi8c.color = Yellow ' Yellow
		gi8a.intensity = YellowI

		gi9a.colorfull = YellowFull 'Yellow
		gi9a.color = Yellow ' Yellow
		gi9b.colorfull = YellowFull 'Yellow
		gi9b.color = Yellow ' Yellow
		gi9c.colorfull = YellowFull 'Yellow
		gi9c.color = Yellow ' Yellow
		gi9a.intensity = YellowI

		gi12a.colorfull = RedFull 'Red
		gi12a.color = Red ' Red
		gi12b.colorfull = RedFull 'Red
		gi12b.color = Red ' Red
		gi12c.colorfull = RedFull 'Red
		gi12c.color = Red ' Red
		gi12a.intensity = RedI

		gi13a.colorfull = RedFull 'Red
		gi13a.color = Red ' Red
		gi13b.colorfull = RedFull 'Red
		gi13b.color = Red ' Red
		gi13c.colorfull = RedFull 'Red
		gi13c.color = Red ' Red
		gi13a.intensity = RedI

		gi15.colorfull = rgb(0,128,255) 'Blue
		gi15.color = rgb(0,255,255) 'Blue

		gi16.colorfull = rgb(0,128,255) 'Blue
		gi16.color = rgb(0,255,255) 'Blue
	End If


End Sub


'Hill Valley Mod

Sub SetHillValleyColorMod()

	If LeftHillValleyMod = 1 Then
		l15.colorfull = rgb(255,255,128) 'Yellow
		l15.color = rgb(255,255,0) ' Yellow
		l15a.colorfull = rgb(255,255,128) 'Yellow
		l15a.color = rgb(255,255,0) ' Yellow
		l56.colorfull = rgb(255,255,128) 'Yellow
		l56.color = rgb(255,255,0) ' Yellow
		l56a.colorfull = rgb(255,255,128) 'Yellow
		l56a.color = rgb(255,255,0) ' Yellow
		l60.colorfull = rgb(255,255,128) 'Yellow
		l60.color = rgb(255,255,0) ' Yellow
		l60a.colorfull = rgb(255,255,128) 'Yellow
		l60a.color = rgb(255,255,0) ' Yellow
	End If

	If RightHillValleyMod = 1 Then
		l46.colorfull = rgb(0,128,255) 'Blue
		l46.color = rgb(0,255,255) 'Blue
		l46a.colorfull = rgb(0,128,255) 'Blue
		l46a.color = rgb(0,255,255) 'Blue
		l47.colorfull = rgb(0,128,255) 'Blue
		l47.color = rgb(0,255,255) 'Blue
		l47a.colorfull = rgb(0,128,255) 'Blue
		l47a.color = rgb(0,255,255) 'Blue
		l48.colorfull = rgb(0,128,255) 'Blue
		l48.color = rgb(0,255,255) 'Blue
		l48a.colorfull = rgb(0,128,255) 'Blue
		l48a.color = rgb(0,255,255) 'Blue
	End If

End Sub


Sub SetDeloreanColorMod()
	If DeloreanColorMod = 1 Then
		l25d.colorfull = rgb(255,0,0) 'Red
		l25d.color = rgb(255,0,0) ' Red
		l26d.colorfull = rgb(255,0,0) 'Red
		l26d.color = rgb(255,0,0) ' Red
		l27d.colorfull = rgb(255,0,0) 'Red
		l27d.color = rgb(255,0,0) ' Red
		l28d.colorfull = rgb(255,0,0) 'Red
		l28d.color = rgb(255,0,0) ' Red
		l29d.colorfull = rgb(255,0,0) 'Red
		l29d.color = rgb(255,0,0) ' Red
		l30d.colorfull = rgb(255,0,0) 'Red
		l30d.color = rgb(255,0,0) ' Red
		l31d.colorfull = rgb(255,0,0) 'Red
		l31d.color = rgb(255,0,0) ' Red
		l32d.colorfull = rgb(255,0,0) 'Red
		l32d.color = rgb(255,0,0) ' Red
	End If
End Sub

'''''''''''''''''''''''''''''
''''Color Ramp Ball Lock
'''''''''''''''''''''''''''''

Dim CRBLStep, WPStep, WP2Step, PlasticWobbling

Sub sw40_Hit()
	Psw40.rotY = 20
	Controller.Switch(40) = 1
	BallsLocked = BallsLocked + 1
	If HologramPhoto = 1 Then
		HologramUpdateStep = HologramUpdateStep +1
		HologramUpdate
	End If
End Sub
Sub sw40_UnHit:Psw40.rotY = 0:Controller.Switch(40) = 0:End Sub

Sub sw39_Hit:Psw39.rotY = 20:Controller.Switch(39) = 1:End Sub
Sub sw39_UnHit:Psw39.rotY = 0:Controller.Switch(39) = 0:End Sub

Sub sw38_Hit()
	Psw38.rotY = 20
	Controller.Switch(38) = 1
	If WobblePlastic = 1 then 
		If PlasticWobbling = 1 then 
		Else

			WobbleCount = 3
			tWobblePlastic.Enabled = True
		End If
	End If	
	PlaySoundAt "Metal_Touch_1",sw38
End Sub
Sub sw38_UnHit:Psw38.rotY = 0:Controller.Switch(38) = 0:End Sub


Sub CRBallLock(Enabled)
		PlaySound SoundFX("fx_Rudysol1",DOFContactors),0,1,-.3
		pCRLock.collidable = false
		pCRLock.RotZ = 50
		If WobblePlastic = 1 then
			PlasticWobbling = 1
			WobbleCount = 5
			tWobblePlastic.Enabled = True
		End If
		CRBallLockTimer.Enabled = true
End Sub


Sub CRBallLockTimer_Timer()
	Select Case CRBLStep
		Case 0:
		Case 1:
		Case 2:
		Case 3:
		Case 4:
		Case 5:pCRLock.collidable = true:pCRLock.RotZ = 0:CRBallLockTimer.Enabled = false:CRBLStep = 0
	End Select
	CRBLStep = CRBLStep + 1

End Sub

'******************************************
'			Plastic Wobble
'******************************************

Dim WobbleStep, WobbleCount, Wdir

WobbleStep = 0.5	' Controls the size of the wobble
WobbleCount = 5		' Controls the number of wobbles
WDir = 1
tWobblePlastic.interval = 15 ' Controls the speed of the wobble

Sub tWobblePlastic_timer()

	pWabblePlastic0.rotx=pWabblePlastic0.rotx + WDir*WobbleStep

	If WDIR = 1 And PWabblePlastic0.rotx > 89.99 + WobbleCount * WobbleStep Then
		WobbleCount = WobbleCount - 1
		WDir = -1
	ElseIf WDir = -1 And PWabblePlastic0.rotx < 90.01 Then
		WDir = 1
		If WobbleCount = 0 Then
			tWobblePlastic.Enabled = false
			PlasticWobbling = 0
'			WobbleCount = 5
		End If
	End If
	pWabbleScrews.Rotx = pWabblePlastic0.rotx
End Sub



'###############################
'    Holigram Photo
'###############################

Sub HologramUpdate ()
    Select Case HologramUpdateStep
        Case 0:pHologram.Image = "bttf_photo_8"						'Default
        Case 1:pHologram.Image = "bttf_photo_7"						'Animation
        Case 2:pHologram.Image = "bttf_photo_6"						'Lock1
        Case 3:pHologram.Image = "bttf_photo_5"						'Animation
        Case 4:pHologram.Image = "bttf_photo_4"						'Lock2
		Case 5:pHologram.Image = "bttf_photo_3"						'Animation
		Case 6:pHologram.Image = "bttf_photo_2":IsItMultiball = 1	'Lock3
		Case 7:pHologram.Image = "bttf_photo_1"						'Multiball
    End Select

End Sub

Dim IsItMultiballTimerStep

Sub IsItMultiballTimer_Timer()
  Select Case IsItMultiballTimerStep
        Case 0:
        Case 1:
        Case 2:
        Case 3:
        Case 4:If BallsLocked > 1 then IsItMultiball = 0:HologramUpdateStep = 4:HologramUpdate: Else HologramUpdateStep = 7:HologramUpdate: End If
		Case 5:IsItMultiballTimer.Enabled = false:IsItMultiballTimerStep = 0
    End Select
 
    IsItMultiballTimerStep = IsItMultiballTimerStep + 1
 
End Sub


'^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
'Slingshot animation
'^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Dim LeftSlingshotStep,RightSlingshotStep


Sub LeftSlingShot_Slingshot:LeftSlingshota.visible = false:pSlingL.TransZ = -8:LeftSlingshotb.visible = true:RandomSoundSlingshotLeft pSlingL:vpmTimer.PulseSw 21:LeftSlingshotStep = 0:Me.TimerEnabled = 1:If WobblePlastic = 1 then:PlasticWobbling = 1:WobbleCount = 2:tWobblePlastic.Enabled = True:End If:End Sub
Sub LeftSlingshot_Timer
    Select Case LeftSlingshotStep
        Case 0:LeftSlingshotb.visible = false:pSlingL.TransZ = -16:LeftSlingshotc.visible = true
        Case 1:LeftSlingshotc.visible = false:pSlingL.TransZ = -24:LeftSlingshotd.visible = true
        Case 2:LeftSlingshotd.visible = false:pSlingL.TransZ = -16:LeftSlingshotc.visible = true
        Case 3:LeftSlingshotc.visible = false:pSlingL.TransZ = -8:LeftSlingshotb.visible = true
        Case 4:LeftSlingshotb.visible = false:pSlingL.TransZ = 0:LeftSlingshota.visible = true:Me.TimerEnabled = 0 '
    End Select

    LeftSlingshotStep = LeftSlingshotStep + 1
End Sub


Sub RightSlingShot_Slingshot:RightSlingshota.visible = false:pSlingR.TransZ = -8:RightSlingshotb.visible = true:RandomSoundSlingshotRight pSlingR:vpmTimer.PulseSw 22:RightSlingshotStep = 0:Me.TimerEnabled = 1:If WobblePlastic = 1 then:PlasticWobbling = 1:WobbleCount = 2:tWobblePlastic.Enabled = True:End If:End Sub
Sub RightSlingshot_Timer
    Select Case RightSlingshotStep
        Case 0:RightSlingshotb.visible = false:pSlingR.TransZ = -16:RightSlingshotc.visible = true
        Case 1:RightSlingshotc.visible = false:pSlingR.TransZ = -24:RightSlingshotd.visible = true
        Case 2:RightSlingshotd.visible = false:pSlingR.TransZ = -16:RightSlingshotc.visible = true
        Case 3:RightSlingshotc.visible = false:pSlingR.TransZ = -8:RightSlingshotb.visible = true
        Case 4:RightSlingshotb.visible = false:pSlingR.TransZ = 0:RightSlingshota.visible = true:Me.TimerEnabled = 0 '
    End Select

    RightSlingshotStep = RightSlingshotStep + 1
End Sub




''''''''''''''''''
'Rubber
''''''''''''''''''
Dim wRubber1aStep, wRubber1bStep, wRubber2Step, wRubber4Step

Sub wRubber1a_hit()
	Rubber1.visible = false:Rubber1a.visible = true:me.timerEnabled = true
End Sub

Sub wRubber1a_Timer
    Select Case wRubber1aStep
        Case 0:
        Case 1:
        Case 2:Rubber1.visible = true:Rubber1a.visible = false:Me.TimerEnabled = 0:wRubber1aStep = 0
    End Select

    wRubber1aStep = wRubber1aStep + 1
End Sub

Sub wRubber1b_hit()
	Rubber1.visible = false:Rubber1b.visible = true:me.timerEnabled = true
End Sub

Sub wRubber1b_Timer
    Select Case wRubber1bStep
        Case 0:
        Case 1:
        Case 2:Rubber1.visible = true:Rubber1b.visible = false:Me.TimerEnabled = 0:wRubber1bStep = 0
    End Select

    wRubber1bStep = wRubber1bStep + 1
End Sub

Sub wRubber2_hit()
	Rubber2.visible = false:Rubber2b.visible = true:me.timerEnabled = true
End Sub

Sub wRubber2_Timer
    Select Case wRubber2Step
        Case 0:
        Case 1:
        Case 2:Rubber2.visible = true:Rubber2b.visible = false:Me.TimerEnabled = 0:wRubber2Step = 0
    End Select

    wRubber2Step = wRubber2Step + 1
End Sub

Sub wRubber4_hit()
	Rubber4.visible = false:Rubber4b.visible = true:me.timerEnabled = true
End Sub

Sub wRubber4_Timer
    Select Case wRubber4Step
        Case 0:
        Case 1:
        Case 2:Rubber4.visible = true:Rubber4b.visible = false:Me.TimerEnabled = 0:wRubber4Step = 0
    End Select

    wRubber4Step = wRubber4Step + 1
End Sub

' Bumpers
Sub Bumper1_Hit:vpmTimer.PulseSw 46:RandomSoundBumperTop Bumper1:bump1 = 1:Me.TimerEnabled = 1:If WobblePlastic = 1 then:PlasticWobbling = 1:WobbleCount = 2:tWobblePlastic.Enabled = True:End If::End Sub
Sub Bumper1_Timer()
    Select Case bump1
        Case 1:
        Case 2:
        Case 3:
        Case 4:Me.TimerEnabled = 0
    End Select
End Sub

Sub Bumper2_Hit:vpmTimer.PulseSw 47:RandomSoundBumperMiddle Bumper2:bump2 = 1:Me.TimerEnabled = 1:If WobblePlastic = 1 then:PlasticWobbling = 1:WobbleCount = 2:tWobblePlastic.Enabled = True:End If:End Sub
Sub Bumper2_Timer()
    Select Case bump2
        Case 1:
        Case 2:
        Case 3:
        Case 4:Me.TimerEnabled = 0
    End Select
End Sub

Sub Bumper3_Hit:vpmTimer.PulseSw 48:RandomSoundBumperBottom Bumper3:bump3 = 1:Me.TimerEnabled = 1:If WobblePlastic = 1 then:PlasticWobbling = 1:WobbleCount = 2:tWobblePlastic.Enabled = True:End If:End Sub
Sub Bumper3_Timer()
    Select Case bump3
        Case 1:
        Case 2:
        Case 3:
        Case 4:Me.TimerEnabled = 0
    End Select
End Sub

Sub sw45_Hit:bsTR.AddBall 0:Psw45.TransY = -5:PlaySoundAtVol "Saucer_Enter_1",sw45,2:End Sub
Sub sw45_UnHit:Psw45.TransY = 0:If WobblePlastic = 1 then:PlasticWobbling = 1:WobbleCount = 1:tWobblePlastic.Enabled = True:End If:End Sub

'VUK Lock
Sub sw29_Hit()
	PlaySoundat "Saucer_Enter_2",sw29
	Controller.Switch(29) = 1
	If HologramPhoto = 1 Then
		HologramUpdateStep = HologramUpdateStep +1
		HologramUpdate
	End If
End Sub

Sub KickBallUp(Enabled)
	Playsoundat SoundFX("Saucer_Kick",DOFContactors),sw29
	sw29.timerenabled = 1
 	sw29.Kick 0,200,1.50
	Controller.Switch(29) = 0
	If WobblePlastic = 1 then
		PlasticWobbling = 1
		WobbleCount = 5:
		tWobblePlastic.Enabled = True
	End If:
End Sub

Dim sw29step

Sub sw29_timer()
	Select Case sw29step
		Case 0:pUpKicker.TransY = 10
		Case 1:pUpKicker.TransY = 20
		Case 2:pUpKicker.TransY = 30
		Case 3:
		Case 4:
		Case 5:pUpKicker.TransY = 25
		Case 6:pUpKicker.TransY = 20
		Case 7:pUpKicker.TransY = 15
		Case 8:pUpKicker.TransY = 10
		Case 9:pUpKicker.TransY = 5
		Case 10:pUpKicker.TransY = 0:sw29.timerEnabled = 0:sw29step = 0
	End Select
	sw29step = sw29step + 1
End Sub

' Rollovers & Ramp Switches
Sub sw17_Hit()
	Switch17dir = 1
	Sw17Move = 1
	Me.TimerEnabled = true
	Controller.Switch(17) = 1
	PlaySoundAt "sensor",sw17
End Sub

Sub sw17_unHit()
	Switch17dir = -1
	Sw17Move = 5
	Me.TimerEnabled = true
	Controller.Switch(17) = 0
End Sub

Dim Switch17dir, SW17Move

Sub sw17_timer()
Select case Sw17Move

	Case 0:me.TimerEnabled = false:pRollover4.RotX = 90

	Case 1:pRollover4.RotX = 95

	Case 2:pRollover4.RotX = 100

	Case 3:pRollover4.RotX = 105

	Case 4:pRollover4.RotX = 110

	Case 5:pRollover4.RotX = 115

	Case 6:me.TimerEnabled = false:pRollover4.RotX = 120

End Select

SW17Move = SW17Move + Switch17dir

End Sub

Sub sw18_Hit()
	Switch18dir = 1
	Sw18Move = 1
	Me.TimerEnabled = true
	Controller.Switch(18) = 1
	PlaySoundAt "sensor",sw18
End Sub

Sub sw18_unHit()
	Switch18dir = -1
	Sw18Move = 5
	Me.TimerEnabled = true
	Controller.Switch(18) = 0
End Sub

Dim Switch18dir, SW18Move

Sub sw18_timer()
Select case Sw18Move

	Case 0:me.TimerEnabled = false:pRollover3.RotX = 90

	Case 1:pRollover3.RotX = 95

	Case 2:pRollover3.RotX = 100

	Case 3:pRollover3.RotX = 105

	Case 4:pRollover3.RotX = 110

	Case 5:pRollover3.RotX = 115

	Case 6:me.TimerEnabled = false:pRollover3.RotX = 120

End Select

SW18Move = SW18Move + Switch18dir

End Sub

Sub sw20_Hit()
	Switch20dir = 1
	Sw20Move = 1
	Me.TimerEnabled = true
	Controller.Switch(20) = 1
	PlaySoundAt "sensor",sw20
End Sub

Sub sw20_unHit()
	Switch20dir = -1
	Sw20Move = 5
	Me.TimerEnabled = true
	Controller.Switch(20) = 0
End Sub

Dim Switch20dir, SW20Move
'Switch19dir = -2

Sub sw20_timer()
Select case Sw20Move

	Case 0:me.TimerEnabled = false:pRollover2.RotX = 90

	Case 1:pRollover2.RotX = 95

	Case 2:pRollover2.RotX = 100

	Case 3:pRollover2.RotX = 105

	Case 4:pRollover2.RotX = 110

	Case 5:pRollover2.RotX = 115

	Case 6:me.TimerEnabled = false:pRollover2.RotX = 120

End Select

SW20Move = SW20Move + Switch20dir

End Sub




Sub sw19_Hit()
	Switch19dir = 1
	Sw19Move = 1
	Me.TimerEnabled = true
	Controller.Switch(19) = 1
	PlaySoundAt "sensor",sw19
End Sub

Sub sw19_unHit()
	Switch19dir = -1
	Sw19Move = 5
	Me.TimerEnabled = true
	Controller.Switch(19) = 0
End Sub


Dim Switch19dir, SW19Move

Sub sw19_timer()
Select case Sw19Move

	Case 0:me.TimerEnabled = false:pRollover1.RotX = 90

	Case 1:pRollover1.RotX = 95

	Case 2:pRollover1.RotX = 100

	Case 3:pRollover1.RotX = 105

	Case 4:pRollover1.RotX = 110

	Case 5:pRollover1.RotX = 115

	Case 6:me.TimerEnabled = false:pRollover1.RotX = 120

End Select

SW19Move = SW19Move + Switch19dir

End Sub



Sub sw30_Hit:Controller.Switch(30) = 1:PlaySoundAt "sensor",sw30:End Sub
Sub sw30_Unhit:Controller.Switch(30) = 0:End Sub

Sub sw31_Hit:Controller.Switch(31) = 1:PlaySoundAt "sensor",sw31:End Sub
Sub sw31_Unhit:Controller.Switch(31) = 0:End Sub

Sub sw14_Hit()
	Switch14dir = 1
	Sw14Move = 1
	Me.TimerEnabled = true
	PlaySoundAt "sensor",sw14
	Controller.Switch(14) = 1
End Sub

Sub sw14_unHit()
	Switch14dir = -1
	Sw14Move = 5
	Me.TimerEnabled = true
	Controller.Switch(14) = 0
End Sub

Dim Switch14dir, SW14Move

Sub sw14_timer()
Select case Sw14Move

	Case 0:me.TimerEnabled = false:pRollover5.RotX = 90

	Case 1:pRollover5.RotX = 95

	Case 2:pRollover5.RotX = 100

	Case 3:pRollover5.RotX = 105

	Case 4:pRollover5.RotX = 110

	Case 5:pRollover5.RotX = 115

	Case 6:me.TimerEnabled = false:pRollover5.RotX = 120

End Select

SW14Move = SW14Move + Switch14dir

End Sub

'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'   Drop Targets
'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	dim sw41Dir, sw42Dir, sw43Dir
	dim sw41Pos, sw42Pos, sw43Pos
	Dim sw41step, sw42step, sw43step
 
	sw41Dir = 1:sw42Dir = 1:sw43Dir = 1
	sw41Pos = 0:sw42Pos = 0:sw43Pos = 0

  'Targets Init
	sw41.TimerEnabled = 1:sw42.timerEnabled = 1:sw43.TimerEnabled = 1

Sub DoubleDrop1_HIt:sw41.timerenabled = True:sw42.timerenabled = True: End Sub
Sub DoubleDrop2_HIt:sw42.timerenabled = True:sw43.timerenabled = True: End Sub

	Sub sw41_Hit:me.timerEnabled = 1:If WobblePlastic = 1 then:PlasticWobbling = 1:WobbleCount = 1:tWobblePlastic.Enabled = True:End If:End Sub
	Sub sw42_Hit:me.timerEnabled = 1:If WobblePlastic = 1 then:PlasticWobbling = 1:WobbleCount = 1:tWobblePlastic.Enabled = True:End If:End Sub
	Sub sw43_Hit:me.timerEnabled = 1:If WobblePlastic = 1 then:PlasticWobbling = 1:WobbleCount = 1:tWobblePlastic.Enabled = True:End If:End Sub


Sub sw41_timer()
	Select Case sw41step
		Case 0:
		Case 1:sw41P.RotX = 2
		Case 2:sw41P.RotX = 5
		Case 3:DTBank.Hit 1:sw41Dir = 0:sw41a.Enabled = 1:DoubleDrop1.isDropped = True
		Case 4:sw41P.RotX = 3
		Case 5:sw41P.RotX = 0:me.timerEnabled = 0:sw41step = 0
	End Select
	sw41step = sw41step + 1
End Sub


'''Target animation


 Sub sw41a_Timer()	
  Select Case sw41Pos
        Case 0: sw41P.TransZ=0
				 If sw41Dir = 1 then
					sw41a.Enabled = 0
				 else
			     end if        
        Case 1: sw41P.TransZ=0
        Case 2: sw41P.TransZ=-6
        Case 3: sw41P.TransZ=-8
        Case 4: sw41P.TransZ=-18
        Case 5: sw41P.TransZ=-24
        Case 6: sw41P.TransZ=-30
        Case 7: sw41P.TransZ=-36
        Case 8: sw41P.TransZ=-42
        Case 9: sw41P.TransZ=-48
        Case 10: sw41P.TransZ=-52
				 If sw41Dir = 1 then
				 else
					sw41a.Enabled = 0
			     end if

 
End Select
	If sw41Dir = 1 then
		If sw41pos>0 then sw41pos=sw41pos-1
	else
		If sw41pos<10 then sw41pos=sw41pos+1
	end if
  End Sub


Sub sw42_timer()
	Select Case sw42step
		Case 0:
		Case 1:sw42P.RotX = 2
		Case 2:sw42P.RotX = 5
		Case 3:DTBank.Hit 2:sw42Dir = 0:sw42a.Enabled = 1:DoubleDrop1.isDropped = True:DoubleDrop2.isDropped = True
		Case 4:sw42P.RotX = 3
		Case 5:sw42P.RotX = 0:me.timerEnabled = 0:sw42step = 0
	End Select
	sw42step = sw42step + 1
End Sub


 Sub sw42a_Timer()	
  Select Case sw42Pos
        Case 0: sw42P.TransZ=0
				 If sw42Dir = 1 then
					sw42a.Enabled = 0
				 else
			     end if        
        Case 1: sw42P.TransZ=0
        Case 2: sw42P.TransZ=-6
        Case 3: sw42P.TransZ=-12
        Case 4: sw42P.TransZ=-18
        Case 5: sw42P.TransZ=-24
        Case 6: sw42P.TransZ=-30
        Case 7: sw42P.TransZ=-36
        Case 8: sw42P.TransZ=-42
        Case 9: sw42P.TransZ=-48
        Case 10: sw42P.TransZ=-52
				 If sw42Dir = 1 then
				 else
					sw42a.Enabled = 0
			     end if

 
End Select
	If sw42Dir = 1 then
		If sw42pos>0 then sw42pos=sw42pos-1
	else
		If sw42pos<10 then sw42pos=sw42pos+1
	end if
  End Sub

Sub sw43_timer()
	Select Case sw43step
		Case 0:
		Case 1:sw43P.RotX = 2
		Case 2:sw43P.RotX = 5
		Case 3:DTBank.Hit 3:sw43Dir = 0:sw43a.Enabled = 1:DoubleDrop2.isDropped = True
		Case 4:sw43P.RotX = 3
		Case 5:sw43P.RotX = 0:me.timerEnabled = 0:sw43step = 0
	End Select
	sw43step = sw43step + 1
End Sub


Sub sw43a_Timer()	
	Select Case sw43Pos
        Case 0: sw43P.TransZ=0
				 If sw43Dir = 1 then
					sw43a.Enabled = 0
				 else
			     end if        
        Case 1: sw43P.TransZ=0
        Case 2: sw43P.TransZ=-6
        Case 3: sw43P.TransZ=-12
        Case 4: sw43P.TransZ=-18
        Case 5: sw43P.TransZ=-24
        Case 6: sw43P.TransZ=-30
        Case 7: sw43P.TransZ=-36
        Case 8: sw43P.TransZ=-42
        Case 9: sw43P.TransZ=-48
        Case 10: sw43P.TransZ=-52
				 If sw43Dir = 1 then
				 else
					sw43a.Enabled = 0
			     end if
	End Select
	If sw43Dir = 1 then
		If sw43pos>0 then sw43pos=sw43pos-1
	else
		If sw43pos<10 then sw43pos=sw43pos+1
	end if
End Sub

'DT Subs
   Sub ResetDrops(Enabled)
		If Enabled Then
			sw41Dir = 1:sw42Dir = 1:sw43Dir = 1
			sw41a.Enabled = 1:sw42a.Enabled = 1:sw43a.Enabled = 1:DoubleDrop1.isDropped = False:DoubleDrop2.isDropped = False
			DTBank.DropSol_On
			If WobblePlastic = 1 then:PlasticWobbling = 1:WobbleCount = 2:tWobblePlastic.Enabled = True:End If:
		End if
   End Sub

'***************************************
'       Targets
'***************************************

Dim Target25Step, Target26Step, Target27Step, Target33Step, Target34Step, Target35Step, Target36Step, Target37Step

Sub sw25_Hit:vpmTimer.PulseSw(25):P_Target25.TransX = -5:Target25Step = 1:Me.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw25:End Sub			
Sub sw25_timer()
	Select Case Target25Step
		Case 1:P_Target25.TransX = 3
        Case 2:P_Target25.TransX = -2
        Case 3:P_Target25.TransX = 1
        Case 4:P_Target25.TransX = 0:Me.TimerEnabled = 0
     End Select
	Target25Step = Target25Step + 1
End Sub

Sub DoubleTarget6_hit:vpmTimer.PulseSw(26):vpmTimer.PulseSw(25):P_Target26.TransX = -5:Target26Step = 1:sw26.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw26:P_Target25.TransX = -5:Target25Step = 1:sw25.TimerEnabled = 1:End Sub

Sub sw26_Hit:vpmTimer.PulseSw(26):P_Target26.TransX = -5:Target26Step = 1:Me.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw26:End Sub			
Sub sw26_timer()
	Select Case Target26Step
		Case 1:P_Target26.TransX = 3
        Case 2:P_Target26.TransX = -2
        Case 3:P_Target26.TransX = 1
        Case 4:P_Target26.TransX = 0:Me.TimerEnabled = 0
     End Select
	Target26Step = Target26Step + 1
End Sub

Sub DoubleTarget5_hit:vpmTimer.PulseSw(27):vpmTimer.PulseSw(326):P_Target27.TransX = -5:Target27Step = 1:sw27.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw27:P_Target25.TransX = -5:Target26Step = 1:sw26.TimerEnabled = 1:End Sub

Sub sw27_Hit:vpmTimer.PulseSw(27):P_Target27.TransX = -5:Target27Step = 1:Me.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw27:End Sub			
Sub sw27_timer()
	Select Case Target27Step
		Case 1:P_Target27.TransX = 3
        Case 2:P_Target27.TransX = -2
        Case 3:P_Target27.TransX = 1
        Case 4:P_Target27.TransX = 0:Me.TimerEnabled = 0
     End Select
	Target27Step = Target27Step + 1
End Sub

Sub sw33_Hit:vpmTimer.PulseSw(33):P_Target33.TransX = -5:Target33Step = 1:Me.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw33:End Sub			
Sub sw33_timer()
	Select Case Target33Step
		Case 1:P_Target33.TransX = 3
        Case 2:P_Target33.TransX = -2
        Case 3:P_Target33.TransX = 1
        Case 4:P_Target33.TransX = 0:Me.TimerEnabled = 0
     End Select
	Target33Step = Target33Step + 1
End Sub


Sub DoubleTarget1_hit:vpmTimer.PulseSw(33):vpmTimer.PulseSw(34):P_Target33.TransX = -5:Target33Step = 1:sw33.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw33:P_Target34.TransX = -5:Target34Step = 1:sw34.TimerEnabled = 1:End Sub

Sub sw34_Hit:vpmTimer.PulseSw(34):P_Target34.TransX = -5:Target34Step = 1:Me.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw34:End Sub			
Sub sw34_timer()
	Select Case Target34Step
		Case 1:P_Target34.TransX = 3
        Case 2:P_Target34.TransX = -2
        Case 3:P_Target34.TransX = 1
        Case 4:P_Target34.TransX = 0:Me.TimerEnabled = 0
     End Select
	Target34Step = Target34Step + 1
End Sub

Sub DoubleTarget2_hit:vpmTimer.PulseSw(34):vpmTimer.PulseSw(35):P_Target34.TransX = -5:Target34Step = 1:sw34.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw34:P_Target35.TransX = -5:Target35Step = 1:sw35.TimerEnabled = 1:End Sub

Sub sw35_Hit:vpmTimer.PulseSw(35):P_Target35.TransX = -5:Target35Step = 1:Me.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw35:End Sub			
Sub sw35_timer()
	Select Case Target35Step
		Case 1:P_Target35.TransX = 3
        Case 2:P_Target35.TransX = -2
        Case 3:P_Target35.TransX = 1
        Case 4:P_Target35.TransX = 0:Me.TimerEnabled = 0
     End Select
	Target35Step = Target35Step + 1
End Sub

Sub DoubleTarget3_hit:vpmTimer.PulseSw(35):vpmTimer.PulseSw(36):P_Target35.TransX = -5:Target35Step = 1:sw35.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw35:P_Target36.TransX = -5:Target36Step = 1:sw36.TimerEnabled = 1:End Sub

Sub sw36_Hit:vpmTimer.PulseSw(36):P_Target36.TransX = -5:Target36Step = 1:Me.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw36:End Sub			
Sub sw36_timer()
	Select Case Target36Step
		Case 1:P_Target36.TransX = 3
        Case 2:P_Target36.TransX = -2
        Case 3:P_Target36.TransX = 1
        Case 4:P_Target36.TransX = 0:Me.TimerEnabled = 0
     End Select
	Target36Step = Target36Step + 1
End Sub

Sub DoubleTarget4_hit:vpmTimer.PulseSw(36):vpmTimer.PulseSw(37):P_Target36.TransX = -5:Target36Step = 1:sw36.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw36:P_Target37.TransX = -5:Target37Step = 1:sw37.TimerEnabled = 1:End Sub

Sub sw37_Hit:vpmTimer.PulseSw(37):P_Target37.TransX = -5:Target37Step = 1:Me.TimerEnabled = 1:PlaySoundAt SoundFX("_spottarget",DOFTargets),sw37:End Sub			
Sub sw37_timer()
	Select Case Target37Step
		Case 1:P_Target37.TransX = 3
        Case 2:P_Target37.TransX = -2
        Case 3:P_Target37.TransX = 1
        Case 4:P_Target37.TransX = 0:Me.TimerEnabled = 0
     End Select
	Target37Step = Target37Step + 1
End Sub		

' Spinners
Sub sw28_Spin():vpmTimer.PulseSw 28:SoundSpinner sw28:End Sub

' Ramps helpers
Sub RHelp1_Hit:StopSound "plasticroll":PlaySoundAt "BallHit",RHelp1:End Sub
Sub RHelp2_Hit:StopSound "plasticroll":PlaySoundAt "BallHit",RHelp2:End Sub

'Sub BallRol1_Hit:PlaySound "ballrolling":End Sub


'*********
'Solenoids
'*********

SolCallBack(1) = "SetLamp 101,"
SolCallBack(2) = "SetLamp 102,"
SolCallback(3) = "SetLamp 103,"
SolCallback(4) = "SetLamp 104,"
SolCallback(5) = "SetLamp 105,"
SolCallback(6) = "SetLamp 106," 'left side
 'SolCallback(7) = "SetLamp 107," center
SolCallback(8) = "SetLamp 108,"
SolCallback(9) = "SetLamp 109," 'right side
SolCallback(11) = "SolGi"
SolCallback(12) = "SetLamp 112,"
SolCallback(13) = "SetLamp 113,"
SolCallback(14) = "SetLamp 114,"
SolCallback(15) = "SetLamp 115,"
SolCallback(16) = "SetLamp 116,"
SolCallBack(25) = "kisort"
SolCallBack(26) = "KickBallToLane"
SolCallBack(27) = "CRBallLock"
'SolCallBack(27) = "vLock.SolExit"
SolCallBack(28) = "bsTR.SolOut"
SolCallBack(29) = "KickBallUp"
SolCallBack(30) = "ResetDrops"
SolCallBack(32) = "vpmSolSound SoundFX(""Knocker"",DOFKnocker),"

'**************
' Flipper Subs
'**************

SolCallback(sLRFlipper) = "SolRFlipper"
SolCallback(sLLFlipper) = "SolLFlipper"

Const ReflipAngle = 20
Sub SolLFlipper(Enabled)
        If Enabled Then
		LF.Fire
		'LF2.Fire
		'LF3.Fire 
        
                If leftflipper.currentangle < leftflipper.endangle + ReflipAngle Then 
                        RandomSoundReflipUpLeft LeftFlipper
                Else 
                        SoundFlipperUpAttackLeft LeftFlipper
                        RandomSoundFlipperUpLeft LeftFlipper
                End If                
        Else
                LeftFlipper.RotateToStart
				'LeftFlipper2.RotateToStart  'voir ATTENTION
				'LeftFlipper3.RotateToStart
                If LeftFlipper.currentangle < LeftFlipper.startAngle - 5 Then
                        RandomSoundFlipperDownLeft LeftFlipper
                End If
                FlipperLeftHitParm = FlipperUpSoundLevel
    End If
End Sub

Sub SolRFlipper(Enabled)
        If Enabled Then
                RF.Fire
				'RF2.Fire
				'RF3.Fire

                If rightflipper.currentangle > rightflipper.endangle - ReflipAngle Then
                        RandomSoundReflipUpRight RightFlipper
                Else 
                        SoundFlipperUpAttackRight RightFlipper
                        RandomSoundFlipperUpRight RightFlipper
                End If
        Else
                RightFlipper.RotateToStart
				'RightFlipper2.RotateToStart
				'RightFlipper3.RotateToStart
                If RightFlipper.currentangle > RightFlipper.startAngle + 5 Then
                        RandomSoundFlipperDownRight RightFlipper
                End If        
                FlipperRightHitParm = FlipperUpSoundLevel
        End If
End Sub

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

'**********
' Gi Lights
'**********

Sub SolGi(Enabled)
    Dim obj
    If Enabled Then
		SetLamp 200, 0
		Playsound "fx_relay_off"
    Else
		SetLamp 200, 1
		Playsound "fx_relay_on"
    End If
End Sub



''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''''''''''''''''  Ball Through system''''''''''''''''''''''''''
'''''''''''''''''''''by cyberpez''''''''''''''''''''''''''''''''
''''''''''''''''based off of EalaDubhSidhe's''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Dim BallCount
Dim cBall1, cBall2, cBall3

dim bstatus

Sub CreatBalls()
	Controller.Switch(11) = 1
	Controller.Switch(12) = 1
	Controller.Switch(13) = 1
	Set cBall1 = Kicker1.CreateSizedballWithMass(BallRadius,Ballmass)
	Set cBall2 = Kicker2.CreateSizedballWithMass(BallRadius,Ballmass)
	Set cBall3 = Kicker3.CreateSizedballWithMass(BallRadius,Ballmass)

	If BallMod = 1 Then
		cBall1.Image = "PinballLaserLemon"	
		cBall2.Image = "PinballOutrageousOrange"
		cBall3.Image = "PinballRadicalRed"
	End If
End Sub


Sub Kicker3_Hit():Controller.Switch(11) = 1:UpdateTrough:End Sub
Sub Kicker3_UnHit():Controller.Switch(11) = 0:UpdateTrough:End Sub
Sub Kicker2_Hit():Controller.Switch(12) = 1:UpdateTrough:End Sub
Sub Kicker2_UnHit():Controller.Switch(12) = 0:UpdateTrough:End Sub
Sub Kicker1_Hit():Controller.Switch(13) = 1:UpdateTrough:End Sub
Sub Kicker1_UnHit():Controller.Switch(13) = 0:UpdateTrough:End Sub

Sub UpdateTrough()
	CheckBallStatus.Interval = 300
	CheckBallStatus.Enabled = 1
End Sub

Sub CheckBallStatus_timer()
	If Kicker1.BallCntOver = 0 Then Kicker2.kick 60, 9
	If Kicker2.BallCntOver = 0 Then Kicker3.kick 60, 9
	Me.Enabled = 0
End Sub

Dim Kicker1active, Kicker2active, Kicker3active, Kicker4active, Kicker5active, Kicker6active


'******************************************************
'				DRAIN & RELEASE
'******************************************************

Sub Drain_Hit()
	RandomSoundDrain Drain
	UpdateTrough
	Controller.Switch(10) = 1
	fgBall = true
	iBall = iBall + 1
	BallsInPlay = BallsInPlay - 1
	If BallsInPlay = 1 and IsItMultiball = 1 Then IsItMultiball = 0:HologramUpdateStep = 0:HologramUpdate: End If
End Sub

Sub Drain_UnHit()
	Controller.Switch(10) = 0
End Sub

sub kisort(enabled)
	If enabled then
		if fgBall then
			Drain.Kick 70,20
			iBall = iBall + 1
			fgBall = false
		end if
	end if
end sub

Sub KickBallToLane(Enabled)
	if enabled then
		StopSound "intro"
		PlaySoundAt SoundFX("BallRelease1",DOFContactors),kicker1
		Kicker1.Kick 70,40
		If WobblePlastic = 1 then
			PlasticWobbling = 1
			WobbleCount = 2
			tWobblePlastic.Enabled = True
		End If
		iBall = iBall - 1
		fgBall = false
		BallsInPlay = BallsInPlay + 1
		UpdateTrough
	end if
End Sub


'================Light Handling==================
'       GI, Flashers, and Lamp handling
'Based on JP's VP10 fading Lamp routine, based on PD's Fading Lights
'       Mod FrameTime and GI handling by nFozzy
'================================================
'Short installation
'Keep all non-GI lamps/Flashers in a big collection called aLampsAll
'Initialize SolModCallbacks: Const UseVPMModSol = 1 at the top of the script, before LoadVPM. vpmInit me in bttf_Init()
'LUT images (optional)
'Make modifications based on era of game (setlamp / flashc for games without solmodcallback, use bonus GI subs for games with only one GI control)
 
Dim LampState(340), FadingLevel(340), CollapseMe   
Dim FlashSpeedUp(340), FlashSpeedDown(340), FlashMin(340), FlashMax(340), FlashLevel(340)
Dim SolModValue(340)    'holds 0-255 modulated solenoid values
 
'These are used for fading lights and flashers brighter when the GI is darker
Dim LampsOpacity(340, 2) 'Columns: 0 = intensity / opacity, 1 = fadeup, 2 = FadeDown
Dim GIscale(4)  '5 gi strings
Dim TextureArray1: TextureArray1 = Array("Plastic with an image trans", "Plastic with an image1")

 
InitLamps
 
reDim CollapseMe(1) 'Setlamps and SolModCallBacks   (Click Me to Collapse)
    Sub SetLamp(nr, value)
        If value <> LampState(nr) Then
            LampState(nr) = abs(value)
            FadingLevel(nr) = abs(value) + 4
        End If
    End Sub
 
    Sub SetLampm(nr, nr2, value)    'set 2 lamps
        If value <> LampState(nr) Then
            LampState(nr) = abs(value)
            FadingLevel(nr) = abs(value) + 4
        End If
        If value <> LampState(nr2) Then
            LampState(nr2) = abs(value)
            FadingLevel(nr2) = abs(value) + 4
        End If
    End Sub
 
    Sub SetModLamp(nr, value)
        If value <> SolModValue(nr) Then
            SolModValue(nr) = value
            if value > 0 then LampState(nr) = 1 else LampState(nr) = 0
            FadingLevel(nr) = LampState(nr) + 4
        End If
    End Sub
 
    Sub SetModLampM(nr, nr2, value) 'set 2 modulated lamps
        If value <> SolModValue(nr) Then
            SolModValue(nr) = value
            if value > 0 then LampState(nr) = 1 else LampState(nr) = 0
            FadingLevel(nr) = LampState(nr) + 4
        End If
        If value <> SolModValue(nr2) Then
            SolModValue(nr2) = value
            if value > 0 then LampState(nr2) = 1 else LampState(nr2) = 0
            FadingLevel(nr2) = LampState(nr2) + 4
        End If
    End Sub
    'Flashers via SolModCallBacks
'  SolModCallBack(17) = "SetModLamp 117," 'Billions
'  SolModCallBack(18) = "SetModLamp 118," 'Left ramp
'  SolModCallBack(19) = "SetModLamp 119," 'jackpot
'  SolModCallBack(20) = "SetModLamp 120," 'SkillShot
'  SolModCallBack(21) = "SetModLamp 121," 'Left Helmet
'  SolModCallBack(22) = "SetModLamp 122," 'Right Helmet
'  SolModCallBack(23) = "SetModLamp 123," 'Jets Enter
'  SolModCallBack(24) = "SetModLamp 124," 'Left Loop
 
'#end section
reDim CollapseMe(2) 'InitLamps  (Click Me to Collapse)
    Sub InitLamps() 'set fading speeds and other stuff here
        GetOpacity aLampsAll    'All non-GI lamps and flashers go in this object array for compensation script!
        Dim x
        for x = 0 to uBound(LampState)
            LampState(x) = 0    ' current light state, independent of the fading level. 0 is off and 1 is on
            FadingLevel(x) = 4  ' used to track the fading state
            FlashSpeedUp(x) = 0.1   'Fading speeds in opacity per MS I think (Not used with nFadeL or nFadeLM subs!)
            FlashSpeedDown(x) = 0.1
           
            FlashMin(x) = 0.001         ' the minimum value when off, usually 0
            FlashMax(x) = 1             ' the minimum value when off, usually 1
            FlashLevel(x) = 0.001       ' Raw Flasher opacity value. Start this >0 to avoid initial flasher stuttering.
           
            SolModValue(x) = 0          ' Holds SolModCallback values
           
        Next
       
        for x = 0 to uBound(giscale)
            Giscale(x) = 1.625          ' lamp GI compensation multiplier, eg opacity x 1.625 when gi is fully off
        next
           
        for x = 11 to 110 'insert fading levels (only applicable for lamps that use FlashC sub)
            FlashSpeedUp(x) = 0.015
            FlashSpeedDown(x) = 0.009
        Next       
       
        for x = 111 to 186  'Flasher fading speeds 'intensityscale(%) per 10MS
            FlashSpeedUp(x) = 1.1
            FlashSpeedDown(x) = 0.9
        next
       
        for x = 200 to 203      'GI relay on / off  fading speeds
            FlashSpeedUp(x) = 0.01
            FlashSpeedDown(x) = 0.008
            FlashMin(x) = 0
        Next
        for x = 300 to 303      'GI 8 step modulation fading speeds
            FlashSpeedUp(x) = 0.01
            FlashSpeedDown(x) = 0.008
            FlashMin(x) = 0
        Next
       
        UpdateGIon 0, 1:UpdateGIon 1, 1: UpdateGIon 2, 1 : UpdateGIon 3, 1:UpdateGIon 4, 1
        UpdateGI 0, 7:UpdateGI 1, 7:UpdateGI 2, 7 : UpdateGI 3, 7:UpdateGI 4, 7
    End Sub
 
    Sub GetOpacity(a)   'Keep lamp/flasher data in an array
        Dim x
        for x = 0 to (a.Count - 1)
            On Error Resume Next
            if a(x).Opacity > 0 then a(x).Uservalue = a(x).Opacity
            if a(x).Intensity > 0 then a(x).Uservalue = a(x).Intensity
            If a(x).FadeSpeedUp > 0 then LampsOpacity(x, 1) = a(x).FadeSpeedUp : LampsOpacity(x, 2) = a(x).FadeSpeedDown
        Next
        for x = 0 to (a.Count - 1) : LampsOpacity(x, 0) = a(x).UserValue : Next
    End Sub
 
    sub DebugLampsOn(input):Dim x: for x = 10 to 100 : setlamp x, input : next :  end sub
 
'#end section
 
reDim CollapseMe(3) 'LampTimer  (Click Me to Collapse)
    LampTimer.Interval = -1 '-1 is ideal, but it will technically work with any timer interval
    Dim FrameTime, InitFadeTime : FrameTime = 10    'Count Frametime
    Sub LampTimer_Timer()
        FrameTime = gametime - InitFadeTime
        Dim chgLamp, num, chg, ii
        chgLamp = Controller.ChangedLamps
        If Not IsEmpty(chgLamp) Then
            For ii = 0 To UBound(chgLamp)
                LampState(chgLamp(ii, 0) ) = chgLamp(ii, 1)       'keep the real state in an array
                FadingLevel(chgLamp(ii, 0) ) = chgLamp(ii, 1) + 4 'actual fading step
            Next
        End If
       
        UpdateGIstuff
        UpdateLamps
        UpdateFlashers
 
        InitFadeTime = gametime
    End Sub
'#end section
reDim CollapseMe(4) 'ASSIGNMENTS: Lamps, GI, and Flashers (Click Me to Collapse)
    Sub UpdateGIstuff()

    End Sub
   
    Sub UpdateFlashers()


    End Sub
   
    Sub UpdateLamps()


FadeGI 200
UpdateGIobjectsSingle 200, theGicollection
GiCompensationSingle 200, aLampsAll, GIscale(0)
'FadeLUTsingle 200, "LUTCont_", 28
'SubtleDL 200, pColorRamp

	If LampState(3) = 1 Then
		If MusicSnippet = 1 And PrevGameOver = 0 Then	
			PlaySound "intro"
			PrevGameOver = 1
		End If
	else 

	End If


 	NFadeL 1, l1
	NFadeL 2, l2
	NFadeL 3, l3
	NFadeL 4, l4
	NFadeL 5, l5
	NFadeL 6, l6
	NFadeL 7, l7
	NFadeL 8, l8
	NFadeL 9, l9
	NFadeL 10, l10
	NFadeL 11, l11
	NFadeL 12, l12
	NFadeL 13, l13
	NFadeL 14, l14
	FadeMaterialP 15, pHillSignLeftA, TextureArray1
	NFadeLm 15, l15a
	NFadeL 15, l15
	NFadeL 16, l16
	NFadeL 17, l17
	NFadeL 18, l18
	NFadeL 19, l19
	NFadeL 20, l20
	NFadeL 21, l21
	NFadeL 22, l22
	NFadeL 23, l23
	NFadeL 24, l24
	NfadeL 25, l25d
	NfadeL 26, l26d
	NfadeL 27, l27d
	NfadeL 28, l28d
	NfadeL 29, l29d
	NfadeL 30, l30d
	NfadeL 31, l31d
	NfadeL 32, l32d
	NFadeL 33, l33

	' VR Light controlled flashers
	If VRMode = True Then
		NFadeL 34, VRL34
		NFadeL 35, VRL35
		NFadeL 36, VRL36
		NFadeL 37, VRL37
		NFadeL 38, VRL38
		NFadeL 39, VRL39
		NFadeL 47, VRL47
		' DMD square flasher areas for VR or desktop
		'Flash 34, VRBGFL34_1
		'Flash 34, VRBGFL34_2
		'Flash 35, VRBGFL35_1
		'Flash 35, VRBGFL35_2
		'Flash 36, VRBGFL36_1
		'Flash 36, VRBGFL36_2
		'Flash 37, VRBGFL37_1
		'Flash 37, VRBGFL37_2
		'Flash 38, VRBGFL38_1
		'Flash 38, VRBGFL38_2
		'Flash 39, VRBGFL39_1
		'Flash 39, VRBGFL39_2
		'Flash 47, VRBGFL47_1
		'Flash 47, VRBGFL47_2
		'Flash 56, VRBGFL56_1
		'Flash 56, VRBGFL56_2
		NFadeL 56, VRL56
	Else
		FadeR 34, l34
		FadeRm 56, l56c
		FadeMaterialP 56, pHillSignLeftA, TextureArray1
		NFadeLm 56, l56a
		NFadeL 56, l56
		FadeR 35, l35
		FadeR 36, l36
		FadeR 37, l37
		FadeR 38, l38
		FadeR 39, l39
		FadeRm 47, l47c
		FadeMaterialP 47, pHillSignRightA, TextureArray1
		NFadeLm 47, l47a
		NFadeL 47, l47
	End If
	
	NFadeL 40, l40
	NFadeL 41, l41
	NFadeL 42, l42
	NFadeL 43, l43
	NFadeL 44, l44
	NFadeL 45, l45
	FadeMaterialP 46, pHillSignRightA, TextureArray1
	NFadeLm 46, l46a
	NFadeL 46, l46
	FadeMaterialP 48, pHillSignRightA, TextureArray1
	NFadeLm 48, l48a
	NFadeL 48, l48
	NFadeL 49, l49
	NFadeL 50, l50
	NFadeL 51, l51
	NFadeL 52, l52
	NFadeL 53, l53
	NFadeL 54, l54
	NFadeL 55, l55
	NFadeL 57, l57
	NFadeL 58, l58
	NFadeL 59, l59
	FadeMaterialP 60, pHillSignLeftA, TextureArray1
	NFadeLm 60, l60a
	NFadeL 60, l60
	NFadeL 61, l61
	NFadeL 62, l62
	NFadeL 63, l63
	NFadeL 64, l64

    'Flashers
	NFadeLm 101, f1a
	NFadeLm 101, f1b
	NFadeLm 101, f1c
	NFadeL 101, f1d

	NFadeLm 102, f2a
	NFadeLm 102, f2b
	NFadeLm 102, f2c
	NFadeL 102, f2d

	NFadeLm 103, f3a
	NFadeLm 103, f3b
	NFadeLm 103, f3c
	NFadeL 103, f3d

	FadeMaterial2P 104, pWabblePlastic0, TextureArray1
	FadeDisableLighting 104, Primitive10	
	FadeMaterialP 104, Primitive10, TextureArray1
	NFadeLm 104, f4a
	NFadeL 104, f4b

	FadeDisableLighting 105, Primitive3
	FadeMaterialP 105, Primitive3, TextureArray1
	NFadeLm 105, f5a
	NFadeL 105, f5b

	NFadeLm 106, f6d1
	NFadeLm 106, f6d2
	NFadeLm 106, f6c1
	NFadeLm 106, f6c2
	NFadeLm 106, f6a
	NFadeL 106, f6b

	FadeDisableLighting 108, pPlasticClockTower
	FadeMaterial2P 108, pPlasticClockTower, TextureArray1
	FadeDisableLighting 108, Primitive2
	FadeMaterialP 108, Primitive2, TextureArray1

	NFadeLm 108, f8ca 
	NFadeL 108, f8cb 

	' VR Backglass
	If VRMode = True Then
		NFadeL 104, VRS104
		NFadeL 105, VRS105
		NFadeL 108, VRS108
		NFadeL 115, VRS115
	End If

	NFadeLm 109, f9d1
	NFadeLm 109, f9d2
	NFadeLm 109, f9c1
	NFadeLm 109, f9c2
	NFadeLm 109, f9a
	NFadeL 109, f9b

	FadeDisableLighting 112, Primitive1
	FadeMaterialP 112, Primitive1, TextureArray1	
	NFadeLm 112, f12a
	NFadeL 112, f12b



	NFadeL 113, f13
	NFadeL 114, f14
	NFadeL 115, f15

	FadeDisableLighting 116, Primitive16
	FadeMaterialP 116, Primitive16, TextureArray1
	NFadeLm 116, f16a
	NFadeL 116, f16b
 
    End Sub
   
'#end section


''''Additions by CP

Dim aa


Sub FadeDisableLighting(nr, a)
    Select Case FadingLevel(nr)
        Case 4:a.DisableLighting = 0
        Case 5:a.DisableLighting = 1
    End Select
End Sub

Sub SubtleDL(nr, aa)
    Select Case FadingLevel(nr)

		Case 0:aa.DisableLighting = 0
		Case 1:aa.DisableLighting = .01
		Case 2:aa.DisableLighting = .02
		Case 3:aa.DisableLighting = .03
        Case 4:aa.DisableLighting = .04
        Case 5:aa.DisableLighting = .05
    End Select
End Sub

'trxture swap	
dim itemw, itemp, itemp2

Sub FadeMaterialW(nr, itemw, group)
    Select Case FadingLevel(nr)
        Case 4:itemw.TopMaterial = group(1):itemw.SideMaterial = group(1)
        Case 5:itemw.TopMaterial = group(0):itemw.SideMaterial = group(0)
    End Select
End Sub


Sub FadeMaterialP(nr, itemp, group)
    Select Case FadingLevel(nr)
        Case 4:itemp.Material = group(1)
        Case 5:itemp.Material = group(0)
    End Select
End Sub


Sub FadeMaterial2P(nr, itemp2, group)
    Select Case FadingLevel(nr)
        Case 4:itemp2.Material = group(1)
        Case 5:itemp2.Material = group(0)
    End Select
End Sub


'Reels

Sub FadeR(nr, a)
    Select Case FadingLevel(nr)
        Case 2:a.SetValue 3:FadingLevel(nr) = 0
        Case 3:a.SetValue 2:FadingLevel(nr) = 2
        Case 4:a.SetValue 1:FadingLevel(nr) = 3
        Case 5:a.SetValue 1:FadingLevel(nr) = 1
    End Select
End Sub

Sub FadeRm(nr, a)
    Select Case FadingLevel(nr)
        Case 2:a.SetValue 3
        Case 3:a.SetValue 2
        Case 4:a.SetValue 1
        Case 5:a.SetValue 1
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

''''End Of Additions by CP


 
reDim CollapseMe(5) 'Combined GI subs / functions (Click Me to Collapse)
    Set GICallback = GetRef("UpdateGIon")       'On/Off GI to NRs 200-203
    Sub UpdateGIOn(no, Enabled) : Setlamp no+200, cInt(enabled) : End Sub  
   
    Set GICallback2 = GetRef("UpdateGI")
    Sub UpdateGI(no, step)                      '8 step Modulated GI to NRs 300-303
        Dim ii, x', i
        If step = 0 then exit sub 'only values from 1 to 8 are visible and reliable. 0 is not reliable and 7 & 8 are the same so...
        SetModLamp no+300, ScaleGI(step, 0)
        LampState((no+300)) = 0
    '   if no = 2 then tb.text = no & vbnewline & step & vbnewline & ScaleGI(step,0) & SolModValue(102)
    End Sub
 
    Function ScaleGI(value, scaletype)  'returns an intensityscale-friendly 0->100% value out of 1>8 'it does go to 8
        Dim i
        Select Case scaletype   'select case because bad at maths
            case 0  : i = value * (1/8) '0 to 1
            case 25 : i = (1/28)*(3*value + 4)
            case 50 : i = (value+5)/12
            case else : i = value * (1/8)   '0 to 1
    '           x = (4*value)/3 - 85    '63.75 to 255
        End Select
        ScaleGI = i
    End Function
 
'   Dim LSstate : LSstate = False   'fading sub handles SFX 'Uncomment to enable
    Sub FadeGI(nr) 'in On/off       'Updates nothing but flashlevel
        Select Case FadingLevel(nr)
            Case 3 : FadingLevel(nr) = 0
            Case 4 'off
    '           If Not LSstate then Playsound "FX_Relay_Off",0,LVL(0.1) : LSstate = True    'handle SFX
                FlashLevel(nr) = FlashLevel(nr) - (FlashSpeedDown(nr) * FrameTime)
                If FlashLevel(nr) < FlashMin(nr) Then
                   FlashLevel(nr) = FlashMin(nr)
                   FadingLevel(nr) = 3 'completely off
    '               LSstate = False
                End if
            Case 5 ' on
    '           If Not LSstate then Playsound "FX_Relay_On",0,LVL(0.1) : LSstate = True 'handle SFX
                FlashLevel(nr) = FlashLevel(nr) + (FlashSpeedUp(nr) * FrameTime)
                If FlashLevel(nr) > FlashMax(nr) Then
                    FlashLevel(nr) = FlashMax(nr)
                    FadingLevel(nr) = 6 'completely on
    '               LSstate = False
                End if
            Case 6 : FadingLevel(nr) = 1
        End Select
    End Sub
    Sub ModGI(nr2) 'in 0->1     'Updates nothing but flashlevel 'never off
        Dim DesiredFading
        Select Case FadingLevel(nr2)
            case 3 : FadingLevel(nr2) = 0   'workaround - wait a frame to let M sub finish fading
    '       Case 4 : FadingLevel(nr2) = 3   'off -disabled off, only gicallback1 can turn off GI(?) 'experimental
            Case 5, 4 ' Fade (Dynamic)
                DesiredFading = SolModValue(nr2)
                if FlashLevel(nr2) < DesiredFading Then '+
                    FlashLevel(nr2) = FlashLevel(nr2) + (FlashSpeedUp(nr2)  * FrameTime )
                    If FlashLevel(nr2) >= DesiredFading Then FlashLevel(nr2) = DesiredFading : FadingLevel(nr2) = 1
                elseif FlashLevel(nr2) > DesiredFading Then '-
                    FlashLevel(nr2) = FlashLevel(nr2) - (FlashSpeedDown(nr2) * FrameTime    )
                    If FlashLevel(nr2) <= DesiredFading Then FlashLevel(nr2) = DesiredFading : FadingLevel(nr2) = 6
                End If
            Case 6
                FadingLevel(nr2) = 1
        End Select
    End Sub
 
    Sub UpdateGIobjects(nr, nr2, a) 'Just Update GI
        If FadingLevel(nr) > 1 or FadingLevel(nr2) > 1 Then
            Dim x, Output : Output = FlashLevel(nr2) * FlashLevel(nr)
            for each x in a : x.IntensityScale = Output : next
        End If
    end Sub
   
    Sub GiCompensation(nr, nr2, a, GIscaleOff)  'One NR pairing only fading
    '   tbgi.text = "GI: " & SolModValue(nr) & " " & FlashLevel(nr) & " " & FadingLevel(nr) & vbnewline & _
    '               "ModGI: " & SolModValue(nr2) & " " & FlashLevel(nr2) & " " & FadingLevel(nr2) & vbnewline & _
    '               "Solmodvalue, Flashlevel, Fading step"
        if FadingLevel(nr) > 1 or FadingLevel(nr2) > 1 Then
            Dim x, Giscaler, Output : Output = FlashLevel(nr2) * FlashLevel(nr)
            Giscaler = ((Giscaleoff-1) * (ABS(Output-1) )  ) + 1    'fade GIscale the opposite direction
 
            for x = 0 to (a.Count - 1) 'Handle Compensate Flashers
                On Error Resume Next
                a(x).Opacity = LampsOpacity(x, 0) * Giscaler
                a(x).Intensity = LampsOpacity(x, 0) * Giscaler
                a(x).FadeSpeedUp = LampsOpacity(x, 1) * Giscaler
                a(x).FadeSpeedDown = LampsOpacity(x, 2) * Giscaler
            Next
            '       tbbb.text = giscaler & " on:" & FadingLevel(nr) & vbnewline & "flash: " & output & " onmod:" & FadingLevel(nr2) & vbnewline & l37.intensity
            '       tbbb1.text = FadingLevel(nr) & vbnewline & FadingLevel(nr2)
            '   tbgi1.text = Output & " giscale:" & giscaler    'debug
        End If
        '       tbbb1.text = FLashLevel(nr) & vbnewline & FlashLevel(nr2)
    End Sub
   
    Sub GiCompensationAvg(nr, nr2, nr3, nr4, a, GIscaleOff) 'Two pairs of NRs averaged together
    '   tbgi.text = "GI: " & SolModValue(nr) & " " & FlashLevel(nr) & " " & FadingLevel(nr) & vbnewline & _
    '               "ModGI: " & SolModValue(nr2) & " " & FlashLevel(nr2) & " " & FadingLevel(nr2) & vbnewline & _
    '               "Solmodvalue, Flashlevel, Fading step"
        if FadingLevel(nr) > 1 or FadingLevel(nr2) > 1 or FadingLevel(nr3) > 1 or FadingLevel(nr4) > 1 Then
            Dim x, Giscaler, Output : Output = (((FlashLevel(nr)*FlashLevel(nr2)) + (FlashLevel(nr3)*Flashlevel(nr4))) /2)
            Giscaler = ((Giscaleoff-1) * (ABS(Output-1) )  ) + 1    'fade GIscale the opposite direction
 
            for x = 0 to (a.Count - 1) 'Handle Compensate Flashers
                On Error Resume Next
                a(x).Opacity = LampsOpacity(x, 0) * Giscaler
                a(x).Intensity = LampsOpacity(x, 0) * Giscaler
                a(x).FadeSpeedUp = LampsOpacity(x, 1) * Giscaler
                a(x).FadeSpeedDown = LampsOpacity(x, 2) * Giscaler
            Next
       
               
        REM tbgi1.text = "Output:" & output & vbnewline & _
                    REM "GIscaler" & giscaler & vbnewline & _
                    REM "..."
        End If
        REM tbgi.text = "GI0 " & flashlevel(200) & " " & flashlevel(300) & vbnewline & _
                    REM "GI1 " & flashlevel(201) & " " & flashlevel(301) & vbnewline & _
                    REM "GI2 " & flashlevel(202) & " " & flashlevel(302) & vbnewline & _
                    REM "GI3 " & flashlevel(203) & " " & flashlevel(303) & vbnewline & _
                    REM "GI4 " & flashlevel(204) & " " & flashlevel(304) & vbnewline & _
                    REM "..."
    End Sub
   
    Sub GiCompensationAvgM(nr, nr2, nr3, nr4, nr5, nr6, a, GIscaleOff)  'Three pairs of NRs averaged together
    '   tbgi.text = "GI: " & SolModValue(nr) & " " & FlashLevel(nr) & " " & FadingLevel(nr) & vbnewline & _
    '               "ModGI: " & SolModValue(nr2) & " " & FlashLevel(nr2) & " " & FadingLevel(nr2) & vbnewline & _
    '               "Solmodvalue, Flashlevel, Fading step"
        if FadingLevel(nr) > 1 or FadingLevel(nr2) > 1 Then
            Dim x, Giscaler, Output
            Output = (((FlashLevel(nr)*FlashLevel(nr2)) + (FlashLevel(nr3)*Flashlevel(nr4)) + (FlashLevel(nr5)*FlashLevel(nr6)))/3)
           
            Giscaler = ((Giscaleoff-1) * (ABS(Output-1) )  ) + 1    'fade GIscale the opposite direction
 
            for x = 0 to (a.Count - 1) 'Handle Compensate Flashers
                On Error Resume Next
                a(x).Opacity = LampsOpacity(x, 0) * Giscaler
                a(x).Intensity = LampsOpacity(x, 0) * Giscaler
                a(x).FadeSpeedUp = LampsOpacity(x, 1) * Giscaler
                a(x).FadeSpeedDown = LampsOpacity(x, 2) * Giscaler
            Next
            '       tbbb.text = giscaler & " on:" & FadingLevel(nr) & vbnewline & "flash: " & output & " onmod:" & FadingLevel(nr2) & vbnewline & l37.intensity
            '       tbbb1.text = FadingLevel(nr) & vbnewline & FadingLevel(nr2)
            '   tbgi1.text = Output & " giscale:" & giscaler    'debug
        End If
        '       tbbb1.text = FLashLevel(nr) & vbnewline & FlashLevel(nr2)
    End Sub
 
    Sub FadeLUT(nr, nr2, LutName, LutCount) 'fade lookuptable NOTE- this is a bad idea for darkening your table as
        If FadingLevel(nr) >2 or FadingLevel(nr2) > 2 Then              '-it will strip the whites out of your image
            Dim GoLut
            GoLut = cInt(LutCount * (FlashLevel(nr)*FlashLevel(nr2) )   )
            bttf.ColorGradeImage = luts(lutpos)
    '       tbgi2.text = bttf.ColorGradeImage & vbnewline & golut 'debug
        End If
    End Sub
   
    Sub FadeLUTavg(nr, nr2, nr3, nr4, LutName, LutCount)    'FadeLut for two GI strings (WPC)
        If FadingLevel(nr) >2 or FadingLevel(nr2) > 2 or FadingLevel(nr3) >2 or FadingLevel(nr4) > 2 Then
            Dim GoLut
            GoLut = cInt(LutCount * (((FlashLevel(nr)*FlashLevel(nr2)) + (FlashLevel(nr3)*Flashlevel(nr4))) /2) )
            bttf.ColorGradeImage = luts(lutpos)
            REM tbgi2.text = bttf.ColorGradeImage & vbnewline & golut 'debug
        End If
    End Sub
   
    Sub FadeLUTavgM(nr, nr2, nr3, nr4, nr5, nr6, LutName, LutCount) 'FadeLut for three GI strings (WPC)
        If FadingLevel(nr) >2 or FadingLevel(nr2) > 2 or FadingLevel(nr3) >2 or FadingLevel(nr4) > 2 or _
        FadingLevel(nr5) >2 or FadingLevel(nr6) > 2 Then
            Dim GoLut
            GoLut = cInt(LutCount * (((FlashLevel(nr)*FlashLevel(nr2)) + (FlashLevel(nr3)*Flashlevel(nr4)) + (FlashLevel(nr5)*FlashLevel(nr6)))/3)  )   'what a mess
            bttf.ColorGradeImage = "LUTbassgeigeultrdark"
    '       tbgi2.text = bttf.ColorGradeImage & vbnewline & golut 'debug
        End If
    End Sub
   
'#end section
 
reDim CollapseMe(6) 'Fading subs     (Click Me to Collapse)
    Sub nModFlash(nr, object, scaletype, offscale)  'Fading with modulated callbacks
        Dim DesiredFading
        Select Case FadingLevel(nr)
            case 3 : FadingLevel(nr) = 0    'workaround - wait a frame to let M sub finish fading
            Case 4  'off
                If Offscale = 0 then Offscale = 1
                FlashLevel(nr) = FlashLevel(nr) - (FlashSpeedDown(nr) * FrameTime   ) * offscale
                If FlashLevel(nr) < 0 then FlashLevel(nr) = 0 : FadingLevel(nr) = 3
                Object.IntensityScale = ScaleLights(FlashLevel(nr),0 )
            Case 5 ' Fade (Dynamic)
                DesiredFading = ScaleByte(SolModValue(nr), scaletype)
                if FlashLevel(nr) < DesiredFading Then '+
                    FlashLevel(nr) = FlashLevel(nr) + (FlashSpeedUp(nr) * FrameTime )
                    If FlashLevel(nr) >= DesiredFading Then FlashLevel(nr) = DesiredFading : FadingLevel(nr) = 1
                elseif FlashLevel(nr) > DesiredFading Then '-
                    FlashLevel(nr) = FlashLevel(nr) - (FlashSpeedDown(nr) * FrameTime   )
                    If FlashLevel(nr) <= DesiredFading Then FlashLevel(nr) = DesiredFading : FadingLevel(nr) = 6
                End If
                Object.Intensityscale = ScaleLights(FlashLevel(nr),0 )
            Case 6 : FadingLevel(nr) = 1
        End Select
    End Sub
 
    Sub nModFlashM(nr, Object)
        Select Case FadingLevel(nr)
            Case 3, 4, 5, 6 : Object.Intensityscale = ScaleLights(FlashLevel(nr),0 )
        End Select
    End Sub
 
    Sub Flashc(nr, object)  'FrameTime Compensated. Can work with Light Objects (make sure state is 1 though)
        Select Case FadingLevel(nr)
            Case 3 : FadingLevel(nr) = 0
            Case 4 'off
                FlashLevel(nr) = FlashLevel(nr) - (FlashSpeedDown(nr) * FrameTime)
                If FlashLevel(nr) < FlashMin(nr) Then
                    FlashLevel(nr) = FlashMin(nr)
                   FadingLevel(nr) = 3 'completely off
                End if
                Object.IntensityScale = FlashLevel(nr)
            Case 5 ' on
                FlashLevel(nr) = FlashLevel(nr) + (FlashSpeedUp(nr) * FrameTime)
                If FlashLevel(nr) > FlashMax(nr) Then
                    FlashLevel(nr) = FlashMax(nr)
                    FadingLevel(nr) = 6 'completely on
                End if
                Object.IntensityScale = FlashLevel(nr)
            Case 6 : FadingLevel(nr) = 1
        End Select
    End Sub
 
    Sub Flashm(nr, object) 'multiple flashers, it just sets the flashlevel
        select case FadingLevel(nr)
            case 3, 4, 5, 6 : Object.IntensityScale = FlashLevel(nr)
        end select
    End Sub
   
    Sub NFadeL(nr, object)  'Simple VPX light fading using State
   Select Case FadingLevel(nr)
        Case 3:object.state = 0:FadingLevel(nr) = 0
        Case 4:object.state = 0:FadingLevel(nr) = 3
        Case 5:object.state = 1:FadingLevel(nr) = 6
        Case 6:object.state = 1:FadingLevel(nr) = 1
    End Select
    End Sub
 
    Sub NFadeLm(nr, object) ' used for multiple lights
        Select Case FadingLevel(nr)
            Case 3:object.state = 0
            Case 4:object.state = 0
            Case 5:object.state = 1
            Case 6:object.state = 1
        End Select
    End Sub
 
'#End Section
 
reDim CollapseMe(7) 'Fading Functions (Click Me to Collapse)
    Function ScaleLights(value, scaletype)  'returns an intensityscale-friendly 0->100% value out of 255
        Dim i
        Select Case scaletype   'select case because bad at maths   'TODO: Simplify these functions. B/c this is absurdly bad.
            case 0  : i = value * (1 / 255) '0 to 1
            case 6  : i = (value + 17)/272  '0.0625 to 1
            case 9  : i = (value + 25)/280  '0.089 to 1
            case 15 : i = (value / 300) + 0.15
            case 20 : i = (4 * value)/1275 + (1/5)
            case 25 : i = (value + 85) / 340
            case 37 : i = (value+153) / 408     '0.375 to 1
            case 40 : i = (value + 170) / 425
            case 50 : i = (value + 255) / 510   '0.5 to 1
            case 75 : i = (value + 765) / 1020  '0.75 to 1
            case Else : i = 10
        End Select
        ScaleLights = i
    End Function
 
    Function ScaleByte(value, scaletype)    'returns a number between 1 and 255
        Dim i
        Select Case scaletype
            case 0 : i = value * 1  '0 to 1
            case 9 : i = (5*(200*value + 1887))/1037 'ugh
            case 15 : i = (16*value)/17 + 15
            Case 63 : i = (3*(value + 85))/4
            case else : i = value * 1   '0 to 1
        End Select
        ScaleByte = i
    End Function
 
'#end section
 
reDim CollapseMe(8) 'Bonus GI Subs for games with only simple On/Off GI (Click Me to Collapse)
    Sub UpdateGIobjectsSingle(nr, a)    'An UpdateGI script for simple (Sys11 / Data East or whatever)
        If FadingLevel(nr) > 1 Then
            Dim x, Output : Output = FlashLevel(nr)
            for each x in a : x.IntensityScale = Output : next
        End If
    end Sub
   
    Sub GiCompensationSingle(nr, a, GIscaleOff) 'One NR pairing only fading
        if FadingLevel(nr) > 1 Then
            Dim x, Giscaler, Output : Output = FlashLevel(nr)
            Giscaler = ((Giscaleoff-1) * (ABS(Output-1) )  ) + 1    'fade GIscale the opposite direction
 
            for x = 0 to (a.Count - 1) 'Handle Compensate Flashers
                On Error Resume Next
                a(x).Opacity = LampsOpacity(x, 0) * Giscaler
                a(x).Intensity = LampsOpacity(x, 0) * Giscaler
                a(x).FadeSpeedUp = LampsOpacity(x, 1) * Giscaler
                a(x).FadeSpeedDown = LampsOpacity(x, 2) * Giscaler
            Next
        End If
        '       tbbb1.text = FLashLevel(nr) & vbnewline & FlashLevel(nr2)
    End Sub
   
    Sub FadeLUTsingle(nr, LutName, LutCount)    'fade lookuptable NOTE- this is a bad idea for darkening your table as
        If FadingLevel(nr) >2 Then              '-it will strip the whites out of your image
            Dim GoLut
            GoLut = cInt(LutCount * FlashLevel(nr)  )
            'bttf.ColorGradeImage = LutName & GoLut
    '       tbgi2.text = bttf.ColorGradeImage & vbnewline & golut 'debug
        End If
    End Sub
   
'#end section
 
Sub theend() : End Sub
 
 
REM Troubleshooting :
REM Flashers/gi are intermittent or aren't showing up
REM Ensure flashers start visible, light objects start with state = 1
 
REM No lamps or no GI
REM Make sure these constants are set up this way
REM Const UseSolenoids = 1
REM Const UseLamps = 0
REM Const UseGI = 1
 
REM SolModCallback error
REM Ensure you have the latest scripts. Clear out any loose scripts in your tables that might be causing conflicts.
 
REM bttf Error
REM Rename the table to bttf or find/Replace bttf with whatever the table's name is
 
REM SolModCallbacks aren't sending anything
REM Two important things to get SolModCallbacks to initialize properly:
REM Put this at the top of the script, before LoadVPM
    REM Const UseVPMModSol = 1
REM Put this in the bttf_Init() section
    REM vpmInit me

'***********************
'   Visible Locks
' Adapted to this table
' based on the core.vbs
'***********************

Class cvpmVLock2
    Private mTrig, mKick, mSw(), mSize, mBalls, mGateOpen, mRealForce, mBallSnd, mNoBallSnd
    Public ExitDir, ExitForce, KickForceVar

    Private Sub Class_Initialize
        mBalls = 0:ExitDir = 0:ExitForce = 0:KickForceVar = 0:mGateOpen = False
        vpmTimer.addResetObj Me
    End Sub

    Public Sub InitVLock(aTrig, aKick, aSw)
        Dim ii
        mSize = vpmSetArray(mTrig, aTrig)
        If vpmSetArray(mKick, aKick) <> mSize Then MsgBox "cvpmVLock: Unmatched kick+trig":Exit Sub
        On Error Resume Next
        ReDim mSw(mSize)
        If IsArray(aSw) Then
            For ii = 0 To UBound(aSw):mSw(ii) = aSw(ii):Next
        ElseIf aSw = 0 Or Err Then
            For ii = 0 To mSize:mSw(ii) = mTrig(ii).TimerInterval:Next
        Else
            mSw(0) = aSw
        End If
    End Sub

    Public Sub InitSnd(aBall, aNoBall):mBallSnd = aBall:mNoBallSnd = aNoBall:End Sub
    Public Sub CreateEvents(aName)
        Dim ii
        If Not vpmCheckEvent(aName, Me) Then Exit Sub
        For ii = 0 To mSize
            vpmBuildEvent mTrig(ii), "Hit", aName & ".TrigHit ActiveBall," & ii + 1

            vpmBuildEvent mTrig(ii), "Unhit", aName & ".TrigUnhit ActiveBall," & ii + 1

            vpmBuildEvent mKick(ii), "Hit", aName & ".KickHit " & ii + 1
        Next
    End Sub

    Public Sub SolExit(aEnabled)
        Dim ii
        mGateOpen = aEnabled
        If Not aEnabled Then Exit Sub
        If mBalls> 0 Then PlaySound mBallSnd:Else PlaySound mNoBallSnd:Exit Sub
        For ii = 0 To mBalls-1
            mKick(ii).Enabled = False:If mSw(ii) Then Controller.Switch(mSw(ii) ) = False
        Next
        '		If ExitForce > 0 Then ' Up
        '			mRealForce = ExitForce + (Rnd - 0.5)*KickForceVar : mKick(mBalls-1).Kick ExitDir, mRealForce
        '		Else ' Down
        mRealForce = ExitForce + (Rnd - 0.5) * KickForceVar:mKick(0).Kick ExitDir, mRealForce
    '		End If
    End Sub

    Public Sub Reset
        Dim ii:If mBalls = 0 Then Exit Sub
        For ii = 0 To mBalls-1
            If mSw(ii) Then Controller.Switch(mSw(ii) ) = True
        Next
    End Sub

    Public Property Get Balls:Balls = mBalls:End Property

    Public Property Let Balls(aBalls)
        Dim ii:mBalls = aBalls
        For ii = 0 To mSize
            If ii >= aBalls Then
                mKick(ii).DestroyBall:If mSw(ii) Then Controller.Switch(mSw(ii) ) = False
                Else
                    vpmCreateBall mKick(ii):If mSw(ii) Then Controller.Switch(mSw(ii) ) = True
            End If
        Next
    End Property

    Public Sub TrigHit(aBall, aNo)
        aNo = aNo - 1:If mSw(aNo) Then Controller.Switch(mSw(aNo) ) = True
        If aBall.VelY <-1 Then Exit Sub ' Allow small upwards speed
        If aNo = mSize Then mBalls = mBalls + 1
        If mBalls> aNo Then mKick(aNo).Enabled = Not mGateOpen
    End Sub

    Public Sub TrigUnhit(aBall, aNo)
        aNo = aNo - 1:If mSw(aNo) Then Controller.Switch(mSw(aNo) ) = False
        If aBall.VelY> -1 Then
            If aNo = 0 Then mBalls = mBalls - 1
            If aNo <mSize Then mKick(aNo + 1).Kick 0, 0
            Else
                If aNo = mSize Then mBalls = mBalls - 1
                If aNo> 0 Then mKick(aNo-1).Kick ExitDir, mRealForce
        End If
    End Sub

    Public Sub KickHit(aNo):mKick(aNo-1).Enabled = False:End Sub
End Class

' *********************************************************************
'                      Supporting Ball & Sound Functions
' *********************************************************************

'Function Vol(ball) ' Calculates the Volume of the sound based on the ball speed
'    Vol = Csng(BallVel(ball) ^2 / 200)*1.2
'End Function
'
'Function VolZ(ball) ' Calculates the Volume of the sound based on the ball speed in the Z
'    VolZ = Csng(BallVelZ(ball) ^2 / 200)*1.2
'End Function


Function Pan(ball) ' Calculates the pan for a ball based on the X position on the table. "bttf" is the name of the table
    Dim tmp
    tmp = ball.x * 2 / bttf.width-1
    If tmp > 0 Then
        Pan = Csng(tmp ^10)
    Else
        Pan = Csng(-((- tmp) ^10) )
    End If
End Function
'
'Function Pitch(ball) ' Calculates the pitch of the sound based on the ball speed
'    Pitch = BallVel(ball) * 20
'End Function

'Function BallVel(ball) 'Calculates the ball speed
'    BallVel = INT(SQR((ball.VelX ^2) + (ball.VelY ^2) ) )
'End Function

'function AudioFade(ball)
'    Dim tmp
'    tmp = ball.y * 2 / bttf.height-1
'    If tmp > 0 Then
'        AudioFade = Csng(tmp ^10)
'    Else
'        AudioFade = Csng(-((- tmp) ^10) )
'    End If
'End Function

Function BallVelZ(ball) 'Calculates the ball speed in the -Z
    BallVelZ = INT((ball.VelZ) * -1 )
End Function

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


'*****************************************
'      JP's VP10 Rolling Sounds
'*****************************************

Const tnob = 10 ' total number of balls

ReDim rolling(tnob)
InitRolling

Dim DropCount
ReDim DropCount(tnob)

Sub InitRolling
        Dim i
        For i = 0 to tnob
                rolling(i) = False
        Next
End Sub

Sub RollingTimer_Timer()
        Dim BOT, b
        BOT = GetBalls

        ' stop the sound of deleted balls
        For b = UBound(BOT) + 1 to tnob
			If AmbientBallShadowOn = 0 Then BallShadowA(b).visible = 0 'ambient
                rolling(b) = False
                StopSound("BallRoll_" & b)
				StopSound("Wireloop" & b)
				StopSound("RampLoop" & b)
        Next

        ' exit the sub if no balls on the table
        If UBound(BOT) = -1 Then Exit Sub

        ' play the rolling sound for each ball

        For b = 0 to UBound(BOT)
                If BallVel(BOT(b)) > 1 Then
                        rolling(b) = True
							If BOT(b).z < 30 Then
							PlaySound ("BallRoll_" & b), -1, VolPlayfieldRoll(BOT(b)) * 1.1 * VolumeDial, AudioPan(BOT(b)), 0, PitchPlayfieldRoll(BOT(b)), 1, 0, AudioFade(BOT(b))
							StopSound("RampLoop" & b)
							StopSound("Wireloop" & b)							
							Else
							PlaySound ("RampLoop" & b), -1, VolPlayfieldRoll(BOT(b)) * 2.1 * VolumeDial, AudioPan(BOT(b)), 0, PitchPlayfieldRoll(BOT(b)), 1, 0, AudioFade(BOT(b))
							StopSound("BallRoll_" & b)
							StopSound("Wireloop" & b)
							End If

                Else
					If OnWireRamp = 1 Then
						PlaySound ("Wireloop" & b), -1, VolPlayfieldRoll(BOT(b)) * 2.1 * VolumeDial, AudioPan(BOT(b)), 0, PitchPlayfieldRoll(BOT(b)), 1, 0, AudioFade(BOT(b))
						StopSound("BallRoll_" & b)
						StopSound("RampLoop" & b)
					Else
					
                        If rolling(b) = True Then
                                StopSound("BallRoll_" & b)
								StopSound("RampLoop" & b)
								StopSound("Wireloop" & b)
                                rolling(b) = False
                        End If
					End If
                End If

                '***Ball Drop Sounds***
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

'RampHelpers

Dim OnWireRamp

Sub tRampHelper1a_hit()
	OnWireRamp = 1
End Sub

Sub tRampHelper1b_hit()
	OnWireRamp = 0
    StopSound("metalrolling")
End Sub

'******************************************************
' 				JP's Sound Routines
'******************************************************

'Sub Pins_Hit (idx)
'	PlaySound "pinhit_low", 0, Vol(ActiveBall), Pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0, AudioFade(ActiveBall)
'End Sub
'
'Sub Targets_Hit (idx)
'	PlaySound "target", 0, Vol(ActiveBall), Pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0, AudioFade(ActiveBall)
'End Sub
'
'Sub Metals_Hit (idx)
'	PlaySound "metalhit_medium", 0, Vol(ActiveBall), Pan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
'End Sub
'
'Sub Gates_Hit (idx)
'	PlaySound "gate4", 0, Vol(ActiveBall), Pan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall)
'End Sub
'
'Sub aRubbers_Hit(idx)
'    PlaySoundAtBallVol "rubber_hit_" & Int(Rnd*3)+1, .8
'End Sub
'
'Sub aRubbers_Hit(idx)
'    PlaySoundAtBallVol "rubber_hit_" & Int(Rnd*3)+1, .8
'End Sub
'
'Sub Posts_Hit(idx)
'    PlaySoundAtBallVol "rubber_hit_" & Int(Rnd*3)+1, .8
'End Sub


''Flux Ramp Sounds
Sub PlasticRampHit1_Hit:PlaySound "PlasticRamp_Hit3", 0, 0, Pan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall): End Sub
Sub PlasticRampHit2_Hit:PlaySound "PlasticRamp_Hit1", 0, 0, Pan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall):If WobblePlastic = 1 then:PlasticWobbling = 1:WobbleCount = 1:tWobblePlastic.Enabled = True:End If: End Sub
Sub PlasticRampHit3_Hit:PlaySound "PlasticRamp_Hit4", 0, 0, Pan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall):If WobblePlastic = 1 then:PlasticWobbling = 1:WobbleCount = 2:tWobblePlastic.Enabled = True:End If: End Sub
Sub PlasticRampHit4_Hit:PlaySound "PlasticRamp_Hit2", 0, 0, Pan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall):If WobblePlastic = 1 then:PlasticWobbling = 1:WobbleCount = 3:tWobblePlastic.Enabled = True:End If: End Sub
Sub PlasticRampHit5_Hit:PlaySound "PlasticRamp_Hit3", 0, 0, Pan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall): End Sub

''Color Ramp Sounds
Sub Sound1_Hit:PlaySound "rail_low_slowerNOTUSED", 0, Vol(ActiveBall), Pan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall):End Sub
Sub Sound2_Hit()
	PlaySound "rail_low_slowerNOTUSED", 0, Vol(ActiveBall), Pan(ActiveBall), 0, Pitch(ActiveBall), 1, 0, AudioFade(ActiveBall):
	BallsLocked = BallsLocked - 1
	If HologramPhoto = 1 Then
		If IsItMultiball = 1 then
			IsItMultiballTimer.Enabled = true
		Else
			HologramUpdateStep = HologramUpdateStep - 2
			HologramUpdate
		End If
	End If
End Sub

'**************************************************************************
'                 Positional Sound Playback Functions by DJRobX
'**************************************************************************

'Set position as table object (Use object or light but NOT wall) and Vol to 1

'Sub PlaySoundAt(sound, tableobj)
'		PlaySound sound, 1, 1, Pan(tableobj), 0,0,0, 1, AudioFade(tableobj)
'End Sub
'
'
''Set all as per ball position & speed.
'
'Sub PlaySoundAtBall(sound)
'		PlaySound sound, 0, Vol(ActiveBall), Pan(ActiveBall), 0, Pitch(ActiveBall), 0, 1, AudioFade(ActiveBall)
'End Sub
'
'
''Set position as table object and Vol manually.
'
'Sub PlaySoundAtVol(sound, tableobj, Vol)
'		PlaySound sound, 1, Vol, Pan(tableobj), 0,0,0, 1, AudioFade(tableobj)
'End Sub
'
'
''Set all as per ball position & speed, but Vol Multiplier may be used eg; PlaySoundAtBallVol "sound",3
'
'Sub PlaySoundAtBallVol(sound, VolMult)
'		PlaySound sound, 0, Vol(ActiveBall) * VolMult, Pan(ActiveBall), 0, Pitch(ActiveBall), 0, 1, AudioFade(ActiveBall)
'End Sub
'
'Sub PlaySoundAtBOTBallZ(sound, BOT)
'		PlaySound sound, 0, VolZ(BOT), Pan(BOT), 0, Pitch(BOT), 1, 1, AudioFade(BOT)
'End Sub
'
''Set position as bumperX and Vol manually.
'
'Sub PlaySoundAtBumperVol(sound, tableobj, Vol)
'		PlaySound sound, 1, Vol, Pan(tableobj), 0,0,1, 1, AudioFade(tableobj)
'End Sub

'*****************************
'Random Ramp and Orbit Sounds
'*****************************

Dim NextOrbitHit:NextOrbitHit = 0 

Sub WireRampBumps_Hit(idx)
	if BallVel(ActiveBall) > .3 and Timer > NextOrbitHit then
		RandomBump3 .1, Pitch(ActiveBall)+5
		' Schedule the next possible sound time.  This prevents it from rapid-firing noises too much. 
		' Lowering these numbers allow more closely-spaced clunks.
		NextOrbitHit = Timer + .4 + (Rnd * .2)
	end if 
End Sub

Sub PlasticRampBumps_Hit(idx)
	if BallVel(ActiveBall) > .4 and Timer > NextOrbitHit then
		RandomBump 5, Pitch(ActiveBall)
		' Schedule the next possible sound time.  This prevents it from rapid-firing noises too much. 
		' Lowering these numbers allow more closely-spaced clunks.
		NextOrbitHit = Timer + .2 + (Rnd * .2)
	end if 
End Sub


Sub MetalGuideBumps_Hit(idx)
	if BallVel(ActiveBall) > .3 and Timer > NextOrbitHit then
		RandomBump2 2, Pitch(ActiveBall)
		' Schedule the next possible sound time.  This prevents it from rapid-firing noises too much. 
		' Lowering these numbers allow more closely-spaced clunks.
		NextOrbitHit = Timer + .2 + (Rnd * .2)
	end if 
End Sub

Sub MetalWallBumps_Hit(idx)
	if BallVel(ActiveBall) > .3 and Timer > NextOrbitHit then
		RandomBump 2, 20000 'Increased pitch to simulate metal wall
		' Schedule the next possible sound time.  This prevents it from rapid-firing noises too much. 
		' Lowering these numbers allow more closely-spaced clunks.
		NextOrbitHit = Timer + .2 + (Rnd * .2)
	end if 
End Sub


' Requires rampbump1 to 7 in Sound Manager
Sub RandomBump(voladj, freq)
	dim BumpSnd:BumpSnd= "fx_rampbump" & CStr(Int(Rnd*7)+1)
		PlaySound BumpSnd, 0, Vol(ActiveBall)*voladj, Pan(ActiveBall), 0, freq, 0, 1, AudioFade(ActiveBall)
End Sub

' Requires metalguidebump1 to 2 in Sound Manager
Sub RandomBump2(voladj, freq)
	dim BumpSnd:BumpSnd= "metalguidebump" & CStr(Int(Rnd*2)+1)
		PlaySound BumpSnd, 0, Vol(ActiveBall)*voladj, Pan(ActiveBall), 0, freq, 0, 1, AudioFade(ActiveBall)
End Sub

' Requires WireRampBump1 to 5 in Sound Manage
Sub RandomBump3(voladj, freq)
	dim BumpSnd:BumpSnd= "WireRampBump" & CStr(Int(Rnd*5)+1)
		PlaySound BumpSnd, 0, Vol(ActiveBall)*voladj, Pan(ActiveBall), 0, freq, 0, 1, AudioFade(ActiveBall)
End Sub



' Stop Bump Sounds
Sub BumpSTOP1_Hit ()
dim i:for i=1 to 4:StopSound "WireRampBump" & i:next
NextOrbitHit = Timer + 1
End Sub

Sub BumpSTOP2_Hit ()
dim i:for i=1 to 4:StopSound "PlasticRampBump" & i:next
NextOrbitHit = Timer + 1
End Sub

'******************************************************
'****  GENEREAL ADVICE ON PHYSICS
'******************************************************
'
' It's advised that flipper corrections, dampeners, and general physics settings should all be updated per these 
' examples as all of these improvements work together to provide a realistic physics simulation.
'
' Tutorial videos provided by Bord
' Flippers: 	https://www.youtube.com/watch?v=FWvM9_CdVHw
' Dampeners: 	https://www.youtube.com/watch?v=tqsxx48C6Pg
' Physics: 		https://www.youtube.com/watch?v=UcRMG-2svvE
'
'
' Note: BallMass must be set to 1. BallSize should be set to 50 (in other words the ball radius is 25) 
'
' Recommended Table Physics Settings
' | Gravity Constant             | 0.97      |
' | Playfield Friction           | 0.15-0.25 |
' | Playfield Elasticity         | 0.25      |
' | Playfield Elasticity Falloff | 0         |
' | Playfield Scatter            | 0         |
' | Default Element Scatter      | 2         |
'
' Bumpers
' | Force         | 9.5-10.5 |
' | Hit Threshold | 1.6-2    |
' | Scatter Angle | 2        |
' 
' Slingshots
' | Hit Threshold      | 2    |
' | Slingshot Force    | 4-5  |
' | Slingshot Theshold | 2-3  |
' | Elasticity         | 0.85 |
' | Friction           | 0.8  |
' | Scatter Angle      | 1    |



'******************************************************
'****  FLIPPER CORRECTIONS by nFozzy
'******************************************************
'
' There are several steps for taking advantage of nFozzy's flipper solution.  At a high level weÂll need the following:
'	1. flippers with specific physics settings
'	2. custom triggers for each flipper (TriggerLF, TriggerRF)
'	3. an object or point to tell the script where the tip of the flipper is at rest (EndPointLp, EndPointRp)
'	4. and, special scripting
'
' A common mistake is incorrect flipper length.  A 3-inch flipper with rubbers will be about 3.125 inches long.  
' This translates to about 147 vp units.  Therefore, the flipper start radius + the flipper length + the flipper end 
' radius should  equal approximately 147 vp units. Another common mistake is is that sometimes the right flipper
' angle was set with a large postive value (like 238 or something). It should be using negative value (like -122).
'
' The following settings are a solid starting point for various eras of pinballs.
' |                    | EM's           | late 70's to mid 80's | mid 80's to early 90's | mid 90's and later |
' | ------------------ | -------------- | --------------------- | ---------------------- | ------------------ |
' | Mass               | 1              | 1                     | 1                      | 1                  |
' | Strength           | 500-1000 (750) | 1400-1600 (1500)      | 2000-2600              | 3200-3300 (3250)   |
' | Elasticity         | 0.88           | 0.88                  | 0.88                   | 0.88               |
' | Elasticity Falloff | 0.15           | 0.15                  | 0.15                   | 0.15               |
' | Fricition          | 0.8-0.9        | 0.9                   | 0.9                    | 0.9                |
' | Return Strength    | 0.11           | 0.09                  | 0.07                   | 0.055              |
' | Coil Ramp Up       | 2.5            | 2.5                   | 2.5                    | 2.5                |
' | Scatter Angle      | 0              | 0                     | 0                      | 0                  |
' | EOS Torque         | 0.3            | 0.3                   | 0.275                  | 0.275              |
' | EOS Torque Angle   | 4              | 4                     | 6                      | 6                  |
'


'******************************************************
' Flippers Polarity (Select appropriate sub based on era) 
'******************************************************

dim LF : Set LF = New FlipperPolarity
dim RF : Set RF = New FlipperPolarity
dim RF1: Set RF1 = New FlipperPolarity
dim LF1: Set LF1 = New FlipperPolarity
dim LF2 : Set LF2 = New FlipperPolarity
dim RF2 : Set RF2 = New FlipperPolarity
dim LF3 : Set LF3 = New FlipperPolarity
dim RF3 : Set RF3 = New FlipperPolarity


InitPolarity

'
''*******************************************
'' Late 70's to early 80's
'
'Sub InitPolarity()
'        dim x, a : a = Array(LF, RF, LF2, RF2, LF3, RF3)
'        for each x in a
'                x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 1        'disabled
'                x.AddPoint "Ycoef", 1, RightFlipper.Y-11, 1
'                x.enabled = True
'                x.TimeDelay = 80  '*****Important, this variable is an offset for the speed that the ball travels down the table to determine if the flippers have been fired 
'							'This is needed because the corrections to ball trajectory should only applied if the flippers have been fired and the ball is in the trigger zones.
'							'FlipAT is set to GameTime when the ball enters the flipper trigger zones and if GameTime is less than FlipAT + this time delay then changes to velocity
'							'and trajectory are applied.  If the flipper is fired before the ball enters the trigger zone then with this delay added to FlipAT the changes
'							'to tragectory and velocity will not be applied.  Also if the flipper is in the final 20 degrees changes to ball values will also not be applied.
'							'"Faster" tables will need a smaller value while "slower" tables will need a larger value to give the ball more time to get to the flipper. 		
'							'If this value is not set high enough the Flipper Velocity and Polarity corrections will NEVER be applied.
'
'        Next
'
'        AddPt "Polarity", 0, 0, 0
'        AddPt "Polarity", 1, 0.05, -2.7        
'        AddPt "Polarity", 2, 0.33, -2.7
'        AddPt "Polarity", 3, 0.37, -2.7        
'        AddPt "Polarity", 4, 0.41, -2.7
'        AddPt "Polarity", 5, 0.45, -2.7
'        AddPt "Polarity", 6, 0.576,-2.7
'        AddPt "Polarity", 7, 0.66, -1.8
'        AddPt "Polarity", 8, 0.743, -0.5
'        AddPt "Polarity", 9, 0.81, -0.5
'        AddPt "Polarity", 10, 0.88, 0
'
'        addpt "Velocity", 0, 0,         1
'        addpt "Velocity", 1, 0.16, 1.06
'        addpt "Velocity", 2, 0.41,         1.05
'        addpt "Velocity", 3, 0.53,         1'0.982
'        addpt "Velocity", 4, 0.702, 0.968
'        addpt "Velocity", 5, 0.95,  0.968
'        addpt "Velocity", 6, 1.03,         0.945
'
'        LF.Object = LeftFlipper 
'        LF.EndPoint = EndPointLp  'you can use just a coordinate, or an object with a .x property. Using a couple of simple primitive objects
'        RF.Object = RightFlipper
'        RF.EndPoint = EndPointRp
'		'LF2.Object = LeftFlipper2        
'        'LF2.EndPoint = EndPointLp2
'        'RF2.Object = RightFlipper2
'        'RF2.EndPoint = EndPointRp2
'		'LF3.Object = LeftFlipper3        
'        'LF3.EndPoint = EndPointLp3
'        'RF3.Object = RightFlipper3
'        'RF3.EndPoint = EndPointRp3
'
'End Sub



''*******************************************
'' Mid 80's
'
'Sub InitPolarity()
'        dim x, a : a = Array(LF, RF, LF2, RF2, LF3, RF3)
'        for each x in a
'                x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 1        'disabled
'                x.AddPoint "Ycoef", 1, RightFlipper.Y-11, 1
'                x.enabled = True
'                x.TimeDelay = 80
'        Next
'
'        AddPt "Polarity", 0, 0, 0
'        AddPt "Polarity", 1, 0.05, -3.7        
'        AddPt "Polarity", 2, 0.33, -3.7
'        AddPt "Polarity", 3, 0.37, -3.7
'        AddPt "Polarity", 4, 0.41, -3.7
'        AddPt "Polarity", 5, 0.45, -3.7 
'        AddPt "Polarity", 6, 0.576,-3.7
'        AddPt "Polarity", 7, 0.66, -2.3
'        AddPt "Polarity", 8, 0.743, -1.5
'        AddPt "Polarity", 9, 0.81, -1
'        AddPt "Polarity", 10, 0.88, 0
'
'        addpt "Velocity", 0, 0,         1
'        addpt "Velocity", 1, 0.16, 1.06
'        addpt "Velocity", 2, 0.41,         1.05
'        addpt "Velocity", 3, 0.53,         1'0.982
'        addpt "Velocity", 4, 0.702, 0.968
'        addpt "Velocity", 5, 0.95,  0.968
'        addpt "Velocity", 6, 1.03,         0.945
'
'        LF.Object = LeftFlipper        
'        LF.EndPoint = EndPointLp
'        RF.Object = RightFlipper
'        RF.EndPoint = EndPointRp
'		'LF2.Object = LeftFlipper2        
'       'LF2.EndPoint = EndPointLp2
'       'RF2.Object = RightFlipper2
'       'RF2.EndPoint = EndPointRp2
'		'LF3.Object = LeftFlipper3        
'       'LF3.EndPoint = EndPointLp3
'       'RF3.Object = RightFlipper3
'       'RF3.EndPoint = EndPointRp3
'End Sub
'
'


'*******************************************
'  Late 80's early 90's
'
Sub InitPolarity()
        dim x, a : a = Array(LF, RF, LF2, RF2, LF3, RF3)
	for each x in a
		x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 1        'disabled
		x.AddPoint "Ycoef", 1, RightFlipper.Y-11, 1
		x.enabled = True
		x.TimeDelay = 60
	Next

	AddPt "Polarity", 0, 0, 0
	AddPt "Polarity", 1, 0.05, -5
	AddPt "Polarity", 2, 0.4, -5
	AddPt "Polarity", 3, 0.6, -4.5
	AddPt "Polarity", 4, 0.65, -4.0
	AddPt "Polarity", 5, 0.7, -3.5
	AddPt "Polarity", 6, 0.75, -3.0
	AddPt "Polarity", 7, 0.8, -2.5
	AddPt "Polarity", 8, 0.85, -2.0
	AddPt "Polarity", 9, 0.9,-1.5
	AddPt "Polarity", 10, 0.95, -1.0
	AddPt "Polarity", 11, 1, -0.5
	AddPt "Polarity", 12, 1.1, 0
	AddPt "Polarity", 13, 1.3, 0

	addpt "Velocity", 0, 0,         1
	addpt "Velocity", 1, 0.16, 1.06
	addpt "Velocity", 2, 0.41,         1.05
	addpt "Velocity", 3, 0.53,         1'0.982
	addpt "Velocity", 4, 0.702, 0.968
	addpt "Velocity", 5, 0.95,  0.968
	addpt "Velocity", 6, 1.03,         0.945

        LF.Object = LeftFlipper        
        LF.EndPoint = EndPointLp
        RF.Object = RightFlipper
        RF.EndPoint = EndPointRp
		'LF2.Object = LeftFlipper2        
       'LF2.EndPoint = EndPointLp2
       'RF2.Object = RightFlipper2
       'RF2.EndPoint = EndPointRp2
		'LF3.Object = LeftFlipper3        
       'LF3.EndPoint = EndPointLp3
       'RF3.Object = RightFlipper3
       'RF3.EndPoint = EndPointRp3
End Sub
'
'
'
'
'*******************************************
'' Early 90's and after
'
'Sub InitPolarity()
'        dim x, a : a = Array(LF, RF, LF2, RF2, LF3, RF3)
'        for each x in a
'                x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 1        'disabled
'                x.AddPoint "Ycoef", 1, RightFlipper.Y-11, 1
'                x.enabled = True
'                x.TimeDelay = 60
'        Next
'
'        AddPt "Polarity", 0, 0, 0
'        AddPt "Polarity", 1, 0.05, -5.5
'        AddPt "Polarity", 2, 0.4, -5.5
'        AddPt "Polarity", 3, 0.6, -5.0
'        AddPt "Polarity", 4, 0.65, -4.5
'        AddPt "Polarity", 5, 0.7, -4.0
'        AddPt "Polarity", 6, 0.75, -3.5
'        AddPt "Polarity", 7, 0.8, -3.0
'        AddPt "Polarity", 8, 0.85, -2.5
'        AddPt "Polarity", 9, 0.9,-2.0
'        AddPt "Polarity", 10, 0.95, -1.5
'        AddPt "Polarity", 11, 1, -1.0
'        AddPt "Polarity", 12, 1.05, -0.5
'        AddPt "Polarity", 13, 1.1, 0
'        AddPt "Polarity", 14, 1.3, 0
'
'        addpt "Velocity", 0, 0,         1
'        addpt "Velocity", 1, 0.16, 1.06
'        addpt "Velocity", 2, 0.41,         1.05
'        addpt "Velocity", 3, 0.53,         1'0.982
'        addpt "Velocity", 4, 0.702, 0.968
'        addpt "Velocity", 5, 0.95,  0.968
'        addpt "Velocity", 6, 1.03,         0.945
'
'        LF.Object = LeftFlipper        
'        LF.EndPoint = EndPointLp
'        RF.Object = RightFlipper
'        RF.EndPoint = EndPointRp
'		'LF2.Object = LeftFlipper2        
'       'LF2.EndPoint = EndPointLp2
'       'RF2.Object = RightFlipper2
'       'RF2.EndPoint = EndPointRp2
'		'LF3.Object = LeftFlipper3        
'       'LF3.EndPoint = EndPointLp3
'       'RF3.Object = RightFlipper3
'       'RF3.EndPoint = EndPointRp3
'End Sub


' Flipper trigger hit subs
Sub TriggerLF_Hit() : LF.Addball activeball : End Sub
Sub TriggerLF_UnHit() : LF.PolarityCorrect activeball : End Sub
Sub TriggerRF_Hit() : RF.Addball activeball : End Sub
Sub TriggerRF_UnHit() : RF.PolarityCorrect activeball : End Sub
'Sub TriggerLF2_Hit() : LF.Addball activeball : End Sub
'Sub TriggerLF2_UnHit() : LF.PolarityCorrect activeball : End Sub
'Sub TriggerRF2_Hit() : RF.Addball activeball : End Sub
'Sub TriggerRF2_UnHit() : RF.PolarityCorrect activeball : End Sub
'Sub TriggerLF3_Hit() : LF.Addball activeball : End Sub
'Sub TriggerLF3_UnHit() : LF.PolarityCorrect activeball : End Sub
'Sub TriggerRF3_Hit() : RF.Addball activeball : End Sub
'Sub TriggerRF3_UnHit() : RF.PolarityCorrect activeball : End Sub

'Methods:
'.TimeDelay - Delay before trigger shuts off automatically. Default = 80 (ms)
'.AddPoint - "Polarity", "Velocity", "Ycoef" coordinate points. Use one of these 3 strings, keep coordinates sequential. x = %position on the flipper, y = output
'.Object - set to flipper reference. Optional.
'.StartPoint - set start point coord. Unnecessary, if .object is used.

'Called with flipper - 
'ProcessBalls - catches ball data. 
' - OR - 
'.Fire - fires flipper.rotatetoend automatically + processballs. Requires .Object to be set to the flipper.


'******************************************************
'  FLIPPER CORRECTION FUNCTIONS
'******************************************************

Sub AddPt(aStr, idx, aX, aY)        'debugger wrapper for adjusting flipper script in-game
	dim a : a = Array(LF, RF, LF1, RF1, LF2, RF2)
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

'********Triggered by a ball hitting the flipper trigger area
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

'*********Used to rotate flipper since this is removed from the key down for the flippers
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
		PartialFlipCoef = ((Flipper.StartAngle - Flipper.CurrentAngle) / (Flipper.StartAngle - Flipper.EndAngle))   '% of flipper swing
		PartialFlipCoef = abs(PartialFlipCoef-1)
	End Sub

'***********gameTime is a global variable of how long the game has progressed in ms
'***********This function lets the table know if the flipper has been fired
	Private Function FlipperOn() : if gameTime < FlipAt+TimeDelay then FlipperOn = True : End If : End Function        'Timer shutoff for polaritycorrect

'***********This is turned on when a ball leaves the flipper trigger area
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
				Set a(aCount) = aArray(x)   'Set creates an object in VB
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
'**********Takes in more than one array and passes them to ShuffleArray
Sub ShuffleArrays(aArray1, aArray2, offset)
	ShuffleArray aArray1, offset
	ShuffleArray aArray2, offset
End Sub

' Used for flipper correction, rubber dampeners, and drop targets
'**********Calculate ball speed as hypotenuse of velX/velY triangle
Function BallSpeed(ball) 'Calculates the ball speed
	BallSpeed = SQR(ball.VelX^2 + ball.VelY^2 + ball.VelZ^2)
End Function

' Used for flipper correction and rubber dampeners
'**********Calculates the value of Y for an input x using the slope intercept equation
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
'********Interpolates the value for areas between the low and upper bounds sent to it
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
	Dim b, BOT
	BOT = GetBalls

	If Flipper1.currentangle = Endangle1 and EOSNudge1 <> 1 Then
		EOSNudge1 = 1
		debug.print Flipper1.currentangle &" = "& Endangle1 &"--"& Flipper2.currentangle &" = "& EndAngle2
		If Flipper2.currentangle = EndAngle2 Then 
			For b = 0 to Ubound(BOT)
				If FlipperTrigger(BOT(b).x, BOT(b).y, Flipper1) Then
					Debug.Print "ball in flip1. exit"
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
		If Abs(Flipper1.currentangle) > Abs(EndAngle1) + 30 then EOSNudge1 = 0
	End If
End Sub

'*****************
' Maths
'*****************
'Dim PI: PI = 4*Atn(1)

Function dSin(degrees)
	dsin = sin(degrees * Pi/180)
End Function

Function dCos(degrees)
	dcos = cos(degrees * Pi/180)
End Function

'Function Atn2(dy, dx)
'	If dx > 0 Then
'		Atn2 = Atn(dy / dx)
'	ElseIf dx < 0 Then
'		If dy = 0 Then 
'			Atn2 = pi
'		Else
'			Atn2 = Sgn(dy) * (pi - Atn(Abs(dy / dx)))
'		end if
'	ElseIf dx = 0 Then
'		if dy = 0 Then
'			Atn2 = 0
'		else
'			Atn2 = Sgn(dy) * pi / 2
'		end if
'	End If
'End Function

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

'Function AnglePP(ax,ay,bx,by)
'	AnglePP = Atn2((by - ay),(bx - ax))*180/PI
'End Function

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
dim RFEndAngle, LFEndAngle, LF1EndAngle, RF1EndAngle

'Const FlipperCoilRampupMode = 1   	'0 = fast, 1 = medium, 2 = slow (tap passes should work)

LFState = 1
RFState = 1
EOST = leftflipper.eostorque			'End of Swing Torque
EOSA = leftflipper.eostorqueangle		'End of Swing Torque Angle
Frampup = LeftFlipper.rampup			'Flipper Stregth Ramp Up
FElasticity = LeftFlipper.elasticity	'Flipper Elasticity
FReturn = LeftFlipper.return			'Flipper Return Strength
'Const EOSTnew = 1 'EM's to late 80's
Const EOSTnew = 0.8 '90's and later
Const EOSAnew = 1
Const EOSRampup = 0
Dim SOSRampup
Select Case FlipperCoilRampupMode 		'determines strength of coil field at start of swing
	Case 0:
		SOSRampup = 2.5
	Case 1:
		SOSRampup = 6
	Case 2:
		SOSRampup = 8.5
End Select

Const LiveCatch = 16					'variable to check elapsed time
Const LiveElasticity = 0.45
Const SOSEM = 0.815						
'Const EOSReturn = 0.055  'EM's
'Const EOSReturn = 0.045  'late 70's to mid 80's
Const EOSReturn = 0.035  'mid 80's to early 90's
'Const EOSReturn = 0.025  'mid 90's and later

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
	'What this code does is swing the flipper fast and make the flipper soft near its EOS to enable live catches.  It resets back to the base Table
	'settings once the flipper reaches the end of swing.  The code also makes the flipper starting ramp up high to simulate the stronger starting
	'coil strength and weaker at its EOS to simulate the weaker hold coil.

	Dim Dir
	Dir = Flipper.startangle/Abs(Flipper.startangle)        '-1 for Right Flipper

	If Abs(Flipper.currentangle) > Abs(Flipper.startangle) - 0.05 Then  'If the flipper has started its swing, make it swing fast to nearly the end...
		If FState <> 1 Then
			Flipper.rampup = SOSRampup 									'set flipper Ramp Up high
			Flipper.endangle = FEndAngle - 3*Dir						'swing to within 3 degrees of EOS
			Flipper.Elasticity = FElasticity * SOSEM					'Set the elasticity to the base table elasticity
			FCount = 0 
			FState = 1
		End If
	ElseIf Abs(Flipper.currentangle) <= Abs(Flipper.endangle) and FlipperPress = 1 then   'If the flipper is fully swung and the flipper button is pressed then
		if FCount = 0 Then FCount = GameTime				'notes the Game Time to see if a live catch is possible

		If FState <> 2 Then
			Flipper.eostorqueangle = EOSAnew				'sets flipper EOS Torque Angle to .2 
			Flipper.eostorque = EOSTnew						'sets flipper EOS Torque to 1
			Flipper.rampup = EOSRampup                        
			Flipper.endangle = FEndAngle
			FState = 2
		End If
	Elseif Abs(Flipper.currentangle) > Abs(Flipper.endangle) + 0.01 and FlipperPress = 1 Then 'If the flipper has swung past it's end of swing then..
		If FState <> 3 Then													
			Flipper.eostorque = EOST        								'set the flipper EOS Torque back to the base table setting
			Flipper.eostorqueangle = EOSA									'set the flipper EOS Torque Angle back to the base table setting
			Flipper.rampup = Frampup										'set the flipper Ramp Up back to the base table setting
			Flipper.Elasticity = FElasticity								'set the flipper Elasticity back to the base table setting
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
        If Abs(Flipper.currentangle) <= Abs(Flipper.endangle) + 1 Then FlippersD.Dampenf Activeball, parm
	End If
End Sub

'**************************************************
'        Flipper Collision Subs
'NOTE: COpy and overwrite collision sound from original collision subs over
'RandomSoundFlipper()' below
'**************************************************'

'Sub LeftFlipper_Collide(parm)
'    CheckLiveCatch Activeball, LeftFlipper, LFCount, parm
'    'RandomSoundFlipper() 'Remove this line if Fleep is integrated
'    LeftFlipperCollide parm   'This is the Fleep code
'End Sub
'
'Sub RightFlipper_Collide(parm)
'    CheckLiveCatch Activeball, RightFlipper, RFCount, parm
'    'RandomSoundFlipper() 'Remove this line if Fleep is integrated
'    RightFlipperCollide parm  'This is the Fleep code
'End Sub

' iaakki Rubberizer
sub Rubberizer(parm)
	if parm < 10 And parm > 2 And Abs(activeball.angmomz) < 10 then
		'debug.print "parm: " & parm & " momz: " & activeball.angmomz &" vely: "& activeball.vely
		activeball.angmomz = activeball.angmomz * 1.2
		activeball.vely = activeball.vely * 1.2
		'debug.print ">> newmomz: " & activeball.angmomz&" newvely: "& activeball.vely
	Elseif parm <= 2 and parm > 0.2 Then
		'debug.print "* parm: " & parm & " momz: " & activeball.angmomz &" vely: "& activeball.vely
		activeball.angmomz = activeball.angmomz * -1.1
		activeball.vely = activeball.vely * 1.4
		'debug.print "**** >> newmomz: " & activeball.angmomz&" newvely: "& activeball.vely
	end if
end sub

' apophis rubberizer
sub Rubberizer2(parm)
	if parm < 10 And parm > 2 And Abs(activeball.angmomz) < 10 then
		'debug.print "parm: " & parm & " momz: " & activeball.angmomz &" vely: "& activeball.vely
		activeball.angmomz = -activeball.angmomz * 2
		activeball.vely = activeball.vely * 1.2
		'debug.print ">> newmomz: " & activeball.angmomz&" newvely: "& activeball.vely
	Elseif parm <= 2 and parm > 0.2 Then
		'debug.print "* parm: " & parm & " momz: " & activeball.angmomz &" vely: "& activeball.vely
		activeball.angmomz = -activeball.angmomz * 0.5
		activeball.vely = activeball.vely * (1.2 + rnd(1)/3 )
		'debug.print "**** >> newmomz: " & activeball.angmomz&" newvely: "& activeball.vely
	end if
end sub

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
End Sub

Sub dSleeves_Hit(idx) 
	SleevesD.Dampen Activeball
End Sub

'*********This sets up the rubbers:
dim RubbersD : Set RubbersD = new Dampener     'Makes a Dampener Class Object 
RubbersD.name = "Rubbers"
RubbersD.debugOn = False        'shows info in textbox "TBPout"
RubbersD.Print = False        'debug, reports in debugger (in vel, out cor)
'cor bounce curve (linear)
'for best results, try to match in-game velocity as closely as possible to the desired curve
'RubbersD.addpoint 0, 0, 0.935        'point# (keep sequential), ballspeed, CoR (elasticity)
RubbersD.addpoint 0, 0, 1.1        'point# (keep sequential), ballspeed, CoR (elasticity)
RubbersD.addpoint 1, 3.77, 0.97
RubbersD.addpoint 2, 5.76, 0.967        'dont take this as gospel. if you can data mine rubber elasticitiy, please help!
RubbersD.addpoint 3, 15.84, 0.874
RubbersD.addpoint 4, 56, 0.64        'there's clamping so interpolate up to 56 at least

dim SleevesD : Set SleevesD = new Dampener        'this is just rubber but cut down to 85%...
SleevesD.name = "Sleeves"
SleevesD.debugOn = False        'shows info in textbox "TBPout"
SleevesD.Print = False        'debug, reports in debugger (in vel, out cor)
SleevesD.CopyCoef RubbersD, 0.85

'######################### Add new FlippersD Profile
'#########################    Adjust these values to increase or lessen the elasticity

dim FlippersD : Set FlippersD = new Dampener
FlippersD.name = "Flippers"
FlippersD.debugOn = False
FlippersD.Print = False	
FlippersD.addpoint 0, 0, 1.1	
FlippersD.addpoint 1, 3.77, 0.99
FlippersD.addpoint 2, 6, 0.99

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
'       		 Uses the LinearEnvelope function to calculate the correction based upon where it's value sits in relation
'       		 to the addpoint parameters set above.  Basically interpolates values between set points in a linear fashion
		DesiredCor = LinearEnvelope(cor.ballvel(aBall.id), ModIn, ModOut )
'       		 Uses the function BallSpeed's value at the point of impact/the active ball's velocity which is constantly being updated	
'				 RealCor is always less than 1 
		RealCOR = BallSpeed(aBall) / (cor.ballvel(aBall.id)+0.0001)
'                Divides the desired CoR by the real COR to make a multiplier to correct velocity in x and y
		coef = desiredcor / realcor 
		if debugOn then str = name & " in vel:" & round(cor.ballvel(aBall.id),2 ) & vbnewline & "desired cor: " & round(desiredcor,4) & vbnewline & _
		"actual cor: " & round(realCOR,4) & vbnewline & "ballspeed coef: " & round(coef, 3) & vbnewline 
		if Print then debug.print Round(cor.ballvel(aBall.id),2) & ", " & round(desiredcor,3)
'             	  Applies the coef to x and y velocities
		aBall.velx = aBall.velx * coef : aBall.vely = aBall.vely * coef
		if debugOn then TBPout.text = str
	End Sub

	public sub Dampenf(aBall, parm) 'Rubberizer is handled here
		dim RealCOR, DesiredCOR, str, coef
		DesiredCor = LinearEnvelope(cor.ballvel(aBall.id), ModIn, ModOut )
		RealCOR = BallSpeed(aBall) / (cor.ballvel(aBall.id)+0.0001)
		coef = desiredcor / realcor 
		If abs(aball.velx) < 2 and aball.vely < 0 and aball.vely > -3.75 then 
			aBall.velx = aBall.velx * coef : aBall.vely = aBall.vely * coef
		End If
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
'*********CoR is Coefficient of Restitution defined as "how much of the kinetic energy remains for the objects 
'to rebound from one another vs. how much is lost as heat, or work done deforming the objects 
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

' Note, cor.update must be called in a 10 ms timer. The example table uses the GameTimer for this purpose, but sometimes a dedicated timer call RDampen is used.
'
Sub RDampen_Timer
	Cor.Update
End Sub

'******************************************************
'  END NFOZZY PHYSICS
'******************************************************
'//////////////////////////////////////////////////////////////////////
'// Mechanic Sounds
'//////////////////////////////////////////////////////////////////////

' This part in the script is an entire block that is dedicated to the physics sound system.
' Various scripts and sounds that may be pretty generic and could suit other WPC systems, but the most are tailored specifically for the TOM table

' Many of the sounds in this package can be added by creating collections and adding the appropriate objects to those collections.  
' Create the following new collections:
' 	Metals (all metal objects, metal walls, metal posts, metal wire guides)
' 	Apron (the apron walls and plunger wall)
' 	Walls (all wood or plastic walls)
' 	Rollovers (wire rollover triggers, star triggers, or button triggers)
' 	Targets (standup or drop targets, these are hit sounds only ... you will want to add separate dropping sounds for drop targets)
' 	Gates (plate gates)
' 	GatesWire (wire gates)
' 	Rubbers (all rubbers including posts, sleeves, pegs, and bands)
' When creating the collections, make sure "Fire events for this collection" is checked.  
' You'll also need to make sure "Has Hit Event" is checked for each object placed in these collections (not necessary for gates and triggers).  
' Once the collections and objects are added, the save, close, and restart VPX.
'
' Tutorial vides by Apophis
' Part 1: 	https://youtu.be/PbE2kNiam3g
' Part 2: 	https://youtu.be/B5cm1Y8wQsk
' Part 3: 	https://youtu.be/eLhWyuYOyGg


'///////////////////////////////  SOUNDS PARAMETERS  //////////////////////////////
Dim GlobalSoundLevel, CoinSoundLevel, PlungerReleaseSoundLevel, PlungerPullSoundLevel, NudgeLeftSoundLevel
Dim NudgeRightSoundLevel, NudgeCenterSoundLevel, StartButtonSoundLevel, RollingSoundFactor

CoinSoundLevel = 1														'volume level; range [0, 1]
NudgeLeftSoundLevel = 1													'volume level; range [0, 1]
NudgeRightSoundLevel = 1												'volume level; range [0, 1]
NudgeCenterSoundLevel = 1												'volume level; range [0, 1]
StartButtonSoundLevel = 0.1												'volume level; range [0, 1]
PlungerReleaseSoundLevel = 0.8 '1 wjr											'volume level; range [0, 1]
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
RubberFlipperSoundFactor = 0.075/5										'volume multiplier; must not be zero
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
TargetSoundFactor = 0.0025 * 10											'volume multiplier; must not be zero
DTSoundLevel = 0.25														'volume multiplier; must not be zero
RolloverSoundLevel = 0.25                              					'volume level; range [0, 1]
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

Function AudioFade(tableobj) ' Fades between front and back of the table (for surround systems or 2x2 speakers, etc), depending on the Y position on the table. "bttf" is the name of the table
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

Function AudioPan(tableobj) ' Calculates the pan for a tableobj based on the X position on the table. "bttf" is the name of the table
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
'********************************************
'*   LUT Selector
'********************************************																																				"

dim textindex : textindex = 1
dim charobj(55), glyph(201)
InitDisplayText

Sub myChangeLut
	bttf.ColorGradeImage = luts(lutpos)
	DisplayText lutpos, luts(lutpos)
	vpmTimer.AddTimer 2000, "If lutpos = " & lutpos & " then for anr = 10 to 54 : charobj(anr).visible = 0 : next'"
End Sub

Sub InitDisplayText
	Dim anr
	For anr = 10 to 54 : set charobj(anr) = eval("text0" & anr) : charobj(anr).visible = 0 : Next
	For anr = 32 to 96 : glyph(anr) = anr : next
	For anr = 0 to 31 : glyph(anr) = 32 : next
	for anr = 97 to 122 : glyph(anr)  = anr - 32 : next
	for anr = 123 to 200 : glyph(anr) = 32 : next
End Sub

Sub DisplayText(nr, luttext)
	dim tekst, anr
	for anr = 10 to 54 : charobj(anr).imageA = 32 : charobj(anr).visible = 1 : next
	If nr > -1 then
		tekst = "lutpos:" & nr
		For anr = 1 to len(tekst) : charobj(43 + anr).imageA = glyph(asc(mid(tekst, anr, 1))) : Next
	End If
	For anr = 1 to len(luttext)
		charobj(9 + anr).imageA = glyph(asc(mid(luttext, anr, 1)))
		If nr = -1 Then
			charobj(9 + anr).y = 1500 + sin(((textindex * 4 + anr)/20)*3.14) * 100
			charobj(9 + anr).height = 150 + cos(((textindex * 4 + anr)/20)*3.14) * 100
		End If
	Next
End Sub

Sub SetLUT
	'bttf.ColorGradeImage = "LUT" & LUTset
	bttf.ColorGradeImage = luts(lutpos)
end sub 

Sub SaveLUT

	Dim FileObj
	Dim ScoreFile

	Set FileObj=CreateObject("Scripting.FileSystemObject")
	If Not FileObj.FolderExists(UserDirectory) then 
		Exit Sub
	End if

	if lutpos = "" then lutpos = 0 'failsafe

	Set ScoreFile=FileObj.CreateTextFile(UserDirectory & "SLUT_" & cGameName & ".txt",True)
	ScoreFile.WriteLine lutpos 'la réf dans le txt
	Set ScoreFile=Nothing
	Set FileObj=Nothing

End Sub

Sub LoadLUT

	Dim FileObj, ScoreFile, TextStr
	dim rLine

	Set FileObj=CreateObject("Scripting.FileSystemObject")
	If Not FileObj.FolderExists(UserDirectory) then 
		If RenderingMode = 2 Then
			lutpos = 26 ' Less Reddish tint in VR with this LUT default
		Else
			lutpos = 1
		End If
		Exit Sub
	End if
	If Not FileObj.FileExists(UserDirectory & "SLUT_" & cGameName & ".txt") then
		If RenderingMode = 2 Then
			lutpos = 26 ' Less Reddish tint in VR with this LUT default
		Else
			lutpos = 1
		End If
		Exit Sub
	End if
	Set ScoreFile=FileObj.GetFile(UserDirectory & "SLUT_" & cGameName & ".txt")
	Set TextStr=ScoreFile.OpenAsTextStream(1,0)
		If (TextStr.AtEndOfStream=True) then
			Exit Sub
		End if
		rLine = TextStr.ReadLine
		If rLine = "" then
			If RenderingMode = 2 Then
				lutpos = 26 ' Less Reddish tint in VR with this LUT default
			Else
				lutpos = 1
			End If
			Exit Sub
		End if
		lutpos = int (rLine) 
		Set ScoreFile = Nothing
	    Set FileObj = Nothing
End Sub
'********************************************	
'***************************************************************
'****  VPW DYNAMIC BALL SHADOWS by Iakki, Apophis, and Wylte
'***************************************************************

'****** INSTRUCTIONS please read ******

'****** Part A:  Table Elements ******
'
' Import the "bsrtx7" and "ballshadow" images
' Import the shadow materials file (3 sets included) (you can also export the 3 sets from this table to create the same file)
' Copy in the BallShadowA flasher set and the sets of primitives named BallShadow#, RtxBallShadow#, and RtxBall2Shadow#
'	* with at least as many objects each as there can be balls, including locked balls
' Ensure you have a timer with a -1 interval that is always running

' Create a collection called DynamicSources that includes all light sources you want to cast ball shadows
'***These must be organized in order, so that lights that intersect on the table are adjacent in the collection***
'***If there are more than 3 lights that overlap in a playable area, exclude the less important lights***
' This is because the code will only project two shadows if they are coming from lights that are consecutive in the collection, and more than 3 will cause "jumping" between which shadows are drawn
' The easiest way to keep track of this is to start with the group on the right slingshot and move anticlockwise around the table
'	For example, if you use 6 lights: A & B on the left slingshot and C & D on the right, with E near A&B and F next to C&D, your collection would look like EBACDF
'
'G				H											^	E
'															^	B
'	A		 C												^	A
'	 B		D			your collection should look like	^	G		because E&B, B&A, etc. intersect; but B&D or E&F do not
'  E		  F												^	H
'															^	C
'															^	D
'															^	F
'		When selecting them, you'd shift+click in this order^^^^^

'****** End Part A:  Table Elements ******


'****** Part B:  Code and Functions ******

' *** Timer sub
' The "DynamicBSUpdate" sub should be called by a timer with an interval of -1 (framerate)
Sub FrameTimer_Timer()
	If DynamicBallShadowsOn Or AmbientBallShadowOn Then DynamicBSUpdate 'update ball shadows
End Sub

' *** These are usually defined elsewhere (ballrolling), but activate here if necessary
'Const tnob = 10 ' total number of balls
'Const lob = 0	'locked balls on start; might need some fiddling depending on how your locked balls are done
'Dim tablewidth: tablewidth = bttf.width
'Dim tableheight: tableheight = bttf.height

' *** User Options - Uncomment here or move to top
'----- Shadow Options -----
'Const DynamicBallShadowsOn = 1		'0 = no dynamic ball shadow ("triangles" near slings and such), 1 = enable dynamic ball shadow
'Const AmbientBallShadowOn = 1		'0 = Static shadow under ball ("flasher" image, like JP's)
'									'1 = Moving ball shadow ("primitive" object, like ninuzzu's) - This is the only one that shows up on the pf when in ramps and fades when close to lights!
'									'2 = flasher image shadow, but it moves like ninuzzu's

Const fovY					= 0		'Offset y position under ball to account for layback or inclination (more pronounced need further back)
Const DynamicBSFactor 		= 0.95	'0 to 1, higher is darker
Const AmbientBSFactor 		= 0.97	'0 to 1, higher is darker
Const AmbientMovement		= 2		'1 to 4, higher means more movement as the ball moves left and right
Const Wideness				= 20	'Sets how wide the dynamic ball shadows can get (20 +5 thinness should be most realistic for a 50 unit ball)
Const Thinness				= 5		'Sets minimum as ball moves away from source


' *** This segment goes within the RollingUpdate sub, so that if Ambient...=0 and Dynamic...=0 the entire DynamicBSUpdate sub can be skipped for max performance
'	' stop the sound of deleted balls
'	For b = UBound(BOT) + 1 to tnob
'		If AmbientBallShadowOn = 0 Then BallShadowA(b).visible = 0
'		...rolling(b) = False
'		...StopSound("BallRoll_" & b)
'	Next
'
'...rolling and drop sounds...

'		If DropCount(b) < 5 Then
'			DropCount(b) = DropCount(b) + 1
'		End If
'
'		' "Static" Ball Shadows
'		If AmbientBallShadowOn = 0 Then
'			If BOT(b).Z > 30 Then
'				BallShadowA(b).height=BOT(b).z - BallSize/4		'This is technically 1/4 of the ball "above" the ramp, but it keeps it from clipping
'			Else
'				BallShadowA(b).height=BOT(b).z - BallSize/2 + 5
'			End If
'			BallShadowA(b).Y = BOT(b).Y + Ballsize/5 + fovY
'			BallShadowA(b).X = BOT(b).X
'			BallShadowA(b).visible = 1
'		End If

' *** Required Functions, enable these if they are not already present elswhere in your table
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

'Dim PI: PI = 4*Atn(1)

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

Function AnglePP(ax,ay,bx,by)
	AnglePP = Atn2((by - ay),(bx - ax))*180/PI
End Function

'****** End Part B:  Code and Functions ******


'****** Part C:  The Magic ******
Dim sourcenames, currentShadowCount, DSSources(30), numberofsources, numberofsources_hold
sourcenames = Array ("","","","","","","","","","","","")
currentShadowCount = Array (0,0,0,0,0,0,0,0,0,0,0,0)

' *** Trim or extend these to match the number of balls/primitives/flashers on the table!
dim objrtx1(12), objrtx2(12)
dim objBallShadow(12)
Dim BallShadowA
BallShadowA = Array (BallShadowA0,BallShadowA1,BallShadowA2,BallShadowA3,BallShadowA4,BallShadowA5,BallShadowA6,BallShadowA7,BallShadowA8,BallShadowA9,BallShadowA10,BallShadowA11)

DynamicBSInit

sub DynamicBSInit()
	Dim iii, source

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

	iii = 0

	For Each Source in DynamicSources
		DSSources(iii) = Array(Source.x, Source.y)
		iii = iii + 1
	Next
	numberofsources = iii
	numberofsources_hold = iii
end sub


Sub DynamicBSUpdate
	Dim falloff:	falloff = 150			'Max distance to light sources, can be changed if you have a reason
	Dim ShadowOpacity, ShadowOpacity2 
	Dim s, Source, LSd, currentMat, AnotherSource, BOT, iii
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
				For iii = 0 to numberofsources - 1 
					LSd=DistanceFast((BOT(s).x-DSSources(iii)(0)),(BOT(s).y-DSSources(iii)(1)))	'Calculating the Linear distance to the Source
					If LSd < falloff And gilvl > 0 Then						    'If the ball is within the falloff range of a light and light is on (we will set numberofsources to 0 when GI is off)
						currentShadowCount(s) = currentShadowCount(s) + 1		'Within range of 1 or 2
						if currentShadowCount(s) = 1 Then						'1 dynamic shadow source
							sourcenames(s) = iii
							currentMat = objrtx1(s).material
							objrtx2(s).visible = 0 : objrtx1(s).visible = 1 : objrtx1(s).X = BOT(s).X : objrtx1(s).Y = BOT(s).Y + fovY
	'						objrtx1(s).Z = BOT(s).Z - 25 + s/1000 + 0.01						'Uncomment if you want to add shadows to an upper/lower pf
							objrtx1(s).rotz = AnglePP(DSSources(iii)(0), DSSources(iii)(1), BOT(s).X, BOT(s).Y) + 90
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
							AnotherSource = sourcenames(s)
							objrtx1(s).visible = 1 : objrtx1(s).X = BOT(s).X : objrtx1(s).Y = BOT(s).Y + fovY
	'						objrtx1(s).Z = BOT(s).Z - 25 + s/1000 + 0.01							'Uncomment if you want to add shadows to an upper/lower pf
							objrtx1(s).rotz = AnglePP(DSSources(AnotherSource)(0),DSSources(AnotherSource)(1), BOT(s).X, BOT(s).Y) + 90
							ShadowOpacity = (falloff-DistanceFast((BOT(s).x-DSSources(AnotherSource)(0)),(BOT(s).y-DSSources(AnotherSource)(1))))/falloff
							objrtx1(s).size_y = Wideness*ShadowOpacity+Thinness
							UpdateMaterial currentMat,1,0,0,0,0,0,ShadowOpacity*DynamicBSFactor^3,RGB(0,0,0),0,0,False,True,0,0,0,0

							currentMat = objrtx2(s).material
							objrtx2(s).visible = 1 : objrtx2(s).X = BOT(s).X : objrtx2(s).Y = BOT(s).Y + fovY
	'						objrtx2(s).Z = BOT(s).Z - 25 + s/1000 + 0.02							'Uncomment if you want to add shadows to an upper/lower pf
							objrtx2(s).rotz = AnglePP(DSSources(iii)(0), DSSources(iii)(1), BOT(s).X, BOT(s).Y) + 90
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
'****************************************************************
'  GI
'****************************************************************
dim gilvl:gilvl = 1
Sub ToggleGI(Enabled)
	dim xx
	If enabled Then
		for each xx in GI:xx.state = 1:Next
		gilvl = 1
	Else
		for each xx in GI:xx.state = 0:Next	
		GITimer.enabled = True
		gilvl = 0
	End If
	Sound_GI_Relay enabled, bumper1
End Sub

Sub GITimer_Timer()
	me.enabled = False
	ToggleGI 1
End Sub
'****************************************************************
'  END GI
'****************************************************************

Sub bttf_exit()
	SaveLUT
	Controller.Stop
End Sub

'*****************************************************************
' VR PLUNGER ANIMATION
'*****************************************************************
Sub TimerAnalogPlunger_Timer
 	Primary_plunger.Y = 880 + (5* Plunger.Position) -20
End Sub

Sub TimerDigitalPlunger_Timer
  If Primary_plunger.Y < 960 then
	Primary_plunger.Y = Primary_plunger.Y + 5
  End If
End Sub

Sub Moon_Timer()
	VR_Moon.ObjRotZ=VR_Moon.ObjRotZ+.01   ' Rotate the moon.
End Sub

'******************************
'* Alpha-Numeric Display for VR
'******************************
Dim Digits(32)
Digits(0)=Array(ax00, ax05, ax0c, ax0d, ax08, ax01, ax06, ax0e, ax02, ax03, ax04, ax07, ax0b, ax0a, ax09, ax0f)
Digits(1)=Array(ax10, ax15, ax1c, ax1d, ax18, ax11, ax16, ax1e, ax12, ax13, ax14, ax17, ax1b, ax1a, ax19, ax1f)
Digits(2)=Array(ax20, ax25, ax2c, ax2d, ax28, ax21, ax26, ax2e, ax22, ax23, ax24, ax27, ax2b, ax2a, ax29, ax2f)
Digits(3)=Array(ax30, ax35, ax3c, ax3d, ax38, ax31, ax36, ax3e, ax32, ax33, ax34, ax37, ax3b, ax3a, ax39, ax3f)
Digits(4)=Array(ax40, ax45, ax4c, ax4d, ax48, ax41, ax46, ax4e, ax42, ax43, ax44, ax47, ax4b, ax4a, ax49, ax4f)
Digits(5)=Array(ax50, ax55, ax5c, ax5d, ax58, ax51, ax56, ax5e, ax52, ax53, ax54, ax57, ax5b, ax5a, ax59, ax5f)
Digits(6)=Array(ax60, ax65, ax6c, ax6d, ax68, ax61, ax66, ax6e, ax62, ax63, ax64, ax67, ax6b, ax6a, ax69, ax6f)
Digits(7)=Array(ax70, ax75, ax7c, ax7d, ax78, ax71, ax76, ax7e, ax72, ax73, ax74, ax77, ax7b, ax7a, ax79, ax7f)
Digits(8)=Array(ax80, ax85, ax8c, ax8d, ax88, ax81, ax86, ax8e, ax82, ax83, ax84, ax87, ax8b, ax8a, ax89, ax8f)
Digits(9)=Array(ax90, ax95, ax9c, ax9d, ax98, ax91, ax96, ax9e, ax92, ax93, ax94, ax97, ax9b, ax9a, ax99, ax9f)
Digits(10)=Array(axa0, axa5, axac, axad, axa8, axa1, axa6, axae, axa2, axa3, axa4, axa7, axab, axaa, axa9, axaf)
Digits(11)=Array(axb0, axb5, axbc, axbd, axb8, axb1, axb6, axbe, axb2, axb3, axb4, axb7, axbb, axba, axb9, axbf)
Digits(12)=Array(axc0, axc5, axcc, axcd, axc8, axc1, axc6, axce, axc2, axc3, axc4, axc7, axcb, axca, axc9, axcf)
Digits(13)=Array(axd0, axd5, axdc, axdd, axd8, axd1, axd6, axde, axd2, axd3, axd4, axd7, axdb, axda, axd9, axdf)
Digits(14)=Array(axe0, axe5, axec, axed, axe8, axe1, axe6, axee, axe2, axe3, axe4, axe7, axeb, axea, axe9, axef)
Digits(15)=Array(axf0, axf5, axfc, axfd, axf8, axf1, axf6, axfe, axf2, axf3, axf4, axf7, axfb, axfa, axf9, axff)
Digits(16)=Array(bx00, bx05, bx0c, bx0d, bx08, bx01, bx06, bx0e, bx02, bx03, bx04, bx07, bx0b, bx0a, bx09, bx0f)
Digits(17)=Array(bx10, bx15, bx1c, bx1d, bx18, bx11, bx16, bx1e, bx12, bx13, bx14, bx17, bx1b, bx1a, bx19, bx1f)
Digits(18)=Array(bx20, bx25, bx2c, bx2d, bx28, bx21, bx26, bx2e, bx22, bx23, bx24, bx27, bx2b, bx2a, bx29, bx2f)
Digits(19)=Array(bx30, bx35, bx3c, bx3d, bx38, bx31, bx36, bx3e, bx32, bx33, bx34, bx37, bx3b, bx3a, bx39, bx3f)
Digits(20)=Array(bx40, bx45, bx4c, bx4d, bx48, bx41, bx46, bx4e, bx42, bx43, bx44, bx47, bx4b, bx4a, bx49, bx4f)
Digits(21)=Array(bx50, bx55, bx5c, bx5d, bx58, bx51, bx56, bx5e, bx52, bx53, bx54, bx57, bx5b, bx5a, bx59, bx5f)
Digits(22)=Array(bx60, bx65, bx6c, bx6d, bx68, bx61, bx66, bx6e, bx62, bx63, bx64, bx67, bx6b, bx6a, bx69, bx6f)
Digits(23)=Array(bx70, bx75, bx7c, bx7d, bx78, bx71, bx76, bx7e, bx72, bx73, bx74, bx77, bx7b, bx7a, bx79, bx7f)
Digits(24)=Array(bx80, bx85, bx8c, bx8d, bx88, bx81, bx86, bx8e, bx82, bx83, bx84, bx87, bx8b, bx8a, bx89, bx8f)
Digits(25)=Array(bx90, bx95, bx9c, bx9d, bx98, bx91, bx96, bx9e, bx92, bx93, bx94, bx97, bx9b, bx9a, bx99, bx9f)
Digits(26)=Array(bxa0, bxa5, bxac, bxad, bxa8, bxa1, bxa6, bxae, bxa2, bxa3, bxa4, bxa7, bxab, bxaa, bxa9, bxaf)
Digits(27)=Array(bxb0, bxb5, bxbc, bxbd, bxb8, bxb1, bxb6, bxbe, bxb2, bxb3, bxb4, bxb7, bxbb, bxba, bxb9, bxbf)
Digits(28)=Array(bxc0, bxc5, bxcc, bxcd, bxc8, bxc1, bxc6, bxce, bxc2, bxc3, bxc4, bxc7, bxcb, bxca, bxc9, bxcf)
Digits(29)=Array(bxd0, bxd5, bxdc, bxdd, bxd8, bxd1, bxd6, bxde, bxd2, bxd3, bxd4, bxd7, bxdb, bxda, bxd9, bxdf)
Digits(30)=Array(bxe0, bxe5, bxec, bxed, bxe8, bxe1, bxe6, bxee, bxe2, bxe3, bxe4, bxe7, bxeb, bxea, bxe9, bxef)
Digits(31)=Array(bxf0, bxf5, bxfc, bxfd, bxf8, bxf1, bxf6, bxfe, bxf2, bxf3, bxf4, bxf7, bxfb, bxfa, bxf9, bxff)
 
Sub TiDisplay_Timer()
	Dim ChgLED, ii, num, chg, stat, obj
	If VRMode = True Then
		ChgLED=Controller.ChangedLEDs(&H00000000, &Hffffffff)
		If Not IsEmpty(ChgLED) Then
			For ii=0 To UBound(chgLED)
				num=chgLED(ii,0)
				chg=chgLED(ii,1)
				stat=chgLED(ii,2)
				For Each obj In Digits(num)
					If chg And 1 Then obj.visible=stat And 1
					chg=chg\2
					stat=stat\2
				Next
			Next
		End If
	End If
End Sub

'******************************
'VR Lighting
'******************************
VR_Mega035.blenddisablelighting = 50
VR_Mega038.blenddisablelighting = 0.5
VR_Mega040.blenddisablelighting = 0.5
VR_Mega041.blenddisablelighting = 0.5
VR_Mega042.blenddisablelighting = 0.2
VR_Sphere.blenddisablelighting = 5
VR_Mega018.blenddisablelighting = 50

'**********************************************************************************************************
' Desktop Digital Display
'**********************************************************************************************************
Dim dDigits(32)
dDigits(0)=Array(a00, a05, a0c, a0d, a08, a01, a06, a0f, a02, a03, a04, a07, a0b, a0a, a09, a0e)
dDigits(1)=Array(a10, a15, a1c, a1d, a18, a11, a16, a1f, a12, a13, a14, a17, a1b, a1a, a19, a1e)
dDigits(2)=Array(a20, a25, a2c, a2d, a28, a21, a26, a2f, a22, a23, a24, a27, a2b, a2a, a29, a2e)
dDigits(3)=Array(a30, a35, a3c, a3d, a38, a31, a36, a3f, a32, a33, a34, a37, a3b, a3a, a39, a3e)
dDigits(4)=Array(a40, a45, a4c, a4d, a48, a41, a46, a4f, a42, a43, a44, a47, a4b, a4a, a49, a4e)
dDigits(5)=Array(a50, a55, a5c, a5d, a58, a51, a56, a5f, a52, a53, a54, a57, a5b, a5a, a59, a5e)
dDigits(6)=Array(a60, a65, a6c, a6d, a68, a61, a66, a6f, a62, a63, a64, a67, a6b, a6a, a69, a6e)
dDigits(7)=Array(a70, a75, a7c, a7d, a78, a71, a76, a7f, a72, a73, a74, a77, a7b, a7a, a79, a7e)
dDigits(8)=Array(a80, a85, a8c, a8d, a88, a81, a86, a8f, a82, a83, a84, a87, a8b, a8a, a89, a8e)
dDigits(9)=Array(a90, a95, a9c, a9d, a98, a91, a96, a9f, a92, a93, a94, a97, a9b, a9a, a99, a9e)
dDigits(10)=Array(aa0, aa5, aac, aad, aa8, aa1, aa6, aaf, aa2, aa3, aa4, aa7, aab, aaa, aa9, aae)
dDigits(11)=Array(ab0, ab5, abc, abd, ab8, ab1, ab6, abf, ab2, ab3, ab4, ab7, abb, aba, ab9, abe)
dDigits(12)=Array(ac0, ac5, acc, acd, ac8, ac1, ac6, acf, ac2, ac3, ac4, ac7, acb, aca, ac9, ace)
dDigits(13)=Array(ad0, ad5, adc, adx, ad8, ad1, ad6, adf, ad2, ad3, ad4, ad7, adb, ada, ad9, ade)
dDigits(14)=Array(ae0, ae5, aec, aed, ae8, ae1, ae6, aef, ae2, ae3, ae4, ae7, aeb, aea, ae9, aee)
dDigits(15)=Array(af0, af5, afc, afd, af8, af1, af6, aff, af2, af3, af4, af7, afb, afa, af9, afe)
dDigits(16)=Array(b00, b05, b0c, b0d, b08, b01, b06, b0f, b02, b03, b04, b07, b0b, b0a, b09, b0e)
dDigits(17)=Array(b10, b15, b1c, b1d, b18, b11, b16, b1f, b12, b13, b14, b17, b1b, b1a, b19, b1e)
dDigits(18)=Array(b20, b25, b2c, b2d, b28, b21, b26, b2f, b22, b23, b24, b27, b2b, b2a, b29, b2e)
dDigits(19)=Array(b30, b35, b3c, b3d, b38, b31, b36, b3f, b32, b33, b34, b37, b3b, b3a, b39, b3e)
dDigits(20)=Array(b40, b45, b4c, b4d, b48, b41, b46, b4f, b42, b43, b44, b47, b4b, b4a, b49, b4e)
dDigits(21)=Array(b50, b55, b5c, b5d, b58, b51, b56, b5f, b52, b53, b54, b57, b5b, b5a, b59, b5e)
dDigits(22)=Array(b60, b65, b6c, b6d, b68, b61, b66, b6f, b62, b63, b64, b67, b6b, b6a, b69, b6e)
dDigits(23)=Array(b70, b75, b7c, b7d, b78, b71, b76, b7f, b72, b73, b74, b77, b7b, b7a, b79, b7e)
dDigits(24)=Array(b80, b85, b8c, b8d, b88, b81, b86, b8f, b82, b83, b84, b87, b8b, b8a, b89, b8e)
dDigits(25)=Array(b90, b95, b9c, b9d, b98, b91, b96, b9f, b92, b93, b94, b97, b9b, b9a, b99, b9e)
dDigits(26)=Array(ba0, ba5, bac, bad, ba8, ba1, ba6, baf, ba2, ba3, ba4, ba7, bab, baa, ba9, bae)
dDigits(27)=Array(bb0, bb5, bbc, bbd, bb8, bb1, bb6, bbf, bb2, bb3, bb4, bb7, bbb, bba, bb9, bbe)
dDigits(28)=Array(bc0, bc5, bcc, bcd, bc8, bc1, bc6, bcf, bc2, bc3, bc4, bc7, bcb, bca, bc9, bce)
dDigits(29)=Array(bd0, bd5, bdc, bdd, bd8, bd1, bd6, bdf, bd2, bd3, bd4, bd7, bdb, bda, bd9, bde)
dDigits(30)=Array(be0, be5, bec, bed, be8, be1, be6, bef, be2, be3, be4, be7, beb, bea, be9, bee)
dDigits(31)=Array(bf0, bf5, bfc, bfd, bf8, bf1, bf6, bff, bf2, bf3, bf4, bf7, bfb, bfa, bf9, bfe)

Sub DesktopDisplayTimer_Timer

	If DesktopMode = True and VRMode = False Then
	Dim ChgLED, ii, jj, num, chg, stat, obj, b, x
	Debug.Print "Timer Went"
	ChgLED=Controller.ChangedLEDs(&Hffffffff, &Hffffffff)
    If Not IsEmpty(ChgLED)Then
		If DesktopMode = True Then
			Debug.Print "1"
       For ii=0 To UBound(chgLED)
          num=chgLED(ii, 0) : chg=chgLED(ii, 1) : stat=chgLED(ii, 2)
			if (num < 32) then
              For Each obj In dDigits(num)
                   If chg And 1 Then obj.State=stat And 1
                   chg=chg\2 : stat=stat\2
                  Next
			Else
			       end if
        Next
		End if
	End If
	End If
End Sub

