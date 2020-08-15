;-------------------------------------[General Purpose Variables]------------------------------------

.alias GenByteE0        $E0     ;General purpose byte.
.alias GenByteE1        $E1     ;General purpose byte.

;-----------------------------------------[Variable Defines]-----------------------------------------

.alias PPU0Load         $10     ;Value to load next into PPU control register 0.
.alias PPU1Load         $11     ;Value to load next into PPU control register 1.

.alias GameEngStatus    $1C     ;0=Main game engine running, non-zero=Main game engine not running.
.alias GameStatus       $1D     ;Enables/disables portions of the game.
                                ;#$00 - Main game engine running.
                                ;#$01 - Run game timers.
                                ;#$02 - Stop all game processing.
                                ;#$03 - Process only audio.
                                ;#$FF - Run non-playable portions of game(intro, cut scenes, etc).
                                
.alias FrameCounter     $1E     ;Increments every frame and rolls over when maxed out.
.alias TransTimer       $1F     ;Countdown timer for various transitions.

.alias MacStatus        $50     ;Status of Little Mac during a fight.
                                
.alias Joy1Buttons      $D0     ;Controller 1 button presses.
.alias Joy2Buttons      $D1     ;Controller 2 button presses.

.alias Button1Status    $D2     ;Base for controller 1 button statuses.
.alias Button1History   $D3     ;Base for controller 1 button histories.      -->
                                ;#$00=Not pressed.                            -->
                                ;#$01=Dpad not released since last change.    -->
                                ;#$81=Dpad/button first press since last release.
                                
.alias DPad1Status      $D2     ;Controller 1 dpad status.
.alias DPad1History     $D3     ;Controller 1 dpad history.
.alias A1Status         $D4     ;Controller 1 A button status.
.alias A1History        $D5     ;Controller 1 A button history.
.alias B1Status         $D6     ;Controller 1 B button status.
.alias B1History        $D7     ;Controller 1 B button history.
.alias Strt1Status      $D8     ;Controller 1 start status.
.alias Strt1History     $D9     ;Controller 1 start history.
.alias Sel1Status       $DA     ;Controller 1 select button status.
.alias Sel1History      $DB     ;Controller 1 select button history.

.alias EnteredPasswd    $0110   ;To $0119 and $0120 to $0129. The first 10 bytes are password data
                                ;that after A+B+select were pressed. The second 10 bytes are normal
                                ;password data entered by the user.

.alias RoundMinute      $0302   ;Current minute in round.
.alias RoundColon       $0303   ;Colon tile pointer used to separate minutes from seconds.
.alias RoundUpperSec    $0304   ;Current tens of seconds in round.
.alias RoundLowerSec    $0305   ;Current second in round(base 10).

.alias MacTargetHP      $0391   ;Target HP for Little Mac.

.alias MacCurrentHP     $0393   ;Current HP for Little Mac.

.alias JoyRawReads      $06A0   ;Through $06A8. Raw reads from controller 1 and 2. Even values -->
                                ;are from controller 1 while odd values are from controller 2. -->
                                ;The controllers are polled 4 times each per frame. Used to -->
                                ;DPCM conflict.

;--------------------------------------[Sound Engine Variables]--------------------------------------

.alias SFXInitSQ1       $F0     ;The SFX index to be started that uses SQ1.
.alias SFXInitSQ2       $F1     ;The SFX index to be started that uses SQ2.
.alias MusicInit        $F2     ;The music index to be started.
.alias DMCInit          $F3     ;The DMC SFX index to be started.

.alias SFXIndexSQ1      $F4     ;The SFX currently being played that uses SQ1.
.alias SFXIndexSQ2      $F5     ;The SFX currently being played that uses SQ2.
.alias MusicIndex       $F6     ;The music currently being played.
.alias DMCIndex         $F7     ;The DMC SFX currently being played.

.alias MusicDataPtr     $F8     ;Pointer base of music data.
.alias MusicDataPtrLB   $F8     ;Pointer base of music data, lower byte.
.alias MusicDataPtrUB   $F9     ;Pointer base of music data, upper byte.

.alias SQ2NoteIndex     $FC     ;Index to current SQ2 musical note data.
.alias SQ1NoteIndex     $FD     ;Index to current SQ1 musical note data.

.alias SQ2NoteRemain    $0700   ;The counter used for remaining SQ2 note time.
.alias SQ1NoteRemain    $0701   ;The counter used for remaining SQ1 note time.
.alias TriNoteRemain    $0702   ;The counter used for remaining triangle note time.
.alias NoiseNoteRemain  $0703   ;The counter used for remaining noise note time.

.alias SQ2NoteLength    $0704   ;The total length of the of the current SQ2 note.
.alias SQ1NoteLength    $0705   ;The total length of the of the current SQ1 note.
.alias TriNoteLength    $0706   ;The total length of the of the current triangle note.
.alias NoiseNoteLength  $0707   ;The total length of the of the current noise note.

.alias SQ2EnvIndex      $0708   ;The current index to SQ2 envelope data while playing music.
.alias SQ1EnvIndex      $0709   ;The current index to SQ1 envelope data while playing music.

.alias MusSeqBase       $070A   ;Base index for finding music sequence data.
.alias MusSeqIndex      $070B   ;Current index for finding music sequence data.

.alias NoiseIndexReload $070C   ;Reload address to repeat drum beatsin song background.
.alias NoteLengthsBase  $070D   ;Base index for note lengths for a given piece of music.

.alias SQ1SweepCntrl    $070E   ;Control byte for SQ1 sweep hardware.
.alias SQ1LoFreqBits    $070F   ;Lower frequency bits of SQ0.
.alias SQ2LoFreqBits    $0710   ;Lower frequency bits of SQ2.

;$0711

.alias SQ1SFXTimer      $0712   ;Length timer for SQ1 SFX.
.alias SQ1SFXByte       $0713   ;Multi purpose register for SQ1 SFX.

.alias SQ2SFXTimer      $0715   ;Length timer for SQ2 SFX.
.alias SQ2SFXByte1      $0716   ;Multi purpose register for SQ2 SFX.
.alias SQ2SFXByte2      $0717   ;Multi purpose register for SQ2 SFX.

.alias SQ2ShortPause    $0718   ;Creates a short 2 frame pause in SQ2 music.
.alias SQ1ShortPause    $0719   ;Creates a short 2 frame pause in SQ1 music.

.alias SQ2RestartFlag   $071A   ;Flag indicating SQ2 music needs to resume after SFX completes.
.alias SQ1RestartFlag   $071B   ;Flag indicating SQ1 music needs to resume after SFX completes.

.alias SQ2EnvBase       $071C   ;Base index for SQ2 envelope data while playing music.
.alias SQ1EnvBase       $071D   ;Base index for SQ1 envelope data while playing music.

;These registers are used for the timing with the DMC laugh SFX. $071E is the time between
;laughs while $071F is the time of the audible portion of the laugh. Each laugh has a small
;silence between them.

.alias DMCLaughLength   $071E   ;Time remaining until next laugh starts.
.alias DMCLghAudLength  $071F   ;Auduble time remaining in this laugh segment.

.alias NoiseVolIndex    $0720   ;Index to noise channel control byte for volume/envelope.
.alias NoiseBeatType    $0721   ;If drum beat is type 10 or 11, decay will be applied.
.alias TriNoteIndex     $0722   ;Index to current triangle musical note data.
.alias NoiseMusicIndex  $0723   ;Index to current noise music data.

.alias NoiseInUse       $0724   ;Non-zero indicates an SFX is using the noise channel.
.alias SQ2InUse         $0725   ;Non-zero indicates an SFX is using the SQ2 channel.
.alias SQ1InUse         $0726   ;Non-zero indicates an SFX is using the SQ1 channel.

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

.alias TriMidBlip       $072A   ;Loaded with 1/2 of Triangle note counter.
.alias TriFrontBlip     $072B   ;Loaded with triangle note counter - 2.
.alias TriBlipType      $072C   ;#$00=Front half blip, #$01=Mid way blip, #$02=Back half blip.


;-------------------------------------[Hardware Registers]-------------------------------------------

.alias PPUControl0      $2000   ;
.alias PPUControl1      $2001   ;
.alias PPUStatus        $2002   ;
.alias SPRAddress       $2003   ;PPU hardware control registers.
.alias SPRIOReg         $2004   ;
.alias PPUScroll        $2005   ;
.alias PPUAddress       $2006   ;
.alias PPUIOReg         $2007   ;

.alias SQ1Cntrl0        $4000   ;
.alias SQ1Cntrl1        $4001   ;SQ1 hardware control registers.
.alias SQ1Cntrl2        $4002   ;
.alias SQ1Cntrl3        $4003   ;

.alias SQ2Cntrl0        $4004   ;
.alias SQ2Cntrl1        $4005   ;SQ2 hardware control registers.
.alias SQ2Cntrl2        $4006   ;
.alias SQ2Cntrl3        $4007   ;

.alias TriangleCntrl0   $4008   ;
.alias TriangleCntrl1   $4009   ;Triangle hardware control registers.
.alias TriangleCntrl2   $400A   ;
.alias TriangleCntrl3   $400B   ;

.alias NoiseCntrl0      $400C   ;
.alias NoiseCntrl1      $400D   ;Noise hardware control registers.
.alias NoiseCntrl2      $400E   ;
.alias NoiseCntrl3      $400F   ;

.alias DMCCntrl0        $4010   ;
.alias DMCCntrl1        $4011   ;DMC hardware control registers.
.alias DMCCntrl2        $4012   ;
.alias DMCCntrl3        $4013   ;

.alias SPRDMAReg        $4014   ;Sprite RAM DMA register.
.alias APUCommonCntrl0  $4015   ;APU common control 1 register.
.alias CPUJoyPad1       $4016   ;Joypad1 register.
.alias APUCommonCntrl1  $4017   ;Joypad2/APU common control 2 register.

;------------------------------------------[MMC Registers]-------------------------------------------

;--------------------------------------------[Constants]---------------------------------------------

;Sound channel indexes.
.alias AUD_SQ1_INDEX    $00     ;Square wave 1 channel index.
.alias AUD_SQ2_INDEX    $04     ;Square wave 2 channel index.
.alias AUD_TRI_INDEX    $08     ;Triangle wave channel index.

;Drum beat types.
.alias DRUM_BEAT_1      $02     ;
.alias DRUM_BEAT_2      $06     ;
.alias DRUM_BEAT_3      $0A     ;
.alias DRUM_BEAT_4      $0E     ;
.alias DRUM_BEAT_5      $12     ;Various drum beats used in the music. Drum beat -->
.alias DRUM_SILENT      $16     ;10 and 11 will have a decay value applied to them.
.alias DRUM_BEAT_7      $1A     ;
.alias DRUM_BEAT_8      $1E     ;
.alias DRUM_BEAT_9      $22     ;
.alias DRUM_BEAT_10     $26     ;
.alias DRUM_BEAT_11     $2A     ;

;DMC SFX index numbers.
.alias DMC_CROWD        $01     ;Crowd cheering, repeats.
.alias DMC_LAUGH1       $02     ;Opponent laughing, style 1.
.alias DMC_LAUGH2       $03     ;Opponent laughing, style 2.
.alias DMC_LAUGH3       $04     ;Opponent laughing, style 3.
.alias DMC_LAUGH4       $05     ;Opponent laughing, style 4.
.alias DMC_LAUGH5       $06     ;Opponent laughing, style 5.
.alias DMC_GRUNT        $07     ;Opponent grunt when hit blocked.

;SQ1 SFX index numbers.
.alias SQ1_INTRO_PUNCH  $01     ;Punch SFX when start is pressed at intro.
.alias SQ1_FALL         $02     ;Opponent/player falls to the ground SFX.
.alias SQ1_PUNCH1       $03     ;Opponent/player lands a punch SFX, version 1.
.alias SQ1_PUNCH_BLOCK  $04     ;Opponent/player blocks a punch SFX.
.alias SQ1_OPP_PUNCH1   $05     ;Opponent punch SFX, vesrion 1.
.alias SQ1_PUNCH_MISS1  $06     ;Little Mac misses a punch SFX, vesion 1.
.alias SQ1_PUNCH_MISS2  $07     ;Little Mac misses a punch SFX, vesion 2.
.alias SQ1_PUNCH2       $08     ;Little Mac lands a punch, version 2.
.alias SQ1_TALK1        $09     ;Talking SFX, version 1.
.alias SQ1_TALK2        $0A     ;Talking SFX, version 2.
.alias SQ1_TALK3        $0B     ;Talking SFX, version 3.
.alias SQ1_BELL1        $0C     ;Single bell ring SFX.
.alias SQ1_FIGHT        $0D     ;Referee "Fight!" SFX.
.alias SQ1_KO           $0E     ;Referee "KO" SFX.
.alias SQ1_TKO          $0F     ;Referee "TKO" SFX.
.alias SQ1_COUNT        $10     ;Referee count SFX.
.alias SQ1_DODGE        $11     ;Little Mac dodge to one side SFX.
.alias SQ1_DIGIT        $12     ;Beep when password digit entered SFX.
.alias SQ1_PUNCH3       $13     ;Opponent/player lands a punch SFX, version 3.
.alias SQ1_BEEP         $14     ;Beep SFX.
.alias SQ1_BELL3        $15     ;3 bells SFX.
.alias SQ1_STAR_PUNCH   $16     ;Little Mac star punch wind up SFX.
.alias SQ1_HIPPO_TALK   $17     ;King Hippo talking SFX.
.alias SQ1_HOLE_PUNCH   $18     ;Glove punching a hole in the intro SFX.

;SQ2 SFX index numbers.
.alias SQ2_INTRO_PUNCH  $01     ;Punch SFX when start is pressed at intro.
.alias SQ2_FALL         $02     ;Opponent/player falls to the ground SFX.
.alias SQ2_GET_STAR     $03     ;Little Mac gets a star SFX.
.alias SQ2_HONK1        $04     ;Opponent honk SFX, version 1.
.alias SQ2_HONK2        $05     ;Opponent honk SFX, version 2.
.alias SQ2_PUNCH1       $06     ;Little Mac lands a punch, version 1
.alias SQ2_PUNCH2       $07     ;Little Mac lands a punch, version 2.
.alias SQ2_OPP_PUNCH1   $08     ;Opponent punch SFX, version 1.
.alias SQ2_OPP_PUNCH2   $09     ;Opponent punch SFX, version 2.
.alias SQ2_OPP_PUNCH3   $0A     ;Opponent punch SFX, version 3.
.alias SQ2_SPRING1      $0B     ;Opponent spring SFX, version 1.
.alias SQ2_TAUNT        $0C     ;Opponent taunt.
.alias SQ2_OPP_PUNCH4   $0D     ;Opponent punch SFX, version 4.
.alias SQ2_STUN1        $0E     ;Opponent stunned SFX, version 1.
.alias SQ2_TIGER_PUNCH  $0F     ;Great Tiger magic punch SFX.
.alias SQ2_MAGIC        $10     ;Great Tiger Dissapear SFX.
.alias SQ2_FLEX         $11     ;Mike Tyson muscle flex.
.alias SQ2_MACHO_PUNCH  $12     ;Super Macho Man super punch SFX.
.alias SQ2_HIPPO_TALK   $13     ;King Hippo talking SFX.
.alias SQ2_WIND_UP      $14     ;Opponent punch wind up SFX.
.alias SQ2_SPRING2      $15     ;Opponent spring SFX, version 2.

;Music index numbers.
.alias MUS_END          $01     ;End music.
.alias MUS_SHORT_INTRO  $02     ;Short version of the intro music.
.alias MUS_ATTRACT      $03     ;Attract music.
.alias MUS_NEWSPAPER    $04     ;Music that plays newspaper is displayed.
.alias MUS_CHAMP        $05     ;Circuit champion music.
.alias MUS_FIGHT_WIN    $06     ;Fight win music.
.alias MUS_FIGHT_LOSS   $07     ;Fight loss music.
.alias MUS_TITLE_BOUT   $08     ;Title bout music.
.alias MUS_GAME_OVER    $09     ;Game over music.
.alias MUS_PRE_FIGHT    $0A     ;Pre-fight music.
.alias MUS_NONE         $0B     ;No music.
.alias MUS_INTRO        $0C     ;Intro music.
.alias MUS_ATTRACT2     $0D     ;Attract music. Same as above.
.alias MUS_DREAM_FIGHT  $0E     ;Dream fight music.
.alias MUS_NONE2        $0F     ;No music.
.alias MUS_VON_KAISER   $10     ;Von Kaiser/Macho Man intro music.
.alias MUS_GLASS_JOE    $11     ;Glass Joe intro music.
.alias MUS_DON_FLAM     $12     ;Don Flamenco intro music.
.alias MUS_KING_HIPPO   $13     ;King Hippo intro music.
.alias MUS_SODA_POP     $14     ;Soda popinski intro music.
.alias MUS_PISTON_HON   $15     ;Piston Honda intro music.
.alias MUS_NONE3        $16     ;No music.
.alias MUS_NONE4        $17     ;No music.
.alias MUS_NONE5        $18     ;No music.
.alias MUS_NONE6        $19     ;No music.
.alias MUS_TRAIN_RPT    $1A     ;Training music, repeats.
.alias MUS_NONE7        $1B     ;No music.
.alias MUS_NONE8        $1C     ;No music.
.alias MUS_OPP_DOWN     $1D     ;Opponent on the mat music.
.alias MUS_MAC_DOWN     $1E     ;Little Mac on the mat music.
.alias MUS_FIGHT        $1F     ;Main fight music.

;Little Mac status.
.alias MAC_NO_FIGHT     $00     ;Fight not running.
.alias MAC_WAITING      $01     ;Normal. Waiting for player input.
.alias MAC_NO_HEARTS    $02     ;No hearts.
.alias MAC_DODGE_RIGHT  $03     ;Dodging right.
.alias MAC_DODGE_LEFT   $05     ;Dodging left.
.alias MAC_BLOCK        $07     ;Blocking.
.alias MAC_BLOCK_HIT    $08     ;Blocking hit.
.alias MAC_RP_LOW       $09     ;Right punching opponent's stomach.
.alias MAC_LP_LOW       $0A     ;Left punching opponent's stomach.
.alias MAC_RP_HIGH      $0B     ;Right punching opponent's face.
.alias MAC_LP_HI        $0C     ;Left punching opponent's face.
.alias MAC_SUPER_PUNCH  $0D     ;Super punching opponent.
.alias MAC_STUN_RIGHT   $10     ;Little Mac stunned to the right.
.alias MAC_STUN_LEFT    $11     ;Little Mac stunned to the left.
.alias MAC_PRE_WAIT     $40     ;Pre-fight wait.
.alias MAC_OPP_WAIT     $41     ;Opponent down wait.
.alias MAC_ROUND_WAIT   $42     ;Round over.

;Controller bits.
.alias IN_RIGHT         $01
.alias IN_LEFT          $02
.alias IN_DOWN          $04
.alias IN_UP            $08
.alias IN_START         $10
.alias IN_SELECT        $20
.alias IN_B             $40
.alias IN_A             $80

;Nibble selection bit masks.
.alias LO_NIBBLE        $0F     ;Bitmask for lower nibble.
.alias HI_NIBBLE        $F0     ;Bitmask for upper nibble.

;Misc. items.
.alias SND_OFF          $80     ;Silences sound channel.
.alias PPU_LEFT_EN      $06     ;Enable both left background column and left sprite column.
.alias GAME_ENG_RUN     $00     ;Enables the main game engine.