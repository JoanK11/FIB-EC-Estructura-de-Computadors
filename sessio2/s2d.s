# PRACTICA 2 #######################
.data
alfabet: .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
w1:      .asciiz "ARQUITECTURA"
         .space 3
w2:      .space 16
w3:      .space 16
count:   .word 0

.text
.globl main
main:
   addiu $sp, $sp, -4
   sw    $ra, 0($sp) 
   la    $s0, count
   la    $a0, w1
   la    $a1, w2
   jal   codifica 
   sw    $v0, 0($s0)
   la    $a0, w2
   la    $a1, w3
   jal   codifica 
   lw    $s1, 0($s0)
   addu  $s1, $s1, $v0
   sw    $s1, 0($s0)
   li    $v0, 4
   la    $a0, w2
   syscall
   la    $a0, w3
   syscall
   lw    $ra, 0($sp)
   addiu $sp, $sp, 4
   jr    $ra

g:  
   lb    $t0, 0($a1)		# $t0 = *pfrasein 
   li    $t1, 'A'
   addiu $t1, $t1, 25		# $t1 = 'Z'
   sub   $t1, $t1, $t0		# $t1 = Diferència entre 'A' i *pfrasein
   add   $t0, $a0, $t1		# Invertim la lletra
   lb    $v0, 0($t0) 
  
   jr $ra


codifica:
   addiu $sp, $sp, -16
   sw    $ra, 0($sp)
   sw    $s0, 4($sp)
   sw    $s1, 8($sp)
   sw    $s2, 12($sp)
   move  $s2, $zero
   move  $s0, $a0
   move  $s1, $a1 
while:
   lb    $t0, 0($s0)		# Aquí ja hem agafat el valor de *pfrasein
   #lb    $t0, 0($s1) --> 	1r ERROR: Accedim a una posició de memòria incorrecta (*pfrasein)
   beq   $t0, $zero, fi_while
   la    $a0, alfabet
   move  $a1, $s0		# 2n ERROR: Volem agafar $s0 = pfrasein, no $s1 = pfraseout
   jal   g  
   sb    $v0, 0($s1)  		# 3r ERROR: Hem de guardar el nou valor a pfraseout, no a prfrasein
   addiu $s0, $s0, 1
   addiu $s1, $s1, 1
   addiu $s2, $s2, 1  
   b     while     
 fi_while:
   sb    $zero, 0($s1)
   move  $v0, $s2
   lw    $ra, 0($sp)
   lw    $s0, 4($sp)
   lw    $s1, 8($sp)
   lw    $s2, 12($sp)
   addiu $sp, $sp, 16
   jr    $ra
