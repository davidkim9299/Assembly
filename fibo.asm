.model small
.stack 100h
.data
	msg1 db 0dh, 0ah, "DONGRYUL KIM",0dh,0ah,"$"
	msg2 db 0dh, 0ah, "Enter 2 digits for the nth term",0dh,0ah,"$"
	space db "  ","$" 
	f0 dw 0000h
	f1 dw 0000h
	num dd 0
	temp dw 0000h
.code
extrn writeint:proc

;fibonacci sequence F(n) = F(n-1) + F(n-2)

main proc
	mov ax,@data		; copy the address of the data segment to ax
	mov ds,ax		; move the address in to the ds

	mov ah,9
	mov dx, offset msg1
	int 21h
	
	mov ah,9		
	mov dx, offset msg2	; print out msg
	int 21h			
	
	MOV AH, 01		; get first digit number A
	INT 21H
	SUB AL, '0'		
	MOV BL, 10		; set bl 10
	mul bl			; al x 10 to make a number Ax10
	mov bl, al		; copy al to bl
	
	MOV AH, 01		; get second number B
	INT 21H
	SUB AL, '0'
	mov cl, al		; copy al to bl
	
	add cl,bl		; making 2 digits number form of A*10 + B -> AB. will be used as a count number

	mov   ah,9              
    	mov   dx,offset space	; print out space
    	int   21h 
	
	mov f0,0000h		; set the f(0) of the fibonacci sequence = 0
	mov f1,0001h		; set the f(1) of the fibonacci sequence = 1
	
	mov ax,f0		; copy f1 to ax
	mov bx,10		; base 10
	
	call writeint		; print out f(0)
	mov   ah,9              
    	mov   dx,offset space	; print out spcae
    	int   21h 


fibo:
	dec cl			; cl is used as a count number. it will decrease in every looping until it is 0
	mov bx,f0		; copy f1 to bx
	add bx,f1		; add the second with last value
	mov temp,bx		; move the result to temp

	mov bx,f0		; copy f1 to bx
	mov f1,bx		; copy bx to f2
	mov bx,temp		; coput temp to bx
	mov f0,bx		; copy bx to f1

	mov ax,temp		; copt temp to ax to print out
	mov bx,10		; base 10

	call writeint		; print out the n-th fibonacci number
	mov   ah,9
   	mov   dx,offset space	; print out space
    	int   21h 
	
	cmp cl,0		; compare cl and 0
	jne fibo		; if cl not equals 0, then repeat the fibo loop

	mov ax,4c00h		; end statement
	int 21h
	
main endp			; end of main proc
end main			; end program
