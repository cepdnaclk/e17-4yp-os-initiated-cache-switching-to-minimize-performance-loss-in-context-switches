main:
        addi    sp, sp, 128
        addi    sp,sp,-48
        sw      s0,44(sp)
        addi    s0,sp,48
        sw      zero,-32(s0)
        addi    a5, zero, 1
        sw      a5,-24(s0)
        lw      a4,-32(s0)
        lw      a5,-24(s0)
        add     a5,a4,a5
        sw      a5,-28(s0)
        addi    a5, zero, 20
        sw      a5,-36(s0)
        addi    a5, zero, 3
        sw      a5,-20(s0)
        jal     x6, .L2
.L3:
        lw      a5,-24(s0)
        sw      a5,-32(s0)
        lw      a5,-28(s0)
        sw      a5,-24(s0)
        lw      a4,-32(s0)
        lw      a5,-24(s0)
        add     a5,a4,a5
        sw      a5,-28(s0)
        lw      a5,-20(s0)
        addi    a5,a5,1
        sw      a5,-20(s0)
.L2:
        lw      a4,-36(s0)
        lw      a5,-20(s0)
        bge     a4,a5,.L3

        addi    a5, zero, 0
        addi    a0, a5, 0
        lw      s0,44(sp)
        addi    sp,sp,48
        jal     ra, 0
		
-------------------------------------

main:
        addi    sp, sp, 64
        addi    sp,sp,-48
        sw      s0,44(sp)
        addi    s0,sp,48
        sw      zero,-32(s0)
        addi    a5, zero, 1
        sw      a5,-24(s0)
        lw      a4,-32(s0)
        lw      a5,-24(s0)
        add     a5,a4,a5
        sw      a5,-28(s0)
        addi    a5, zero, 20
        sw      a5,-36(s0)
        addi    a5, zero, 3
        sw      a5,-20(s0)
        jal     x6, .L2
.L3:
        lw      a5,-24(s0)
        sw      a5,-32(s0)
        lw      a5,-28(s0)
        sw      a5,-24(s0)
        lw      a4,-32(s0)
        lw      a5,-24(s0)
        add     a5,a4,a5
        sw      a5,-28(s0)
        lw      a5,-20(s0)
        addi    a5,a5,1
        sw      a5,-20(s0)
.L2:
        lw      a4,-36(s0)
        lw      a5,-20(s0)
        bge     a4,a5,.L3
        addi    a5, zero, 0
        addi    a0, a5, 0
        lw      s0,44(sp)
        addi    sp,sp,48
        jal     ra, 0