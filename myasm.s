section .data                    	; data section, read-write
        an:    DD 0              	; this is a temporary var

section .text                    	; our code is always in the .text section
        global do_Str          	; makes the function appear in global scope
        extern printf            	; tell linker that printf is defined elsewhere 							; (not used in the program)

do_Str:                        	; functions are defined as labels
        push    ebp              	; save Base Pointer (bp) original value
        mov     ebp, esp         	; use base pointer to access stack contents
        pushad                   	; push all variables onto stack
        mov ecx, dword [ebp+8]	; get function argument

;;;;;;;;;;;;;;;; FUNCTION EFFECTIVE CODE STARTS HERE ;;;;;;;;;;;;;;;; 

	mov	dword [an], 0		; initialize answer
	label_here:
        cmp byte [ecx],'(';
        je o1
        cmp byte [ecx],')'
        je o2
        cmp byte [ecx], 'a'
        jge o3
        cmp byte [ecx], 'A'
        jge o5
        jmp sign
                        ; keep looping until it is null terminated
    o1: 
        mov byte [ecx],'<'
        inc dword [an]
        jmp fin
    o2: 
        mov byte [ecx],'>'
        inc dword [an]
        jmp fin
    o3:
        cmp byte [ecx],'z'
        jle o4
        jmp sign
    o4:
        sub byte [ecx],32
        jmp fin
    o5:
        cmp byte [ecx],'Z'
        jle fin
        jmp sign
    sign:
        inc dword [an]
        jmp fin
     fin:
		inc ecx      	    ; increment pointer
		cmp byte [ecx], 0   ; check if byte pointed to is zero
		jnz label_here 
;;;;;;;;;;;;;;;; FUNCTION EFFECTIVE CODE ENDS HERE ;;;;;;;;;;;;;;;; 

         popad                    ; restore all previously used registers
         mov     eax,[an]         ; return an (returned values are in eax)
         mov     esp, ebp
         pop     ebp
         ret 
		 
