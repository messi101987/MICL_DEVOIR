; Important: dans la chaîne "Faites des ponts.....", les caractères du mot caché 'sept' se trouvent aux position 5,8,11,14. 
; Nous avons fait un choix techniques dans le tableau ci-dessous: pour avoir une belle représentation du message on décide 
; de poinçonner à plusieurs reprises le caractère à la position 100 dans la chaine puis de revenir en arrière.

global start

section .data        

; Le tableau suivant représente la position du caractère dans la chaine se trouvant 
; dans le fichier 'message'

	position 	 DW 	5,8,11,14,100,19,34,40,44,100,55,100,57,70,80,83,84,99,100,101
	length		 DB		length - position


section .rodata
    nomFichier      DB      `message`, 0
    output	        DB      `fileOut`, 0
    msgErreur       DB      `Error : file not found or permission denied`
    lgrMsgErreur    DQ      lgrMsgErreur - msgErreur
    retourLigne 	DQ		`\n`
    lgrRetourLigne	DQ		lgrRetourLigne - retourLigne
    msgReussite     DB      `fichier ouvert avec succès \n`
    lgrMsgReussite  DQ      lgrMsgReussite - msgReussite

section .text

start:

	mov     rax, 2          ; open
    mov     rdi, nomFichier ; /adresse/ du 1er caractère du noms
    mov     rsi, 1q | 2000q ; WRONLY + O_APPEND
    syscall
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
    mov     rax, 1          ;write
    mov     rdi, 1          ; stdout, sortie standard
    mov     rsi, msgReussite  ;adresse du 1er caractere
    mov     rdx, [lgrMsgReussite] ;nombre de car
    syscall
    mov     rax, 3         ; close
    mov     rdi, nomFichier ; /adresse/ du 1er caractère du noms
    syscall
    mov     rax, 0
    mov  	r8b, 0
    mov 	ax, length 
pour:
	cmp     r8b, 20
	jz fin_pour
    syscall


fin_pour:

fin:

    mov     rax, 60
    mov     rdi,0
    syscall


	
		
	
    	





