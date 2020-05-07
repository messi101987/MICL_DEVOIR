; Important: dans la chaîne "Faites des ponts.....", les caractères du mot caché 'sept' se trouvent aux position 5,8,11,14. 
; Nous avons fait un choix techniques dans le tableau ci-dessous: pour avoir une belle représentation du message on décide 
; de poinçonner à plusieurs reprises le caractère à la position 100 dans la chaine puis de revenir en arrière.

global start

section .data        

; Le tableau suivant représente la position du caractère dans la chaine se trouvant 
; dans le fichier 'message'

	position 	 DW 	5,8,11,14,100,19,34,40,44,100,55,100,57,70,80,83,84,99,100,101

section .rodata
    message	      	DB      `message`, 0
    output	        DB      `fileOut`, 0
    msgErreur       DB      `Error : file not found or permission denied`
    lgrMsgErreur    DQ      $ - msgErreur
    retourLigne 	DQ		`\n`
    lgrRetourLigne	DQ		$ - retourLigne


section .bss
    fd1 			resq	1
    fd2				resq	1
    car				resb	1


section .text


start:

	mov     rax, 2          
    mov     rdi, message 
    mov     rsi, 2q
    mov 	rdx, 644q
    syscall

    mov [fd1], RAX

    cmp     rax, 3
    jz reussite




echec:
    mov     rax, 1          ;write
    mov     rdi, 1          ; stdout, sortie standard
    mov     rsi, msgErreur  ;adresse du 1er caractere
    mov     rdx, [lgrMsgErreur] ;nombre de car
    syscall

   

    mov     rax, 1          ;write
    mov     rdi, 1   
    mov     rsi, retourLigne  ;adresse du 1er caractere
    mov     rdx, [lgrRetourLigne] ;nombre de car
    syscall
    jmp fin

reussite:

    mov     rax, 2          
    mov     rdi, output  
    mov     rsi, 2q | 100q | 2000q ; WRONLY + O_CREAT + O_APPEND
    mov     rdx, 755q
    syscall

     mov [fd2], RAX


	mov r8b, 0
pour:
	cmp r8b, 20
	jz fin_pour

    mov r9w, [position + r8 * 2]

    mov     rax, 8
    mov     rdi, [fd1]
    mov     rsi, r9
    mov     rdx, 0
    syscall

	mov 	rax, 0
	mov 	rdi, [fd1]
	mov 	rsi, car		
	mov 	rdx, 1
	syscall


    mov     rax, 1         
    mov     rdi, [fd2]     
    mov     rsi, car 
    mov 	rdx, 1
    syscall

	inc r8b
	jmp pour

fin_pour:


fin:

    mov     rax, 60
    mov     rdi,0
    syscall


	
		
	
    	





