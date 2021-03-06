#
# guzhoudiaoke@126.com
# 2018-02-08
#

# start up the Application porcessors(AP).

#include "kernel.h"

.code16
.global start
start:
	cli

	xorw	%ax,             %ax
	movw	%ax,             %ds
	movw	%ax,             %es
	movw	%ax,             %ss

	lgdt	gdt_ptr
	movl	%cr0,	         %eax
	orl		$CR0_PE,         %eax
	movl	%eax,	         %cr0

	ljmpl	$(SEG_KCODE<<3), $(start32)

.code32
start32:
	movw	$(SEG_KDATA<<3), %ax
	movw	%ax,             %ds
	movw	%ax,             %es
	movw	%ax,             %ss
	xorw	%ax,             %ax
	movw	%ax,             %fs
	movw	%ax,             %gs

	# setup page directory
	movl    (AP_PGDIR),	     %eax
	movl    %eax,		     %cr3

	# turn on paging
	movl    %cr0,		     %eax
	orl	    $(CR0_PG),	     %eax
	movl    %eax,		     %cr0

	# set a new stack
	movl    (AP_KSTACK),     %esp
    pushl   (AP_INDEX)

	# jump to main
	movl    (AP_MAIN),	     %eax
	call    *%eax

1:
    jmp 1b



.p2align 2
gdt:
.quad	0x0000000000000000
.quad	0x00cf9a000000ffff
.quad	0x00cf92000000ffff
gdt_ptr:
.word	(gdt_ptr - gdt - 1)
.long   gdt

