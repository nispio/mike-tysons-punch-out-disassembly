
.org $8000

.include "Mike_Tysons_Punchout_Defines.asm"

L8000:  JMP UpdateStars         ;($8974)
L8003:  JMP UpdateHeartsDisplay ;($890D)
L8006:  JMP UpdateHealthBars    ;($881E)
L8009:  JMP UpdateClock         ;($8759)
L800C:  JMP UpdatePoints        ;($86D0)
L800F:  JMP CheckCrowdSpecial   ;($8A6F)
L8012:  JMP UpdateRNG           ;($85E9)
L8015:  JMP PunchAnalyzer       ;($805D)
L8018:  .byte $00, $00, $00
L801B:  JMP ClearPassword       ;($8DED)
L801E:  JMP FillPswdDashes      ;($8E11)
L8021:  JMP $8E1F
L8024:  JMP $8E23
L8027:  JMP TranslatePswd2      ;($8E34)Translate password2 numbers into glyphs
L802A:  JMP TranslatePswd       ;($8E3B)Translate password numbers into glyphs
L802D:  JMP GroupPswdDigits     ;($8E53)Insert a space between digit groups
DoVerifyCheckPoint:
L8030:  JMP VerifyCheckPoint    ;($8EBA)
L8033:  JMP ChkNormalPswd       ;($8EC1)Check a normal password
L8036:  JMP SavePassword        ;($8FC6)Save the entered password
L8039:  JMP LoadCheckPoint      ;($8FD2)Verify checkpoint, clear password if invalid
L803C:  JMP $8FF0
L803F:  JMP ChkBusyPassword     ;($8D7D)Check fur busy signal passwords.
L8042:  JMP ChkAWCPassword2     ;($8D6C)Check for another world circuit password.
L8045:  JMP ChkAWCPassword      ;($8D72)Check for AWC password in $0120
L8048:  JMP ChkCreditsPassword  ;($8D5D)Check for end credits password.
L804B:  JMP _Clear170           ;($8FE5)Clear the entered password
L804E:  JMP ChkTysonPassword    ;($8D68)Check if player entered password to start at Mike Tyson.

L8051:  JMP $FFD0
L8054:  JMP $FFD3
L8057:  JMP $FFD6

L805A:  JMP $856F

PunchAnalyzer:
L805D:  LDY #$00
L805F:  LDA OppPunchSts
L8061:  BMI $8069
L8063:  JMP $81B2
L8066:  JMP $80FF
L8069:  LDA $58
L806B:  BPL $806F
L806D:  STY $58
L806F:  STY VulnerableTimer
L8072:  LDA #$01
L8074:  AND OppPunchSide
L8076:  TAX
L8077:  LDA MacDefense1,X
L8079:  CMP #$80                ;Was Mac ducking?
L807B:  BEQ $8090
L807D:  CMP #$FF                ;Was Mac dodging?
L807F:  BNE $8066
L8081:  LDA MacStatus           ;($50)
L8083:  STA $03B0
L8086:  STY $03C5
L8089:  LDX $05A0
L808C:  LDA #$04
L808E:  BNE $809E

L8090:  LDX $05A1
L8093:  LDA MacStatus           ;($50)
L8095:  CMP #$0E
L8097:  BNE $809C
L8099:  LDX $05A2
L809C:  LDA #PUNCH_DUCKED

L809E:  STA OppPunchSts
L80A0:  STA OppLastPunchSts
L80A2:  LDA MacCanPunch
L80A4:  BNE $80B3
L80A6:  TXA
L80A7:  JSR $84B9
L80AA:  LDA MacCanPunch
L80AC:  BEQ $80B3
L80AE:  LDA #$00
L80B0:  STA $03C5

L80B3:  LDA #$00
L80B5:  STA OppPunchDamage
L80B7:  STA OppPunchSide
L80B9:  RTS

L80BA:  LDA MacDefense1,X
L80BC:  CMP #$08
L80BE:  BEQ $80C7
L80C0:  LDA #PUNCH_DUCKED
L80C2:  STA OppPunchSts
L80C4:  STA OppLastPunchSts
L80C6:  RTS

L80C7:  LDA #PUNCH_BLOCKED
L80C9:  STA OppPunchSts
L80CB:  STA OppLastPunchSts
L80CD:  LDA #$88
L80CF:  STA MacStatus           ;($50)
L80D1:  LDA #$01
L80D3:  JSR $843E
L80D6:  LDA #$82
L80D8:  STA LastPunchSts        ;($03D2)
L80DB:  LDA #$02
L80DD:  LDX MacCanPunch
L80DF:  BNE $80E3
L80E1:  LDA #$04
L80E3:  JSR DealDamageToMac     ;($8503)
L80E6:  BEQ $80EF

ClearNumbersAfterPunch:
L80E8:  JSR $8540
L80EB:  JSR $8550
L80EE:  RTS

L80EF:  LDA #PUNCH_LANDED
L80F1:  STA OppPunchSts
L80F3:  STA OppLastPunchSts
L80F5:  JSR $849F

KnockdownBoxer:
L80F8:  JSR SetKnockdownFlags   ;($83EB)
L80FB:  JSR $8550
L80FE:  RTS

L80FF:  LDA OppPunchDamage
L8101:  SEC
L8102:  SBC MacDefense1,X
L8104:  BEQ $80BA
L8106:  BMI $80BA
L8108:  STA $E0
L810A:  LDA MacPunchType
L810C:  AND #$03                ;Filter everything but star punch
L810E:  TAX
L810F:  LDA MacPunchDamage
L8111:  SEC
L8112:  SBC OppHitDefense,X
L8114:  BPL $8118
L8116:  LDA #$00
L8118:  STA $E1
L811A:  BNE $8176
L811C:  LDA #PUNCH_LANDED
L811E:  STA OppPunchSts
L8120:  STA OppLastPunchSts
L8122:  LDA MacCanPunch
L8124:  BNE $8131
L8126:  LDA HeartTable          ;($05A3)
L8129:  JSR $84B9
L812C:  LDA #$01                ;Flag set of some sort
L812E:  STA $0329
L8131:  LDA $0581
L8134:  SEC
L8135:  SBC $0582
L8138:  CMP $0583
L813B:  BCS $8140
L813D:  LDA $0583
L8140:  STA $0581
L8143:  LDA #$03                ;Parameter for update hearts
L8145:  JSR $843E
L8148:  LDA #$FF
L814A:  STA $0341
L814D:  JSR $849F
L8150:  LDA $03C5
L8153:  BNE $816E
L8155:  LDA #$82                ;Opponent threw last punch
L8157:  STA LastPunchSts        ;($03D2)
L815A:  JSR $852B               ;Opponent gains health from landing punch

L815D:  LDA $E0
L815F:  CLC
L8160:  ADC $05AF
L8163:  JSR DealDamageToMac     ;($8503)
L8166:  BNE $816B               ;Boxer still standing after punch
L8168:  JMP KnockdownBoxer      ;($80F8)
L816B:  JMP ClearNumbersAfterPunch ;($80E8)

KnockdownLittleMac:
L816E:  LDA #$00
L8170:  STA $0391
L8173:  JMP KnockdownBoxer      ;($80F8)

L8176:  LDA #PUNCH_NONE
L8178:  STA OppPunchSts
L817A:  STA OppLastPunchSts
L817C:  LDA #$8D
L817E:  JSR $8562
L8181:  JSR $849F
L8184:  LDA #$03
L8186:  JSR $843E
L8189:  LDA #$FF
L818B:  STA $0341
L818E:  LDX #$00
L8190:  LDA SpecialKD           ;($03CB)
L8193:  CMP #$09
L8195:  BEQ $8199
L8197:  LDX #$81
L8199:  STX LastPunchSts        ;($03D2)
L819C:  LDA $E1
L819E:  LDA #$00
L81A0:  JSR DealDamageToOpponent ;($84FF)
L81A3:  BEQ $81A9
L81A5:  LDX #$82
L81A7:  BNE $81AC
L81A9:  JSR $8404
L81AC:  STX LastPunchSts        ;($03D2) X=0
L81AF:  JMP $815D

L81B2:  LDA $58
L81B4:  BMI $81B7
L81B6:  RTS

L81B7:  STY $0344
L81BA:  CMP #$80
L81BC:  BNE $81C4
L81BE:  JMP $8259
L81C1:  JMP $825D
L81C4:  LDA MacPunchType
L81C6:  BMI $81C1
L81C8:  LDY ComboTimer
L81CA:  BEQ $81C1
L81CC:  AND #$03
L81CE:  TAX
L81CF:  LDA OppHitDefense,X
L81D1:  BEQ $81E0
L81D3:  CMP #$08
L81D5:  BNE $81DD
L81D7:  JSR ResetCombo          ;($8435)
L81DA:  JMP $8297
L81DD:  JMP $8267
L81E0:  LDA $0580
L81E3:  STA $0581
L81E6:  LDA #$20
L81E8:  STA ComboTimer
L81EA:  LDA #$01
L81EC:  STA $03E5
L81EF:  LDA #$80
L81F1:  STA PointsStatus        ;($03E0)
L81F4:  LDA ComboCountDown
L81F6:  BEQ $820A
L81F8:  DEC ComboCountDown
L81FA:  BEQ $8204
L81FC:  LDA $4C
L81FE:  AND #$01
L8200:  BEQ $824E
L8202:  BNE $8240

L8204:  LDA $4C
L8206:  AND #$01
L8208:  BNE $823E
L820A:  JSR ResetCombo          ;($8435)
L820D:  LDA #$03
L820F:  STA $58
L8211:  LDA #$8D
L8213:  JSR $8562
L8216:  JSR $8550
L8219:  JSR $842A
L821C:  LDA #$81
L821E:  LDX SpecialKD           ;($03CB)
L8221:  CPX #$09
L8223:  BNE $8227
L8225:  LDA #$00
L8227:  STA LastPunchSts        ;($03D2)
L822A:  LDA $05C5
L822D:  JSR DealDamageToOpponent ;($84FF)
L8230:  BEQ $8236
L8232:  JSR $8540
L8235:  RTS

L8236:  LDA #$8D
L8238:  JSR $8562
L823B:  JMP $8312
L823E:  INC ComboCountDown
L8240:  DEC $05C4
L8243:  BNE $824B
L8245:  LDA #$00
L8247:  STA $4C
L8249:  BEQ $824E
L824B:  JSR $8057
L824E:  LDA #$03
L8250:  STA $58
L8252:  LDA #$91
L8254:  JSR $8562
L8257:  BNE $8219
L8259:  LDA MacPunchType
L825B:  BPL $8260
L825D:  JSR ResetCombo          ;($8435)
L8260:  AND #$03
L8262:  TAX
L8263:  LDA OppHitDefense,X
L8265:  BPL $82B2
L8267:  LDA #$02
L8269:  STA $58
L826B:  LDA #$01
L826D:  JSR $843E
L8270:  LDY #$00
L8272:  LDA MacPunchType
L8274:  AND #$03
L8276:  TAX
L8277:  LDA OppHitDefense,X
L8279:  CMP #$80
L827B:  BEQ $8282
L827D:  JSR $8550
L8280:  LDY #ST_REF_MOVING
L8282:  STY GameStatusBB
L8284:  JSR $8540
L8287:  RTS

L8288:  LDA OppHitDefense,X
L828A:  CMP #$08
L828C:  BEQ $8297
L828E:  LDA #$02
L8290:  STA $58
L8292:  LDA #$00
L8294:  STA GameStatusBB
L8296:  RTS

L8297:  LDA #$01
L8299:  STA $58
L829B:  STY IncStars
L829E:  STY VulnerableTimer
L82A1:  LDA #$85
L82A3:  JSR $8562
L82A6:  LDA #$01
L82A8:  JSR $843E
L82AB:  JSR $8540
L82AE:  JSR $8550
L82B1:  RTS

L82B2:  LDA MacPunchDamage
L82B4:  SEC
L82B5:  SBC OppHitDefense,X
L82B7:  BEQ $8288               ;Was opponent defense == Mac punch power?
L82B9:  BMI $8288               ;Was opponent defense > Mac punch power?
L82BB:  STA $E0                 ;Save Mac punch damage
L82BD:  LDA OppPunchSide
L82BF:  AND #$01
L82C1:  TAX
L82C2:  LDA OppPunchDamage
L82C4:  SEC
L82C5:  SBC MacDefense1,X
L82C7:  BPL $82CB
L82C9:  LDA #$00
L82CB:  STA $E1                 ;Save opponent punch damage
L82CD:  BEQ ProcessMacPunch     ;($8319)

L82CF:  LDA #$00
L82D1:  STA $58
L82D3:  LDA #$8D
L82D5:  JSR $8562
L82D8:  JSR $849F
L82DB:  LDA #$01
L82DD:  JSR $843E
L82E0:  LDA #$FF
L82E2:  STA $0341
L82E5:  LDA #$82                ;Opponent made the last punch
L82E7:  STA LastPunchSts        ;($03D2)
L82EA:  LDA $E1
L82EC:  CLC
L82ED:  ADC $05AF
L82F0:  JSR DealDamageToMac     ;($8503)
L82F3:  BEQ $8302
L82F5:  LDA SpecialKD           ;($03CB)
L82F8:  LDX #$81
L82FA:  CMP #$09
L82FC:  BNE $8305
L82FE:  LDX #$00
L8300:  BEQ $8305
L8302:  JSR SetKnockdownFlags   ;($83EB)
L8305:  STX LastPunchSts        ;($03D2)
L8308:  LDA $E0
L830A:  JSR DealDamageToOpponent ;($84FF)
L830D:  BEQ $8312
L830F:  JMP $83B9
L8312:  JSR $8404
L8315:  JSR $8550
L8318:  RTS

ProcessMacPunch:
L8319:  LDA #$03
L831B:  STA $58
L831D:  LDA #$81                ;Mac made the last punch
L831F:  STA LastPunchSts        ;($03D2)
L8322:  LDA #$05
L8324:  LDX #$04
L8326:  LDY MacPunchType
L8328:  BMI $832D
L832A:  INX
L832B:  LDA #$01
L832D:  STA PointsStatus,X      ;($03E0)
L8330:  LDA #$80
L8332:  STA PointsStatus        ;($03E0)
L8335:  LDA $BA
L8337:  BEQ $8345
L8339:  LDA #$00
L833B:  STA $0398
L833E:  LDA #$8D
L8340:  JSR $8562
L8343:  BNE $8312
L8345:  LDA SpecialKD           ;($03CB)
L8348:  CMP #$01
L834A:  BEQ $8352
L834C:  CMP #$09
L834E:  BEQ $835D
L8350:  BNE $8366
L8352:  LDA MacPunchType
L8354:  BPL $8366
L8356:  LDA #$00
L8358:  STA $0398
L835B:  BEQ $837C
L835D:  LDA MacPunchType
L835F:  BMI $8366
L8361:  LDA #$00
L8363:  STA LastPunchSts        ;($03D2)
L8366:  JSR $8525
L8369:  LDA $E0
L836B:  LDX MacPunchType
L836D:  BPL $8373
L836F:  CLC
L8370:  ADC $05D3
L8373:  JSR DealDamageToOpponent ;($84FF)
L8376:  BNE $8382
L8378:  LDA MacPunchType
L837A:  BPL $833E
L837C:  LDA #$82
L837E:  STA OppCurState
L8380:  BNE $8312
L8382:  LDA $0580
L8385:  STA $0581
L8388:  INC $03B1
L838B:  LDA ComboTimer
L838D:  BEQ $83AE
L838F:  LDA ComboCountDown
L8391:  BNE $839F
L8393:  JSR $8054
L8396:  LDX ComboCountDown
L8398:  DEX
L8399:  BNE $839F
L839B:  LDA #$80
L839D:  STA $4C
L839F:  LDA #$20
L83A1:  STA ComboTimer
L83A3:  LDA #$91
L83A5:  JSR $8562
L83A8:  JSR $842A
L83AB:  JMP $8540
L83AE:  LDA MacPunchType
L83B0:  BPL $83C0
L83B2:  LDA #$82
L83B4:  STA OppCurState
L83B6:  JSR $842A
L83B9:  JSR $8540
L83BC:  JSR $8550
L83BF:  RTS

L83C0:  LDA #$8D
L83C2:  JSR $8562
L83C5:  DEC StarCountDown
L83C8:  BNE $83D2
L83CA:  LDA $05B1
L83CD:  STA StarCountDown
L83D0:  BNE $83E4
L83D2:  LDA IncStars
L83D5:  BMI $83B9
L83D7:  LDA NumStars
L83DA:  BEQ $83B9
L83DC:  LDA $05B4
L83DF:  JSR RandomChance16      ;($910B)
L83E2:  BCC $83B9
L83E4:  LDA #$80
L83E6:  STA IncStars
L83E9:  BNE $83B9

SetKnockdownFlags:
L83EB:  LDA #$80
L83ED:  STA $0320
L83F0:  STA $0340
L83F3:  STA GameStatusBB
L83F5:  JSR HaltRoundTimer      ;($8421)
L83F8:  LDX #$02                ;Mac is down (X=2)
L83FA:  STX KnockdownSts        ;($05)
L83FC:  DEX                     ;Mac can punch (X=1)
L83FD:  STX MacCanPunch         ;($BC)
L83FF:  DEX                     ;X=0
L8400:  STX $03C5
L8403:  RTS

L8404:  JSR ResetCombo          ;($8435)
L8407:  JSR HaltRoundTimer      ;($8421)
L840A:  LDA #$01
L840C:  STA $03E3
L840F:  LDA #$80
L8411:  STA PointsStatus        ;($03E0)
L8414:  LDX #$01
L8416:  STX KnockdownSts        ;($05)
L8418:  STX $36
L841A:  DEX
L841B:  STX GameStatusBB
L841D:  STX SpecialKD           ;($03CB)
L8420:  RTS                     ;Return A=$80, X=0

HaltRoundTimer:
L8421:  LDA RoundTmrCntrl
L8424:  ORA #$01
L8426:  STA RoundTmrCntrl
L8429:  RTS

L842A:  DEC StarCountDown
L842D:  BNE $8434
L842F:  LDA #$01
L8431:  STA StarCountDown
L8434:  RTS

ResetCombo:
L8435:  LDY #$00
L8437:  STY ComboTimer
L8439:  STY ComboCountDown
L843B:  STY $4C
L843D:  RTS

UpdateHearts:
L843E:  TAX
L843F:  LDA CurHeartsLD
L8442:  ORA CurHeartsUD
L8445:  BEQ $849E
L8447:  TXA
L8448:  SEC
L8449:  STA $E7
L844B:  LDA CurHeartsLD
L844E:  SBC $E7
L8450:  BCS $8455
L8452:  ADC #$0A
L8454:  CLC
L8455:  STA NewHeartsLD
L8458:  LDA CurHeartsUD
L845B:  SBC #$00
L845D:  STA NewHeartsUD
L8460:  BCC $8469
L8462:  BNE $8491
L8464:  LDA NewHeartsLD
L8467:  BNE $8491
L8469:  LDA #$00
L846B:  STA MacCanPunch
L846D:  STA $0329
L8470:  LDA #$20
L8472:  STA $0328
L8475:  LDA $05A4
L8478:  STA $032A
L847B:  LDA #$14
L847D:  STA $048E
L8480:  LDA #$80
L8482:  STA $0320
L8485:  STA $04A0
L8488:  LDA $36
L848A:  AND #$80
L848C:  ORA #$04
L848E:  STA $36
L8490:  RTS

L8491:  LDX #$02
L8493:  LDA $0320,X
L8496:  CMP $032A,X
L8499:  BNE $849E
L849B:  DEX
L849C:  BNE $8493
L849E:  RTS

L849F:  LDA $5A
L84A1:  BMI $84AC
L84A3:  LDA OppPunchSide
L84A5:  AND #$01
L84A7:  ORA #$90
L84A9:  CLC
L84AA:  ADC $59
L84AC:  STA MacStatus           ;($50)
L84AE:  LDA #$25
L84B0:  STA $048E
L84B3:  LDA #$81
L84B5:  STA $04A0
L84B8:  RTS

L84B9:  CLC
L84BA:  ADC $0328
L84BD:  STA $0328
L84C0:  BEQ $84C9
L84C2:  BPL $84F3
L84C4:  LDA #$00
L84C6:  STA $0328
L84C9:  LDA #$01
L84CB:  STA MacCanPunch
L84CD:  LDA #$8F
L84CF:  STA $048E
L84D2:  LDA #$80
L84D4:  STA $04A0
L84D7:  LDA $36
L84D9:  AND #$80
L84DB:  ORA #$08
L84DD:  STA $36
L84DF:  LDA $0329
L84E2:  ASL
L84E3:  ADC #$05
L84E5:  TAX
L84E6:  LDA $0328,X
L84E9:  STA NewHeartsUD
L84EC:  LDA $0329,X
L84EF:  STA NewHeartsLD
L84F2:  RTS
L84F3:  CMP $032A
L84F6:  BCC $84FE
L84F8:  LDA $032A
L84FB:  STA $0328
L84FE:  RTS

DealDamageToOpponent:
L84FF:  LDX #$09
L8501:  BNE DealDamageLogic     ;($8505)

DealDamageToMac:
L8503:  LDX #$02

DealDamageLogic:
L8505:  STA $E7
L8507:  LDA HealthPoints,X      ;($0390)
L850A:  DEX
L850B:  SEC
L850C:  SBC $E7
L850E:  BEQ $8512               ;Health = 0 means knocked down
L8510:  BPL DealDamageSetHealth ;($851F)
L8512:  LDY LastPunchSts        ;($03D2)
L8515:  BEQ DealDamageHealthZero ;($851D)
L8517:  LDA #$00
L8519:  STA HealthPoints,X      ;($0390)
L851C:  RTS

DealDamageHealthZero:
L851D:  LDA #$00

DealDamageSetHealth:
L851F:  STA HealthPoints,X      ;($0390)
L8522:  LDA #$01                ;
L8524:  RTS

L8525:  LDA #$0F
L8527:  LDX #$02
L8529:  BNE $8530

L852B:  LDA OppHPBoostCap       ;($05D7)
L852E:  LDX #$09
L8530:  CMP HealthPoints,X      ;($0390)
L8533:  BCC $853F
L8535:  LDA HealthPoints,X      ;($0390)
L8538:  DEX
L8539:  CLC
L853A:  ADC #$04
L853C:  STA HealthPoints,X      ;($0390)
L853F:  RTS
L8540:  LDA #$00
L8542:  LDX #$04
L8544:  STA $73,X
L8546:  STA $B3,X
L8548:  DEX
L8549:  BNE $8544
L854B:  STA OppHitDefenseLR     ;($B8)
L854D:  STA OppHitDefenseLL     ;($B9)
L854F:  RTS

L8550:  LDA #$81
L8552:  STA MacStateStatus      ;($51)
L8554:  STA OppStateStatus      ;($91)
L8556:  JSR $8051
L8559:  RTS

L855A:  LDX #$01
L855C:  BNE $8564
L855E:  LDX #$02
L8560:  BNE $8564

L8562:  LDX #$03
L8564:  STA $E7
L8566:  TXA
L8567:  AND MacPunchType
L8569:  CLC
L856A:  ADC $E7
L856C:  STA OppCurState
L856E:  RTS

L856F:  LDA $013E
L8572:  BEQ $859C
L8574:  LDX $00
L8576:  CPX #$FA
L8578:  BEQ $859C
L857A:  LDX #$23
L857C:  LDY #$91
L857E:  LDA PPUStatus
L8581:  STX PPUAddress
L8584:  STY PPUAddress
L8587:  LDY #$00
L8589:  LDX #$05
L858B:  JSR $85D7
L858E:  JSR $859D
L8591:  LDX #$02
L8593:  JSR $85D7
L8596:  LDX RoundNumber
L8598:  INX
L8599:  STX PPUIOReg
L859C:  RTS

L859D:  JSR $85C9
L85A0:  LDA #$25
L85A2:  STA PPUIOReg
L85A5:  LDA RoundTimerUB        ;($0306)
L85A8:  AND #$F0
L85AA:  LSR
L85AB:  LSR
L85AC:  LSR
L85AD:  TAX
L85AE:  LDA $85BB,X
L85B1:  STA PPUIOReg
L85B4:  LDA $85BC,X
L85B7:  STA PPUIOReg
L85BA:  RTS

L85BB:  .byte $01, $01, $03, $06, $05, $09, $07, $02, $09, $03, $0A, $08, $0A, $0A

L85C9:  LDX #$00
L85CB:  LDA ClockDisplay,X      ;($030B)
L85CE:  STA PPUIOReg
L85D1:  INX
L85D2:  CPX #$04
L85D4:  BNE $85CB
L85D6:  RTS

L85D7:  LDA $85E2,Y
L85DA:  STA PPUIOReg
L85DD:  INY
L85DE:  DEX
L85DF:  BNE $85D7
L85E1:  RTS

L85E2:  .byte $1E, $13, $17, $0F, $FF, $2B, $1C

UpdateRNG:
L85E9:  LDA FrameCounter        ;($1E)
L85EB:  ROR
L85EC:  STA $E8
L85EE:  ROR
L85EF:  STA $E9
L85F1:  ROR
L85F2:  STA $EA
L85F4:  ROR
L85F5:  AND #$08
L85F7:  STA $ED
L85F9:  LDA $E8
L85FB:  AND #$01
L85FD:  ORA $ED
L85FF:  STA $ED
L8601:  LDA $E9
L8603:  AND #$92
L8605:  ORA $ED
L8607:  STA $ED
L8609:  LDA $EA
L860B:  AND #$04
L860D:  ORA $ED
L860F:  STA $ED
L8611:  LDA FrameCounter        ;($1E)
L8613:  ROL
L8614:  STA $E8
L8616:  ROL
L8617:  ROL
L8618:  ROL
L8619:  AND #$40
L861B:  ORA $ED
L861D:  STA $ED
L861F:  LDA $E8
L8621:  AND #$20
L8623:  ORA $ED
L8625:  STA $ED
L8627:  LDA Joy1Buttons
L8629:  ROR
L862A:  STA $E8
L862C:  ROR
L862D:  STA $E9
L862F:  ROR
L8630:  AND #$98
L8632:  STA $EC
L8634:  LDA Joy1Buttons
L8636:  AND #$01
L8638:  ORA $EC
L863A:  STA $EC
L863C:  LDA $E8
L863E:  AND #$02
L8640:  ORA $EC
L8642:  STA $EC
L8644:  LDA $E9
L8646:  AND #$04
L8648:  ORA $EC
L864A:  STA $EC
L864C:  LDA Joy1Buttons
L864E:  ROL
L864F:  STA $E8
L8651:  ROL
L8652:  AND #$20
L8654:  ORA $EC
L8656:  STA $EC
L8658:  LDA $E8
L865A:  AND #$40
L865C:  ORA $EC
L865E:  CLC
L865F:  ADC InputAccum          ;($19)
L8661:  STA InputAccum          ;($19)
L8663:  ROR
L8664:  STA $E8
L8666:  ROR
L8667:  STA $E9
L8669:  ROR
L866A:  AND #$02
L866C:  STA $EC
L866E:  LDA $E8
L8670:  AND #$20
L8672:  ORA $EC
L8674:  STA $EC
L8676:  LDA $E9
L8678:  AND #$08
L867A:  ORA $EC
L867C:  STA $EC
L867E:  LDA InputAccum          ;($19)
L8680:  ROL
L8681:  STA $E8
L8683:  ROL
L8684:  STA $E9
L8686:  ROL
L8687:  AND #$40
L8689:  ORA $EC
L868B:  STA $EC
L868D:  LDA $E8
L868F:  AND #$04
L8691:  ORA $EC
L8693:  STA $EC
L8695:  LDA $E9
L8697:  AND #$10
L8699:  ORA $EC
L869B:  STA $EC
L869D:  LDA InputAccum          ;($19)
L869F:  AND #$81
L86A1:  ORA $EC
L86A3:  CLC
L86A4:  ADC $ED
L86A6:  STA RNGValue            ;($18)
L86A8:  RTS

ResetPoints:
L86A9:  LDX #$01
L86AB:  STX $03E7
L86AE:  STX PointsStatus        ;($03E0)
L86B1:  CMP #$80
L86B3:  BEQ _ResetPoints        ;($86C1)
L86B5:  LDA #$00
L86B7:  LDX #$05
L86B9:  STA PointsNew,X         ;($03E1)
L86BC:  DEX
L86BD:  BPL $86B9
L86BF:  BMI $86DC

_ResetPoints:
L86C1:  LDA #$00
L86C3:  LDX #$05
L86C5:  STA PointsTotal,X       ;($03E8)
L86C8:  STA PointsNew,X         ;($03E1)
L86CB:  DEX
L86CC:  BPL $86C5
L86CE:  BMI $86DC

UpdatePoints:
L86D0:  LDA $03E7
L86D3:  BEQ $871E
L86D5:  BMI $86A9
L86D7:  LDA PointsStatus        ;($03E0)
L86DA:  BEQ $871E

UpdatePointTotal:
L86DC:  CLC
L86DD:  LDX #$05
L86DF:  LDA PointsTotal,X       ;($03E8)
L86E2:  ADC PointsNew,X         ;($03E1)
L86E5:  CMP #$0A
L86E7:  BCC $86EB
L86E9:  SBC #$0A
L86EB:  STA PointsTotal,X       ;($03E8)
L86EE:  DEX
L86EF:  BPL $86DF
L86F1:  LDX #$06
L86F3:  LDA #$00
L86F5:  STA PointsStatus,X      ;($03E0)
L86F8:  DEX
L86F9:  BPL $86F5
L86FB:  LDX #$00
L86FD:  LDY #$06
L86FF:  CLC
L8700:  LDA PointsTotal,X       ;($03E8)
L8703:  BNE $871F
L8705:  DEY
L8706:  BMI $8721
L8708:  LDA #$FF
L870A:  STA $03F1,X
L870D:  INX
L870E:  CPX #$05
L8710:  BNE $8700
L8712:  LDX $03ED
L8715:  INX
L8716:  STX $03F6
L8719:  LDA #$80
L871B:  STA $03F0
L871E:  RTS

L871F:  LDY #$FF
L8721:  ADC #$01
L8723:  BNE $870A

FlashRoundClock:
L8725:  DEC RoundTimerLB        ;($0307)
L8728:  BNE $8758
L872A:  LDA #$08
L872C:  STA RoundTimerLB        ;($0307)
L872F:  LDY #$00
L8731:  DEC RoundTimerUB        ;($0306)
L8734:  BEQ $8750
L8736:  LDA ClockDispMin        ;($030B)
L8739:  CMP #$04
L873B:  BNE $873F
L873D:  LDY #$04
L873F:  LDX #$00
L8741:  LDA $87FE,Y
L8744:  STA ClockDisplay,X      ;($030B)
L8747:  INY
L8748:  INX
L8749:  CPX #$04
L874B:  BNE $8741
L874D:  JMP $87E4
L8750:  STY RoundTmrStart       ;($0300)
L8753:  BEQ $873D
L8755:  JMP $87EA
L8758:  RTS

UpdateClock:
L8759:  LDA RoundTmrStart       ;($0300)
L875C:  BEQ $8758               ;If the clock is not started, then return
L875E:  BMI $8755               ;If MSB set, then reset the clock and return
L8760:  LDA RoundTmrCntrl       ;($0301)
L8763:  BEQ RoundTmrTick        ;If the clock is not paused, then tick
L8765:  BMI FlashRoundClock     ;If MSB is set, then flash 3:00
L8767:  CMP #$01
L8769:  BEQ $8758               ;If the clock is paused, then return
L876B:  LDA ClockDispStatus     ;$(030A)
L876E:  BNE $8758               ;If the clock display requires an update, then return
L8770:  LDA #$81
L8772:  STA RoundTmrCntrl       ;Initiate clock flash sequence
L8775:  LDA #$10                ; Flash sequence has 16 steps
L8777:  STA RoundTimerUB        ; 8 times "3:00" and 8 times "----", alternating
L877A:  LDA #$08                ; One flash step every 8 frames
L877C:  STA RoundTimerLB        ; Use Chrono to track where we are in the sequence
L877F:  RTS

RoundTmrTick:
L8780:  LDA RoundTimerLB        ;Binary addition of 16-bit ClockRate into Chrono.     -->
L8783:  CLC                     ;The clock rate is the number of chrono counts that   -->
L8784:  ADC ClockRateLB         ;the chronometer advances each frame.  This is a more -->
L8787:  STA RoundTimerLB        ;fine-grained timekeeper than the round clock, which  -->
L878A:  LDA RoundTimerUB        ;derives its time from the chronometer. It is worth   -->
L878D:  ADC ClockRateUB         ;noting that clock rate changes from round to round.
L8790:  STA RoundTimerUB
L8793:  CMP #$64
L8795:  BCC $87E9               ;If chronometer hasn't ticked past #$6400 counts, return
L8797:  SBC #$64                ;Else subtract #$6400 from the current count
L8799:  STA RoundTimerUB
L879C:  DEC $0311
L879F:  INC RoundLowerSec       ;Each time the chronometer ticks past $#6400, the  -->
L87A2:  LDA RoundLowerSec       ;round clock is advanced by one second.
L87A5:  CMP #$0A                ;If the lower digit of the second clock has not    -->
L87A7:  BNE UpdateClockDisplay  ;reached 10 yet, then we are done.
L87A9:  LDX #$00
L87AB:  STX RoundLowerSec       ;If the lower digit has reached 10, then it wraps  -->
L87AE:  INC RoundUpperSec       ;back around to zero and the digit in the tens     -->
L87B1:  LDA RoundUpperSec       ;place is incremented
L87B4:  CMP #$06
L87B6:  BNE UpdateClockDisplay  ;If the tens digit has not reached 6, then we are done
L87B8:  STX RoundUpperSec       ;Else the tens digit wraps back around to zero    -->
L87BB:  INC RoundMinute         ;and the minute is incremented.
L87BE:  LDA RoundMinute
L87C1:  CMP #$03
L87C3:  BNE UpdateClockDisplay  ;If the round hasn't reached 3 minutes, then we are done
L87C5:  LDA #$02                ;Else we have reached the end of the round, so    -->
L87C7:  STA RoundTmrCntrl       ;set RoundTmrCntrl=2 to signal the clock flash sequence
L87CA:  LDA #$00
L87CC:  STA OppCurState
L87CE:  STA OppStateStatus
L87D0:  STA MacStateStatus      ;($51)
L87D2:  LDA #$C2
L87D4:  STA MacStatus           ;($50)

UpdateClockDisplay:
L87D6:  CLC
L87D7:  LDX #$04
L87D9:  LDA RoundTmrCntrl,X     ;($0301)
L87DC:  ADC #$01
L87DE:  STA ClockDispStatus,X   ;($030A)
L87E1:  DEX
L87E2:  BNE $87D9
L87E4:  LDY #$80
L87E6:  STY ClockDispStatus     ;Set flag to update clock display
L87E9:  RTS

ResetRoundClock:
L87EA:  LDA #$00
L87EC:  STA RoundTmrStart       ;($0300)
L87EF:  LDX #$07
L87F1:  STA RoundTmrStart,X     ;($0300) Used as base address for clock values
L87F4:  DEX
L87F5:  BNE $87F1
L87F7:  LDA #$2B
L87F9:  STA RoundColon          ;($0303)
L87FC:  BNE UpdateClockDisplay  ;($87D6)

;Values for flashing clock: "3:00" and "----"
L87FE:  .byte $04, $2C, $01, $01, $28, $28, $28, $28

L8806:  AND #$7F
L8808:  STA HealthPoints        ;($0390)
L880B:  LDA #$00
L880D:  LDX #$0E
L880F:  STA $0391,X
L8812:  DEX
L8813:  BPL $880F
L8815:  LDA #$60
L8817:  STA $0391
L881A:  STA $0398
L881D:  RTS

UpdateHealthBars:
L881E:  LDA HealthPoints        ;($0390)
L8821:  BEQ $881D
L8823:  BMI $8806
L8825:  LDA $0391
L8828:  CMP MacCurrentHP
L882B:  BEQ $8830
L882D:  STA MacCurrentHP
L8830:  LDA $0394
L8833:  BMI $8892
L8835:  LDA MacDisplayedHP
L8838:  CMP MacCurrentHP
L883B:  BEQ $8892
L883D:  BCC $885E
L883F:  SBC #$01
L8841:  STA MacDisplayedHP
L8844:  LSR
L8845:  BCS $8892
L8847:  STA $E0
L8849:  AND #$07
L884B:  BEQ $8851
L884D:  ADC #$80
L884F:  BNE $8853
L8851:  LDA #$FC
L8853:  STA $0396
L8856:  LDA $E0
L8858:  LSR
L8859:  LSR
L885A:  LSR
L885B:  JMP $8883
L885E:  ADC #$01
L8860:  STA MacDisplayedHP
L8863:  LSR
L8864:  BCC $886B
L8866:  BNE $8892
L8868:  CLC
L8869:  LDA #$01
L886B:  STA $E0
L886D:  LDX #$00
L886F:  AND #$07
L8871:  BNE $8874
L8873:  INX
L8874:  STX $E1
L8876:  ADC #$80
L8878:  STA $0396
L887B:  LDA $E0
L887D:  LSR
L887E:  LSR
L887F:  LSR
L8880:  SEC
L8881:  SBC $E1
L8883:  STA $E0
L8885:  SEC
L8886:  LDA #$66
L8888:  SBC $E0
L888A:  STA $0395
L888D:  LDA #$80
L888F:  STA $0394
L8892:  LDA $0398
L8895:  CMP $0399
L8898:  BEQ $889D
L889A:  STA $0399
L889D:  LDA $039B
L88A0:  BMI $88FB
L88A2:  LDA $039A
L88A5:  CMP $0399
L88A8:  BEQ $88FB
L88AA:  BCC $88CB
L88AC:  SBC #$01
L88AE:  STA $039A
L88B1:  LSR
L88B2:  BCS $88FB
L88B4:  STA $E0
L88B6:  AND #$07
L88B8:  BEQ $88BE
L88BA:  ADC #$88
L88BC:  BNE $88C0
L88BE:  LDA #$FC
L88C0:  STA $039D
L88C3:  LDA $E0
L88C5:  LSR
L88C6:  LSR
L88C7:  LSR
L88C8:  JMP $88F0
L88CB:  ADC #$01
L88CD:  STA $039A
L88D0:  LSR
L88D1:  BCC $88D8
L88D3:  BNE $88FB
L88D5:  CLC
L88D6:  LDA #$01
L88D8:  STA $E0
L88DA:  LDX #$00
L88DC:  AND #$07
L88DE:  BNE $88E1
L88E0:  INX
L88E1:  STX $E1
L88E3:  ADC #$88
L88E5:  STA $039D
L88E8:  LDA $E0
L88EA:  LSR
L88EB:  LSR
L88EC:  LSR
L88ED:  SEC
L88EE:  SBC $E1
L88F0:  CLC
L88F1:  ADC #$68
L88F3:  STA $039C
L88F6:  LDA #$80
L88F8:  STA $039B
L88FB:  RTS

L88FC:  LDX #$01
L88FE:  STX $0320
L8901:  CMP #$80
L8903:  BEQ $8909
L8905:  LDX #$02
L8907:  BNE $892A
L8909:  LDX #$04
L890B:  BNE $892A

UpdateHeartsDisplay:
L890D:  LDA $0320
L8910:  BEQ $894A
L8912:  BMI $88FC
L8914:  LDA NewHeartsUD
L8917:  ORA NewHeartsLD
L891A:  BEQ $894A
L891C:  LDX NewHeartsUD
L891F:  STX CurHeartsUD
L8922:  LDY NewHeartsLD
L8925:  STY CurHeartsLD
L8928:  LDX #$02
L892A:  LDA #$00
L892C:  STA $0320,X
L892F:  DEX
L8930:  BNE $892C
L8932:  CLC
L8933:  LDA CurHeartsUD
L8936:  BEQ $894B
L8938:  ADC #$40
L893A:  STA HeartDisplayUD      ;($0326)
L893D:  LDA CurHeartsLD
L8940:  ADC #$40
L8942:  STA HeartDisplayLD      ;($0327)
L8945:  LDX #$80
L8947:  STX HeartDispStatus     ;($0325)
L894A:  RTS

L894B:  LDA #$FC
L894D:  BNE $893A
L894F:  LDA #$00
L8951:  STA $0341
L8954:  STA NumStars
L8957:  STA IncStars
L895A:  LDA #$01
L895C:  STA $0340
L895F:  BNE $8990
L8961:  CMP #$03
L8963:  BCC $898D
L8965:  LDA #$03
L8967:  LDX $0348
L896A:  BNE $898D
L896C:  LDX $05B3
L896F:  STX $0348
L8972:  BNE $898D

UpdateStars:
L8974:  LDA $0340
L8977:  BEQ $89BD
L8979:  BMI $894F
L897B:  LDA $0341
L897E:  BEQ $899E
L8980:  LDX #$00
L8982:  STX $0341
L8985:  CLC
L8986:  ADC NumStars
L8989:  BPL $8961
L898B:  LDA #$00
L898D:  STA NumStars
L8990:  LDA NumStars
L8993:  CLC
L8994:  ADC #$40
L8996:  STA $034A
L8999:  LDX #$80
L899B:  STX $0349
L899E:  LDX IncStars
L89A1:  BEQ $89BD
L89A3:  BMI $89BE
L89A5:  DEX
L89A6:  STX IncStars
L89A9:  BEQ $89DE
L89AB:  LDA $89FD,X
L89AE:  STA $02FD
L89B1:  CPX #$10
L89B3:  BNE $89B9
L89B5:  LDA #$03
L89B7:  STA $F1
L89B9:  LDA #$81
L89BB:  STA $17
L89BD:  RTS

L89BE:  LDA $0344
L89C1:  BEQ $89BD
L89C3:  STA $02FF
L89C6:  LDA $0345
L89C9:  STA $02FC
L89CC:  CLC
L89CD:  ADC #$08
L89CF:  STA $0208
L89D2:  LDA #$02
L89D4:  STA $02FE
L89D7:  LDX #$14
L89D9:  STX IncStars
L89DC:  BNE $89AB
L89DE:  LDY PointsStatus        ;($03E0)
L89E1:  BNE $89FA
L89E3:  STY $0344
L89E6:  LDA #$F8
L89E8:  STA $02FC
L89EB:  STY $0208
L89EE:  INY
L89EF:  STY $0341
L89F2:  STY $03E4
L89F5:  STY PointsStatus        ;($03E0)
L89F8:  BNE $89B9
L89FA:  INC IncStars
L89FD:  RTS

L89FE:  .byte $82, $82, $82, $82, $80, $80, $80, $80, $81, $81, $80, $80, $81, $81, $80, $80
L8A0E:  .byte $81, $81, $80, $80

L8A12:  .byte $81, $21, $32, $E9, $00, $00, $21, $32, $E9, $21, $32, $F1
L8A1E:  .byte $25, $3E, $3C, $25, $3E, $F5, $21, $2E, $3B, $21, $2E, $F9

;; L8A2A:  .byte $A2, $05, $BD, $12
;; L8A2E:  TXA

L8A2A:  LDX #$05
L8A2C:  LDA $8A12,X
L8A2F:  STA $0410,X
L8A32:  DEX
L8A33:  BPL $8A2C
L8A35:  LDX #$03
L8A37:  LDA $05BD,Y
L8A3A:  LSR
L8A3B:  CLC
L8A3C:  ADC $05BD,Y
L8A3F:  TAY
L8A40:  LDA $8A17,Y
L8A43:  STA $0410,X
L8A46:  DEY
L8A47:  DEX
L8A48:  BNE $8A40
L8A4A:  RTS

UpdateCrowdState:
L8A4B:  AND #$7F                ;Mask out MSB
L8A4D:  TAY
L8A4E:  LDA FrameCounter        ;($1E)
L8A50:  AND #$0F
L8A52:  BNE VQSetUpdateFlag     ;($8AD2) If frame number is not a multiple of 16, redraw crowd
L8A54:  TYA
L8A55:  STA CrowdCurState       ;($40) Clear MSB of CrowdCurState
L8A57:  LDY #$80
L8A59:  STY CrowdStateStatus    ;($41) Set CrowdStateStatus = 0x80
L8A5B:  LDY #$01
L8A5D:  STY CrowdStateTimer     ;($42) Set CrowdStateTimer = 0x01
L8A5F:  DEY
L8A60:  STY CrowdStateIndex     ;($43) Set CrowdStateIndex = 0x00
L8A62:  ASL
L8A63:  TAY
L8A64:  LDA CrowdDataPtrs,Y     ;($8CD2)
L8A67:  STA CrowdStBasePtrLB    ;($44)
L8A69:  INY
L8A6A:  LDA CrowdDataPtrs,Y     ;($8CD2)
L8A6D:  STA CrowdStBasePtrUB    ;($45)

CheckCrowdSpecial:
L8A6F:  LDA CrowdCurState       ;($40)
L8A71:  BMI $8A4B
L8A73:  BEQ VQSetUpdateFlag     ;($8AD2)
L8A75:  LDY CrowdStRptCntr      ;($46)
L8A77:  BNE $8A2A               ;???
L8A79:  TAY
L8A7A:  DEY
L8A7B:  BEQ $8AA2
L8A7D:  DEY
L8A7E:  BEQ $8A8D
L8A80:  DEY
L8A81:  BNE $8AA2
L8A83:  LDA FrameCounter        ;($1E)
L8A85:  AND #$0F
L8A87:  BNE $8A8D
L8A89:  LDA #$04
L8A8B:  STA CrowdCurState       ;($40)
L8A8D:  LDA FrameCounter        ;($1E)
L8A8F:  AND #$0F
L8A91:  TAY
L8A92:  LDA $048A
L8A95:  AND #$0F
L8A97:  ORA $8B8B,Y
L8A9A:  STA $048A
L8A9D:  LDA #$81
L8A9F:  STA $04A0
L8AA2:  LDA $0410
L8AA5:  BMI $8ADC
L8AA7:  DEC CrowdStateTimer     ;($42)
L8AA9:  BNE VQSetUpdateFlag     ;($8AD2)
L8AAB:  LDA #$01
L8AAD:  STA CrowdStateTimer     ;($42)
L8AAF:  LDY CrowdStateIndex     ;($43)
L8AB1:  LDA (CrowdStBasePtr),Y  ;($44)
L8AB3:  AND #$1F
L8AB5:  TAX
L8AB6:  LDA (CrowdStBasePtr),Y  ;($44)
L8AB8:  INC CrowdStateIndex     ;($43)
L8ABA:  INY
L8ABB:  JSR _Div16              ;($9158)
L8ABE:  LSR
L8ABF:  JSR IndJumpFromTable    ;($9134)

L8AC2:  .word $8ADD, $0000, $8AF0, $8B19, $8B1E, $0000, $8B39, $8B50


;If VRAMQueueStatus is zero, then set MSB to signal a flush
VQSetUpdateFlag:
L8AD2:  LDA $0410
L8AD5:  BEQ $8ADC
L8AD7:  ORA #$80
L8AD9:  STA $0410
L8ADC:  RTS

L8ADD:  TXA
L8ADE:  AND #$0F
L8AE0:  JSR RandomChance16      ;($910B)
L8AE3:  BCC $8AED
L8AE5:  LDA (CrowdStBasePtr),Y  ;($44)
L8AE7:  TAY
L8AE8:  STY CrowdStateIndex     ;($43)
L8AEA:  JMP $8AB1

L8AED:  INY
L8AEE:  BNE $8AE8
L8AF0:  TXA
L8AF1:  LDX #$00
L8AF3:  AND #$0F
L8AF5:  CMP #$0B
L8AF7:  BCC $8AFB
L8AF9:  SBC #$05
L8AFB:  ASL
L8AFC:  ASL
L8AFD:  ASL
L8AFE:  STA $E0
L8B00:  LDA RNGValue            ;($18)
L8B02:  JSR _RotateRNG          ;($9151)
L8B05:  AND #$07
L8B07:  ORA $E0
L8B09:  ASL
L8B0A:  TAY
L8B0B:  LDA $8B9B,Y
L8B0E:  STA $0400,X
L8B11:  LDA $8B9C,Y
L8B14:  STA $0401,X
L8B17:  BNE VQSetUpdateFlag     ;($8AD2)
L8B19:  TXA
L8B1A:  LDX #$02
L8B1C:  BNE $8AF3

L8B1E:  TXA
L8B1F:  AND #$0F
L8B21:  JSR RandomChance16      ;($910B)
L8B24:  BCC $8B31
L8B26:  LDA (CrowdStBasePtr),Y  ;($44)
L8B28:  AND #$0F
L8B2A:  INC CrowdStateIndex     ;($43)
L8B2C:  STA CrowdStateTimer     ;($42)
L8B2E:  JMP VQSetUpdateFlag     ;($8AD2)

L8B31:  LDA (CrowdStBasePtr),Y  ;($44)
L8B33:  JSR _Div16              ;($9158)
L8B36:  JMP $8B2A

VQAddrSelect1:
L8B39:  LDA #$00

_VQAddrSelect:
L8B3B:  STX $E2
L8B3D:  TAX
L8B3E:  LDA $0400,X
L8B41:  STA $0412
L8B44:  LDA $0401,X
L8B47:  STA $0411
L8B4A:  JSR $8B54
L8B4D:  JMP VQSetUpdateFlag     ;($8AD2)

VQAddrSelect2:
L8B50:  LDA #$02
L8B52:  BNE _VQAddrSelect       ;($8B3B)

ReadVQCrowdTable:
L8B54:  LDA $E2
L8B56:  ASL
L8B57:  TAY
L8B58:  LDA VQCrowdTablePtrs,Y  ;($8C4B)
L8B5B:  STA $E0
L8B5D:  INY
L8B5E:  LDA VQCrowdTablePtrs,Y  ;($8C4B)
L8B61:  STA $E1
L8B63:  LDY #$00
L8B65:  LDX #$03
L8B67:  LDA ($E0),Y
L8B69:  BEQ $8B7B
L8B6B:  INY
L8B6C:  STA $0410,X
L8B6F:  INX
L8B70:  LDA ($E0),Y
L8B72:  BEQ $8B7B
L8B74:  INY
L8B75:  STA $0410,X
L8B78:  INX
L8B79:  BNE $8B67
L8B7B:  STA $0410,X
L8B7E:  INX
L8B7F:  INY
L8B80:  LDA ($E0),Y
L8B82:  BNE $8B6B
L8B84:  STA $0410,X
L8B87:  INC $0410
L8B8A:  RTS

L8B8B:  .byte $10, $10, $10, $10, $00, $00, $00, $00, $10, $10, $10, $10, $20, $20, $20, $20
L8B9B:  .byte $3C, $25, $24, $21, $2C, $21, $3C, $25, $24, $21, $2C, $21, $3C, $25, $2C, $21
L8BAB:  .byte $1C, $25, $00, $21, $04, $21, $08, $21, $0C, $21, $10, $21, $08, $21, $10, $21
L8BBB:  .byte $3B, $25, $23, $21, $2B, $21, $3B, $25, $23, $21, $2B, $21, $23, $21, $23, $21
L8BCB:  .byte $1B, $25, $07, $21, $03, $21, $07, $21, $0B, $21, $0F, $21, $1B, $25, $0B, $21
L8BDB:  .byte $1A, $25, $1E, $25, $02, $21, $06, $21, $0A, $21, $0E, $21, $12, $21, $12, $21
L8BEB:  .byte $39, $25, $21, $21, $29, $21, $31, $21, $39, $25, $21, $21, $29, $21, $31, $21
L8BFB:  .byte $F9, $24, $FB, $24, $FD, $24, $E1, $20, $E5, $20, $E9, $20, $ED, $20, $F1, $20
L8C0B:  .byte $DB, $24, $CB, $20, $C3, $20, $C5, $20, $C7, $20, $CB, $20, $CF, $20, $C5, $20
L8C1B:  .byte $F2, $20, $F0, $20, $EE, $20, $EA, $20, $E6, $20, $E2, $20, $FE, $24, $FA, $24
L8C2B:  .byte $FE, $24, $E4, $20, $EE, $20, $FE, $24, $EE, $20, $E4, $20, $FE, $24, $E4, $20
L8C3B:  .byte $D9, $24, $C7, $20, $D1, $20, $D9, $24, $D1, $20, $C7, $20, $D9, $24, $C7, $20

VQCrowdTablePtrs:
L8C4B:  .word $8C79, $8C7E, $8C83, $8C88, $8C8D, $8C90, $8C93, $8C96
L8C5B:  .word $8C99, $8C9C, $8C9F, $8CA4, $8CA9, $8CAC, $8CAF, $8CB2
L8C6B:  .word $8CB5, $8CBA, $8CBF, $8CC2, $8CC5, $8CC8, $8CCD

VQCrowdTable:
L8C79:  .byte $F0, $00, $D2, $00, $00
L8C7E:  .byte $D3, $00, $D4, $00, $00
L8C83:  .byte $F3, $00, $F4, $00, $00
L8C88:  .byte $E6, $00, $E7, $00, $00
L8C8D:  .byte $F2, $00, $00
L8C90:  .byte $E5, $00, $00
L8C93:  .byte $EE, $00, $00
L8C96:  .byte $E4, $00, $00
L8C99:  .byte $ED, $00, $00
L8C9C:  .byte $E3, $00, $00
L8C9F:  .byte $EF, $00, $EC, $00, $00
L8CA4:  .byte $E1, $00, $E2, $00, $00
L8CA9:  .byte $EA, $00, $00
L8CAC:  .byte $96, $00, $00
L8CAF:  .byte $EB, $00, $00
L8CB2:  .byte $97, $00, $00
L8CB5:  .byte $92, $00, $93, $00, $00
L8CBA:  .byte $94, $00, $95, $00, $00
L8CBF:  .byte $D7, $00, $00
L8CC2:  .byte $D8, $00, $00
L8CC5:  .byte $D9, $00, $00
L8CC8:  .byte $F0, $00, $F1, $00, $00
L8CCD:  .byte $D5, $00, $D6, $00, $00

;----------------------------------------------------------------------------------------------------

; Crowd behavior tables.  CrowdTable1 is normal crowd, CrowdTable2 is end of match
CrowdDataPtrs:
L8CD2:  .word $0000, CrowdTable1, CrowdTable2

CrowdTable1:
L8CD8:  .byte $40, $C3, $4D, $CC, $61, $EA, $6C, $F0, $63, $E6, $6B, $EF, $42, $C5, $88, $37
L8CE8:  .byte $43, $C6, $4D, $CC, $64, $E8, $6C, $F1, $61, $EA, $6B, $EF, $44, $C8, $88, $58
L8CF8:  .byte $41, $CB, $4D, $CD, $60, $E2, $6C, $F0, $63, $E7, $6B, $EE, $42, $C4, $88, $28
L8D08:  .byte $43, $C7, $4D, $CD, $64, $E9, $6C, $F1, $61, $EB, $6B, $EE, $44, $C9, $88, $36
L8D18:  .byte $0F, $00

CrowdTable2:
L8D1A:  .byte $62, $E5, $60, $E2, $45, $C0, $C1, $D6, $60, $E3, $8F, $01, $D5, $08, $05, $63
L8D2A:  .byte $E7, $64, $E8, $4E, $D2, $D3, $D4, $61, $EB, $D0, $60, $E3, $62, $E5, $45, $C0
L8D3A:  .byte $C1, $D6, $60, $E2, $8F, $01, $D5, $08, $1F, $62, $E4, $4F, $D2, $D3, $D4, $61
L8D4A:  .byte $EA, $CC, $63, $E6, $62, $E4, $45, $C0, $C1, $D6, $64, $E9, $8F, $01, $D5, $88
L8D5A:  .byte $4A, $0F, $00

;----------------------------------------------------------------------------------------------------

ChkCreditsPassword:
L8D5D:  LDY #$28                ;Look for a A+B+select password(end credits).
L8D5F:  JSR FindSpecPassword    ;($8D8D)Look for a hard coded password.

L8D62:  BNE +
L8D64:  JSR CheckABSelect       ;($8DDE)Check that A+B+Select was pressed
L8D67:* RTS

ChkTysonPassword:
L8D68:  LDY #$32                ;Prepare to check entered password to start at Mike Tyson.
L8D6A:  BNE FindSpecPassword    ;($8D8D)Look for a hard coded password.

ChkAWCPassword2:
L8D6C:  LDX #$00                ;Compare $0110 to AWC password
L8D6E:  LDY #$1E                ;Start at the 4th entry in PswrdDatTbl.
L8D70:  BNE _FindSpecPassword   ;Branch always.

ChkAWCPassword:
L8D72:  LDY #$1E                ;Look for a A+B+select password(another world circuit).
L8D74:  JSR FindSpecPassword    ;($8D8D)Look for a hard coded password.

L8D77:  BNE +
L8D79:  JSR CheckABSelect       ;($8DDE)Check that A+B+Select was pressed
L8D7C:* RTS

ChkBusyPassword:
L8D7D:  LDY #$00                ;Prepare to look for busy signal 1 password.
L8D7F:  JSR FindSpecPassword    ;($8D8D)Look for a hard coded password.
L8D82:  BEQ ChkPswdTblEnd

L8D84:  LDY #$0A                ;Prepare to look for busy signal 2 password.
L8D86:  JSR FindSpecPassword    ;($8D8D)Look for a hard coded password.
L8D89:  BEQ ChkPswdTblEnd

L8D8B:  LDY #$14                ;Prepare to look for busy signal 3 password.

FindSpecPassword:
L8D8D:  LDX #$10                ;Prepare to look for a hard coded password

_FindSpecPassword:
L8D8F:  LDA #$0A                ;Prepare to check 10 password digits.
L8D91:  STA GenByteE0           ;

ChkPswdTblLoop:
L8D93:  LDA SavedPasskey,X     ;Does the current digit in the user entered password match the -->
L8D96:  CMP PswrdDatTbl,Y       ;entry in the hard coded password table?
L8D99:  BNE ChkPswdTblEnd       ;If not, branch to exit.

L8D9B:  INX                     ;Move to next digit in used enterd password and PswrdDatTbl.
L8D9C:  INY                     ;

L8D9D:  DEC GenByteE0           ;Have all 10 password digits been compared in PswrdDatTbl?
L8D9F:  BNE ChkPswdTblLoop      ;If not, branch to check another digit.

ChkPswdTblEnd:
L8DA1:  RTS                     ;Done checking for special password. 0=found, non-zero=not found.

;The following is a table of the 6 special passwords in the game.
;Entry 0: 075-541-6113  Busy signal 1.
;Entry 1: 800-422-2602  Busy signal 2.
;Entry 2: 206-882-2040  Busy signal 3.
;Entry 3: 135-792-4680  Another world circuit. Must press A + B + select.
;Entry 4: 106-113-0120  End credits. Must press A + B + select.
;Entry 5: 007-373-5963  Start at Mike Tyson.

PswrdDatTbl:
L8DA2:  .byte $00, $07, $05, $05, $04, $01, $06, $01, $01, $03
L8DAC:  .byte $08, $00, $00, $04, $02, $02, $02, $06, $00, $02
L8DB6:  .byte $02, $00, $06, $08, $08, $02, $02, $00, $04, $00
L8DC0:  .byte $01, $03, $05, $07, $09, $02, $04, $06, $08, $00
L8DCA:  .byte $01, $00, $06, $01, $01, $03, $00, $01, $02, $00
L8DD4:  .byte $00, $00, $07, $03, $07, $03, $05, $09, $06, $03

CheckABSelect:
L8DDE:  LDA A1History
L8DE0:  ORA B1History
L8DE2:  AND Sel1History
L8DE4:  BPL $8DEA
L8DE6:  LDA #$00
L8DE8:  BEQ $8DEC
L8DEA:  LDA #$01
L8DEC:  RTS

ClearPassword:
L8DED:  LDY #$30
L8DEF:  LDA #$FF
L8DF1:  JSR _FillPassword       ;($8E15)Fill $0140 through $0149 with spaces

DisplayPassword:
L8DF4:  JSR $802D               ;($8E53)Copy password into $0150 with grouping
L8DF7:  LDY #$0D
L8DF9:  LDX #$00
L8DFB:  LDA $0150,X             ;Copy $0150 through $015B -->
L8DFE:  STA $0411,Y             ;into $041E through $0429
L8E01:  INY
L8E02:  INX
L8E03:  CPX #$0C
L8E05:  BNE $8DFB
L8E07:  LDA #$00
L8E09:  STA $0411,Y             ;Set $042A to zero
L8E0C:  INY
L8E0D:  STA $0411,Y             ;Set $042B to zero
L8E10:  RTS

FillPswdDashes:
L8E11:  LDY #$00
L8E13:  LDA #$27

_FillPassword:
L8E15:  LDX #$0A
L8E17:  STA SavedPasskey,Y     ;($0110)
L8E1A:  INY
L8E1B:  DEX
L8E1C:  BNE $8E17
L8E1E:  RTS

L8E1F:  LDY #$10
L8E21:  BNE $8E13
L8E23:  JSR $802A
L8E26:  JSR DisplayPassword     ;($8DF4)
L8E29:  LDA #$C4
L8E2B:  STA $0412
L8E2E:  LDA #$81
L8E30:  STA $0410
L8E33:  RTS

TranslatePswd2:
L8E34:  LDY #$19
L8E36:  JSR $8E3D
L8E39:  BMI $8E26

TranslatePswd:
L8E3B:  LDY #$09

_TranslateDigits:
L8E3D:  LDX #$0A
L8E3F:  LDA #$00
L8E41:  STA $0140,X
L8E44:  DEX
L8E45:  LDA SavedPasskey,Y
L8E48:  STA $0140,X
L8E4B:  INC $0140,X
L8E4E:  DEY
L8E4F:  DEX
L8E50:  BPL $8E45
L8E52:  RTS

; Copy password from $0140 to $0150, inserting #$FF between digit groups
GroupPswdDigits:
L8E53:  LDY #$00
L8E55:  LDX #$00

L8E57:  LDA $0140,Y
L8E5A:  STA $0150,X
L8E5D:  INY
L8E5E:  INX
L8E5F:  CPX #$03
L8E61:  BEQ $8E6C

L8E63:  CPX #$07
L8E65:  BEQ $8E6C

L8E67:  CPX #$0D
L8E69:  BNE $8E57
L8E6B:  RTS

L8E6C:  LDA #$FF
L8E6E:  STA $0150,X
L8E71:  INX
L8E72:  BNE $8E57

L8E74:  LDA #$0C
L8E76:  JSR $8E84
L8E79:  DEY
L8E7A:  BPL $8E82
L8E7C:  LDA #$0C
L8E7E:  JSR $8E84
L8E81:  INY
L8E82:  LDA #$03
L8E84:  AND $0130,X
L8E87:  ORA $0100,Y
L8E8A:  STA $0100,Y
L8E8D:  RTS

L8E8E:  LDA $0100,Y
L8E91:  DEY
L8E92:  BPL $8E98

L8E94:  LDA $0100,Y
L8E97:  INY
L8E98:  AND #$0C
L8E9A:  STA $0105
L8E9D:  LDA $0100,Y
L8EA0:  AND #$03
L8EA2:  ORA $0105
L8EA5:  STA $0130,X
L8EA8:  RTS

L8EA9:  LDX #$05
L8EAB:  LDA #$00
L8EAD:  CLC
L8EAE:  ADC $0130,X
L8EB1:  DEX
L8EB2:  BPL $8EAE
L8EB4:  EOR #$FF
L8EB6:  CMP $0138
L8EB9:  RTS

VerifyCheckPoint:
L8EBA:  LDY #$00
L8EBC:  BEQ $8EC3

L8EBE:  JMP _PasswordFailed     ;($8FC3)

ChkNormalPswd:
L8EC1:  LDY #$10

_VerifyPassword:
L8EC3:  LDX #$00
L8EC5:  LDA SavedPasskey,Y
L8EC8:  SEC
L8EC9:  SBC PasswordSalt,X      ;($9101)
L8ECC:  BPL $8ED1
L8ECE:  CLC
L8ECF:  ADC #$0A
L8ED1:  STA $0100,X
L8ED4:  INY
L8ED5:  INX
L8ED6:  CPX #$0A
L8ED8:  BNE $8EC5
L8EDA:  LDA $0109
L8EDD:  AND #$03
L8EDF:  STA $010E
L8EE2:  BEQ $8F11
L8EE4:  STA $010D
L8EE7:  LDX #$00
L8EE9:  LSR $0100,X
L8EEC:  LDA #$00
L8EEE:  ROL
L8EEF:  ROL
L8EF0:  ROL
L8EF1:  ROL
L8EF2:  INX
L8EF3:  CPX #$0A
L8EF5:  BEQ $8F00
L8EF7:  ORA $0100,X
L8EFA:  STA $0100,X
L8EFD:  JMP $8EE9
L8F00:  LDA $0109
L8F03:  AND #$02
L8F05:  ASL
L8F06:  ORA $0100
L8F09:  STA $0100
L8F0C:  DEC $010D
L8F0F:  BNE $8EE7
L8F11:  LDX #$00
L8F13:  LDY #$00
L8F15:  LDA $0100,X
L8F18:  ASL
L8F19:  ASL
L8F1A:  ASL
L8F1B:  INX
L8F1C:  ORA $0100,X
L8F1F:  STA $0100,Y
L8F22:  INY
L8F23:  INX
L8F24:  CPX #$0A
L8F26:  BNE $8F15
L8F28:  LDX #$00
L8F2A:  LDY #$00
L8F2C:  JSR $8E94
L8F2F:  INX
L8F30:  LDY #$03
L8F32:  JSR $8E8E
L8F35:  LDX #$04
L8F37:  LDY #$02
L8F39:  JSR $8E94
L8F3C:  INX
L8F3D:  LDY #$01
L8F3F:  JSR $8E8E
L8F42:  LDY #$02
L8F44:  LDA #$00
L8F46:  LSR
L8F47:  LSR
L8F48:  STA $0138
L8F4B:  LDA $0100,Y
L8F4E:  AND #$30
L8F50:  ORA $0138
L8F53:  DEY
L8F54:  BPL $8F46
L8F56:  STA $0138
L8F59:  LDA $0103
L8F5C:  AND #$30
L8F5E:  ASL
L8F5F:  ASL
L8F60:  ORA $0138
L8F63:  STA $0138
L8F66:  LDA $0104
L8F69:  TAX
L8F6A:  AND #$0C
L8F6C:  STA $0137
L8F6F:  TXA
L8F70:  LSR
L8F71:  LSR
L8F72:  LSR
L8F73:  LSR
L8F74:  ORA $0137
L8F77:  STA $0137
L8F7A:  AND #$03
L8F7C:  STA $0133
L8F7F:  LDA $0137
L8F82:  LSR
L8F83:  LSR
L8F84:  STA $0136
L8F87:  JSR $8EA9
L8F8A:  BNE _PasswordFailed     ;($8FC3)
L8F8C:  LDY $0137
L8F8F:  LDA $90F1,Y
L8F92:  BMI _PasswordFailed     ;($8FC3)
L8F94:  CMP $010E
L8F97:  BNE _PasswordFailed     ;($8FC3)
L8F99:  LDX #$05
L8F9B:  LDA $0130,X
L8F9E:  CMP #$0A
L8FA0:  BCS _PasswordFailed     ;($8FC3)
L8FA2:  DEX
L8FA3:  BPL $8F9B
L8FA5:  LDA $0130
L8FA8:  BNE $8FB1
L8FAA:  LDA $0131
L8FAD:  CMP #$03
L8FAF:  BCC _PasswordFailed     ;($8FC3)
L8FB1:  CMP $0134
L8FB4:  BCC _PasswordFailed     ;($8FC3)
L8FB6:  BNE $8FC0
L8FB8:  LDA $0131
L8FBB:  CMP $0135
L8FBE:  BCC _PasswordFailed     ;($8FC3)
L8FC0:  LDA #$00
L8FC2:  RTS

_PasswordFailed:
L8FC3:  LDA #$01
L8FC5:  RTS

; Save the password that was entered as the current checkpoint
SavePassword:
L8FC6:  LDY #$09
L8FC8:  LDA PasskeyDigits,Y      ;($0120)
L8FCB:  STA SavedPasskey,Y
L8FCE:  DEY
L8FCF:  BPL $8FC8
L8FD1:  RTS

LoadCheckPoint:
L8FD2:  JSR DoVerifyCheckPoint  ;($8030)
L8FD5:  BNE _Clear170           ;($8FE5)
L8FD7:  LDY #$05
L8FD9:  LDA $0130,Y
L8FDC:  STA $0170,Y
L8FDF:  DEY
L8FE0:  BPL $8FD9
L8FE2:  LDA #$00
L8FE4:  RTS

;; TODO: Not sure what role $0170-$0175 play yet
_Clear170:
L8FE5:  LDY #$05
L8FE7:  LDA #$00
L8FE9:  STA $0170,Y
L8FEC:  DEY
L8FED:  BPL $8FE9
L8FEF:  RTS

;; Generate Pass Key?
L8FF0:  LDY #$05
L8FF2:  LDA $0170,Y
L8FF5:  STA $0130,Y
L8FF8:  DEY
L8FF9:  BPL $8FF2
L8FFB:  JSR $8EA9
L8FFE:  STA $0138
L9001:  LDA $09
L9003:  AND #$30
L9005:  EOR #$30
L9007:  SEC
L9008:  SBC #$10
L900A:  LSR
L900B:  LSR
L900C:  STA $0136
L900F:  LDA $0133
L9012:  ORA $0136
L9015:  STA $0137
L9018:  TAY
L9019:  LDA $90F1,Y
L901C:  STA $010D
L901F:  LDX #$04
L9021:  LDA #$00
L9023:  STA $0100,X
L9026:  DEX
L9027:  BPL $9023
L9029:  LDX #$00
L902B:  LDY #$00
L902D:  JSR $8E7C
L9030:  INX
L9031:  LDY #$03
L9033:  JSR $8E74
L9036:  LDX #$04
L9038:  LDY #$02
L903A:  JSR $8E7C
L903D:  INX
L903E:  LDY #$01
L9040:  JSR $8E74
L9043:  LDA $0138
L9046:  LDX #$00
L9048:  TAY
L9049:  AND #$30
L904B:  ORA $0100,X
L904E:  STA $0100,X
L9051:  TYA
L9052:  ASL
L9053:  ASL
L9054:  INX
L9055:  CPX #$03
L9057:  BNE $9048
L9059:  LDA $0138
L905C:  LSR
L905D:  LSR
L905E:  AND #$30
L9060:  ORA $0103
L9063:  STA $0103
L9066:  LDA $0137
L9069:  ASL
L906A:  ASL
L906B:  ASL
L906C:  ASL
L906D:  AND #$30
L906F:  STA $0104
L9072:  LDA $0137
L9075:  AND #$0C
L9077:  ORA $0104
L907A:  STA $0104
L907D:  LDY #$09
L907F:  LDX #$04
L9081:  LDA $0100,X
L9084:  ASL
L9085:  ASL
L9086:  ASL
L9087:  ASL
L9088:  ASL
L9089:  STA SavedPasskey,Y
L908C:  DEY
L908D:  LDA $0100,X
L9090:  ASL
L9091:  ASL
L9092:  AND #$E0
L9094:  STA SavedPasskey,Y
L9097:  DEY
L9098:  DEX
L9099:  BPL $9081
L909B:  LDA $010D
L909E:  BEQ $90C2
L90A0:  STA $010B
L90A3:  LDX #$09
L90A5:  ASL SavedPasskey,X
L90A8:  LDA #$00
L90AA:  ROR
L90AB:  DEX
L90AC:  BMI $90BA
L90AE:  ROR
L90AF:  ROR
L90B0:  ROR
L90B1:  ORA SavedPasskey,X
L90B4:  STA SavedPasskey,X
L90B7:  JMP $90A5
L90BA:  STA $0119
L90BD:  DEC $010B
L90C0:  BNE $90A3
L90C2:  LDX #$09
L90C4:  LDA SavedPasskey,X
L90C7:  LSR
L90C8:  LSR
L90C9:  LSR
L90CA:  LSR
L90CB:  LSR
L90CC:  STA SavedPasskey,X
L90CF:  DEX
L90D0:  BPL $90C4
L90D2:  LDA $010D
L90D5:  ORA $0119
L90D8:  STA $0119

_AddSalt:
L90DB:  LDY #$09
L90DD:  LDA SavedPasskey,Y
L90E0:  CLC
L90E1:  ADC PasswordSalt,Y      ;($9101)
L90E4:  CMP #$0A
L90E6:  BCC $90EA
L90E8:  SBC #$0A
L90EA:  STA SavedPasskey,Y
L90ED:  DEY
L90EE:  BPL $90DD
L90F0:  RTS

L90F1:  .byte $01, $02, $00, $FF, $02, $00, $01, $FF, $00, $01, $02, $FF, $FF, $FF, $FF, $FF

PasswordSalt:
L9101:  .byte $06, $03, $05, $07, $09, $00, $01, $04, $02, $08

;Compare whether a random value 0-15 is greater than A
;  Result is obtained by checking the carry bit
RandomChance16:
L910B:  STA $EF
L910D:  LDA #$0F

;Compare whether a random value is greater than the value in $EF
;  The value is in the range 0 - (A-1)
;  Result is obtained by checking the carry bit
_RandomChance:
L910F:  STA $EE
L9111:  LDA $EF
L9113:  CMP $EE
L9115:  BEQ $9127
L9117:  LDA RNGValue            ;($18)
L9119:  JSR _RotateRNG          ;($9151)
L911C:  AND $EE
L911E:  STA $EE
L9120:  LDA $EF
L9122:  CMP $EE
L9124:  BNE $9127
L9126:  CLC
L9127:  RTS

;Compare whether a random value 0-127 is greater than A
;  Result is obtained by checking the carry bit
RandomChance128:
L9128:  STA $EF
L912A:  LDA #$7F
L912C:  BNE _RandomChance       ;($910F)

;Compare whether a random value 0-255 is greater than A
;  Result is obtained by checking the carry bit
RandomChance256:
L912E:  STA $EF
L9130:  LDA #$FF
L9132:  BNE _RandomChance       ;($910F)

IndJumpFromTable:
L9134:  STY $04C9
L9137:  ASL
L9138:  TAY
L9139:  PLA
L913A:  STA $EE
L913C:  PLA
L913D:  STA $EF
L913F:  INY
L9140:  LDA ($EE),Y
L9142:  PHA
L9143:  INY
L9144:  LDA ($EE),Y
L9146:  STA $EF
L9148:  PLA
L9149:  STA $EE
L914B:  LDY $04C9
L914E:  JMP ($00EE)

;Rotate the RNG value right by 3. Happens after every RNG read
;Alternate name because this function also exists in bank DEF
_RotateRNG:
L9151:  ROR RNGValue            ;($18)
L9153:  ROR RNGValue            ;($18)
L9155:  ROR RNGValue            ;($18)
L9157:  RTS

;Divide the A register by 16
;Alternate name because this function also exists in bank DEF
_Div16:
L9158:  LSR
L9159:  LSR
L915A:  LSR
L915B:  LSR
L915C:  RTS

;----------------------------------------------------------------------------------------------------

;Unused.
L915D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L916D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L917D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L918D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L919D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91AD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91BD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91CD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91DD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91ED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91FD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L920D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L921D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L922D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L923D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L924D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L925D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L926D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L927D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L928D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L929D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92AD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92BD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92CD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92DD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92ED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92FD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L930D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L931D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L932D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L933D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L934D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L935D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L936D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L937D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L938D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L939D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93AD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93BD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93CD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93DD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93ED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93FD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L940D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L941D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L942D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L943D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L944D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L945D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L946D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L947D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L948D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L949D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94AD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94BD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94CD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94DD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94ED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94FD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L950D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L951D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L952D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L953D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L954D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L955D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L956D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L957D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L958D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L959D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L95AD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L95BD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L95CD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L95DD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L95ED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L95FD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L960D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L961D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L962D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L963D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L964D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L965D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L966D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L967D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L968D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L969D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L96AD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L96BD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L96CD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L96DD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L96ED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L96FD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L970D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L971D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L972D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L973D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L974D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L975D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L976D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L977D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L978D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L979D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L97AD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L97BD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L97CD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L97DD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L97ED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L97FD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L980D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L981D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L982D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L983D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L984D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L985D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L986D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L987D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L988D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L989D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L98AD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L98BD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L98CD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L98DD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L98ED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L98FD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L990D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L991D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L992D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L993D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L994D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L995D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L996D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L997D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L998D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L999D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L99AD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L99BD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L99CD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L99DD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L99ED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L99FD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A0D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A1D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A2D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A3D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A4D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A5D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A6D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A7D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A8D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A9D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9AAD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9ABD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9ACD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9ADD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9AED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9AFD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B0D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B1D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B2D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B3D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B4D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B5D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B6D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B7D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B8D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B9D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9BAD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9BBD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9BCD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9BDD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9BED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9BFD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C0D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C1D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C2D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C3D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C4D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C5D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C6D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C7D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C8D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C9D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9CAD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9CBD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9CCD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9CDD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9CED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9CFD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D0D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D1D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D2D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D3D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D4D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D5D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D6D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D7D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D8D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D9D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9DAD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9DBD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9DCD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9DDD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9DED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9DFD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E0D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E1D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E2D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E3D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E4D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E5D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E6D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E7D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E8D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E9D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9EAD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9EBD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9ECD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9EDD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9EED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9EFD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F0D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F1D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F2D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F3D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F4D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F5D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F6D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F7D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F8D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F9D:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FAD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FBD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FCD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FDD:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FED:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FFD:  .byte $00, $00, $00
