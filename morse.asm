; Alfabet Morse'a by FiNS
; 29.o1.2oo4

.486
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\gdi32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\gdi32.lib

assume   fs:flat

.const
DIALOG_ID       =10
ABOUT_DLG_ID    =20
ICON_ID         =30
OK_ID           =101
EDIT_ID         =100
ABOUT_ID        =102
EXIT_ID         =103
EDIT_ABOUT      =200
EXIT_ABOUT_ID   =201

.data?

hInstance       dd  ?
hInst           dd  ?
hFile           dd  ?
nlength         dd  ?
dlugoscpliku    dd  ?
bufor           db  1024 dup (?)
bufor2          db  2000 dup (?)

.data
filename    db  "audio.au",0
naglowek    db  02Eh,073h,06Eh,064h,0,0,0,01Ch,0FFh,0FFh,0FFh,0FFh,0,0,0,1,0,0,01Fh,040h,0,0,0,1,0,0,0,0
dane        db  0FFh,013h,9,9,013h,0FFh,093h,089h,089h,093h
odstep      db  10 dup (0FFh)
abouttxt    db  13,10,"Alfabet Morse'a",13,10,13,10,"created by FiNS",13,10,13,10,"29.o1.2oo4",0

.code
start:
    push    0
    call    GetModuleHandleA
    mov     hInstance, eax

    push    0
    push    offset DlgProc
    push    0
    push    DIALOG_ID
    push    hInstance
    call    DialogBoxParamA

    push    eax
    call    ExitProcess

DlgProc     proc uses esi edi ebp ebx, hDlg:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD

    cmp     uMsg, WM_INITDIALOG
    jz      initdlg
    cmp     uMsg, WM_COMMAND
    jz      wmcommand
    cmp     uMsg, WM_CLOSE
    jz      close
    cmp     uMsg, WM_MOUSEMOVE
    je      move

powrot:
    xor     eax, eax
    ret

initdlg:
    push    ICON_ID
    push    hInstance
    call    LoadIconA

    push    eax
    push    1
    push    WM_SETICON
    push    hDlg
    call    SendMessageA

    push    EDIT_ID
    push    hDlg
    call    GetDlgItem

    push    0
    push    1024
    push    EM_SETLIMITTEXT
    push    eax
    call    SendMessage
    jmp     powrot

wmcommand:
    cmp     wParam, OK_ID
    jz      go
    cmp     wParam, ABOUT_ID
    jz      about
    cmp     wParam, EXIT_ID
    jz      close
    jmp     powrot

close:
    push    0
    push    hDlg
    call    EndDialog
    jmp     powrot

move:
    cmp     wParam, 1
    je      moveform
    jmp     powrot
moveform:
    call    ReleaseCapture
    push    0
    push    0F012h
    push    WM_SYSCOMMAND
    push    hDlg
    call    SendMessageA
    jmp     powrot

about:
    push    0
    push    offset AboutProc
    push    hDlg
    push    ABOUT_DLG_ID
    push    hInst
    call    DialogBoxParamA
    jmp     powrot

go:
    push    1024
    push    offset bufor
    push    EDIT_ID
    push    hDlg
    call    GetDlgItemTextA
    test    eax, eax
    jz      koniec

    mov     eax, offset bufor
    mov     ebx, offset bufor2
    dec     eax

nextletter:
    inc     eax
    cmp     byte ptr [eax], 'A'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'B'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'C'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'D'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'E'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'F'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'G'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'H'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'I'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'J'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'K'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'L'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'M'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'N'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'O'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'P'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'Q'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'R'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'S'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'T'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'U'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'V'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'W'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'X'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'Y'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 'Z'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], ' '
    jne     @F
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
@@:
    cmp     byte ptr [eax], '1'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], '2'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], '3'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], '4'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], '5'
    jne     @F
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], '6'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], '7'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], '8'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], '9'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 1
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], '0'
    jne     @F
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 3
    inc     ebx
    mov     byte ptr [ebx], 2
    inc     ebx
    mov     byte ptr [ebx], 4
    inc     ebx
@@:
    cmp     byte ptr [eax], 0
    jne     nextletter
    mov     byte ptr [ebx], 0

    push    0
    push    FILE_ATTRIBUTE_ARCHIVE
    push    CREATE_ALWAYS
    push    0
    push    FILE_SHARE_READ
    push    GENERIC_READ + GENERIC_WRITE
    push    offset filename
    call    CreateFileA
    mov     hFile, eax

    push    0
    push    offset nlength
    push    28
    push    offset naglowek
    push    hFile
    call    WriteFile

    mov     eax, offset bufor2
cozapisac:
    cmp     byte ptr [eax], 1
    je      zapisz_k
    cmp     byte ptr [eax], 2
    je      zapisz_d
    cmp     byte ptr [eax], 3
    je      zapisz_ok
    cmp     byte ptr [eax], 4
    je      zapisz_od
    jmp     koniec

zapisz_k:
    push    eax
    mov     ecx, 50
zapisk:
    push    ecx
    push    0
    push    offset nlength
    push    10
    push    offset dane
    push    hFile
    call    WriteFile
    pop     ecx
    loop    zapisk
    pop     eax
    inc     eax
    jmp     cozapisac

zapisz_d:
    push    eax
    mov     ecx, 150
zapisd:
    push    ecx
    push    0
    push    offset nlength
    push    10
    push    offset dane
    push    hFile
    call    WriteFile
    pop     ecx
    loop    zapisd
    pop     eax
    inc     eax
    jmp     cozapisac

zapisz_ok:
    push    eax
    mov     ecx, 50
zapisok:
    push    ecx
    push    0
    push    offset nlength
    push    10
    push    offset odstep
    push    hFile
    call    WriteFile
    pop     ecx
    loop    zapisok
    pop     eax
    inc     eax
    jmp     cozapisac

zapisz_od:
    push    eax
    mov     ecx, 200
zapisod:
    push    ecx
    push    0
    push    offset nlength
    push    10
    push    offset odstep
    push    hFile
    call    WriteFile
    pop     ecx
    loop    zapisod
    pop     eax
    inc     eax
    jmp     cozapisac

koniec:
    push    hFile
    call    CloseHandle
    jmp     powrot

DlgProc        endp

AboutProc   proc STDCALL uses esi edi ebp ebx hDlg:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD

    cmp     uMsg, WM_INITDIALOG
    jz      initdlg
    cmp     uMsg, WM_CLOSE
    jz      close
    cmp     uMsg, WM_COMMAND
    jz      wmcommand
    cmp     uMsg, WM_MOUSEMOVE
    je      move

aboutpowrot:
    xor     eax, eax
    ret

initdlg:
    push    ICON_ID
    push    hInstance
    call    LoadIconA

    push    eax
    push    1
    push    WM_SETICON
    push    hDlg
    call    SendMessageA

    push    offset abouttxt
    push    EDIT_ABOUT
    push    hDlg
    call    SetDlgItemTextA
    jmp     aboutpowrot

move:
    cmp     wParam, 1
    je      moveform
    jmp     aboutpowrot
moveform:
    call    ReleaseCapture
    push    0
    push    0F012h
    push    WM_SYSCOMMAND
    push    hDlg
    call    SendMessageA
    jmp     aboutpowrot

close:
    push    0
    push    hDlg
    call    EndDialog
    jmp     aboutpowrot

wmcommand:
    cmp     wParam, EXIT_ABOUT_ID
    jz      close
    cmp     wParam, EXIT_ID
    jz      close
    jmp     aboutpowrot

AboutProc   endp

end start
