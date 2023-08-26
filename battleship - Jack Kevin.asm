TITLE MASM Template						(battleship.asm)

INCLUDE Irvine32.inc
.data
p1ships db 100 DUP (0)
;p1ships db 20 DUP (0), 20 DUP (1), 20 DUP (2), 20 DUP (3), 20 DUP (4) 
;p1ships db 11 dup (0),1,0,0,0,4 dup (1),0,0,1,9 dup (0), 1,12 dup (0), 5 dup (1), 9 dup (0), 5 dup (0), 1, 9 dup (0), 1, 0, 1, 1,6 dup (0), 1, 9 dup (0), 1, 6 dup (0)
p1view  db 100 DUP (4)
p1hits db 17

p2ships db 100 DUP (0)
;p2ships db 20 DUP (0), 20 DUP (1), 20 DUP (2), 20 DUP (3), 20 DUP (4) 
p2view  db 100 DUP (4)
p2hits db 17
topbar db 10,13,"  /------------------------O----------------------\",13,10,"  |   B A T T L E S H I P  |  B A T T L E S H I P |",13,10,0
;[implied]      "  |   B A T T L E S H I P  |  B A T T L E S H I P |",0
 midbar db      "  |                        |                      |",13,10,0
;	ruler	     012345678901234567890123456789012345678901234567890
;midbar db      "  |   1 2 3 4 5 6 7 8 9 0  |                      |",0
;midbar db      "  | A                      |  ^ O O O O ^ ^ ^ ^ ^ |",0
;midbar db      "  | B   O X O O X          |  ^ ^ ^ ^ ^ ^ ^ ^ X ^ |",0
;midbar db      "  | C     X         O      |  ^ ^ ^ ^ ^ O ^ ^ X ^ |",0
;midbar db      "  | D     X                |  ^ ^ ^ ^ ^ O ^ ^ ^ ^ |",0
;midbar db      "  | E     O                |  ^ ^ ^ ^ ^ O ^ ^ ^ ^ |",0
;midbar db      "  | F               O      |  ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ |",0
;midbar db      "  | G       X              |  ^ ^ O O O X X ^ ^ ^ |",0
;midbar db      "  | H   O                  |  ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ |",0
;midbar db      "  | I         O     O      |  ^ ^ ^ ^ ^ O O O O ^ |",0
;midbar db      "  | J                      |  ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ |",0
 botbar db      "  \------------------------O----------------------/",0

                ;01234567890123456789012345678901234567890123456789012345678901234567890123456789	;
splashmid db    "        |                                                              |        ", 0
splashtop  db	"        +--------------------------------------------------------------+        ", 0
splash0 db      "        |     ____  ___  ______________    ___________ __  __________  |        ";, 0
splash1 db      "        |    / __ )/   |/_  __/_  __/ /   / ____/ ___// / / /  _/ __ \ |        ";, 0
splash2 db      "        |   / __  / /| | / /   / / / /   / __/  \__ \/ /_/ // // /_/ / |        ";, 0
splash3 db      "        |  / /_/ / ___ |/ /   / / / /___/ /___ ___/ / __  // // ____/  |        ";, 0
splash4 db      "        | /_____/_/  |_/_/   /_/ /_____/_____//____/_/ /_/___/_/       |        ";, 0
splash5 db      "        |                                                              |        ";, 0
;splash6 db	    "        +--------------------------------------------------------------+        ";, 13, 10, 0

							;Wait 2 seconds, write below
splash6  db		13, 10, 13, 10																	  ;, 0
splash7  db		"                                                                                ";, 0
splash8  db		"   WELCOME TO BATTLESHIP, AN EXCITING GAME FOR TWO!                             ";, 0
splash9  db		"   YOU ARE COMMANDER OF AN ELITE MILITARY FLEET, ENGAGED IN A TENSE BATTLE ON   ";, 0
splash10  db	"   THE HIGH SEAS. BOTH YOU AND THE ENEMY ARE DOWN TO FIVE SHIPS EACH, RANGING   ";, 0
splash11  db	"   IN SIZE FROM PATROL BOATS TO CARRIERS.  IF YOU CAN DESTROY THEIR FLEET AND   ";, 0
splash12  db	"   MAKE IT OUT ALIVE, YOU CAN END THIS WAR ONCE AND FOR ALL.  GOOD LUCK.        ";, 0
splash13  db	13, 10, 13, 10, 13, 10															  ;, 0
splash14  db	"                    TO LAUNCH YOUR FLEET, TYPE 'n'",13, 10				  ;, 0
splash15  db	"                    FOR ADDITIONAL HELP, TYPE 'h'",13, 10					  ;, 0
splash16  db	"                    TO WITHDRAW FROM BATTLE, TYPE 'e'",13, 10, 13, 10		  ;, 0
splash17  db	"                    THE DECISION IS YOURS, COMMANDER:  "						  , 0

help0 db		"                                                                                ", 0
help1 db		"   WELCOME TO BASIC TRAINING, COMMANDER. HERE YOU WILL LEARN THE RULES OF WAR   ";, 0
help2 db		"   THE RULES ARE SIMPLE, SINK THE ENEMY'S SHIPS WITHOUT GETTING SUNK YOURSELF   ";, 0
help3 db		"   THE DISPLAYS REPRESENT YOUR SHIPS ON THE RIGHT, AND YOUR RADAR ON THE LEFT   ";, 0
help4 db		"   ON THE RADAR, SHIPS YOU HIT ARE REPRESENTED WITH A RED X, AND MISSES ARE O   ";, 0
help5 db		"   YOUR SHIPS ARE GRAY O'S AND HIT SHIPS ARE RED X'S.  EACH TURN, YOU AND THE   ";, 0
help6 db		"   ENEMY FIRE ONE SHOT, AND TRY TO SINK EACH OTHER'S SHIPS. IF YOU GET A MISS   ";, 0
help7 db		"   OR A HIT YOUR RADAR WILL BE UPDATED ACCORDINGLY. DESTROY ALL FIVE SHIPS TO   ";, 0
help8 db		"   DEFEAT THE ENEMY. GOT THAT? GOOD, NOW GO OUT THERE AND WIN THIS WAR!         ";, 0

help9 db		13, 10, 13, 10, 13, 10															  ;, 0
help10 db		"                            PRESS ANY KEY TO CONTINUE"									  , 0

userx		db ?
usery		db ?
p1sunk		db 5 DUP (0)
p2sunk		db 5 DUP (0)
p1carrier	db 10 DUP (?)				; locations are stored as xyxyxyxyxy
p1battleship db 8 DUP (?)				; locations are stored as xyxyxyxy
p1destroyer db 6 DUP (?)				; locations are stored as xyxyxy
p1submarine	db 6 DUP (?)				; locations are stored as xyxyxy
p1patrolboat db 4 DUP (?)				; locations are stored as xyxy
p2carrier	db 10 DUP (?)				; locations are stored as xyxyxyxyxy
p2battleship db 8 DUP (?)				; locations are stored as xyxyxyxy
p2destroyer db 6 DUP (?)				; locations are stored as xyxyxy
p2submarine	db 6 DUP (?)				; locations are stored as xyxyxy
p2patrolboat db 4 DUP (?)				; locations are stored as xyxy
promptx		db "Enter the number of the column you wish to attack.", 0
prompty		db "Enter the letter of the row you wish to attack.", 0
promptInv	db "Invalid location. Please try again.", 0
promptCarX	db "Enter a starting column for your carrier. A carrier is 5 spaces."			,13,10,"   ",0
promptBatX	db "Enter a starting column for your battleship. A battleship is 4 spaces."		,13,10,"   ",0
promptDesX	db "Enter a starting column for your destroyer. A destroyer is 3 spaces."		,13,10,"   ",0
promptSubX	db "Enter a starting column for your submarine. A submarine is 3 spaces."		,13,10,"   ",0
promptPBX	db "Enter a starting column for your patrol boat. A patrol boat is 2 spaces."	,13,10,"   ",0
promptCarY	db "   Enter a starting row for your carrier. A carrier is 5 spaces."			,13,10,"   ",0
promptBatY	db "   Enter a starting row for your battleship. A battleship is 4 spaces."		,13,10,"   ",0
promptDesY	db "   Enter a starting row for your destroyer. A destroyer is 3 spaces."		,13,10,"   ",0
promptSubY	db "   Enter a starting row for your submarine. A submarine is 3 spaces."		,13,10,"   ",0
promptPBY	db "   Enter a starting row for your patrol boat. A patrol boat is 2 spaces."	,13,10,"   ",0
promptDir	db "   Enter a direction to extend your boat. Enter L for left, R for right,"	,13,10,"   U for up, or D for down.", 13,10,"   ",0 

testprompt	db "test", 0

filename db "HITANIM.txt",0
hitanim db "hitanim.txt",0
missanim db "missanim.txt",0
introanim db "introanim.txt",0
introanim2 db "introanim2.txt",0
p1winanim db "p1winanim.txt",0
p2winanim db "p2winanim.txt",0
filehandle dd 0
filedata db (2024*12) dup (?), 0
buffersize dd (2024 * 12)

.code
main PROC								;only contains calls

mov edx, offset introanim
call playanim
mov edx, offset introanim2
call playanim

call drawSplash
call mainmenu

exit
main ENDP 

game proc

	call p1shiplocation					; ask player 1 for ship locations and fill array 
	call p2shiplocation					; ask player 2 for ship locations and fill array 

	mainloop:							; ~~~~~~ MAIN GAME LOOP ~~~~~~
		call p1turn						; Player 1 makes his move
		cmp p2hits, 0					; check to see if the opponent has any ship left
			je p1wins					; if they don't, player 1 wins!

		call p2turn						; Player 2 makes his move
		cmp p1hits, 0					; check to see if the opponent has any ship left
			je p2wins					; if they don't player 2 wins!

		jmp mainloop					; keep looping until broken out of by a win state

	p1wins:								; p2 has no ships left, p1 wins!
		mov edx, offset p1winanim		; play the winning animation
		call playanim
		ret								; return to the main menu

	p2wins:								; p1 has no ships left, p1 wins!
		mov edx, offset p2winanim		; play the winning animation
		call playanim
		ret								; return to the main menu
game endp

p1turn proc
	call drawui							; display player 1 ui
	call p1display
	mov esi, offset p1view
	call userinput						; get user input
	mov edx, offset p2ships
	mov bh, userx
	mov bl, usery
	call getpoint						; get the value in the location of p2 ships
	cmp ah, 1							; check if hit or miss
		je Hit
		jne Miss
Hit:
	sub p1hits, 1						; decrement p1hits
	mov ah, 2							; number for hit
	call setpoint						; update p2 ships
	mov edx, esi
	call setpoint						; update p1 view
	mov edx, offset hitanim
	call playanim						; play hit animation
	ret
Miss:
	mov ah, 3							; number for miss
	mov edx, esi                                   
	call setpoint						; update p1 view
	mov edx, offset missanim
	call playanim						; play miss animation
	ret
p1turn endp
 
p2turn proc
	call drawui							; display player 1 ui
	call p2display
	mov esi, offset p2view
	call userinput						; get user input
	mov edx, offset p1ships
	mov bh, userx
	mov bl, usery
	call getpoint						; get the value in the location of p2 ships
	cmp ah, 1							; check if hit or miss
		je Hit
		jne Miss
Hit:
	sub p2hits, 1						; decrement p1hits
	mov ah, 2							; number for hit
	call setpoint						; update p2 ships
	mov edx, esi
	call setpoint						; update p1 view
	mov edx, offset hitanim
	call playanim						; play hit animation
	ret
Miss:
	mov ah, 3							; number for miss
	mov edx, esi
	call setpoint						; update p1 view
	mov edx, offset missanim
	call playanim						; play miss animation
	ret
p2turn endp

UserInput proc							; asks user to input values to attack, give player view array in edx
	mov dl, 3
	mov dh, 18
	call gotoxy
	mov edx, offset promptx                               
	call writestring					; ask user to enter value for columns 1- 10
	call readdec
	mov userx, al						; move x value into memory
      
	mov dl, 3
	mov dh, 18
	call gotoxy
	mov edx, offset prompty				; ask user to enter character for rows A- J
	call writestring
	call readchar
	mov usery, al						; move y value into memory
	call writechar						; read char doesnt print the character you enter
	call crlf
 
	call UserInputCheck
	ret
UserInput endp
 
UserInputCheck proc						; checks user input to see if it is a valid location and not already played
	cmp userx, 10						; check if x value is between 1 and 10
	jg reset
	cmp userx, 1
	jl reset
	
	cmp usery, 74						; check if y value falls between A and J (Ascii values = 65 - 74)
	jg lccheck							; if not check for lowercase letters
	cmp usery, 65
	jl lccheck
	jge boardchecku
 
lccheck:								; catches lower case letters a - j (Ascii values = 97 - 106)
	cmp usery, 106						; if not, reset input process
	jg reset
	cmp usery, 97
	jl reset
	jge boardcheckl
 
boardchecku:							; converts uppercase character to a number 1 - 10 and sends it to getpoint
	sub usery, 64
	mov bl, usery
	mov bh, userx
	mov edx, esi
	call getpoint
	cmp ah, 4
	       jne reset
	movzx eax, ah
	
	ret
 
boardcheckl:							; converts uppercase character to a number 1 - 10 and sends it to getpoint
	sub usery, 96
	mov bl, usery
	mov bh, userx
	mov edx, esi
	call getpoint
	cmp ah, 4
	       jne reset
	movzx eax, ah
	ret
 
reset:									; tells the user that the input is invalid and to try again
	mov edx, offset promptInv
	call writestring
	call crlf
	call UserInput
	ret
UserInputCheck endp

P1ShipLocation proc						; gets the location of player 1's ships
	call drawUI
	call p1display
	mov dl, 3
	mov dh, 18
	call gotoxy
Carrier:
	mov ebx, offset promptCarY			; get variables of arrays for the input methods
	mov ecx, lengthof p1carrier			; no need to call ecx, esi, and edi again because of uses operator
	mov edx, offset promptCarX	
	mov esi, offset p1carrier
	mov edi, offset p1ships
	call shipxy							; gets a starting location from the user
	call shipdir						; extends that starting point into an array in a user specified direction	
	call shipcheck						; check to make sure this array is valid and none of the locations are already taken
	cmp dl, 1							; if the array is invalid restart the process of ship input for this ship
		je Carrier
	call insertship						; if the array is valid add the locations to the board

	call drawUI
	call p1display
	mov dl, 3
	mov dh, 18
	call gotoxy

Battleship:
	mov ebx, offset promptBatY		
	mov ecx, lengthof p1battleship
	mov edx, offset promptBatX	
	mov esi, offset p1battleship
	mov edi, offset p1ships
	call shipxy
	call shipdir	
	call shipcheck
	cmp dl, 1
		je Battleship
	call insertship

	call drawUI
	call p1display
	mov dl, 3
	mov dh, 18
	call gotoxy

Destroyer:
	mov ebx, offset promptDesY
	mov ecx, lengthof p1destroyer
	mov edx, offset promptDesX	
	mov esi, offset p1destroyer
	mov edi, offset p1ships
	call shipxy
	call shipdir	
	call shipcheck
	cmp dl, 1
		je Destroyer
	call insertship

	call drawUI
	call p1display
	mov dl, 3
	mov dh, 18
	call gotoxy

Submarine:
	mov ebx, offset promptSubY
	mov ecx, lengthof p1submarine
	mov edx, offset promptSubX	
	mov esi, offset p1submarine
	mov edi, offset p1ships
	call shipxy
	call shipdir	
	call shipcheck
	cmp dl, 1
		je Submarine
	call insertship

	call drawUI
	call p1display
	mov dl, 3
	mov dh, 18
	call gotoxy

Patrolboat:
	mov ebx, offset promptPBY		
	mov ecx, lengthof p1patrolboat	
	mov edx, offset promptPBX	
	mov esi, offset p1patrolboat
	mov edi, offset p1ships
	call shipxy						
	call shipdir					
	call shipcheck					
	cmp dl, 1						
		je Patrolboat
	call insertship					

	call drawUI
	call p1display
	ret
P1ShipLocation endp

P2ShipLocation proc						; gets the location of player 2's ships
	call drawUI
	call p2display
	mov dl, 3
	mov dh, 18
	call gotoxy
Carrier:
	mov ebx, offset promptCarY			; get variables of arrays for the input methods
	mov ecx, lengthof p2carrier			; no need to call ecx, esi, and edi again because of uses operator
	mov edx, offset promptCarX	
	mov esi, offset p2carrier
	mov edi, offset p2ships
	call shipxy							; gets a starting location from the user
	call shipdir						; extends that starting point into an array in a user specified direction
	call shipcheck						; check to make sure this array is valid and none of the locations are already taken
	cmp dl, 1							; if the array is invalid restart the process of ship input for this ship
		je Carrier
	call insertship						; if the array is valid add the locations to the board

	call drawUI
	call p2display
	mov dl, 3
	mov dh, 18
	call gotoxy

Battleship:
	mov ebx, offset promptBatY			; repeat steps for each of player 1's ships
	mov ecx, lengthof p2battleship
	mov edx, offset promptBatX	
	mov esi, offset p2battleship
	mov edi, offset p2ships
	call shipxy
	call shipdir	
	call shipcheck
	cmp dl, 1
		je Battleship
	call insertship

	call drawUI
	call p2display
	mov dl, 3
	mov dh, 18
	call gotoxy

Destroyer:
	mov ebx, offset promptDesY
	mov ecx, lengthof p2destroyer
	mov edx, offset promptDesX	
	mov esi, offset p2destroyer
	mov edi, offset p2ships
	call shipxy
	call shipdir	
	call shipcheck
	cmp dl, 1
		je Destroyer
	call insertship

	call drawUI
	call p2display
	mov dl, 3
	mov dh, 18
	call gotoxy

Submarine:
	mov ebx, offset promptSubY
	mov ecx, lengthof p2submarine
	mov edx, offset promptSubX	
	mov esi, offset p2submarine
	mov edi, offset p2ships
	call shipxy
	call shipdir	
	call shipcheck
	cmp dl, 1
		je Submarine
	call insertship

	call drawUI
	call p2display
	mov dl, 3
	mov dh, 18
	call gotoxy

Patrolboat:
	mov ebx, offset promptPBY
	mov ecx, lengthof p2patrolboat
	mov edx, offset promptPBX	
	mov esi, offset p2patrolboat
	mov edi, offset p2ships
	call shipxy
	call shipdir	
	call shipcheck
	cmp dl, 1
		je Patrolboat
	call insertship

	call drawUI
	call p2display

	ret
P2ShipLocation endp

shipxy proc	uses ecx esi edi			; needs ship array in esi, x message in edx, y message in ebx
	call WriteString					; print out x message

	call readdec						; get x value
	mov cl, al							; move x location to unused register
	xchg edx, ebx						; exchange x and y registers
	call WriteString					; print y message

	call readchar						; get y value
	call writechar						; print y value since readchar doesn't
	call crlf
	
	mov ah, cl							; move x value into ah
	cmp al, 97							; figure out if y could be upper or lower case
		jge Lower						; might be a character with a higher value than z but the next compare statements will catch it
	cmp al, 65
		jge Upper
		jl Reset
Lower:
	sub al, 96							; converts ascii value to number
	cmp al, 10							; checks if new y value is a number on the board
		jg Reset
	cmp al, 1
		jl Reset
	cmp ah, 10							; checks if new x value is a number on the board
		jg Reset
	cmp ah, 1
		jl Reset
		jge Addtoarray
Upper:
	sub al, 64							; converts ascii value to number
	cmp al, 10							; checks if new y value is a number on the board
		jg Reset
	cmp al, 1
		jl Reset
	cmp ah, 10							; checks if new x value is a number on the board
		jg Reset
	cmp ah, 1
		jl Reset
		jge Addtoarray
Addtoarray:								; adds the location to array
	mov [esi], ah
	inc esi
	mov [esi], al
	ret
Reset:
	xchg edx, ebx						; puts the x and y messages back in original location
	mov eax, edx						; moves x message to eax 
	mov edx, offset promptInv			; puts invalid location message in edx
	call writestring					; prints invalid location message
	call crlf
	mov edx, eax						; puts x message back in edx
	call shipxy							; runs procedure again
	ret
shipxy endp

shipdir proc uses ecx esi edi			; needs ship array in esi and length of array in ecx
	mov edx, offset promptDir			
	call writestring					; prints prompt to ask for direction

	call readchar						; gets a char from the user
	call writechar						; prints out char because readchar doesn't
	call crlf							; remove later

	cmp al, 76							; catches L
		je Left
	cmp al, 108							; catches l
		je Left
	cmp al, 82							; catches R
		je Right
	cmp al, 114							; catches r
		je Right
	cmp al, 85							; catches U
		je Up
	cmp al, 117							; catches u
		je Up
	cmp al, 68							; catches D
		je Down
	cmp al, 100							; catches d
		je Down
		jne Reset						; if not, reset
Left:									; creates an array with the same y value but decreasing x values
	mov al, [esi]
	inc esi
	dec ecx
	mov ah, [esi]
	inc esi
	dec ecx
L:
	sub al, 1
	mov [esi], al
	inc esi
	dec ecx
	mov [esi], ah
	inc esi
	Loop L
	ret
Right:									; creates an array with the same y value but increasing x values
	mov al, [esi]
	inc esi
	dec ecx
	mov ah, [esi]
	inc esi
	dec ecx
R:
	add al, 1
	mov [esi], al
	inc esi
	dec ecx
	mov [esi], ah
	inc esi
	Loop R
	ret
Up:										; creates an array with the same x value but decreasing y values
	mov al, [esi]
	inc esi
	dec ecx
	mov ah, [esi]
	inc esi
	dec ecx
U:
	mov [esi], al
	inc esi
	dec ecx
	sub ah, 1
	mov [esi], ah
	inc esi
	Loop U
	ret
Down:									; creates an array with the same x value but increasing y values
	mov al, [esi]
	inc esi
	dec ecx
	mov ah, [esi]
	inc esi
	dec ecx
D:
	mov [esi], al
	inc esi
	dec ecx
	add ah, 1
	mov [esi], ah
	inc esi
	Loop D
	ret
Reset:									; runs the shipdir method again
	call shipdir
	ret
shipdir endp

shipcheck proc uses ecx esi edi			; pass in esi as ship array, edi as player field array, ecx as length of ship array
	mov eax, esi
	add eax, ecx
	dec eax								; get the last point in the array
	mov bl, [eax]						; bl is the last y value
	dec eax
	mov bh, [eax]						; bh is the last x value
	
	cmp bl, 10							; check to see if the array goes out of the 10x10 field
		jg Reset
	cmp bh, 10
		jg Reset
	cmp bl, 1
		jl Reset
	cmp bh, 1
		jl Reset
	
	mov edx, edi						; move field array to edx for the getpoint procedure
locationcheck:
	mov bh, [esi]						; get a point in the array
	inc esi
	dec ecx
	mov bl, [esi]
	inc esi	
	call getpoint						; get the value of that point in the field array
	movzx eax, ah
	cmp eax, 0							; if the spot isnt empty reset the input process
		jg Reset
	Loop locationcheck
	mov dl, 0							; control variable for compare statement in p1(2)shipslocation
	ret

Reset:
	mov edx, offset promptInv
	call writestring					; print invalid location statement
	call crlf 
	mov dl, 1							; set control variable to trigger compare statement in p1(2)shipslocation
	ret
shipcheck endp

insertship proc
	mov edx, edi						; move field array to edx for setpoint method
	mov ah, 1							; value for active ship to be inserted at each point in the array 
Insert:
	mov bh, [esi]						; get the x and y values for each point in the array
	inc esi
	dec ecx
	mov bl, [esi]
	inc esi
	call setpoint						; set that location to 1
	Loop Insert
	ret
insertship endp

setpoint proc uses eax bx edx			;put the value in ah into the point edx[bh][bl]
	dec bl								;convert to index value
	dec bh								;convert index value
	push eax							;save the value we need
	movzx eax, bl						;move the row to be multiplied
	mov bl, 10							;
	mul bl								;and multiply by 10
	add bh, al							;add it to the column value
	movzx ebx, bh						;clear higher bits
	pop eax								;restore value to set
	mov [edx + ebx], ah					;move value to proper spot
	ret									;
setpoint endp							;

getpoint proc uses bx edx				;put the value in the point edx[bh][bl] into ah
	dec bl								;convert to index value
	dec bh								;convert index value
	movzx eax, bl						;move the row to be multiplied
	mov bl, 10							;
	mul bl								;and multiply by 10
	add bh, al							;add it to the column value
	movzx ebx, bh						;clear higher bits
	mov ah, byte ptr [edx + ebx]		;move value to ah
	ret									;
getpoint endp							;

writetest proc uses edx
	mov edx, offset testprompt
	call writestring
	call crlf
	ret
writetest endp

drawSplash proc
	mov eax, lightgreen + (black * 16)
	call settextcolor
	call clrscr

	mov dx, 0
	call gotoxy
	mov edx, offset splashtop
	call writestring
	mov edx, offset splashmid
	mov ecx, 6
	splashloop:
		call writestring
	loop splashloop
	mov edx, offset splashtop
	call writestring
	call crlf

	mov dl, 0
	mov dh, 1
	call gotoxy
	mov edx, offset splash0
	splashwrite:
		;cmp eax, 32
		;je nodelay

		mov eax, 5
		call delay

		nodelay:
		mov eax, [edx]
		call writechar
		inc edx
		cmp ah, 0
		jg splashwrite

	ret
drawSplash endp

mainmenu proc
	newinput:
	mov dl, 54
	mov dh, 22
	call gotoxy

	call readchar
	cmp al, 96
	;jl menuinput
	;sub al, 32

	menuinput:
	cmp al, 104 ;'h'
	je callhelp

	cmp al, 110 ;'n'
	je callnew

	cmp al, 101 ;'e'
	je callexit

	jmp newinput

	callhelp:
	call helpmenu
	call drawsplash
	call mainmenu
	jmp leavemenu

	callnew:
	call game
	jmp leavemenu

	callexit:
	exit

	leavemenu:
	ret
mainmenu endp

helpmenu proc
	mov dl, 0
	mov dh, 10
	call gotoxy
	
	mov eax, lightgreen + (black*16)
	call settextcolor

	mov ecx, 13
	mov edx, offset help0
	clrloop:
		call writestring
	loop clrloop

	mov dl, 0
	mov dh, 10
	call gotoxy
	mov edx, offset help1
	splashwrite:
			mov eax, 5
			call delay
	
			mov eax, [edx]
			call writechar
			inc edx
			cmp ah, 0
			jg splashwrite

	call readchar
	ret
helpmenu endp


drawUI proc uses edx ecx				;draw UI

	mov eax, lightgray + (black*16)
	call settextcolor

	call clrscr							;clear screen (menus etc)
	mov edx, 0							
	call gotoXY							;get into position
	mov edx, offset topbar				
	call writestring					;write top line
	mov ecx, 13							
	mov edx, offset midbar				
	ui:									
		call writestring				;write 13 middle sections
	loop ui								
	mov edx, offset botbar				
	call writestring					;write bottom bar

	mov eax, 1							;starting at 1
	mov ecx, 10							;10 times
	mov dl, 6							;at 6,4
	mov dh, 4							
	nums:								
		call gotoxy						;move to point
		call writedec					;write column header
		add dl, 2						;move over two
		inc eax							;and next number
	loop nums							

	mov eax, 'A'						;starting at A
	mov ecx, 10							;10 times
	mov dl, 4							;at 4,5
	mov dh, 5							
	lets:								
		call gotoxy						;move to point
		call writechar					;write row header
		inc dh							;down 1 row
		inc eax							;next letter
	loop lets							
ret										
drawUI endp								
										
p1display proc uses esi dx				;displays player 1's information
	mov esi, offset p1view				;move p1 viewscreen into printing location
	mov  dl, 6							;get to correct position
	mov  dh, 5							;
	call displayarray					;display array

	mov esi, offset p1ships				;move p1 ships into printing location
	mov  dl, 29							;get to correct position
	mov  dh, 5							;
	call displayarray					;display array
										
	ret									
p1display endp							
										
p2display proc uses esi dx				;displays player 2's information
	mov esi, offset p2view				;move p2 viewscreen into printing location
	mov  dl, 6							;get to correct position
	mov  dh, 5							;
	call displayarray					;display array

	mov esi, offset p2ships				;move p2 ships into printing location
	mov  dl, 29							;get to correct position
	mov  dh, 5							;
	call displayarray					;display array

	ret									
p2display endp							

displayarray proc						;output array in esi, starting at (dl, dh)
	mov ecx, 10							;for 10 rows
	rowsloop:							;
		push dx							;save dx to stack
		call gotoXY						;go to dl,dh (already defined beforehand)
		push ecx						;save (outer loop) ecx to stack

		mov ecx, 10						;for 10 columns
		colsloop:						;
		call gotoXY						;get to correct location (already defined beforehand)
			mov al, byte ptr [esi]		;get value of array

			cmp al, 2					;compare to 2 (see design doc)
			jz hitship					;value is hit ship

			cmp al, 2					;compare to 2 (see design doc)
			jl self						;if less than 2, value is on ship array
			jmp view					;if greater than 2, value is on view array

			hitship:					;value is a hit ship (can be both ship or viewport)
				call drawhitship		;draw hit at location
				jmp next				;jump to get ready for next value

			self:						;values <2 must be on player's ship array
				cmp al, 1				;compare to 1
				jl ocean				;if less (0) it is empty ocean point

				ship:					;otherwise it must be the player's ship
					call drawship		;draw ship at location
					jmp next			;jump to get ready for next value
				ocean:					;value <1 is empty ocean
					call drawocean		;draw ocean at location
					jmp next			;jump to get ready for next value

			view:						;values >2 must be on player's viewport array
				cmp al, 3				;compare to 3
				jg unknown				;if greater (4) it is unknown

				miss:					;otherwise it must be a missed shot
					call drawmiss		;draw miss at location
					jmp next			;jump to get ready for next value
				unknown:				;value >3 is unknown
					call drawunknown	;draw unknown at location
					jmp next			;jump to get ready for next value

			next:						;landing after drawcall
			inc esi						;move to next value in array
			add dl, 2					;move over two slots 
		loop colsloop					;iterate for whole row
		pop ecx							;restore (outer loop) ecx from stack
		pop dx							;restore dx from stack (back to start of row)
		inc dh							;move to next row
	loop rowsloop						;iterate for all rows

	mov eax, lightgray + (black*16)		;set color to default
	call settextcolor					;reset to normal colors
	ret									
displayarray endp						

drawocean proc							;draws ocean at dl,dh (already set)
	mov eax, white + (blue*16)			;
	call settextcolor					;
	mov eax, '^'						;
	call writechar						;
	mov eax, ' '						;
	call writechar						;
	ret									
drawocean endp							

drawship proc							;draws ship at dl,dh (already set)
	mov eax, lightgray + (gray*16)		;
	call settextcolor					;
	mov eax, 'O'						;
	call writechar						;
	mov eax, ' '						;
	call writechar						;
	ret									
drawship endp							

drawhitship proc						;draws hit ship at dl,dh (already set)
	mov eax, black + (red*16)			;
	call settextcolor					;
	mov eax, 'X'						;
	call writechar						;
	mov eax, ' '						;
	call writechar						;
	ret									
drawhitship endp						

drawmiss proc							;draws miss at dl,dh (already set)
	mov eax, white + (black*16)			;
	call settextcolor					;
	mov eax, 'O'						;
	call writechar						;
	mov eax, ' '						;
	call writechar						;
	ret									
drawmiss endp							

drawunknown proc						;draws unknown at dl,dh (already set)
	mov eax, white + (black*16)			;
	call settextcolor					;
	mov eax, ' '						;
	call writechar						;
	call writechar						;
	ret									
drawunknown endp	

playanim proc uses eax ecx edx
	call openinputfile

	mov dx, 0
	call gotoxy

	mov filehandle, eax
	mov edx, offset filedata
	mov ecx, buffersize
	call readfromfile
		mov edx, offset filedata
		mov ecx, 12
	newframe:
		push ecx
		mov ecx, 2023
		splashwrite:
			mov al, byte ptr [edx]
			inc edx
			cmp al, 'e'
				je skiprest

			cmp al, 's'
				je skiplines

			call setcolor
			call writechar
		loop splashwrite

		jmp skiprest

		skiplines:

		push edx

		mov bx, 80
		movzx ax, byte ptr [edx]
		sub ax, 48
		mul bx
		push ax

		dec ecx
		dec ecx

		add eax, 2023
		sub eax, ecx

		div bx
		
		;mov dh, dl
		mov dh, al
		
		call gotoxy

		;sub cl, dh
		sub cl, al


		pop ax
		sub cx, ax

		pop edx

		movzx eax, byte ptr [edx]
		sub al, 48
		;sub ecx, eax

		inc edx
		;add edx, eax
		;dec edx
		;dec edx
		


		loop splashwrite
	
		
		skiprest:
		mov eax, 50;100
		call delay

			push edx
			mov dx, 0
			call gotoxy
			pop edx

		inc edx
		pop ecx

	loop newframe
	sub edx, 2
	cmp byte ptr [edx], 'c'
		je nodelay

		;mov eax, 13
		;call writechar

	mov eax, 2000
	call delay
	nodelay:								;for multipart animations

	mov eax, lightgray + (black * 16)
	call settextcolor
	ret
playanim endp

setcolor proc uses eax
	push eax
	cmp al, 'Q'
	je sun
	cmp al, '~'
	je water
	cmp al, '3'
	je sky
	cmp al, 'O'
	je ship
	cmp al, '#'
	je fire
	cmp al, '@'
	je splash
	cmp al, '?'
	je subspecial
	cmp al, '/'
	je lettering
	cmp al, '_'
	je lettering
	cmp al, '|'
	je lettering
	cmp al, '\'
	je lettering
	cmp al, '-'
	je lettering
	cmp al, '+'
	je lettering
	cmp al, 'B'
	je blackened
	cmp al, 'H'
	je shipbottom
	;cmp al, 'n'
	;je letterfill
	cmp al, ' '
	jmp none
	
	sun:
	mov eax, yellow + (yellow * 16)
	jmp set

	water:
	mov eax, blue + (blue * 16)
	jmp set

	sky:
	mov eax, cyan + (cyan * 16)
	jmp set

	ship:
	mov eax, gray + (gray * 16)
	jmp set

	fire:
	mov eax, yellow + (red * 16)
	jmp set

	splash:
	mov eax, lightgray + (white * 16)
	jmp set

	lettering:
	mov eax, black + (cyan * 16)
	jmp set

	letterfill:
	mov eax, lightgray + (cyan * 16)
	jmp set

	subspecial:
	mov eax, gray + (blue * 16)
	jmp set

	blackened:
	mov eax, black + (black * 16)
	jmp set

	shipbottom:
	mov eax, red + (red * 16)
	jmp set

	none:
	mov eax, lightgray + (cyan * 16)
	jmp set

	set:
	call settextcolor
	pop eax
	ret

setcolor endp
END main