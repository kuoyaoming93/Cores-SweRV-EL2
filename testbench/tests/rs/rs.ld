/*
 NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
 This is an automatically generated file by kuo on mar 23 mar 2021 11:03:54 CET

 cmd:    swerv -target=default -set build_axi4 -set bitmanip_zbc 

*/
OUTPUT_ARCH( "riscv" )
ENTRY(_start)

SECTIONS
{
  . = 0x80000000;
  .text.init .  : { *(.text.init) }
  
  .text . : { *(.text) }
  _end = .;
  end = _end;
  . = 0xd0580000;
  .data.io .  : { *(.data.io) }
    . = 0xf0040000 ;
  .data  :  ALIGN(0x800) { *(.*data) *(.rodata*) STACK = ALIGN(16) + 0x1000; }
  .bss : { *(.bss) }
  
    . = 0xfffffff8; .data.ctl : { LONG(0xf0040000); LONG(STACK) }
}