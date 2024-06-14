;-------------------------------------[General Purpose Variables]------------------------------------

GenByteE0 :=        $E0     ;General purpose byte.
GenByteE1 :=        $E1     ;General purpose byte.

GenPtrE0 :=         $E0     ;General use pointer.
GenPtrE0LB :=       $E0     ;General use pointer, lower byte.
GenPtrE0UB :=       $E1     ;General use pointer, upper byte.

;-----------------------------------------[Variable Defines]-----------------------------------------

FightNumber :=      $01     ;The current fight number (0=GJ, 1=VK, 2=PH, ... 13=Tyson)
FightBank :=        $02     ;The memory bank containing the data for the current fight
FightOffset :=      $03     ;Offset of the current fight within its memory bank
KnockdownSts :=     $05     ;Knockdown status #$01=Opp down, #$02=Mac down
RoundNumber :=      $06     ;Current round number.
MacLosses :=        $0A     ;Number of losses on Mac's record
CurrPRGBank :=      $0D     ;The current PRG bank mapped to $8000-$9FFF
SavedPRGBank :=     $0E     ;The last PRG bank to be loaded

PPU0Load :=         $10     ;Value to load next into PPU control register 0.
PPU1Load :=         $11     ;Value to load next into PPU control register 1.

RNGValue :=         $18     ;Random number generator
InputAccum :=       $19     ;Controller 1 input accumulator

SprtBkgUpdt :=      $1B     ;MSB set=update sprite/background enable/disable.
                                ;#$80=Disable sprites and background.
                                ;#$81=Enable sprites and background.
GameEngStatus :=    $1C     ;0=Main game engine running, non-zero=Main game engine not running.
GameStatus :=       $1D     ;Enables/disables portions of the game.
                                ;#$00 - Main game engine running.
                                ;#$01 - Run game timers.
                                ;#$02 - Stop all game processing.
                                ;#$03 - Process only audio.
                                ;#$FF - Run non-playable portions of game(intro, cut scenes, etc).

FrameCounter :=     $1E     ;Increments every frame and rolls over when maxed out.
TransTimer :=       $1F     ;Countdown timer for various transitions.

CrowdCurState :=    $40     ;Crowd's current state. Set MSB=initialize new state.
CrowdStateStatus := $41     ;Status of Crowd's current state.
CrowdStateTimer :=  $42     ;Timer for Crowds current state.
CrowdStateIndex :=  $43     ;Index to Crowd current state data.
CrowdStBasePtr :=   $44     ;Pase pointer to Crowd's current state data.
CrowdStBasePtrLB := $44     ;Pase pointer to Crowd's current state data, lower byte.
CrowdStBasePtrUB := $45     ;Pase pointer to Crowd's current state data, upper byte.
CrowdStRptCntr :=   $46     ;Counter used to repeat the Crowd's current state.


ComboTimer :=       $4A     ;Frames left until another punch must be landed to keep combo alive.
ComboCountDown :=   $4B     ;Hits left in current combo.

MacStatus :=        $50     ;Status of Little Mac during a fight. MSB set=status update.
MacStateStatus :=   $51     ;Status of Mac's current state
MacStateTimer :=    $52     ;Timer for Mac's current state.
MacStateIndex :=    $53     ;Index to Mac's current state data.
MacStBasePtr :=     $54     ;Base pointer to Mac's current state data.
MacStBasePtrLB :=   $54     ;Base pointer to Mac's current state data, lower byte.
MacStBasePtrUB :=   $55     ;Base pointer to Mac's current state data, upper byte.
MacStateRptCntr :=  $56     ;Counter used to repeat Mac's current state.

MacPunchType :=     $74     ;Little Mac punch type.
                                ;#$00=Right punch to face.
                                ;#$01=Left punch to face.
                                ;#$02=Right punch to stomach.
                                ;#$03=Left punch to stomach.
                                ;#$80=Super punch.
MacPunchDamage :=   $75     ;The amount of damage Little Mac's puch will do to opponent.
MacDefense1 :=      $76     ;Little Mac's defense. there are 2 values but they are always -->
MacDefense2 :=      $77     ;written to the same value. Maybe there was plans for a left and -->
                                ;right defense? #$FF=Dodge, #$08=Block, #$80=Duck.

MacKDRound :=       $8F     ;How many times has Mac been knocked down this round?

OppCurState :=      $90     ;Opponent's current state. Set MSB=initialize new state.
OppStateStatus :=   $91     ;Status of opponent's current state.
OppStateTimer :=    $92     ;Timer for opponents current state.
OppStateIndex :=    $93     ;Index to opponent current state data.
OppStBasePtr :=     $94     ;Pase pointer to opponent's current state data.
OppStBasePtrLB :=   $94     ;Pase pointer to opponent's current state data, lower byte.
OppStBasePtrUB :=   $95     ;Pase pointer to opponent's current state data, upper byte.
OppStRepeatCntr :=  $96     ;Counter used to repeat the opponent's current state.
OppPunching :=      $97     ;#$00=Opponent not punching, #$01=Opponent punching.
OppPunchSts :=      $98     ;Same as OppLastPunchSts except #$80=punch active.

OppAnimSeg :=       $9A     ;Number of timed segments in opponent's current animation.
OppAnimSegTimer :=  $9B     ;Number of frames per segment in Opponent's animation.
OppOutlineTimer :=  $9C     ;Timer for dodge indicator outline color. MSB set=set timer.
OppIndexReturn :=   $9D     ;Restore value of OppStateIndex after function return.
OppPtrReturnLB :=   $9E     ;Restore value of OppStBasePtrLB after function return.
OppPtrReturnUB :=   $9F     ;Restore value of OppStBasePtrUB after function return.
OppAnimFlags :=     $A0     ;MSB set=Change opponent sprites, LSB set=Move opponent on screen.
OppBaseAnimIndex := $A1     ;Base animation index for opponent sprites.

OppBaseSprite :=    $B0     ;Base address for opponent sprite X,Y positions.
OppBaseXSprite :=   $B0     ;Base X position for opponent sprites.
OppBaseYSprite :=   $B1     ;Base Y position for opponent sprites.

OppPunchSide :=     $B4     ;#$00=Punching Little Mac's left side, #$01=Little Mac's right side.
OppPunchDamage :=   $B5     ;The amount of damage the current punch will do to Little Mac.
OppHitDefense :=    $B6     ;Base address to opponent defense to Little Mac's various punches.
OppHitDefenseUR :=  $B6     ;Amount to subtract from Little Mac right punch to face damage.
OppHitDefenseUL :=  $B7     ;Amount to subtract from Little Mac left punch to face damage.
OppHitDefenseLR :=  $B8     ;Amount to subtract from Little Mac right punch to stomach damage.
OppHitDefenseLL :=  $B9     ;Amount to subtract from Little Mac left punch to stomach damage.

GameStatusBB :=     $BB     ;Various game statuses.
                                ;#$00=No action.
                                ;#$01=Referee moving on screen.
                                ;#$02=Opponent throwing right hook.
                                ;#$03=Opponent getting up.
                                ;#$04=Opponent walking to Little Mac after knowck down.
                                ;#$80=Little Mac falling down.
                                ;#$FD=Freeze fight.
                                ;#$FF=Opponent victory dance.
MacCanPunch :=      $BC     ;#$00=Little Mac can't punch, #$01=Little Mac can punch.

OppLastPunchSts :=  $BD     ;Last punch status of opponent. See punch statuses below.

CurrentCount :=     $C2     ;Current referee count. #$9A=1 through #$A2=9.

OppGetUpCount :=    $C4     ;Count opponent will get up on. #$9A=1 through #$A2=9.

Joy1Buttons :=      $D0     ;Controller 1 button presses.
Joy2Buttons :=      $D1     ;Controller 2 button presses.

Button1Status :=    $D2     ;Base for controller 1 button statuses.
Button1History :=   $D3     ;Base for controller 1 button histories.      -->
                                ;#$00=Not pressed.                            -->
                                ;#$01=Dpad not released since last change.    -->
                                ;#$81=Dpad/button first press since last release.

DPad1Status :=      $D2     ;Controller 1 dpad status.
DPad1History :=     $D3     ;Controller 1 dpad history.
A1Status :=         $D4     ;Controller 1 A button status.
A1History :=        $D5     ;Controller 1 A button history.
B1Status :=         $D6     ;Controller 1 B button status.
B1History :=        $D7     ;Controller 1 B button history.
Strt1Status :=      $D8     ;Controller 1 start status.
Strt1History :=     $D9     ;Controller 1 start history.
Sel1Status :=       $DA     ;Controller 1 select button status.
Sel1History :=      $DB     ;Controller 1 select button history.

_IndJumpPtr :=      $00EE   ;Pointer for indirect jump.
IndJumpPtr :=       $EE     ;Pointer for indirect jump.
IndJumpPtrLB :=     $EE     ;Pointer for indirect jump, lower byte.
IndJumpPtrUB :=     $EF     ;Pointer for indirect jump, upper byte.

SavedPasskey :=     $0110   ;To $0119 and $0120 to $0129. The first 10 bytes are password data
                                ;that after A+B+select were pressed. The second 10 bytes are normal
                                ;password data entered by the user.
PasskeyDigits :=    $0120

RoundTmrStart :=    $0300   ;Round timer started: 0=Not started, 1=Started, MSB=needs reset
RoundTmrCntrl :=    $0301   ;Round timer control. 0=running, 1=halt, 2=flash clock
RoundClock :=       $0301   ;Base address for clock values
RoundMinute :=      $0302   ;Current minute in round.
RoundColon :=       $0303   ;Colon tile pointer used to separate minutes from seconds.
RoundUpperSec :=    $0304   ;Current tens of seconds in round.
RoundLowerSec :=    $0305   ;Current second in round(base 10).

RoundTimerUB :=     $0306   ;Underlying timer behind round clock, upper byte
RoundTimerLB :=     $0307   ;Underlying timer behind round clock, lower byte
ClockRateUB :=      $0308   ;Rate that RoundTimer advances per frame, upper byte
ClockRateLB :=      $0309   ;Rate that RoundTimer advances per frame, lower byte

ClockDispStatus :=  $030A   ;Whether the clock display requires an update, MSB=needs update
ClockDisplay :=     $030B   ;Base address for clock display values
ClockDispMin :=     $030B   ;Clock digit index for minutes
ClockDispColon :=   $030C   ;Clock digit index for the colon
ClockDispSecUD :=   $030D   ;Clock digit index for tens of seconds
ClockDispSecLD :=   $030E   ;Clock digit index for seconds

NewHeartsUD :=      $0321   ;New amount of hearts, upper digit(base 10).
NewHeartsLD :=      $0322   ;New amount of hearts, lower digit(base 10).
CurHeartsUD :=      $0323   ;Current amount of hearts, upper digit(base 10).
CurHeartsLD :=      $0324   ;Current amount of hearts, lower digit(base 10).
HeartDispStatus :=  $0325   ;Hearts display status, MSB=needs update
HeartDisplayUD :=   $0326   ;Hearts display digit index, upper digit
HeartDisplayLD :=   $0327   ;Hearts display digit index, lower digit

HeartRecover :=     $032D   ;recover hearts this round, base address.
HeartNormRecUD :=   $032D   ;recover hearts this round, normal amount, upper digit(base 10).
HeartNormRecLD :=   $032E   ;recover hearts this round, normal amount, lower digit(base 10).
HeartNormRedUD :=   $032F   ;recover hearts this round, reduced amount, upper digit(base 10).
HeartNormRedLD :=   $0330   ;recover hearts this round, reduced amount, lower digit(base 10).

NumStars :=         $0342   ;Current number of stars Little Mac has.
IncStars :=         $0343   ;#$01=Increment number of stars.

StarCountDown :=    $0347   ;Must count down to 1 before stars will be given.

HealthPoints :=     $0390
MacNextHP :=        $0391   ;Next value to assign to Little Mac HP.
MacCurrentHP :=     $0392   ;Current vlaue of Little Mac's HP.
MacDisplayedHP :=   $0393   ;Displayed HP for Little Mac.

MacMaxHP :=         $0397   ;Max allowable HP for Little Mac.
OppHP :=            $0398   ;Base for HP opponent HP addresses below.
OppNextHP :=        $0398   ;Next value to assign to opponent's HP.
OppCurrentHP :=     $0399   ;Current value of opponents HP.
OppDisplayedHP :=   $039A   ;Displayed value of opponent's HP.

OppRefillIndex :=   $03C9   ;Index into the table of random opponent HP refills
OppKDRound :=       $03CA   ;Number of times opponent has been knocked down this round
SpecialKD :=        $03CB   ;Special knockdown condition

MacKDFight :=       $03D0   ;Number of times Mac has been knocked down in this fight
OppKDFight :=       $03D1   ;Number of times opponent has been knocked down this fight
LastPunchSts :=     $03D2   ;Who made the last punch? #$81=Mac #$82=Opp

SelectRefill :=     $03D9   ;Amount of HP refill Mac will receive from pushing select

PointsStatus :=     $03E0   ;Status of points
PointsNew :=        $03E1   ;New points that should be added to the total (base 10)
PointsTotal :=      $03E8   ;Total points for this round (base 10)

VRAMQueue :=        $0410   ;Base pointer for the VRAM queue
VRAMQueueStatus :=  $0410   ;Status of the VRAM queue
VQAddress :=        $0411   ;VRAM address where bytes from the queue will be written
VQAddressLB :=      $0411   ;VRAM address where queue bytes will be written (lower byte)
VQAddressUB :=      $0412   ;VRAM address where queue bytes will be written (upper byte)
VRAMQueueData :=    $0413   ;Base pointer for data to be copied into VRAM

ThisBkgPalette :=   $0480   ;Through $048F. Current background palette data.
ThisSprtPalette :=  $0490   ;Through $049F. Current sprite palette data.
UpdatePalFlag :=    $04A0   ;Non-zero value indicates the palettes need to be updated.

PasskeyStatus :=    $04C0   ;Pass key status...
PasskeyCursor :=    $04C1   ;Pass key cursor...
PasskeyModified :=  $04C2   ;Pass key modified...
DemoTimerSec :=     $04C6   ;Idle countdown timer to trigger demo from main menu (seconds, roughly)
DemoTimerFrac :=    $04C7   ;Idle countdown timer to trigger demo (fractional part, frames)
DatIndexTemp :=     $04C9   ;Temporary storage for data index.

VulnerableTimer :=  $04FD   ;Opponent is vunerable while counting down. Does not count on combos.

VariableStTime :=   $0581   ;A vaiable time for states. Usually decreases after being punched.

TimerVal0585 :=     $0585   ;A variable used to load special timer values.

HeartTable :=       $05A3   ;Table of heart values for this fight. (Indexing starts at 3)

StarCountReset :=   $05B0   ;Reset value for StarCountDown.

ReactTimer :=       $05B8   ;Opponents reaction time. Does not count on combos.

ComboDataPtrLB :=   $05C2   ;Pointer to combo data for the current opponent, lower byte
ComboDataPtrUB :=   $05C3   ;Pointer to combo data for the current opponent, upper byte

OppRefillPtr :=     $05D5   ;Pointer to beginning of table of random refill values
OppRefillPtrLB :=   $05D5   ;Pointer to random refill table, lower byte
OppRefillPtrUB :=   $05D6   ;Pointer to random refill table, upper byte
OppHPBoostCap :=    $05D7   ;Soft cap for HP boosts
ClockRateTable :=   $05D8   ;Table of values for this fight. (Indexing starts at 2)

OppGetUpTable :=    $05E0   ;Base address for opponent stand up times after knock down

OppOutline :=       $05EC   ;Base address for determining the opponent's outline color.

SelRefillPtrLB :=   $05EE   ;Pointer to refill table for pressing Select between rounds
SelRefillPtrUB :=   $05EF   ;Pointer to refill table for pressing Select between rounds

OppMessages :=      $05F0   ;Table of message indices for current opponent
TrainerMessages :=  $05F8   ;Table of message indices from trainer for this fight

JoyRawReads :=      $06A0   ;Through $06A8. Raw reads from controller 1 and 2. Even values -->
                                ;are from controller 1 while odd values are from controller 2. -->
                                ;The controllers are polled 4 times each per frame. Used to -->
                                ;DPCM conflict.

;--------------------------------------[Sound Engine Variables]--------------------------------------

SoundInitBase :=    $F0     ;Base address for sound initialization addresses below.
SFXInitSQ1 :=       $F0     ;The SFX index to be started that uses SQ1.
SFXInitSQ2 :=       $F1     ;The SFX index to be started that uses SQ2.
MusicInit :=        $F2     ;The music index to be started.
DMCInit :=          $F3     ;The DMC SFX index to be started.
SFXIndexSQ1 :=      $F4     ;The SFX currently being played that uses SQ1.
SFXIndexSQ2 :=      $F5     ;The SFX currently being played that uses SQ2.
MusicIndex :=       $F6     ;The music currently being played.
DMCIndex :=         $F7     ;The DMC SFX currently being played.
MusicDataPtr :=     $F8     ;Pointer base of music data.
MusicDataPtrLB :=   $F8     ;Pointer base of music data, lower byte.
MusicDataPtrUB :=   $F9     ;Pointer base of music data, upper byte.

SQ2NoteIndex :=     $FC     ;Index to current SQ2 musical note data.
SQ1NoteIndex :=     $FD     ;Index to current SQ1 musical note data.

SQ2NoteRemain :=    $0700   ;The counter used for remaining SQ2 note time.
SQ1NoteRemain :=    $0701   ;The counter used for remaining SQ1 note time.
TriNoteRemain :=    $0702   ;The counter used for remaining triangle note time.
NoiseNoteRemain :=  $0703   ;The counter used for remaining noise note time.
SQ2NoteLength :=    $0704   ;The total length of the of the current SQ2 note.
SQ1NoteLength :=    $0705   ;The total length of the of the current SQ1 note.
TriNoteLength :=    $0706   ;The total length of the of the current triangle note.
NoiseNoteLength :=  $0707   ;The total length of the of the current noise note.
SQ2EnvIndex :=      $0708   ;The current index to SQ2 envelope data while playing music.
SQ1EnvIndex :=      $0709   ;The current index to SQ1 envelope data while playing music.
MusSeqBase :=       $070A   ;Base index for finding music sequence data.
MusSeqIndex :=      $070B   ;Current index for finding music sequence data.
NoiseIndexReload := $070C   ;Reload address to repeat drum beatsin song background.
NoteLengthsBase :=  $070D   ;Base index for note lengths for a given piece of music.
SQ1SweepCntrl :=    $070E   ;Control byte for SQ1 sweep hardware.
SQ1LoFreqBits :=    $070F   ;Lower frequency bits of SQ0.
SQ2LoFreqBits :=    $0710   ;Lower frequency bits of SQ2.

;$0711

SQ1SFXTimer :=      $0712   ;Length timer for SQ1 SFX.
SQ1SFXByte :=       $0713   ;Multi purpose register for SQ1 SFX.

SQ2SFXTimer :=      $0715   ;Length timer for SQ2 SFX.
SQ2SFXByte1 :=      $0716   ;Multi purpose register for SQ2 SFX.
SQ2SFXByte2 :=      $0717   ;Multi purpose register for SQ2 SFX.
SQ2ShortPause :=    $0718   ;Creates a short 2 frame pause in SQ2 music.
SQ1ShortPause :=    $0719   ;Creates a short 2 frame pause in SQ1 music.
SQ2RestartFlag :=   $071A   ;Flag indicating SQ2 music needs to resume after SFX completes.
SQ1RestartFlag :=   $071B   ;Flag indicating SQ1 music needs to resume after SFX completes.
SQ2EnvBase :=       $071C   ;Base index for SQ2 envelope data while playing music.
SQ1EnvBase :=       $071D   ;Base index for SQ1 envelope data while playing music.

;These registers are used for the timing with the DMC laugh SFX. $071E is the time between
;laughs while $071F is the time of the audible portion of the laugh. Each laugh has a small
;silence between them.

DMCLaughLength :=   $071E   ;Time remaining until next laugh starts.
DMCLghAudLength :=  $071F   ;Auduble time remaining in this laugh segment.
NoiseVolIndex :=    $0720   ;Index to noise channel control byte for volume/envelope.
NoiseBeatType :=    $0721   ;If drum beat is type 10 or 11, decay will be applied.
TriNoteIndex :=     $0722   ;Index to current triangle musical note data.
NoiseMusicIndex :=  $0723   ;Index to current noise music data.
NoiseInUse :=       $0724   ;Non-zero indicates an SFX is using the noise channel.
SQ2InUse :=         $0725   ;Non-zero indicates an SFX is using the SQ2 channel.
SQ1InUse :=         $0726   ;Non-zero indicates an SFX is using the SQ1 channel.

;$0728
;$0729

;These register functionalities are hard to explain. When the intro or Piston Honda's intro
;music are playing, a special situation exists where the triangle channel needs to turn off
;before the note length expires. This leaves gaps where the triangle channel does not play.
;Let's call this a "blip". There are 3 situations where special processing is considered:
;  1)If triangle note length > #$09 frames, blib occurs 5 frames before note timer end.
;  2)If #$09 >= triangle note length > #$07, blib occurs in the middle of the note timer.
;  3)if triangle note length <= #$07, a blip occurs 2 frames after the note timer start.
;Registers $072A and $072B keep track of the timing values for the blips. Register $072C determines
;which blip type to use based on initial note length.

TriMidBlip :=       $072A   ;Loaded with 1/2 of Triangle note counter.
TriFrontBlip :=     $072B   ;Loaded with triangle note counter - 2.
TriBlipType :=      $072C   ;#$00=Front half blip, #$01=Mid way blip, #$02=Back half blip.


;-------------------------------------[Hardware Registers]-------------------------------------------

PPUControl0 :=      $2000   ;
PPUControl1 :=      $2001   ;
PPUStatus :=        $2002   ;
SPRAddress :=       $2003   ;PPU hardware control registers.
SPRIOReg :=         $2004   ;
PPUScroll :=        $2005   ;
PPUAddress :=       $2006   ;
PPUIOReg :=         $2007   ;

SQ1Cntrl0 :=        $4000   ;
SQ1Cntrl1 :=        $4001   ;SQ1 hardware control registers.
SQ1Cntrl2 :=        $4002   ;
SQ1Cntrl3 :=        $4003   ;

SQ2Cntrl0 :=        $4004   ;
SQ2Cntrl1 :=        $4005   ;SQ2 hardware control registers.
SQ2Cntrl2 :=        $4006   ;
SQ2Cntrl3 :=        $4007   ;

TriangleCntrl0 :=   $4008   ;
TriangleCntrl1 :=   $4009   ;Triangle hardware control registers.
TriangleCntrl2 :=   $400A   ;
TriangleCntrl3 :=   $400B   ;

NoiseCntrl0 :=      $400C   ;
NoiseCntrl1 :=      $400D   ;Noise hardware control registers.
NoiseCntrl2 :=      $400E   ;
NoiseCntrl3 :=      $400F   ;

DMCCntrl0 :=        $4010   ;
DMCCntrl1 :=        $4011   ;DMC hardware control registers.
DMCCntrl2 :=        $4012   ;
DMCCntrl3 :=        $4013   ;

SPRDMAReg :=        $4014   ;Sprite RAM DMA register.
APUCommonCntrl0 :=  $4015   ;APU common control 1 register.
CPUJoyPad1 :=       $4016   ;Joypad1 register.
APUCommonCntrl1 :=  $4017   ;Joypad2/APU common control 2 register.

;------------------------------------------[MMC Registers]-------------------------------------------

BankSelect :=       $AFFF

;--------------------------------------------[Constants]---------------------------------------------

;Silent note indexes.
NO_NOTE1 =         $00     ;Silent note.
NO_NOTE2 =         $02     ;Silent note.

;Sound channel indexes.
AUD_SQ1_INDEX =    $00     ;Square wave 1 channel index.
AUD_SQ2_INDEX =    $04     ;Square wave 2 channel index.
AUD_TRI_INDEX =    $08     ;Triangle wave channel index.

;Drum beat types.
DRUM_BEAT_1 =      $02     ;
DRUM_BEAT_2 =      $06     ;
DRUM_BEAT_3 =      $0A     ;
DRUM_BEAT_4 =      $0E     ;
DRUM_BEAT_5 =      $12     ;Various drum beats used in the music. Drum beat -->
DRUM_SILENT =      $16     ;10 and 11 will have a decay value applied to them.
DRUM_BEAT_7 =      $1A     ;
DRUM_BEAT_8 =      $1E     ;
DRUM_BEAT_9 =      $22     ;
DRUM_BEAT_10 =     $26     ;
DRUM_BEAT_11 =     $2A     ;

;DMC SFX index numbers.
DMC_CROWD =        $01     ;Crowd cheering, repeats.
DMC_LAUGH1 =       $02     ;Opponent laughing, style 1.
DMC_LAUGH2 =       $03     ;Opponent laughing, style 2.
DMC_LAUGH3 =       $04     ;Opponent laughing, style 3.
DMC_LAUGH4 =       $05     ;Opponent laughing, style 4.
DMC_LAUGH5 =       $06     ;Opponent laughing, style 5.
DMC_GRUNT =        $07     ;Opponent grunt when hit blocked.

;SQ1 SFX index numbers.
SQ1_INTRO_PUNCH =  $01     ;Punch SFX when start is pressed at intro.
SQ1_FALL =         $02     ;Opponent/player falls to the ground SFX.
SQ1_PUNCH1 =       $03     ;Opponent/player lands a punch SFX, version 1.
SQ1_PUNCH_BLOCK =  $04     ;Opponent/player blocks a punch SFX.
SQ1_OPP_PUNCH1 =   $05     ;Opponent punch SFX, vesrion 1.
SQ1_PUNCH_MISS1 =  $06     ;Little Mac misses a punch SFX, vesion 1.
SQ1_PUNCH_MISS2 =  $07     ;Little Mac misses a punch SFX, vesion 2.
SQ1_PUNCH2 =       $08     ;Little Mac lands a punch, version 2.
SQ1_TALK1 =        $09     ;Talking SFX, version 1.
SQ1_TALK2 =        $0A     ;Talking SFX, version 2.
SQ1_TALK3 =        $0B     ;Talking SFX, version 3.
SQ1_DIGIT1 =       $09     ;Beep SFX when password cursor is advanced (same as TALK1)
SQ1_DIGIT2 =       $0B     ;Beep SFX when password digits are changed (same as TALK3)
SQ1_BELL1 =        $0C     ;Single bell ring SFX.
SQ1_FIGHT =        $0D     ;Referee "Fight!" SFX.
SQ1_KO =           $0E     ;Referee "KO" SFX.
SQ1_TKO =          $0F     ;Referee "TKO" SFX.
SQ1_COUNT =        $10     ;Referee count SFX.
SQ1_DODGE =        $11     ;Little Mac dodge to one side SFX.
SQ1_BUSY =         $12     ;Busy signal SFX
SQ1_PUNCH3 =       $13     ;Opponent/player lands a punch SFX, version 3.
SQ1_BEEP =         $14     ;Beep SFX.
SQ1_BELL3 =        $15     ;3 bells SFX.
SQ1_STAR_PUNCH =   $16     ;Little Mac star punch wind up SFX.
SQ1_HIPPO_TALK =   $17     ;King Hippo talking SFX.
SQ1_HOLE_PUNCH =   $18     ;Glove punching a hole in the intro SFX.

;SQ2 SFX index numbers.
SQ2_INTRO_PUNCH =  $01     ;Punch SFX when start is pressed at intro.
SQ2_FALL =         $02     ;Opponent/player falls to the ground SFX.
SQ2_GET_STAR =     $03     ;Little Mac gets a star SFX.
SQ2_HONK1 =        $04     ;Opponent honk SFX, version 1.
SQ2_HONK2 =        $05     ;Opponent honk SFX, version 2.
SQ2_PUNCH1 =       $06     ;Little Mac lands a punch, version 1
SQ2_PUNCH2 =       $07     ;Little Mac lands a punch, version 2.
SQ2_OPP_PUNCH1 =   $08     ;Opponent punch SFX, version 1.
SQ2_OPP_PUNCH2 =   $09     ;Opponent punch SFX, version 2.
SQ2_OPP_PUNCH3 =   $0A     ;Opponent punch SFX, version 3.
SQ2_SPRING1 =      $0B     ;Opponent spring SFX, version 1.
SQ2_TAUNT =        $0C     ;Opponent taunt.
SQ2_OPP_PUNCH4 =   $0D     ;Opponent punch SFX, version 4.
SQ2_STUN1 =        $0E     ;Opponent stunned SFX, version 1.
SQ2_TIGER_PUNCH =  $0F     ;Great Tiger magic punch SFX.
SQ2_MAGIC =        $10     ;Great Tiger Dissapear SFX.
SQ2_FLEX =         $11     ;Mike Tyson muscle flex.
SQ2_MACHO_PUNCH =  $12     ;Super Macho Man super punch SFX.
SQ2_HIPPO_TALK =   $13     ;King Hippo talking SFX.
SQ2_WIND_UP =      $14     ;Opponent punch wind up SFX.
SQ2_SPRING2 =      $15     ;Opponent spring SFX, version 2.

;Music index numbers.
MUS_END =          $01     ;End music.
MUS_SHORT_INTRO =  $02     ;Short version of the intro music.
MUS_ATTRACT =      $03     ;Attract music.
MUS_NEWSPAPER =    $04     ;Music that plays newspaper is displayed.
MUS_CHAMP =        $05     ;Circuit champion music.
MUS_FIGHT_WIN =    $06     ;Fight win music.
MUS_FIGHT_LOSS =   $07     ;Fight loss music.
MUS_TITLE_BOUT =   $08     ;Title bout music.
MUS_GAME_OVER =    $09     ;Game over music.
MUS_PRE_FIGHT =    $0A     ;Pre-fight music.
MUS_NONE =         $0B     ;No music.
MUS_INTRO =        $0C     ;Intro music.
MUS_ATTRACT2 =     $0D     ;Attract music. Same as above.
MUS_DREAM_FIGHT =  $0E     ;Dream fight music.
MUS_NONE2 =        $0F     ;No music.
MUS_VON_KAISER =   $10     ;Von Kaiser/Macho Man intro music.
MUS_GLASS_JOE =    $11     ;Glass Joe intro music.
MUS_DON_FLAM =     $12     ;Don Flamenco intro music.
MUS_KING_HIPPO =   $13     ;King Hippo intro music.
MUS_SODA_POP =     $14     ;Soda popinski intro music.
MUS_PISTON_HON =   $15     ;Piston Honda intro music.
MUS_NONE3 =        $16     ;No music.
MUS_NONE4 =        $17     ;No music.
MUS_NONE5 =        $18     ;No music.
MUS_NONE6 =        $19     ;No music.
MUS_TRAIN_RPT =    $1A     ;Training music, repeats.
MUS_NONE7 =        $1B     ;No music.
MUS_NONE8 =        $1C     ;No music.
MUS_OPP_DOWN =     $1D     ;Opponent on the mat music.
MUS_MAC_DOWN =     $1E     ;Little Mac on the mat music.
MUS_FIGHT =        $1F     ;Main fight music.

;Game status.
ST_REF_MOVING =    $01     ;Indicates ref is moving on the screen.

;Little Mac status.
MAC_NO_FIGHT =     $00     ;Fight not running.
MAC_WAITING =      $01     ;Normal. Waiting for player input.
MAC_NO_HEARTS =    $02     ;No hearts.
MAC_DODGE_RIGHT =  $03     ;Dodging right.
MAC_DODGE_LEFT =   $05     ;Dodging left.
MAC_BLOCK =        $07     ;Blocking.
MAC_BLOCK_HIT =    $08     ;Blocking hit.
MAC_RP_LO =        $09     ;Right punching opponent's stomach.
MAC_LP_LO =        $0A     ;Left punching opponent's stomach.
MAC_RP_HI =        $0B     ;Right punching opponent's face.
MAC_LP_HI =        $0C     ;Left punching opponent's face.
MAC_SUPER_PUNCH =  $0D     ;Super punching opponent.
MAC_DUCK =         $0E     ;Ducking.
MAC_STUN_RIGHT =   $10     ;Little Mac stunned to the right.
MAC_STUN_LEFT =    $11     ;Little Mac stunned to the left.
MAC_PRE_WAIT =     $40     ;Pre-fight wait.
MAC_OPP_WAIT =     $41     ;Opponent down wait.
MAC_ROUND_WAIT =   $42     ;Round over.

;Opponent punch side of Little Mac.
MAC_LEFT_SIDE =    $00     ;Punch comming in on Little Mac's left side.
MAC_RIGHT_SIDE =   $01     ;Punch comming in on Little Mac's right side.

;Opponent state functions.
ST_SPRITES =       $00     ;Load sprite data for current opponent sub-state.
ST_SPRITES_XY =    $10     ;Load sprite data and XY position for current opponent sub-state.
ST_SPRT_MV_NU =    $60     ;Move opponent sprites with no animation update.
ST_SPRTS_MOVE =    $70     ;Move opponent animation around on the screen. -->
                                ;Bits 0,1=frames between movements, bits 2,3=number of movements.
ST_TIMER =         $80     ;Number of frames for sub-state to wait.
ST_SPRT_BIG_MV =   $A0     ;Move opponent around the screen large lengths.
ST_CALL_FUNC =     $E0     ;Call an opponent state subroutine.
ST_RETURN_FUNC =   $E1     ;Return from an opponent state subroutine.
ST_VAR_TIME =      $E4     ;Set opponent's state time to a varying amount.
ST_AUD_INIT =      $EC     ;Play a SFX/music.
ST_PNCH_ACTIVE =   $F0     ;Indicates an opponent's punch is active.
ST_JUMP =          $F1     ;Jump to new state base address and index.
ST_CHK_BRANCH =    $F2     ;Check memory for value and branch in state data if value found.
ST_CHK_REPEAT =    $F3     ;Check if a sub-state needs to repeat.
ST_WAIT_STATE =    $F4     ;Put opponent into wait state.
ST_REPEAT =        $F5     ;Load a repeat value for this sub-state.
ST_PUNCH_SIDE =    $F6     ;Indicate what side of Little Mac a punch is approaching.
ST_DEFENSE =       $F7     ;Load Opponent's defense from following 4 data bytes.
ST_PUNCH =         $F9     ;Indicate the opponent is punching.
ST_WRITE_BYTE =    $FA     ;Write a byte into zero page memory.
ST_SPEC_TIMER =    $FB     ;Load a special state timer value.
ST_COMBO_WAIT =    $FC     ;Wait for combo timer to expire.
ST_END =           $FF     ;Indicate the end of this state has been reached.

;Opponent state status.
STAT_NONE =        $00     ;Current state is not active.
STAT_ACTIVE =      $80     ;Current state is active.
STAT_FINISHED =    $83     ;Current state has finished.

;Opponent punch status.
PUNCH_NONE =       $00     ;No opponent punch being thrown.
PUNCH_BLOCKED =    $01     ;Punch blocked by Little Mac.
PUNCH_DUCKED =     $02     ;Punch is ducked by Little Mac.
PUNCH_LANDED =     $03     ;Punch hit Little Mac.
PUNCH_DODGED =     $04     ;Punch dodged by Little Mac.
PUNCH_ACTIVE =     $80     ;Punch is initialized.

;Controller bits.
IN_RIGHT =         $01     ;Right on the dpad.
IN_LEFT =          $02     ;Left on the dpad.
IN_DOWN =          $04     ;Down on the dpad.
IN_UP =            $08     ;Up on the dpad.
IN_START =         $10     ;Start button.
IN_SELECT =        $20     ;Select button.
IN_B =             $40     ;B button.
IN_A =             $80     ;A button.

;Nibble selection bit masks.
LO_NIBBLE =        $0F     ;Bitmask for lower nibble.
HI_NIBBLE =        $F0     ;Bitmask for upper nibble.

;Opponent state flags
OPP_CHNG_NONE =    $00     ;Done changing opponent sprites.
OPP_CHNG_POS =     $01     ;Move opponent's sprites on the screen.
OPP_CHNG_SPRT =    $80     ;Change opponent's sprites(Next animation sequence).
OPP_CHNG_BOTH =    $81     ;Change both position and sprites.
OPP_RGHT_HOOK =    $02     ;Indicate a right hook is being thrown.

;Misc. items.
NULL_PNTR =        $0000   ;Null pointer.
NO_ACTION =        $00     ;Idle memory byte.
SND_OFF =          $80     ;Silences sound channel.
PPU_LEFT_EN =      $06     ;Enable both left background column and left sprite column.
GAME_ENG_RUN =     $00     ;Enables the main game engine.
SPRT_BKG_OFF =     $80     ;Disable sprites and background.
SPRT_BKG_ON =      $81     ;Enable sprites and background.
PAL_UPDATE =       $81     ;Update palettes flag.

;Musical note indexes SQ1, SQ2.
SQ_C_2 =           $04     ;C2
SQ_C_SHARP_2 =     $06     ;C#2
SQ_D_2 =           $08     ;D2
SQ_D_SHARP_2 =     $0A     ;D#2
SQ_E_2 =           $0C     ;E2
SQ_F_2 =           $0E     ;F2
SQ_F_SHARP_2 =     $10     ;F#2
SQ_G_2 =           $12     ;G2
SQ_G_SHARP_2 =     $14     ;G#2
SQ_A_2 =           $16     ;A2
SQ_A_SHARP_2 =     $18     ;A#2
SQ_B_2 =           $1A     ;B2
SQ_C_3 =           $1C     ;C3
SQ_C_SHARP_3 =     $1E     ;C#3
SQ_D_3 =           $20     ;D3
SQ_D_SHARP_3 =     $22     ;D#3
SQ_E_3 =           $24     ;E3
SQ_F_3 =           $26     ;F3
SQ_F_SHARP_3 =     $28     ;F#3
SQ_G_3 =           $2A     ;G3
SQ_G_SHARP_3 =     $2C     ;G#3
SQ_A_3 =           $2E     ;A3
SQ_A_SHARP_3 =     $30     ;A#3
SQ_B_3 =           $32     ;B3
SQ_C_4 =           $34     ;C4
SQ_C_SHARP_4 =     $36     ;C#4
SQ_D_4 =           $38     ;D4
SQ_D_SHARP_4 =     $3A     ;D#4
SQ_E_4 =           $3C     ;E4
SQ_F_4 =           $3E     ;F4
SQ_F_SHARP_4 =     $40     ;F#4
SQ_G_4 =           $42     ;G4
SQ_G_SHARP_4 =     $44     ;G#4
SQ_A_4 =           $46     ;A4
SQ_A_SHARP_4 =     $48     ;A#4
SQ_B_4 =           $4A     ;B4
SQ_C_5 =           $4C     ;C5
SQ_C_SHARP_5 =     $4E     ;C#5
SQ_D_5 =           $50     ;D5
SQ_D_SHARP_5 =     $52     ;D#5
SQ_E_5 =           $54     ;E5
SQ_F_5 =           $56     ;F5
SQ_F_SHARP_5 =     $58     ;F#5
SQ_G_5 =           $5A     ;G5
SQ_G_SHARP_5 =     $5C     ;G#5
SQ_A_5 =           $5E     ;A5
SQ_A_SHARP_5 =     $60     ;A#5
SQ_B_5 =           $62     ;B5
SQ_C_6 =           $64     ;C6
SQ_C_SHARP_6 =     $66     ;C#6
SQ_D_6 =           $68     ;D6
SQ_D_SHARP_6 =     $6A     ;D#6
SQ_E_6 =           $6C     ;E6
SQ_F_6 =           $6E     ;F6
SQ_F_SHARP_6 =     $70     ;F#6
SQ_G_6 =           $72     ;G6
SQ_G_SHARP_6 =     $74     ;G#6
SQ_A_6 =           $76     ;A6
SQ_A_SHARP_6 =     $78     ;A#6
SQ_B_6 =           $7A     ;B6
SQ_C_7 =           $7C     ;C7
SQ_C_SHARP_7 =     $7E     ;C#7
