BITS 16              ; Define que estamos trabalhando com 16 bits
ORG 0x7c00           ; Define o endereço de início do código do bootloader

start:
    mov ax, 0x07c0   ; Carrega o endereço da memória para o registrador AX
    mov ds, ax       ; Define o registrador DS para o mesmo endereço de memória
    mov si, hello    ; Carrega o endereço do texto na memória para o registrador SI
    call print       ; Chama a função de impressão
    cli              ; Desabilita as interrupções
    hlt              ; Para a execução do processador

print:
    mov ah, 0x0e     ; Configura a função para imprimir texto na tela
    mov bh, 0x00     ; Define a página de vídeo para 0
.loop:
    lodsb            ; Carrega o próximo byte do texto na memória
    or al, al        ; Verifica se chegou ao final do texto
    jz .done         ; Pula para o fim se o final do texto for alcançado
    int 0x10         ; Imprime o caractere na tela
    jmp .loop        ; Volta para o início do loop
.done:
    ret              ; Retorna do procedimento

hello:
    db 'Hello, World!', 0x0d, 0x0a, 0x00   ; Define o texto a ser impresso na tela
