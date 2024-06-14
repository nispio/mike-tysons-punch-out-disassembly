
.include "Mike_Tysons_Punchout_Defines.asm"

.org $8000
.segment "PRG_BankB"

L8000:  JMP $8020
L8003:  JMP $8119
L8006:  JMP $8319
L8009:  JMP $8280

;Unused.
L800C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L801C:  .byte $00, $00, $00, $00

L8020:  LDX #$00
L8022:  STX $60
L8024:  LDA $64
L8026:  STA PPUAddress
L8029:  LDA $63
L802B:  STA PPUAddress
L802E:  LDY #$00
L8030:  LDA ($66),Y
L8032:  BEQ $8073
L8034:  INY
L8035:  STA PPUIOReg
L8038:  LDA ($66),Y
L803A:  BEQ $8073
L803C:  INY
L803D:  STA PPUIOReg
L8040:  LDA ($66),Y
L8042:  BEQ $8073
L8044:  INY
L8045:  STA PPUIOReg
L8048:  LDA ($66),Y
L804A:  BEQ $8073
L804C:  INY
L804D:  STA PPUIOReg
L8050:  LDA ($66),Y
L8052:  BEQ $8073
L8054:  INY
L8055:  STA PPUIOReg
L8058:  LDA ($66),Y
L805A:  BEQ $8073
L805C:  INY
L805D:  STA PPUIOReg
L8060:  LDA ($66),Y
L8062:  BEQ $8073
L8064:  INY
L8065:  STA PPUIOReg
L8068:  LDA ($66),Y
L806A:  BEQ $8073
L806C:  INY
L806D:  STA PPUIOReg
L8070:  JMP $8030
L8073:  INY
L8074:  LDA ($66),Y
L8076:  INY
L8077:  CMP #$FE
L8079:  BNE $80FA
L807B:  LDA ($66),Y
L807D:  INY
L807E:  TAX
L807F:  LDA ($66),Y
L8081:  INY
L8082:  CPX #$05
L8084:  BCC $80E5
L8086:  CLC
L8087:  BEQ $80E0
L8089:  CPX #$07
L808B:  BCC $80DB
L808D:  CLC
L808E:  BEQ $80D6
L8090:  CPX #$0B
L8092:  BCC $8099
L8094:  CLC
L8095:  BEQ $80C2
L8097:  BNE $80A2
L8099:  CPX #$09
L809B:  BCC $80D1
L809D:  CLC
L809E:  BEQ $80CC
L80A0:  BNE $80C7
L80A2:  CPX #$0D
L80A4:  BCC $80BD
L80A6:  CLC
L80A7:  BEQ $80B8
L80A9:  CPX #$0F
L80AB:  BCC $80B3
L80AD:  CLC
L80AE:  STA PPUIOReg
L80B1:  ADC #$01
L80B3:  STA PPUIOReg
L80B6:  ADC #$01
L80B8:  STA PPUIOReg
L80BB:  ADC #$01
L80BD:  STA PPUIOReg
L80C0:  ADC #$01
L80C2:  STA PPUIOReg
L80C5:  ADC #$01
L80C7:  STA PPUIOReg
L80CA:  ADC #$01
L80CC:  STA PPUIOReg
L80CF:  ADC #$01
L80D1:  STA PPUIOReg
L80D4:  ADC #$01
L80D6:  STA PPUIOReg
L80D9:  ADC #$01
L80DB:  STA PPUIOReg
L80DE:  ADC #$01
L80E0:  STA PPUIOReg
L80E3:  ADC #$01
L80E5:  STA PPUIOReg
L80E8:  ADC #$01
L80EA:  STA PPUIOReg
L80ED:  ADC #$01
L80EF:  STA PPUIOReg
L80F2:  ADC #$01
L80F4:  STA PPUIOReg
L80F7:  JMP $8030
L80FA:  CMP #$FD
L80FC:  BEQ $8114
L80FE:  TAX
L80FF:  LDA $64
L8101:  STA PPUAddress
L8104:  INC $63
L8106:  LDA $63
L8108:  STA PPUAddress
L810B:  TXA
L810C:  BEQ $8111
L810E:  JMP $8035
L8111:  JMP $8074
L8114:  LDA ($66),Y
L8116:  STA $69
L8118:  RTS

L8119:  LDX $04
L811B:  INX
L811C:  BEQ $8121
L811E:  JMP $8207
L8121:  LDA MacStatus           ;($50)
L8123:  BEQ $8186
L8125:  CMP #$40
L8127:  BCS $8186
L8129:  LDA MacStateStatus      ;($51)
L812B:  BMI $8186
L812D:  LDA MacCanPunch         ;($BC)
L812F:  BNE $8134
L8131:  JMP $81C8
L8134:  LDY #$00
L8136:  LDX #$00
L8138:  JSR $81EF
L813B:  TYA
L813C:  BEQ $814C
L813E:  LDA DPad1Status         ;($D2)
L8140:  AND #$08
L8142:  BNE $8148
L8144:  LDA #$89
L8146:  BNE $8180
L8148:  LDA #$8B
L814A:  BNE $8160
L814C:  LDX #$02
L814E:  JSR $81EF
L8151:  TYA
L8152:  BEQ $8164
L8154:  LDA DPad1Status         ;($D2)
L8156:  AND #$08
L8158:  BNE $815E
L815A:  LDA #$8A
L815C:  BNE $8180
L815E:  LDA #$8C
L8160:  LDX #$01
L8162:  BNE $8182
L8164:  LDA NumStars            ;($0342)
L8167:  BEQ $8187
L8169:  LDX #$04
L816B:  JSR $81EF
L816E:  TYA
L816F:  BEQ $8187
L8171:  LDA #$FF
L8173:  STA $0341
L8176:  LDA $0348
L8179:  BEQ $817E
L817B:  DEC $0348
L817E:  LDA #$8D
L8180:  LDX #$00
L8182:  STA MacStatus           ;($50)
L8184:  STX $6B
L8186:  RTS

L8187:  LDA DPad1History        ;($D3)
L8189:  BPL $81B4
L818B:  AND #$7F
L818D:  TAX
L818E:  LDY DPad1Status         ;($D2)
L8190:  TYA
L8191:  AND #$01
L8193:  BEQ $8199
L8195:  LDA #$83
L8197:  BNE $81AB
L8199:  TYA
L819A:  AND #$02
L819C:  BEQ $81A2
L819E:  LDA #$85
L81A0:  BNE $81AB
L81A2:  TYA
L81A3:  AND #$04
L81A5:  BEQ $81AF
L81A7:  LDA #$87
L81A9:  BNE $81AB
L81AB:  STA MacStatus           ;($50)
L81AD:  STX DPad1History        ;($D3)
L81AF:  LDA #$00
L81B1:  STA $6B
L81B3:  RTS

L81B4:  TAX
L81B5:  LDA $6B
L81B7:  BEQ $81B3
L81B9:  LDA Joy1Buttons
L81BB:  AND #$0F
L81BD:  ROR
L81BE:  BCS $8195
L81C0:  ROR
L81C1:  BCS $819E
L81C3:  ROR
L81C4:  BCS $81A7
L81C6:  BCC $81AF
L81C8:  LDY #$00
L81CA:  LDX #$00
L81CC:  JSR $81EF
L81CF:  TYA
L81D0:  BEQ $81D4
L81D2:  BNE $81E6
L81D4:  LDX #$02
L81D6:  JSR $81EF
L81D9:  TYA
L81DA:  BEQ $81DE
L81DC:  BNE $81E6
L81DE:  LDX #$04
L81E0:  JSR $81EF
L81E3:  TYA
L81E4:  BEQ $8187
L81E6:  LDA #$0A
L81E8:  STA MacStateIndex       ;($53)
L81EA:  LDA #$00
L81EC:  STA $6B
L81EE:  RTS

L81EF:  LDA A1History,X         ;($D5)
L81F1:  BPL $81F8
L81F3:  AND #$7F
L81F5:  STA A1History,X         ;($D5)
L81F7:  INY
L81F8:  RTS

L81F9:  LDA #$01
L81FB:  STA $04B0
L81FE:  LDY #$00
L8200:  STY $04B2
L8203:  INY
L8204:  STY $04B1
L8207:  LDA $04B0
L820A:  BEQ $823D
L820C:  BMI $81F9
L820E:  LDA #$00
L8210:  STA DPad1History        ;($D3)
L8212:  STA A1History           ;($D5)
L8214:  STA B1History           ;($D7)
L8216:  LDA MacStatus           ;($50)
L8218:  CMP #$01
L821A:  BNE $823D
L821C:  LDA MacStateStatus      ;($51)
L821E:  BMI $823D
L8220:  DEC $04B1
L8223:  BNE $823D
L8225:  INC $04B1
L8228:  LDY $04B2
L822B:  LDA $9500,Y
L822E:  CMP #$80
L8230:  BNE $823E
L8232:  INY
L8233:  LDA $9500,Y
L8236:  STA $04B1
L8239:  INY
L823A:  STY $04B2
L823D:  RTS

L823E:  INY
L823F:  STY $04B2
L8242:  TAY
L8243:  LDX MacCanPunch         ;($BC)
L8245:  BNE $824A
L8247:  JMP $826F
L824A:  LDX #$01
L824C:  CMP #$8B
L824E:  BCC $8268
L8250:  CMP #$8D
L8252:  BCC $826A
L8254:  BNE $8268
L8256:  LDA NumStars            ;($0342)
L8259:  BEQ $826E
L825B:  LDA #$FF
L825D:  STA $0341
L8260:  LDA $0348
L8263:  BEQ $8268
L8265:  DEC $0348
L8268:  LDX #$00
L826A:  STX $6B
L826C:  STY MacStatus           ;($50)
L826E:  RTS

L826F:  CMP #$89
L8271:  BCC $8268
L8273:  CMP #$8E
L8275:  BEQ $8268
L8277:  LDA #$0A
L8279:  STA MacStateIndex       ;($53)
L827B:  LDA #$00
L827D:  STA $6B
L827F:  RTS

L8280:  LDA $60
L8282:  BPL $82CB
L8284:  LDA $61
L8286:  BMI $8297
L8288:  ASL
L8289:  TAY
L828A:  LDA $8800,Y
L828D:  INY
L828E:  STA $63
L8290:  LDA $8800,Y
L8293:  STA $64
L8295:  BNE $82A4
L8297:  ASL
L8298:  TAY
L8299:  LDA $88C4,Y
L829C:  INY
L829D:  STA $63
L829F:  LDA $88C4,Y
L82A2:  STA $64
L82A4:  LDY #$00
L82A6:  LDA ($63),Y
L82A8:  INY
L82A9:  TAX
L82AA:  LDA $8A3F,X
L82AD:  INX
L82AE:  STA $E0
L82B0:  LDA $8A3F,X
L82B3:  STA $E1
L82B5:  LDA ($63),Y
L82B7:  INY
L82B8:  STA $66
L82BA:  LDA ($63),Y
L82BC:  INY
L82BD:  STA $67
L82BF:  LDA $E0
L82C1:  STA $63
L82C3:  LDA $E1
L82C5:  STA $64
L82C7:  LDX #$01
L82C9:  STX $60
L82CB:  RTS

L82CC:  AND #$7F
L82CE:  STA MacStatus           ;($50)
L82D0:  LDA #$80
L82D2:  ORA MacStateStatus      ;($51)
L82D4:  STA MacStateStatus      ;($51)
L82D6:  LDY #$01
L82D8:  STY MacStateTimer       ;($52)
L82DA:  DEY
L82DB:  STY MacStateIndex       ;($53)
L82DD:  STY $56
L82DF:  STY $58
L82E1:  STY $59
L82E3:  LDA ComboTimer          ;($4A)
L82E5:  BEQ $82EC
L82E7:  LDA ComboCountDown      ;($4B)
L82E9:  BEQ $82EC
L82EB:  INY
L82EC:  STY $5B
L82EE:  LDY #$74
L82F0:  LDX #$04
L82F2:  JSR $85D1
L82F5:  LDA MacStatus           ;($50)
L82F7:  CMP #$40
L82F9:  BCS $830A
L82FB:  ASL
L82FC:  TAY
L82FD:  LDA $9800,Y
L8300:  STA MacStBasePtrLB      ;($54)
L8302:  INY
L8303:  LDA $9800,Y
L8306:  STA MacStBasePtrUB      ;($55)
L8308:  BNE $8319
L830A:  SBC #$40
L830C:  ASL
L830D:  TAY
L830E:  LDA $982C,Y
L8311:  STA MacStBasePtrLB      ;($54)
L8313:  INY
L8314:  LDA $982C,Y
L8317:  STA MacStBasePtrUB      ;($55)
L8319:  LDA MacStatus           ;($50)
L831B:  BEQ $8362
L831D:  BMI $82CC
L831F:  DEC MacStateTimer       ;($52)
L8321:  BNE $8362
L8323:  INC MacStateTimer       ;($52)
L8325:  LDY MacStateIndex       ;($53)
L8327:  LDA (MacStBasePtr),Y    ;($54)
L8329:  INC MacStateIndex       ;($53)
L832B:  AND #$0F
L832D:  TAX
L832E:  LDA (MacStBasePtr),Y    ;($54)
L8330:  INY
L8331:  LSR
L8332:  LSR
L8333:  LSR
L8334:  LSR
L8335:  JSR $860F

L8338:  .word $8363, $8371, $837F, $838B, $839C, $83A7, $83A7, $83A7
L8348:  .word $83A7, $83AE, $83AE, $83AE, $83AE, $83AE, $83AE, $84EC

L8358:  LDY MacStateIndex       ;($53)
L835A:  LDA (MacStBasePtr),Y    ;($54)
L835C:  BNE $8362
L835E:  INC MacStateIndex       ;($53)
L8360:  BNE $8325
L8362:  RTS
L8363:  STX MacStateTimer       ;($52)
L8365:  LDA (MacStBasePtr),Y    ;($54)
L8367:  INY
L8368:  STA $61
L836A:  LDA #$80
L836C:  STA $60
L836E:  STY MacStateIndex       ;($53)
L8370:  RTS
L8371:  STX MacStateTimer       ;($52)
L8373:  LDA (MacStBasePtr),Y    ;($54)
L8375:  INY
L8376:  STA $61
L8378:  LDA (MacStBasePtr),Y    ;($54)
L837A:  INY
L837B:  STA $15
L837D:  BNE $836A
L837F:  STX MacStateTimer       ;($52)
L8381:  LDA (MacStBasePtr),Y    ;($54)
L8383:  INY
L8384:  CLC
L8385:  ADC $15
L8387:  STA $15
L8389:  BNE $836E
L838B:  TXA
L838C:  JSR $85E2
L838F:  BCC $8399
L8391:  LDA (MacStBasePtr),Y    ;($54)
L8393:  TAY
L8394:  STY MacStateIndex       ;($53)
L8396:  JMP $8325
L8399:  INY
L839A:  BNE $8394
L839C:  LDA (MacStBasePtr),Y    ;($54)
L839E:  INY
L839F:  STA $61
L83A1:  LDA #$80
L83A3:  STA $60
L83A5:  BNE $837F
L83A7:  LDA (MacStBasePtr),Y    ;($54)
L83A9:  INC MacStateIndex       ;($53)
L83AB:  STA MacStateTimer       ;($52)
L83AD:  RTS
L83AE:  TXA
L83AF:  JSR $860F

L83B2:  .word $83CE, $83D2, $83D6, $83F4, $8417, $8459, $8465, $8482
L83C2:  .word $848F, $8493, $84AF, $84BE, $84CD, $84E1

L83CE:  LDA #$09
L83D0:  BNE $83D8
L83D2:  LDA #$0A
L83D4:  BNE $83D8
L83D6:  LDA #$04
L83D8:  STA $E0
L83DA:  LDA DPad1History        ;($D3)
L83DC:  BPL $83F1
L83DE:  AND #$7F
L83E0:  TAX
L83E1:  LDA DPad1Status         ;($D2)
L83E3:  AND $E0
L83E5:  BEQ $83F1
L83E7:  STX DPad1History        ;($D3)
L83E9:  LDA (MacStBasePtr),Y    ;($54)
L83EB:  TAY
L83EC:  STY MacStateIndex       ;($53)
L83EE:  JMP $8325
L83F1:  INY
L83F2:  BNE $83EC
L83F4:  LDA (MacStBasePtr),Y    ;($54)
L83F6:  INY
L83F7:  STA $E0
L83F9:  LDA #$00
L83FB:  STA $E1
L83FD:  LDA (MacStBasePtr),Y    ;($54)
L83FF:  INY
L8400:  STY MacStateIndex       ;($53)
L8402:  LDY #$00
L8404:  CMP ($E0),Y
L8406:  BNE $8412
L8408:  LDY MacStateIndex       ;($53)
L840A:  LDA (MacStBasePtr),Y    ;($54)
L840C:  TAY
L840D:  STY MacStateIndex       ;($53)
L840F:  JMP $8325
L8412:  LDY MacStateIndex       ;($53)
L8414:  INY
L8415:  BNE $840D
L8417:  LDA $6A
L8419:  BEQ $844D
L841B:  BMI $843C
L841D:  LDA DPad1History        ;($D3)
L841F:  BPL $8438
L8421:  AND #$7F
L8423:  TAX
L8424:  LDA DPad1Status         ;($D2)
L8426:  AND #$04
L8428:  BEQ $8438
L842A:  STX DPad1History        ;($D3)
L842C:  LDA #$0E
L842E:  STA MacStatus           ;($50)
L8430:  LDA (MacStBasePtr),Y    ;($54)
L8432:  TAY
L8433:  STY MacStateIndex       ;($53)
L8435:  JMP $8325
L8438:  INY
L8439:  STY MacStateIndex       ;($53)
L843B:  RTS
L843C:  LDA DPad1History        ;($D3)
L843E:  AND #$81
L8440:  BNE $8438
L8442:  LDX #$81
L8444:  LDA MacCanPunch         ;($BC)
L8446:  BNE $8449
L8448:  INX
L8449:  STX MacStatus           ;($50)
L844B:  BNE $8438
L844D:  LDA DPad1History        ;($D3)
L844F:  AND #$81
L8451:  BNE $8438
L8453:  LDA #$01
L8455:  STA $6A
L8457:  BNE $8438
L8459:  LDA #$01
L845B:  STA $99
L845D:  LDA (MacStBasePtr),Y    ;($54)
L845F:  INY
L8460:  STA MacPunchType        ;($74)
L8462:  STY MacStateIndex       ;($53)
L8464:  RTS
L8465:  LDA (MacStBasePtr),Y    ;($54)
L8467:  BEQ $8471
L8469:  LDX RoundTmrStart       ;($0300)
L846C:  BNE $8471
L846E:  STA RoundTmrStart       ;($0300)
L8471:  EOR #$01
L8473:  STA $E7
L8475:  LDA RoundTmrCntrl       ;($0301)
L8478:  AND #$FE
L847A:  ORA $E7
L847C:  STA RoundTmrCntrl       ;($0301)
L847F:  INC MacStateIndex       ;($53)
L8481:  RTS
L8482:  LDX #$00
L8484:  LDA $70,X
L8486:  CLC
L8487:  ADC (MacStBasePtr),Y    ;($54)
L8489:  INY
L848A:  STA $70,X
L848C:  JMP $8368
L848F:  LDX #$01
L8491:  BNE $8484
L8493:  LDA MacStBasePtrLB      ;($54)
L8495:  STA $7E
L8497:  LDA MacStBasePtrUB      ;($55)
L8499:  STA $7F
L849B:  LDA (MacStBasePtr),Y    ;($54)
L849D:  INY
L849E:  TAX
L849F:  LDA (MacStBasePtr),Y    ;($54)
L84A1:  INY
L84A2:  STY $7D
L84A4:  STA MacStBasePtrUB      ;($55)
L84A6:  STX MacStBasePtrLB      ;($54)
L84A8:  LDY #$00
L84AA:  STY MacStateIndex       ;($53)
L84AC:  JMP $8325
L84AF:  LDA $7E
L84B1:  STA MacStBasePtrLB      ;($54)
L84B3:  LDA $7F
L84B5:  STA MacStBasePtrUB      ;($55)
L84B7:  LDY $7D
L84B9:  STY MacStateIndex       ;($53)
L84BB:  JMP $8325
L84BE:  LDA $0397
L84C1:  STA $0391
L84C4:  LDA $039E
L84C7:  STA $0398
L84CA:  JMP $8325
L84CD:  LDA (MacStBasePtr),Y    ;($54)
L84CF:  INC MacStateIndex       ;($53)
L84D1:  TAY
L84D2:  AND #$03
L84D4:  TAX
L84D5:  TYA
L84D6:  AND #$FC
L84D8:  BMI $84DC
L84DA:  LSR
L84DB:  LSR
L84DC:  STA $F0,X
L84DE:  JMP $8325
L84E1:  LDA (MacStBasePtr),Y    ;($54)
L84E3:  INY
L84E4:  STA $E0
L84E6:  LDA (MacStBasePtr),Y    ;($54)
L84E8:  INY
L84E9:  JMP $83FB
L84EC:  TXA
L84ED:  JSR $860F
L84F0:  BPL $8477
L84F2:  AND $4D85,Y
L84F5:  STA $56
L84F7:  STA $65
L84F9:  STA $6D
L84FB:  STA MacPunchType        ;($74)
L84FD:  STA $7E
L84FF:  STA $8C
L8501:  STA $00
L8503:  BRK
L8504:  STX $85,Y
L8506:  LDY $85
L8508:  TAY
L8509:  STA $C1
L850B:  STA $00
L850D:  BRK
L850E:  DEX
L850F:  STA $A6
L8511:  CLI
L8512:  BMI $851F
L8514:  BNE $8522
L8516:  LDX #$80
L8518:  LDA $5B
L851A:  BEQ $851D
L851C:  INX
L851D:  STX $58
L851F:  DEC MacStateIndex       ;($53)
L8521:  RTS
L8522:  DEX
L8523:  BEQ $8529
L8525:  DEX
L8526:  BNE $8535
L8528:  INY
L8529:  LDA (MacStBasePtr),Y    ;($54)
L852B:  TAY
L852C:  STY MacStateIndex       ;($53)
L852E:  LDA #$00
L8530:  STA $58
L8532:  JMP $8325
L8535:  INY
L8536:  INY
L8537:  BNE $852C
L8539:  LDA (MacStBasePtr),Y    ;($54)
L853B:  TAX
L853C:  INY
L853D:  LDA (MacStBasePtr),Y    ;($54)
L853F:  STA $E0
L8541:  INY
L8542:  LDA (MacStBasePtr),Y    ;($54)
L8544:  TAY
L8545:  LDA $E0
L8547:  STA MacStBasePtrUB      ;($55)
L8549:  STX MacStBasePtrLB      ;($54)
L854B:  BNE $852C
L854D:  LDA MacStateStatus      ;($51)
L854F:  AND #$7F
L8551:  STA MacStateStatus      ;($51)
L8553:  JMP $8325
L8556:  DEC $56
L8558:  BEQ $8562
L855A:  LDA (MacStBasePtr),Y    ;($54)
L855C:  TAY
L855D:  STY MacStateIndex       ;($53)
L855F:  JMP $8325
L8562:  INY
L8563:  BNE $855D
L8565:  LDA #$82
L8567:  SEC
L8568:  SBC MacCanPunch         ;($BC)
L856A:  STA MacStatus           ;($50)
L856C:  RTS
L856D:  LDA (MacStBasePtr),Y    ;($54)
L856F:  INC MacStateIndex       ;($53)
L8571:  STA $56
L8573:  RTS
L8574:  LDA (MacStBasePtr),Y    ;($54)
L8576:  INY
L8577:  STA MacPunchDamage      ;($75)
L8579:  STY MacStateIndex       ;($53)
L857B:  JMP $8358

L857E:  LDX #$00
L8580:  LDA (MacStBasePtr),Y    ;($54)
L8582:  INY
L8583:  STA MacDefense1,X
L8585:  INX
L8586:  CPX #$02
L8588:  BNE $8580
L858A:  BEQ $8579

L858C:  LDA (MacStBasePtr),Y    ;($54)
L858E:  INC MacStateIndex       ;($53)
L8590:  TAX
L8591:  INC $00,X
L8593:  JMP $8325
L8596:  LDA (MacStBasePtr),Y    ;($54)
L8598:  INY
L8599:  TAX
L859A:  LDA (MacStBasePtr),Y    ;($54)
L859C:  INY
L859D:  STY MacStateIndex       ;($53)
L859F:  STA $00,X
L85A1:  JMP $8358
L85A4:  LDA #$30
L85A6:  BNE $85B1
L85A8:  LDA $04A1
L85AB:  LDX #$14
L85AD:  LDY MacCanPunch         ;($BC)
L85AF:  BEQ $85B3
L85B1:  LDX #$8F
L85B3:  STX $048E
L85B6:  STA $048D
L85B9:  LDA #$81
L85BB:  STA $04A0
L85BE:  JMP $8325
L85C1:  LDA (MacStBasePtr),Y    ;($54)
L85C3:  STA $59
L85C5:  INC MacStateIndex       ;($53)
L85C7:  JMP $8325
L85CA:  DEC MacStateIndex       ;($53)
L85CC:  LDA #$83
L85CE:  STA MacStateStatus      ;($51)
L85D0:  RTS

L85D1:  LDA #$00
L85D3:  STA $0000,Y
L85D6:  INY
L85D7:  DEX
L85D8:  BNE $85D3
L85DA:  RTS

L85DB:  ROR RNGValue            ;($18)
L85DD:  ROR RNGValue            ;($18)
L85DF:  ROR RNGValue            ;($18)
L85E1:  RTS
L85E2:  STA $EF
L85E4:  LDA #$0F
L85E6:  STA $EE
L85E8:  LDA $EF
L85EA:  CMP $EE
L85EC:  BEQ $8602
L85EE:  LDA RNGValue            ;($18)
L85F0:  JSR $85DB
L85F3:  AND $EE
L85F5:  CLC
L85F6:  ADC #$01
L85F8:  BNE $85FC
L85FA:  LDA #$01
L85FC:  STA $EE
L85FE:  LDA $EF
L8600:  CMP $EE
L8602:  RTS

L8603:  STA $EF
L8605:  LDA #$7F
L8607:  BNE $85E6
L8609:  STA $EF
L860B:  LDA #$FF
L860D:  BNE $85E6
L860F:  STY $04C9
L8612:  ASL
L8613:  TAY
L8614:  PLA
L8615:  STA $EE
L8617:  PLA
L8618:  STA $EF
L861A:  INY
L861B:  LDA ($EE),Y
L861D:  PHA
L861E:  INY
L861F:  LDA ($EE),Y
L8621:  STA $EF
L8623:  PLA
L8624:  STA $EE
L8626:  LDY $04C9
L8629:  JMP ($00EE)

L862C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L863C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L864C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L865C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L866C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L867C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L868C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L869C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L86AC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L86BC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L86CC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L86DC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L86EC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L86FC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L870C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L871C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L872C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L873C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L874C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L875C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L876C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L877C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L878C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L879C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L87AC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L87BC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L87CC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L87DC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L87EC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L87FC:  .byte $00, $00, $00, $00

L8800:  .word $8925, $8928, $892B, $8931, $8934, $8A2A, $8937, $893A
L8810:  .word $893D, $8940, $8943, $8949, $894C, $8952, $8955, $8958
L8820:  .word $895B, $895E, $8961, $8964, $8967, $896A, $896D, $8973
L8830:  .word $8976, $8979, $897C, $897F, $8982, $8985, $8988, $898B
L8840:  .word $898E, $8991, $892E, $8994, $8997, $899A, $899D, $89A0
L8850:  .word $89A3, $89A6, $89A9, $89AC, $89AF, $89B2, $89B5, $89BE
L8860:  .word $89C1, $89CD, $89D0, $89C4, $89D3, $89EB, $89EE, $89F1
L8870:  .word $89F4, $89F7, $89E8, $89D6, $89D9, $89DC, $89DF, $89E2
L8880:  .word $89E5, $89E5, $89E5, $89E5, $89FA, $89FD, $8A00, $8A30
L8890:  .word $8A03, $8A06, $8A09, $8A0C, $8A0F, $8A12, $8A15, $8A18
L88A0:  .word $8A1B, $8A1E, $8A21, $8A24, $8970, $8A36, $8A39, $8A3C
L88B0:  .word $8922, $89B8, $89BB, $89C7, $89CA, $8A33, $8A27, $8A2D
L88C0:  .word $8946, $894F

L88C4:  .word $921D, $919F, $91A2, $91A5, $91A8, $91AB
L88D0:  .word $91AE, $91B1, $91B4, $91B7, $91BA, $91BD, $91C0, $91C3
L88E0:  .word $91C6, $91C9, $91CC, $91CF, $91D2, $91D5, $91D8, $91DB
L88F0:  .word $91DE, $91E1, $91E4, $91E7, $91EA, $91ED, $91F0, $91F3
L8900:  .word $91F6, $91F9, $91FC, $91FF, $9202, $9205, $9208, $920B
L8910:  .word $920E, $9211, $9217, $921A, $9220, $9223, $9226, $9229
L8920:  .word $9214

L8922:  .byte $26, $9B, $8A, $26, $BE, $8A, $26, $D0, $8A, $26, $8B, $8F, $16, $A4, $8F, $26
L8932:  .byte $C9, $8F, $26, $E6, $8F, $10, $4D, $8F, $10, $6D, $8F, $12, $91, $8C, $14, $8C
L8942:  .byte $90, $26, $B5, $90, $22, $C8, $90, $16, $D5, $90, $26, $01, $91, $22, $14, $91
L8952:  .byte $10, $21, $91, $10, $ED, $8A, $12, $0A, $8B, $1A, $2C, $8B, $18, $2C, $8B, $14
L8962:  .byte $5B, $8B, $12, $F6, $8E, $12, $7B, $8B, $1A, $A3, $8B, $18, $A3, $8B, $12, $D5
L8972:  .byte $8B, $14, $0A, $8B, $1C, $2C, $8B, $58, $F1, $8B, $56, $F1, $8B, $54, $F1, $8B
L8982:  .byte $16, $5B, $8B, $14, $7B, $8B, $1C, $A3, $8B, $58, $11, $8C, $56, $11, $8C, $54
L8992:  .byte $11, $8C, $12, $F9, $8F, $26, $23, $90, $28, $23, $90, $2A, $23, $90, $2C, $23
L89A2:  .byte $90, $18, $7B, $8B, $20, $A3, $8B, $1E, $40, $90, $1E, $5F, $90, $1C, $5F, $90
L89B2:  .byte $1A, $5F, $90, $18, $5F, $90, $1E, $2D, $8C, $1A, $2D, $8C, $16, $2D, $8C, $14
L89C2:  .byte $2D, $8C, $24, $69, $8C, $1E, $B4, $8C, $1A, $B4, $8C, $16, $B4, $8C, $14, $B4
L89D2:  .byte $8C, $0E, $F0, $8C, $22, $69, $8C, $0A, $19, $8D, $06, $3C, $8D, $04, $57, $8D
L89E2:  .byte $02, $70, $8D, $2E, $86, $8D, $2E, $A2, $8D, $0C, $F0, $8C, $0A, $B3, $8D, $06
L89F2:  .byte $D4, $8D, $04, $EE, $8D, $02, $06, $8E, $2E, $1B, $8E, $02, $33, $8E, $04, $45
L8A02:  .byte $8E, $06, $5A, $8E, $06, $74, $8E, $08, $8D, $8E, $08, $A8, $8E, $0A, $C1, $8E
L8A12:  .byte $0A, $DC, $8E, $0C, $F6, $8E, $0C, $91, $8C, $0E, $D5, $8B, $0E, $91, $8C, $10
L8A22:  .byte $D5, $8B, $10, $91, $8C, $26, $38, $91, $08, $54, $91, $26, $67, $91, $04, $80
L8A32:  .byte $91, $04, $95, $91, $10, $11, $8F, $12, $11, $8F, $28, $2F, $8F, $63, $23, $43
L8A42:  .byte $23, $23, $23, $03, $23, $E3, $22, $C3, $22, $A3, $22, $83, $22, $63, $22, $43
L8A52:  .byte $22, $23, $22, $03, $22, $E3, $21, $C3, $21, $A3, $21, $83, $21, $63, $21, $A4
L8A62:  .byte $22, $84, $22, $64, $22, $44, $22, $24, $22, $04, $22, $61, $23, $E3, $23, $6A
L8A72:  .byte $22, $49, $22, $46, $22, $35, $22, $34, $22, $33, $22, $32, $22, $31, $22, $30
L8A82:  .byte $22, $2F, $22, $2E, $22, $2D, $22, $2C, $22, $2B, $22, $2A, $22, $29, $22, $26
L8A92:  .byte $22, $C4, $21, $A4, $21, $84, $21, $18, $27, $FF, $00, $FE, $07, $01, $FF, $FF
L8AA2:  .byte $00, $00, $FE, $08, $08, $FF, $FF, $00, $00, $FE, $08, $10, $FF, $FF, $00, $FF
L8AB2:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $FD, $01, $FF, $00, $FE, $07
L8AC2:  .byte $01, $00, $00, $FE, $08, $08, $00, $00, $FE, $08, $10, $00, $FD, $01, $FF, $01
L8AD2:  .byte $02, $03, $00, $FE, $04, $18, $00, $00, $FE, $04, $08, $00, $FE, $04, $1C, $00
L8AE2:  .byte $00, $FE, $04, $10, $20, $21, $22, $FF, $00, $FD, $01, $FF, $48, $49, $00, $FF
L8AF2:  .byte $4A, $4B, $4C, $00, $FE, $04, $04, $00, $08, $66, $00, $FE, $06, $0A, $FF, $00
L8B02:  .byte $00, $FE, $08, $10, $FF, $00, $FD, $01, $FF, $48, $49, $FF, $FF, $00, $FF, $4A
L8B12:  .byte $4D, $4C, $00, $FE, $04, $35, $FF, $FF, $00, $00, $FE, $09, $39, $FF, $00, $FF
L8B22:  .byte $00, $FE, $06, $42, $FF, $FF, $FF, $00, $FD, $01, $FF, $FF, $FF, $FF, $FF, $FF
L8B32:  .byte $FF, $00, $FF, $FF, $FF, $00, $FE, $05, $4E, $00, $FE, $04, $18, $00, $FF, $FF
L8B42:  .byte $FF, $00, $FE, $05, $53, $00, $FE, $04, $1C, $FF, $00, $FF, $FF, $FF, $FF, $FF
L8B52:  .byte $58, $59, $5A, $20, $21, $22, $00, $FD, $01, $FF, $FF, $FF, $FF, $32, $00, $FF
L8B62:  .byte $FF, $FF, $00, $FE, $06, $33, $FF, $00, $FF, $00, $FE, $09, $39, $00, $FF, $FF
L8B72:  .byte $00, $FE, $06, $42, $FF, $FF, $00, $FD, $01, $FF, $FF, $FF, $32, $FF, $00, $FF
L8B82:  .byte $FF, $00, $FE, $06, $33, $FF, $FF, $00, $00, $FE, $09, $39, $FF, $00, $FF, $5E
L8B92:  .byte $5F, $60, $FF, $46, $47, $FF, $FF, $FF, $00, $FF, $FF, $61, $62, $FF, $00, $FD
L8BA2:  .byte $01, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $FF, $FF, $FF, $FF, $00, $FE
L8BB2:  .byte $04, $34, $FF, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FE, $09, $38, $FF, $00
L8BC2:  .byte $FF, $FF, $FF, $00, $FE, $09, $41, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L8BD2:  .byte $00, $FD, $02, $FF, $FF, $FF, $FF, $FF, $00, $FF, $FF, $00, $FE, $07, $01, $00
L8BE2:  .byte $FF, $00, $FE, $08, $08, $FF, $00, $FF, $00, $FE, $08, $10, $00, $FD, $01, $FF
L8BF2:  .byte $FF, $FF, $00, $FE, $08, $01, $FF, $FF, $00, $FF, $00, $FE, $0B, $09, $FF, $00
L8C02:  .byte $FF, $FF, $14, $FF, $FF, $FF, $00, $FE, $04, $15, $FF, $FF, $00, $FD, $03, $FF
L8C12:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $19, $1A, $00, $FF, $00, $FE, $0B, $1B, $FF, $00
L8C22:  .byte $FF, $FF, $00, $FE, $09, $26, $FF, $FF, $00, $FD, $03, $FF, $FF, $FF, $FF, $FF
L8C32:  .byte $FF, $FF, $FF, $00, $FF, $FF, $FF, $ED, $EE, $5B, $5C, $04, $C8, $C9, $FF, $FF
L8C42:  .byte $00, $FF, $FF, $FF, $61, $EF, $8D, $8E, $CE, $CF, $D0, $D1, $FF, $FF, $00, $FF
L8C52:  .byte $FF, $FF, $FF, $FF, $8F, $90, $D6, $D7, $D8, $FF, $FF, $00, $FF, $FF, $FF, $FF
L8C62:  .byte $FF, $91, $92, $FF, $00, $FD, $02, $FF, $FF, $E5, $FF, $FF, $FF, $FF, $00, $FF
L8C72:  .byte $00, $FE, $04, $E6, $00, $FE, $04, $5D, $00, $FF, $FF, $EA, $EB, $EC, $A9, $66
L8C82:  .byte $67, $68, $00, $FF, $FF, $FF, $BF, $C0, $C1, $6C, $6D, $6E, $00, $FD, $02, $FF
L8C92:  .byte $FF, $FF, $32, $FF, $00, $FF, $FF, $00, $FE, $06, $33, $FF, $00, $00, $FE, $09
L8CA2:  .byte $39, $00, $FF, $00, $FE, $06, $42, $FF, $FF, $00, $FF, $FF, $FF, $FF, $FF, $00
L8CB2:  .byte $FD, $01, $FF, $FF, $FF, $FF, $FF, $2A, $2B, $FF, $00, $FF, $FF, $FF, $FF, $FF
L8CC2:  .byte $2C, $2D, $2E, $1F, $20, $FF, $FF, $00, $FF, $FF, $FF, $75, $2F, $30, $31, $1A
L8CD2:  .byte $21, $22, $23, $FF, $FF, $00, $FF, $FF, $FF, $32, $33, $7F, $80, $14, $25, $FF
L8CE2:  .byte $FF, $FF, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $FD, $02, $FF, $FF
L8CF2:  .byte $FF, $FF, $00, $FF, $FF, $FF, $C2, $C3, $C4, $72, $73, $74, $00, $FF, $FF, $85
L8D02:  .byte $86, $87, $F8, $7A, $7B, $7C, $00, $FF, $00, $FE, $04, $88, $00, $FE, $04, $81
L8D12:  .byte $00, $FF, $FF, $8C, $00, $FD, $02, $00, $FF, $FF, $FF, $00, $FE, $05, $93, $00
L8D22:  .byte $FF, $FF, $FF, $00, $FE, $05, $99, $00, $FF, $FF, $00, $FE, $06, $9E, $00, $FF
L8D32:  .byte $FF, $A5, $A6, $FF, $FF, $FF, $FF, $00, $FD, $02, $00, $FF, $FF, $00, $FE, $04
L8D42:  .byte $93, $00, $FF, $FF, $00, $FE, $04, $99, $00, $FF, $00, $FE, $05, $9E, $00, $FF
L8D52:  .byte $A5, $A6, $00, $FD, $02, $00, $FF, $FF, $93, $94, $95, $00, $FF, $FF, $99, $9A
L8D62:  .byte $9B, $00, $FF, $00, $FE, $04, $9E, $00, $FF, $A5, $A6, $00, $FD, $02, $00, $FF
L8D72:  .byte $FF, $93, $94, $00, $FF, $FF, $99, $9A, $00, $FF, $9E, $9F, $A0, $00, $FF, $A5
L8D82:  .byte $A6, $00, $FD, $02, $FF, $00, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00
L8D92:  .byte $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $00, $FD, $01
L8DA2:  .byte $FD, $00, $11, $00, $0F, $00, $1E, $00, $00, $1F, $00, $1A, $00, $27, $00, $FD
L8DB2:  .byte $01, $FF, $FF, $AC, $AD, $00, $FF, $FF, $00, $FE, $06, $AE, $00, $FF, $FF, $FF
L8DC2:  .byte $00, $FE, $05, $B5, $00, $FF, $FF, $FF, $00, $FE, $05, $BA, $00, $FF, $FF, $00
L8DD2:  .byte $FD, $02, $FF, $AC, $AD, $00, $FF, $00, $FE, $05, $AE, $00, $FF, $FF, $00, $FE
L8DE2:  .byte $04, $B5, $00, $FF, $FF, $00, $FE, $04, $BA, $00, $FD, $02, $FF, $AC, $AD, $00
L8DF2:  .byte $FF, $00, $FE, $04, $AE, $00, $FF, $FF, $B5, $B6, $B7, $00, $FF, $FF, $BA, $BB
L8E02:  .byte $BC, $00, $FD, $02, $FF, $AC, $AD, $00, $FF, $AE, $AF, $B0, $00, $FF, $FF, $B5
L8E12:  .byte $B6, $00, $FF, $FF, $BA, $BB, $00, $FD, $02, $FF, $00, $FF, $00, $FF, $00, $FF
L8E22:  .byte $FF, $2C, $00, $FF, $08, $0A, $00, $FF, $10, $2F, $00, $FF, $00, $FF, $00, $FD
L8E32:  .byte $01, $00, $FF, $FF, $FF, $2C, $00, $FF, $39, $3A, $0A, $00, $FF, $FF, $42, $2F
L8E42:  .byte $00, $FD, $01, $00, $FF, $FF, $FF, $2C, $2D, $00, $FF, $39, $3A, $0A, $0B, $00
L8E52:  .byte $FF, $FF, $42, $2F, $30, $00, $FD, $01, $FF, $FF, $FF, $FF, $00, $FF, $FF, $00
L8E62:  .byte $FE, $04, $01, $00, $FF, $00, $FE, $05, $08, $00, $FF, $00, $FE, $05, $10, $00
L8E72:  .byte $FD, $01, $FF, $FF, $FF, $32, $00, $FF, $FF, $00, $FE, $04, $33, $00, $00, $FE
L8E82:  .byte $06, $39, $00, $FF, $00, $FE, $05, $42, $00, $FD, $01, $FF, $FF, $FF, $FF, $FF
L8E92:  .byte $00, $FF, $FF, $00, $FE, $05, $01, $00, $FF, $00, $FE, $06, $08, $00, $FF, $00
L8EA2:  .byte $FE, $06, $10, $00, $FD, $01, $FF, $FF, $FF, $32, $00, $FF, $FF, $00, $FE, $05
L8EB2:  .byte $33, $00, $00, $FE, $07, $39, $00, $FF, $00, $FE, $06, $42, $00, $FD, $01, $FF
L8EC2:  .byte $FF, $FF, $FF, $FF, $00, $FF, $FF, $00, $FE, $06, $01, $00, $FF, $00, $FE, $07
L8ED2:  .byte $08, $00, $FF, $00, $FE, $07, $10, $00, $FD, $01, $FF, $FF, $FF, $32, $00, $FF
L8EE2:  .byte $FF, $00, $FE, $06, $33, $00, $00, $FE, $08, $39, $00, $FF, $00, $FE, $06, $42
L8EF2:  .byte $FF, $00, $FD, $01, $FF, $FF, $FF, $FF, $FF, $00, $FF, $FF, $00, $FE, $07, $01
L8F02:  .byte $00, $FF, $00, $FE, $08, $08, $00, $FF, $00, $FE, $08, $10, $00, $FD, $01, $FF
L8F12:  .byte $FF, $FF, $FF, $FF, $FF, $00, $FF, $00, $FE, $08, $8F, $FF, $00, $FF, $00, $FE
L8F22:  .byte $08, $97, $FF, $00, $FF, $00, $FE, $08, $9F, $FF, $00, $FD, $01, $8F, $A7, $A8
L8F32:  .byte $A9, $92, $8A, $8B, $8C, $00, $FF, $AD, $AE, $AF, $9A, $00, $FE, $04, $B0, $00
L8F42:  .byte $9F, $AA, $AB, $AC, $A2, $8D, $8E, $5B, $00, $FD, $01, $FF, $FF, $4A, $4B, $4C
L8F52:  .byte $00, $FF, $FF, $00, $FE, $06, $4D, $00, $FF, $FF, $FF, $00, $FE, $05, $53, $00
L8F62:  .byte $FF, $FF, $FF, $FF, $FF, $58, $FF, $FF, $00, $FD, $02, $FF, $FF, $FF, $FF, $FF
L8F72:  .byte $00, $FF, $00, $FE, $07, $01, $00, $00, $FE, $08, $08, $FF, $00, $00, $FE, $08
L8F82:  .byte $10, $00, $FF, $FF, $FF, $FF, $00, $FD, $01, $FF, $FF, $23, $24, $25, $05, $06
L8F92:  .byte $07, $00, $00, $FE, $08, $08, $00, $10, $FF, $00, $FE, $04, $26, $16, $17, $00
L8FA2:  .byte $FD, $01, $FF, $FF, $00, $FF, $FF, $FF, $FF, $FF, $23, $24, $25, $05, $06, $07
L8FB2:  .byte $00, $FF, $FF, $FF, $00, $FE, $08, $08, $00, $FF, $FF, $FF, $10, $FF, $00, $FE
L8FC2:  .byte $04, $26, $16, $17, $00, $FD, $01, $FF, $FF, $23, $24, $2A, $19, $1A, $1B, $00
L8FD2:  .byte $00, $FE, $04, $08, $00, $FE, $04, $1C, $00, $10, $FF, $26, $27, $2B, $69, $22
L8FE2:  .byte $FF, $00, $FD, $01, $FF, $FF, $2C, $2D, $2E, $67, $00, $39, $3A, $00, $FF, $42
L8FF2:  .byte $2F, $30, $31, $68, $00, $FD, $01, $FF, $FF, $FF, $FF, $00, $FF, $FF, $FF, $FF
L9002:  .byte $C5, $C6, $18, $19, $00, $FF, $FF, $00, $FE, $04, $CA, $1A, $1B, $D1, $00, $FF
L9012:  .byte $FF, $00, $FE, $04, $D2, $1C, $1D, $00, $FF, $FF, $FF, $FF, $FF, $D9, $00, $FD
L9022:  .byte $02, $FF, $FF, $00, $FE, $05, $C5, $FF, $00, $00, $FE, $08, $CA, $FF, $00, $00
L9032:  .byte $FE, $07, $D2, $FF, $00, $FF, $FF, $FF, $D9, $FF, $FF, $00, $FD, $02, $2F, $30
L9042:  .byte $00, $00, $FE, $0A, $31, $FF, $00, $FF, $FF, $00, $FE, $08, $3B, $FF, $00, $FF
L9052:  .byte $FF, $00, $FE, $04, $43, $FF, $FF, $47, $48, $FF, $00, $FD, $03, $FF, $FF, $FF
L9062:  .byte $FF, $49, $4A, $00, $FF, $FF, $FF, $FF, $4B, $4C, $4D, $00, $FE, $04, $37, $00
L9072:  .byte $FF, $FF, $FF, $00, $FE, $04, $4E, $00, $FE, $04, $3F, $00, $FF, $FF, $FF, $43
L9082:  .byte $44, $52, $53, $FF, $FF, $47, $48, $00, $FD, $03, $FF, $FF, $FF, $FF, $FF, $00
L9092:  .byte $FF, $FF, $FF, $01, $02, $03, $00, $FE, $04, $18, $00, $FF, $FF, $00, $FE, $04
L90A2:  .byte $08, $00, $FE, $04, $1C, $00, $FF, $FF, $00, $FE, $04, $10, $20, $21, $22, $FF
L90B2:  .byte $00, $FD, $01, $00, $FE, $08, $59, $00, $00, $FE, $08, $61, $00, $FF, $FF, $00
L90C2:  .byte $FE, $06, $69, $00, $FD, $02, $98, $A4, $00, $A7, $A8, $A9, $00, $BF, $C0, $C1
L90D2:  .byte $00, $FD, $02, $FF, $FF, $FF, $FF, $FF, $FF, $00, $FF, $FF, $FF, $FF, $01, $02
L90E2:  .byte $03, $1E, $1F, $20, $FF, $00, $FF, $FF, $FF, $00, $FE, $05, $08, $21, $22, $23
L90F2:  .byte $00, $FF, $FF, $FF, $00, $FE, $04, $10, $24, $25, $FF, $FF, $00, $FD, $02, $FF
L9102:  .byte $FF, $00, $FE, $06, $6F, $00, $00, $FE, $08, $75, $00, $00, $FE, $08, $7D, $00
L9112:  .byte $FD, $02, $C2, $C3, $C4, $00, $F6, $F7, $F8, $00, $AA, $AB, $00, $FD, $02, $FF
L9122:  .byte $FF, $FF, $FF, $00, $FF, $00, $FE, $07, $01, $00, $00, $FE, $08, $08, $00, $00
L9132:  .byte $FE, $08, $10, $00, $FD, $02, $00, $FE, $04, $26, $00, $FE, $04, $04, $00, $F0
L9142:  .byte $F1, $F2, $00, $FE, $05, $0B, $00, $FF, $F3, $F4, $F5, $00, $FE, $04, $14, $00
L9152:  .byte $FD, $02, $FF, $00, $1E, $1F, $20, $FF, $00, $0C, $21, $22, $23, $00, $24, $25
L9162:  .byte $FF, $FF, $00, $FD, $02, $FF, $DA, $DB, $DC, $1E, $1F, $20, $00, $00, $FE, $05
L9172:  .byte $DD, $21, $22, $23, $00, $FF, $E2, $E3, $E4, $24, $25, $00, $FD, $02, $00, $FF
L9182:  .byte $FF, $2C, $2D, $2E, $00, $39, $3A, $0A, $0B, $0C, $00, $FF, $42, $2F, $30, $31
L9192:  .byte $00, $FD, $01, $00, $00, $FF, $08, $00, $FF, $10, $00, $FD, $01, $3A, $3F, $92
L91A2:  .byte $3A, $5C, $92, $3C, $3F, $92, $3C, $5C, $92, $3E, $3F, $92, $3E, $5C, $92, $40
L91B2:  .byte $3F, $92, $40, $5C, $92, $42, $3F, $92, $42, $5C, $92, $44, $3F, $92, $44, $5C
L91C2:  .byte $92, $46, $3F, $92, $46, $5C, $92, $48, $3F, $92, $48, $5C, $92, $4A, $3F, $92
L91D2:  .byte $4A, $5C, $92, $4C, $3F, $92, $4C, $5C, $92, $4E, $3F, $92, $50, $3A, $92, $52
L91E2:  .byte $2C, $92, $4C, $87, $92, $34, $A2, $92, $32, $AF, $92, $32, $B3, $92, $32, $B7
L91F2:  .byte $92, $32, $BB, $92, $32, $BF, $92, $32, $C3, $92, $32, $C7, $92, $32, $CB, $92
L9202:  .byte $32, $CF, $92, $32, $D3, $92, $4C, $D7, $92, $4C, $F0, $92, $36, $35, $93, $30
L9212:  .byte $83, $92, $30, $7B, $92, $44, $4E, $93, $44, $63, $93, $38, $78, $93, $5A, $95
L9222:  .byte $93, $5A, $A3, $93, $48, $0D, $93, $4C, $1A, $93, $FF, $FF, $FF, $00, $FF, $FF
L9232:  .byte $FF, $FF, $00, $FF, $FF, $FF, $FF, $00, $FF, $FF, $FF, $FF, $00, $FF, $FF, $FF
L9242:  .byte $FF, $00, $00, $FE, $05, $EB, $00, $00, $FE, $06, $F0, $00, $00, $FE, $06, $F6
L9252:  .byte $00, $FF, $FF, $FF, $FF, $FF, $FC, $00, $FD, $01, $FF, $FF, $FF, $FF, $FF, $00
L9262:  .byte $00, $FE, $05, $DA, $FF, $00, $00, $FE, $06, $DF, $00, $00, $FE, $06, $E5, $00
L9272:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $00, $FD, $01, $FD, $00, $FF, $00, $FF, $00, $FD
L9282:  .byte $01, $FD, $00, $FD, $01, $EB, $EC, $ED, $D6, $EF, $00, $F0, $F1, $D7, $F3, $F4
L9292:  .byte $F5, $00, $00, $FE, $06, $F6, $00, $FF, $FF, $FF, $FF, $FF, $FC, $00, $FD, $01
L92A2:  .byte $FF, $CA, $00, $C9, $B4, $CB, $00, $EC, $CC, $5D, $00, $FD, $01, $BF, $00, $FD
L92B2:  .byte $01, $C0, $00, $FD, $01, $C1, $00, $FD, $01, $C2, $00, $FD, $01, $C3, $00, $FD
L92C2:  .byte $01, $C4, $00, $FD, $01, $C5, $00, $FD, $01, $C6, $00, $FD, $01, $C7, $00, $FD
L92D2:  .byte $01, $C8, $00, $FD, $01, $FF, $FF, $FF, $6C, $FF, $00, $00, $FE, $06, $6D, $00
L92E2:  .byte $00, $FE, $06, $73, $00, $FF, $FF, $FF, $79, $7A, $FF, $00, $FD, $01, $FF, $FF
L92F2:  .byte $FF, $6C, $FF, $00, $6D, $6E, $6F, $5C, $71, $72, $00, $73, $74, $D8, $D9, $77
L9302:  .byte $78, $00, $00, $FE, $04, $D2, $7A, $FF, $00, $FD, $01, $73, $74, $CE, $CF, $D0
L9312:  .byte $00, $FF, $FF, $FF, $D1, $00, $FD, $01, $FF, $FF, $7B, $7C, $FF, $00, $00, $FE
L9322:  .byte $05, $7D, $F5, $00, $00, $FE, $05, $82, $FB, $00, $87, $88, $89, $FF, $FF, $FC
L9332:  .byte $00, $FD, $01, $FF, $CA, $00, $C9, $BA, $CB, $00, $C9, $BB, $BC, $00, $C9, $BD
L9342:  .byte $CB, $00, $C9, $BE, $CB, $00, $EC, $CC, $5D, $00, $FD, $01, $FF, $B5, $00, $C9
L9352:  .byte $B7, $CB, $00, $C9, $B8, $CB, $00, $C9, $BE, $CB, $00, $FF, $B9, $CD, $00, $FD
L9362:  .byte $01, $FF, $B5, $00, $C9, $B6, $CB, $00, $C9, $B7, $CB, $00, $C9, $B8, $CB, $00
L9372:  .byte $FF, $B9, $CD, $00, $FD, $01, $FF, $FF, $FF, $FF, $FF, $00, $FF, $FF, $FF, $FF
L9382:  .byte $FF, $FF, $00, $FF, $FF, $FF, $FF, $FF, $FF, $00, $FF, $FF, $FF, $FF, $FF, $FF
L9392:  .byte $00, $FD, $01, $FF, $00, $17, $00, $0B, $00, $0D, $00, $27, $00, $27, $00, $FD
L93A2:  .byte $01, $0E, $00, $0F, $00, $10, $00, $0F, $00, $18, $00, $0E, $00, $0F, $00, $1C
L93B2:  .byte $00, $FD, $01

L93B5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93C5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93D5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93E5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93F5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9405:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9415:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9425:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9435:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9445:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9455:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9465:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9475:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9485:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9495:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94A5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94B5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94C5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94D5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94E5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94F5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L9500:  .byte $80, $8C, $83, $8C, $8B, $8B, $80, $38, $85, $8C, $8C, $8C, $80, $F0, $87, $80
L9510:  .byte $38, $85, $8C, $8B, $8C, $8B, $8C, $8B, $8C, $80, $FC, $83, $8C, $8B, $8B, $80
L9520:  .byte $30, $8C, $8C, $8C, $8D, $8D, $8D, $80, $40, $8A, $80, $40, $89, $80, $40, $8A
L9530:  .byte $80, $40, $89, $80, $40, $8C, $8D, $8B, $8D, $8C, $8D, $8B, $8D, $8C, $8D, $8B
L9540:  .byte $8D, $8C, $8D, $8B, $8D, $8C, $8D, $8B, $8D, $8C, $8D, $8B, $8D, $8C, $8D, $8B
L9550:  .byte $8D, $8C, $8D, $8B, $8D, $8C, $8D, $8B, $8D, $8A, $80, $40, $89, $80, $40, $8A
L9560:  .byte $80, $40, $89, $80, $40, $8C, $8D, $8B, $8D, $8C, $8D, $8B, $8D, $8C, $8D, $8B
L9570:  .byte $8D, $8C, $8D, $8B, $8D, $8C, $8D, $8B, $8D, $8C, $8D, $8B, $8D, $8C, $8D, $8B
L9580:  .byte $8D, $8C, $8D, $8B, $8D, $8C, $8D, $8B, $8D, $8C, $8D, $8B, $8D, $8C, $8D, $8B
L9590:  .byte $8D, $8C, $8D, $8B, $8D, $80, $00, $80, $00, $80, $00, $80, $00, $80, $00, $80
L95A0:  .byte $00, $80, $00, $80, $00, $80

L95A6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L95B6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L95C6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L95D6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L95E6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L95F6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9606:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9616:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9626:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9636:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9646:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9656:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9666:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9676:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9686:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9696:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L96A6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L96B6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L96C6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L96D6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L96E6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L96F6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9706:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9716:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9726:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9736:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9746:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9756:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9766:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9776:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9786:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9796:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L97A6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L97B6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L97C6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L97D6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L97E6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L97F6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;; These pointers get loaded into $54
L9800:  .word $0000, $984A, $9879, $988F, $988F, $9937, $9937, $99E3
L9810:  .word $9A1E, $9A27, $9A67, $9AAA, $9B4A, $9BEA, $99FD, $0000
L9820:  .word $9C50, $9CAE, $9CA8, $9D10, $9C7A, $9CDE, $9D16, $9DB5, $9832

L9832:  .byte $80, $0C, $EC, $80, $EC, $81, $80, $01, $EC, $82, $EC, $83, $80, $01, $EC, $30
L9842:  .byte $80, $FF, $80, $FF, $80, $FF, $80, $FF, $F2, $11, $58, $B0, $12, $00, $B0, $39
L9852:  .byte $14, $80, $0E, $22, $FF, $18, $01, $AD, $38, $04, $3F, $1D, $80, $1E, $22, $01
L9862:  .byte $1F, $01, $B3, $22, $FF, $11, $00, $B0, $38, $14, $80, $03, $22, $01, $22, $02
L9872:  .byte $1C, $01, $B5, $22, $FE, $3F, $04, $F2, $14, $58, $B0, $08, $02, $0F, $04, $3F
L9882:  .byte $04, $14, $02, $B0, $04, $04, $04, $02, $04, $04, $F2, $3F, $04, $E3, $BC, $00
L9892:  .byte $A3, $12, $00, $B0, $22, $FF, $12, $08, $AD, $EC, $44, $E3, $68, $02, $16, $F7
L98A2:  .byte $FF, $FF, $00, $21, $FF, $21, $FF, $21, $FE, $E3, $68, $04, $7C, $12, $0B, $A2
L98B2:  .byte $12, $0C, $9D, $11, $61, $99, $F5, $07, $E1, $59, $80, $01, $F3, $2B, $11, $0D
L98C2:  .byte $A0, $E3, $68, $05, $67, $80, $01, $E3, $68, $02, $41, $F7, $80, $80, $12, $08
L98D2:  .byte $A2, $21, $01, $F7, $00, $00, $21, $01, $21, $02, $F7, $00, $00, $00, $21, $02
L98E2:  .byte $21, $03, $12, $0B, $B0, $F4, $E3, $68, $05, $6E, $11, $0D, $A0, $11, $08, $A3
L98F2:  .byte $21, $03, $3F, $4D, $F7, $00, $00, $80, $02, $3F, $41, $F7, $00, $00, $00, $11
L9902:  .byte $0D, $A0, $11, $08, $A3, $21, $03, $3F, $51, $11, $0B, $A2, $11, $0C, $9D, $11
L9912:  .byte $61, $99, $F5, $05, $E1, $59, $80, $01, $F3, $87, $11, $0D, $A0, $11, $08, $A2
L9922:  .byte $21, $02, $21, $02, $F7, $00, $00, $00, $21, $02, $21, $03, $11, $0B, $B0, $F4
L9932:  .byte $13, $02, $B0, $3F, $07, $E3, $BC, $00, $A7, $12, $00, $B0, $22, $01, $12, $08
L9942:  .byte $B3, $EC, $44, $E3, $68, $02, $16, $F7, $FF, $FF, $00, $21, $01, $21, $02, $21
L9952:  .byte $03, $E3, $68, $04, $7D, $12, $09, $BE, $12, $0A, $C3, $11, $60, $C7, $F5, $07
L9962:  .byte $E0, $5A, $80, $01, $F3, $2B, $11, $07, $C0, $E3, $68, $05, $68, $80, $01, $E3
L9972:  .byte $68, $02, $41, $F7, $80, $80, $12, $08, $BE, $21, $FF, $21, $FF, $F7, $00, $00
L9982:  .byte $00, $21, $FE, $21, $FE, $21, $FD, $F7, $00, $00, $00, $12, $09, $B0, $F4, $E3
L9992:  .byte $68, $05, $6F, $11, $07, $C0, $11, $08, $BC, $21, $FA, $3F, $52, $F7, $00, $00
L99A2:  .byte $80, $02, $3F, $41, $F7, $00, $00, $00, $11, $07, $C0, $11, $08, $BC, $21, $FA
L99B2:  .byte $3F, $56, $11, $09, $BE, $11, $0A, $C3, $11, $60, $C7, $F5, $05, $E0, $5A, $80
L99C2:  .byte $01, $F3, $88, $11, $07, $C0, $11, $08, $BE, $F7, $00, $00, $21, $FE, $21, $FE
L99D2:  .byte $F7, $00, $00, $00, $21, $FE, $21, $FD, $11, $09, $B0, $F4, $13, $02, $B0, $3F
L99E2:  .byte $07, $FA, $6A, $00, $00, $12, $0B, $B0, $F7, $08, $08, $00, $01, $5F, $F5, $0A
L99F2:  .byte $E4, $1A, $F3, $0F, $FA, $6A, $80, $E4, $16, $3F, $16, $EC, $5C, $E3, $68, $02
L9A02:  .byte $32, $F7, $80, $80, $00, $14, $06, $B1, $24, $02, $2D, $02, $13, $07, $B2, $F7
L9A12:  .byte $00, $00, $F4, $F7, $00, $00, $00, $14, $06, $B1, $3F, $27, $EC, $10, $16, $5E
L9A22:  .byte $AC, $14, $05, $B0, $FF, $13, $00, $AE, $12, $14, $AA, $E5, $02, $80, $01, $EC
L9A32:  .byte $18, $80, $02, $01, $15, $F6, $05, $F0, $2D, $35, $24, $02, $E3, $4A, $00, $25
L9A42:  .byte $01, $12, $E6, $00, $11, $54, $B0, $E6, $01, $F4, $80, $06, $04, $12, $14, $54
L9A52:  .byte $B0, $FF, $80, $0A, $05, $16, $12, $54, $B0, $FF, $80, $03, $0E, $16, $12, $54
L9A62:  .byte $B0, $E9, $18, $9F, $F4, $13, $0E, $B0, $11, $0F, $AC, $E5, $03, $EC, $18, $80
L9A72:  .byte $01, $12, $10, $A8, $F6, $04, $F0, $2E, $37, $24, $FE, $E3, $4A, $00, $25, $12
L9A82:  .byte $12, $AC, $E6, $00, $11, $13, $B0, $E6, $01, $F4, $80, $06, $14, $12, $AC, $12
L9A92:  .byte $13, $B0, $FF, $80, $09, $15, $11, $AC, $14, $13, $B0, $FF, $80, $02, $1C, $11
L9AA2:  .byte $AC, $16, $13, $B0, $E9, $18, $9F, $F4, $E3, $68, $03, $6F, $13, $12, $B0, $12
L9AB2:  .byte $1D, $AD, $EC, $18, $E5, $00, $FD, $02, $12, $1E, $AA, $FD, $04, $11, $1F, $A6
L9AC2:  .byte $F6, $05, $F0, $44, $58, $24, $02, $E3, $4A, $00, $36, $12, $1E, $AA, $E6, $00
L9AD2:  .byte $12, $1C, $AD, $12, $12, $B0, $01, $54, $E6, $01, $F4, $FA, $68, $00, $80, $06
L9AE2:  .byte $14, $1E, $AA, $12, $1C, $AD, $12, $12, $B0, $02, $54, $FF, $80, $08, $05, $20
L9AF2:  .byte $FD, $02, $12, $21, $A9, $FD, $00, $12, $16, $AC, $12, $22, $B0, $05, $04, $FF
L9B02:  .byte $80, $02, $0E, $20, $FD, $02, $12, $21, $A9, $FD, $00, $12, $16, $AC, $12, $22
L9B12:  .byte $B0, $06, $04, $E9, $18, $9F, $F4, $11, $12, $B0, $EC, $1C, $E6, $00, $11, $1D
L9B22:  .byte $AD, $E5, $00, $FD, $02, $11, $1E, $AA, $FD, $04, $11, $1F, $A6, $F6, $05, $F0
L9B32:  .byte $44, $58, $EC, $80, $22, $02, $E3, $4A, $00, $33, $12, $1E, $AA, $11, $1C, $AD
L9B42:  .byte $11, $12, $B0, $01, $54, $E6, $01, $F4, $E3, $68, $03, $6F, $13, $12, $B0, $12
L9B52:  .byte $17, $AE, $EC, $18, $E5, $01, $FD, $02, $12, $18, $AC, $FD, $04, $11, $19, $A8
L9B62:  .byte $F6, $05, $F0, $44, $58, $24, $FE, $E3, $4A, $00, $36, $12, $18, $A8, $E6, $00
L9B72:  .byte $12, $1C, $AC, $12, $12, $B0, $01, $13, $E6, $01, $F4, $FA, $68, $00, $80, $06
L9B82:  .byte $14, $18, $A8, $12, $1C, $AC, $12, $12, $B0, $02, $13, $FF, $80, $08, $05, $1A
L9B92:  .byte $FD, $02, $12, $1B, $AC, $FD, $00, $12, $11, $AE, $12, $22, $B0, $05, $04, $FF
L9BA2:  .byte $80, $02, $0E, $1A, $FD, $02, $12, $1B, $AC, $FD, $00, $12, $11, $AE, $12, $22
L9BB2:  .byte $B0, $06, $04, $E9, $18, $9F, $F4, $11, $12, $B0, $EC, $1C, $E6, $00, $11, $17
L9BC2:  .byte $AE, $E5, $01, $FD, $02, $11, $18, $AC, $FD, $04, $11, $19, $A8, $F6, $05, $F0
L9BD2:  .byte $44, $58, $EC, $80, $22, $FE, $E3, $4A, $00, $33, $12, $18, $A8, $11, $1C, $AC
L9BE2:  .byte $11, $12, $B0, $01, $13, $E6, $01, $F4, $EC, $80, $11, $12, $AC, $EC, $58, $80
L9BF2:  .byte $03, $08, $23, $14, $24, $A8, $1F, $23, $AC, $11, $25, $A8, $EC, $14, $FD, $02
L9C02:  .byte $01, $26, $01, $27, $E5, $80, $FD, $04, $03, $28, $04, $29, $F6, $0F, $F0, $44
L9C12:  .byte $44, $01, $2A, $E6, $00, $80, $11, $13, $2B, $A9, $12, $2C, $AA, $11, $2D, $AB
L9C22:  .byte $11, $2E, $AC, $06, $0B, $E3, $05, $01, $43, $E6, $01, $FF, $04, $2A, $24, $02
L9C32:  .byte $24, $02, $24, $02, $13, $2B, $AF, $FD, $02, $12, $2C, $B0, $11, $2D, $B1, $FD
L9C42:  .byte $00, $11, $2E, $B2, $01, $0B, $04, $22, $08, $04, $E9, $18, $9F, $F4, $EC, $0C
L9C52:  .byte $06, $2F, $43, $30, $FC, $41, $33, $04, $E3, $05, $02, $18, $FC, $80, $08, $E3
L9C62:  .byte $68, $01, $17, $80, $14, $FF, $EC, $08, $80, $03, $44, $3B, $FC, $48, $3C, $F0
L9C72:  .byte $47, $3D, $FE, $46, $3E, $FF, $3F, $52, $EC, $0C, $04, $59, $04, $5A, $03, $2F
L9C82:  .byte $02, $30, $41, $33, $08, $E3, $05, $02, $1B, $FC, $80, $06, $E3, $68, $01, $1A
L9C92:  .byte $80, $0E, $FF, $EC, $08, $80, $03, $04, $3B, $48, $3C, $F8, $07, $3D, $06, $3E
L9CA2:  .byte $05, $3F, $F1, $4F, $9E, $00, $EC, $0C, $F1, $7A, $9C, $04, $EC, $0C, $06, $31
L9CB2:  .byte $43, $32, $04, $41, $34, $04, $E3, $05, $02, $1E, $FC, $80, $07, $E3, $68, $02
L9CC2:  .byte $1D, $80, $01, $E3, $68, $01, $1D, $80, $14, $FF, $EC, $08, $80, $03, $44, $35
L9CD2:  .byte $04, $48, $36, $08, $47, $37, $02, $46, $38, $01, $3F, $5C, $EC, $0C, $04, $5B
L9CE2:  .byte $04, $5C, $03, $31, $02, $32, $01, $34, $E3, $05, $02, $20, $80, $05, $FC, $E3
L9CF2:  .byte $68, $02, $1F, $80, $01, $E3, $68, $01, $1F, $80, $0E, $FF, $EC, $08, $80, $03
L9D02:  .byte $04, $35, $08, $36, $07, $37, $06, $38, $05, $39, $F1, $4F, $9E, $00, $04, $5B
L9D12:  .byte $F1, $DE, $9C, $04, $01, $A4, $01, $48, $FA, $46, $00, $E3, $06, $04, $54, $80
L9D22:  .byte $40, $EB, $E9, $85, $9F, $0C, $95, $80, $0C, $08, $A4, $08, $95, $0F, $94, $80
L9D32:  .byte $02, $01, $98, $EC, $34, $08, $A6, $EB, $80, $0D, $E9, $FD, $9E, $01, $97, $FA
L9D42:  .byte $70, $48, $FA, $71, $95, $F5, $0B, $FA, $BB, $01, $00, $E9, $85, $9F, $E9, $09
L9D52:  .byte $9F, $3F, $43, $80, $01, $E8, $FF, $E7, $01, $E8, $FF, $F3, $3F, $FC, $80, $02
L9D62:  .byte $FA, $05, $00, $E6, $01, $01, $54, $FF, $80, $10, $0F, $98, $80, $30, $E3, $C1
L9D72:  .byte $AB, $77, $01, $A7, $0F, $A5, $04, $AC, $E9, $C0, $00, $FA, $BB, $01, $E9, $1E
L9D82:  .byte $9F, $E9, $47, $9F, $FA, $00, $FA, $80, $FF, $80, $FF, $04, $AD, $EC, $54, $E9
L9D92:  .byte $C0, $00, $FA, $BB, $FF, $E9, $85, $9F, $FA, $40, $82, $80, $10, $0F, $47, $0F
L9DA2:  .byte $5D, $E9, $7C, $9F, $E9, $65, $9F, $FA, $00, $F9, $80, $FF, $80, $FF, $E9, $FD
L9DB2:  .byte $9E, $3F, $43, $14, $58, $B0, $3F, $1E, $FA, $BB, $03, $80, $01, $E3, $BB, $03
L9DC2:  .byte $08, $01, $96, $01, $94, $80, $01, $E3, $BB, $04, $12, $EC, $7E, $F1, $16, $9D
L9DD2:  .byte $1D, $FA, $70, $55, $F5, $0D, $E7, $FF, $80, $01, $F3, $23, $E9, $F7, $9E, $80
L9DE2:  .byte $01, $EC, $76, $80, $01, $E3, $BB, $00, $30, $80, $20, $E9, $8A, $9F, $E3, $C0
L9DF2:  .byte $00, $79, $F5, $0A, $FA, $71, $94, $E9, $A3, $9F, $EC, $40, $E9, $C0, $00, $80
L9E02:  .byte $09, $E3, $C1, $A2, $8B, $E3, $C1, $9E, $89, $F3, $44, $EC, $07, $01, $96, $01
L9E12:  .byte $AE, $05, $A5, $F5, $04, $0A, $AC, $06, $A5, $F3, $62, $EC, $38, $08, $A8, $E9
L9E22:  .byte $1E, $9F, $E9, $47, $9F, $FA, $00, $FE, $80, $FF, $80, $FF, $E9, $B0, $9F, $E9
L9E32:  .byte $1E, $9F, $E9, $47, $9F, $FA, $00, $FC, $80, $FF, $80, $FF, $34, $56, $37, $56
L9E42:  .byte $FA, $BB, $02, $80, $01, $E3, $BB, $02, $90, $80, $10, $3F, $56, $1F, $40, $B0
L9E52:  .byte $E9, $F7, $9E, $80, $10, $EC, $04, $80, $01, $EC, $7A, $80, $01, $E3, $BB, $80
L9E62:  .byte $0E, $80, $20, $E9, $8A, $9F, $E3, $C0, $00, $8B, $01, $3A, $FA, $CF, $01, $F5
L9E72:  .byte $09, $FA, $71, $A4, $E9, $A3, $9F, $EC, $40, $E9, $C0, $00, $E3, $70, $48, $7D
L9E82:  .byte $F3, $27, $FA, $CF, $00, $E9, $A3, $9F, $EC, $40, $E9, $C0, $00, $01, $96, $EC
L9E92:  .byte $83, $F5, $04, $E3, $70, $43, $78, $E3, $70, $3A, $78, $80, $03, $E7, $FF, $F3
L9EA2:  .byte $4E, $01, $AE, $05, $A5, $EC, $38, $01, $A8, $FA, $BB, $FF, $EC, $07, $80, $18
L9EB2:  .byte $EC, $54, $E9, $85, $9F, $FA, $40, $82, $E9, $7C, $9F, $E9, $65, $9F, $FA, $00
L9EC2:  .byte $FD, $80, $FF, $80, $FF, $FA, $70, $44, $3F, $4E, $FA, $CF, $00, $01, $96, $E9
L9ED2:  .byte $9C, $9F, $EC, $7E, $F1, $16, $9D, $1D, $E9, $B0, $9F, $FA, $BB, $FF, $80, $20
L9EE2:  .byte $EC, $54, $E9, $85, $9F, $FA, $40, $82, $E9, $7C, $9F, $E9, $65, $9F, $FA, $00
L9EF2:  .byte $FB, $80, $FF, $80, $FF, $FA, $22, $01, $EC, $07, $EA, $E3, $01, $08, $0B, $EC
L9F02:  .byte $83, $80, $01, $FA, $22, $00, $EA, $E3, $01, $08, $05, $EA, $80, $08, $EC, $83
L9F12:  .byte $80, $01, $FA, $22, $00, $EA, $E3, $BB, $01, $05, $EA, $FF, $80, $10, $FA, $70
L9F22:  .byte $48, $F5, $09, $E7, $01, $80, $01, $F3, $07, $04, $55, $0F, $56, $FA, $40, $82
L9F32:  .byte $EC, $54, $F5, $0A, $08, $56, $08, $57, $F3, $18, $EC, $07, $F5, $05, $08, $56
L9F42:  .byte $08, $57, $F3, $22, $EA, $FA, $40, $03, $80, $01, $E3, $40, $03, $03, $80, $60
L9F52:  .byte $EC, $83, $E3, $03, $30, $18, $E3, $03, $40, $1B, $EC, $1A, $EA, $EC, $16, $EA
L9F62:  .byte $EC, $06, $EA, $FA, $40, $03, $80, $01, $E3, $40, $03, $03, $80, $60, $EC, $83
L9F72:  .byte $E3, $8E, $01, $14, $EC, $1E, $EA, $EC, $26, $EA, $80, $01, $E3, $BB, $ED, $08
L9F82:  .byte $3F, $00, $EA, $80, $FF, $3F, $00, $EA, $FB, $FA, $71, $80, $00, $FA, $46, $00
L9F92:  .byte $F5, $15, $E8, $01, $80, $01, $F3, $0A, $80, $04, $01, $A4, $80, $10, $0F, $95
L9FA2:  .byte $EA, $F8, $C1, $01, $96, $E8, $00, $80, $0B, $01, $98, $01, $99, $EA, $01, $AE
L9FB2:  .byte $05, $A5, $EC, $3C, $08, $A9, $EA

L9FB9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FC9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FD9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FE9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FF9:  .byte $00, $00, $00, $00, $00, $00, $00
