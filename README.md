
# Calcolatrice in Assembly (emu8086)

## Descrizione
Questo progetto implementa una **calcolatrice in Assembly** utilizzando l'emu8086. La calcolatrice è in grado di eseguire operazioni matematiche e bitwise su numeri interi non firmati (unsigned) a 16 bit.

## Operazioni Supportate
La calcolatrice può eseguire le seguenti operazioni:

1. **Somma**
2. **Sottrazione**
3. **Moltiplicazione**
4. **Divisione**
5. **Potenza**
6. **Fattoriale**
7. **AND bitwise**
8. **OR bitwise**
9. **Radice quadrata**

## Dettagli Tecnici
- **Numeri supportati:** interi non firmati (unsigned) a 16 bit (0 - 65535).
- **Input:** Il programma utilizza il layout di tastiera americana (US).
  - Se stai utilizzando un layout diverso, consulta una tabella della tastiera americana o modifica il blocco di codice per la selezione delle operazioni.

## Requisiti
- **emu8086**: un emulatore 8086 necessario per eseguire il codice assembly.
- **Tastiera con layout americano** (o modifiche nel codice per adattare il layout).

## Istruzioni per l'Uso
1. **Modifica del Layout della Tastiera:**
   - Assicurati di impostare il layout della tastiera su "Americano (US)" per una corretta selezione delle operazioni.
   - In alternativa, puoi modificare il blocco di codice "SCELTA OPERAZIONE" nel file `ASMCalculator.asm` per adattarlo al tuo layout.

2. **Compilazione ed Esecuzione:**
   - Apri il file `ASMCalculator.asm` nell'emu8086.
   - Compila il codice sorgente.
   - Esegui il programma direttamente nell'emu8086.

3. **Selezione delle Operazioni:**
   - Segui le istruzioni a schermo per scegliere l'operazione desiderata e inserire i numeri di input.

## Note Importanti
- **Precisione:**
  - La divisione utilizza numeri interi (non sono supportati i numeri decimali).
  - La radice quadrata restituisce solo la parte intera.

- **Overflow:**
  - Il programma non gestisce automaticamente casi di overflow. Inserire numeri troppo grandi può causare risultati errati.

## Modifiche Personalizzate
Se desideri cambiare il comportamento del programma, puoi:
- Modificare le assegnazioni di input nel blocco `SCELTA OPERAZIONE` per adattarlo al tuo layout di tastiera.
- Aggiungere nuove operazioni seguendo lo stile del codice esistente

## Licenza
Questo progetto è distribuito sotto la licenza MIT. Consulta il file `LICENSE` (se incluso) per maggiori dettagli.
