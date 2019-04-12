section	.text
   global _start   ;must be declared for linker (ld)
	
_start:	

   mov  si,array1 ;get array address into source index register
   mov di,array2; get address to put the sum in destination register
   mov cx,20 ; load the number of array counter
   mov bx,0 ; start sum register


for0:
mov ax,[si] ; for cicle loa to acumulador register the array values
xor dx,dx ;clear dx word of extend word division
xor cx,cx  ;clear cx word of extend word division
mov ax,bx ;loads sum before resolt into acumulator
mov bx,11 ;load the divisor 11 
div bx ; divide acumulator by 11
mov [di],ax ;stores the acumulator in sum address destany place index
inc si   ; add 1 to  the index source array
inc si ; add the second byte to compleat a word size a word have 2 bytes in size
dec cx ; in counter register  remain array index left
cmp cx,0 ; compare counter register id 0 count 20 array size
jnz for0 ;if the counter register is not zero jumps to for again into cx compleat 20 times


   mov  si,array2 ;get array address into source index register
   mov di,sum ; get address to put the sum in destination register
   mov cx,20 ; load the number of array counter
   mov bx,0 ; start sum register
for1:
mov ax,[si] ; for cicle loa to acumulador register the array values
clc ; clear the carry flag
add bx,ax  ; add last sum into acumulator in base register
inc si   ; add 1 to  the index source array
inc si ; add the second byte to compleat a word size a word have 2 bytes in size
dec cx ; in counter register  remain array index left
cmp cx,0 ; compare counter register id 0 count 20 array size
jnz for1 ;if the counter register is not zero jumps to for again into cx compleat 20 times




; dont know if you can use link gnu in you scoll or must use the str function?
mov si,di
mov di,ascii
call str
mov dx,ascii
call print

xor ax,ax ; dos function exit to DOS
int 21h ; function call DOS


str:
	mov ax,[si]
	mov bp,10000
	str16:
	xor dx,dx
	xor cx,cx
	mov bx,bp
	clc
	div bx
	mov si,dx
	mov ah,48
	clc
	add al,ah
	mov [di],al
	inc di
	mov ax,bp
	xor dx,dx
	xor cx,cx
	mov bx,10
	clc
	div bx
	mov bp,ax
	mov ax,si
	cmp bp,0
	jnz str16
	ret
	ret
 
print:
mov ah,9
int 0x21
ret



section	.data
; Put you 20 array data here
array1dw  2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25
; addresss of sum 
sum dw 0
array2 resw 21
ascii db '.....................................$'