section	.text
   global _start   ;must be declared for linker (ld)
	
_start:	
org 0x100

again:
	mov dx,ascii3
	call print
	mov di,array2
	call input
	mov dx,ascii7
	call print
	mov si,array2
	mov di,ascii2
	call str
	mov dx,ascii2
	call print
	mov si,array2
	mov ax,[si]
	cmp ax,50
	jb again
	cmp ax,100
	ja again
	cmp ax,75
	jb nopass
	mov dx,ascii4
	call print
	jmp ood
nopass:
	mov dx,ascii5
	call print
ood:	
	and ax,1
	cmp ax,0
	jnz notpair	
	mov dx,ascii8
	call print
	jmp exits
notpair:
	mov dx,ascii6
	call print

exits:
xor ax,ax ; dos function exit to DOS
int 21h ; function call DOS


str:
push ax
push bx
push cx
push dx
push bp
push si
push di
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
pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
	ret
	ret
 
print:
push ax
push bx
push cx
push dx
push bp
push si
push di
mov ah,9
int 0x21
pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
ret

val:
push ax
push bx
push cx
push dx
push bp
push si
push di
		mov cl,0
		mov dx,0
		mov bx,1
val2:
		mov al,[si]
		cmp al,48
		jb val3
		cmp al,57
		ja val3
		jmp val4
val3:
		cmp cl,0
		jz val40
		jmp val5
val4:
		cmp cl,4
		jz val55
		inc cl
		inc si
		jmp val2
val55:
		dec cl
val5:
		dec si
val6:
		push cx
		push dx
		xor ax,ax
		mov al,[si]
		clc
		sub al,48
		xor cx,cx
		xor dx,dx
		push bx
		imul bx
		xor cx,cx
		xor dx,dx
		pop bx
		push ax
		mov ax,10
		imul bx
		mov bx,ax
		pop ax
		pop dx
		pop cx
		clc
		add dx,ax
		dec si
		dec cl
		cmp cl,0
		jz val40
		jmp val6
val40:
		mov ax,dx
		mov [di],ax
pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
ret



input:
push ax
push bx
push cx
push dx
push bp
push si
push di
	mov bx,L16
	mov dx,bx
	mov cx,5
	mov bx,dx
	mov [bx],cx
	mov ah,0xa
	int 0x21
	mov bx,L16
	mov si,bx
	inc si
	inc si
	call val
pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
ret



section	.data
sum dw 0
big dw 0
low dw 0
array2 times 22 dw 0
ascii2 db '00000.$'
L16 db '                                         '
ascii3 db 13,10,'grade ? $'
ascii4 db 13,10,'passing grade',13,10,'$'
ascii5 db 13,10,'failed grade',13,10,'$'
ascii6 db 13,10,'even grade',13,10,'$'
ascii8 db 13,10,'odd grade',13,10,'$'
ascii7 db 13,10,'$'







