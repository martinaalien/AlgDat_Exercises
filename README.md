# AlgDat_Exercises

Dette repoet inneholder øvinger i faget Algoritmer og Datastrukturer (TDT4120)

## **Øving 1:**

Du skal oversette pseudokoden for Insertion-Sort i kapittel 2 (Getting started) til Julia. Funksjonen skal hete `insertionsort!` og skal ta ett argument, nemlig listen som skal bli sortert. (Det er en konvensjon at funksjoner som endrer på argumentene, har ! i navnet.) Funksjonen trenger ikke å returnere noe.

## **Øving 2:**

### Question 1: Traversere enkelt lenket liste 

Du skal lære å traversere (se på alle elementene) i en lenket liste. Det viktige i denne øvingen er å forstå hvordan elementer kan være lenket sammen ved hjelp av referanser. Dette er veldig vanlig i objektorientert programmering. Trikset når du lager en lenket liste, er å koble sammen flere objekter av samme klasse, slik at hvert objekt har en referanse (lenke) til ett annet objekt (det 'neste' objektet'). Hvis du så et eller annet sted tar vare på en referanse til det første objektet i lenkingen. har du et utgangspunkt for å traverse hele listen av objekter.

Du skal lage en funksjon som tar imot en lenket liste og en indeks. Denne funksjonen skal så traversere lista og returnerer tallet som er i plassen til indeks argumentet. Funksjonen skal hete `findindexinlist`, og den skal kunne ta to argumenter Det første argumentet er hodet (den første noden) i en lenka liste av typen Node. Node har to felter: `value`, som er tallet som objektet lagrer, og `next`, som er det neste Node-objektet i listen. Det siste `Node`-objektet i listen vil ha `node.next`-verdien lik `nothing` (samme som `null` i Java eller `None` i Python).

I julia kan du hente feltene ut fra objektet med å bruke `node.value` og `node.next` gitt at objektet heter `node`.

Det andre argumentet er et heltall som forteller hvilket element i listen verdien skal komme fra.

Hvis indeksen er større enn lengden til den lenka listen skal du returnere `-1`.

TL;DR `findindexinlist` skal returnere verdien i den linka listen med posisjon `indeks`, og om indeks er større enn lengden til den linka listen skal du returnere `-1`.

Om du kjører koden selv i Juno / Visual studio Code KAN man få problemer med at strukturen Node blir definert flere ganger. En måte å ikke få denne feilen er å kjøre julia filen i terminalen/kommandolinjen, f.eks. `julia testfil.jl` eller starte Julia på nytt i Juno/VScode når du skal kjøre hele koden på nytt.

### Question 2: Stack 

I Julia kan vi bruke en liste (array) som en stack. I neste oppgave er det mulig (men ikke nødvendig) å bruke det i implementasjonen til funksjonen. Ellers er det vel kjekt å vite hvordan man legger til enkelte elementer til en liste i Jula.

I denne oppgaven skal det implementeres funksjonen `reverseandlimit` som tar inn to argumenter. En vanlig liste med heltall og en verdi med navn `maxnumber`. Funksjonen skal gjøre to ting. Først skal den reversere listen den får inn, og så skal den gjøre at ikke noe tall er høyere enn `maxnumber`, og hvis de er det, skal de byttes ut med `maxnumber`.

Et eksempel på dette er at om du kaller `reverseandlimit([10,5,16,0], 8)` skal det returnere `[0,8,5,8]`. Her er lista først reversert, så har tallene 10 og 16 blitt byttet ut med 8.

### Question 3: Traversere dobbel lenket liste 

I denne oppgaven blir det brukt en dobbelt-lenket liste. Her skal du implementere funksjonen `maxofdoublelinkedlist` som tar inn en dobbelt-lenket liste som argument. Den skal så finne det største elementet i denne lista. Noden du får som et argument er ikke nødvendigvis hodet (det første elementet) til lista.

Objektet som blir brukt for å lage den dobbelt-lenket lista ligner på den i oppgave 1, traversere enkelt lenket liste, bare at den har et nytt navn og et `prev` felt. Dette feltet vil gi den forrige noden i lista, og hvis du er i det første elementet, vil `node.prev` returnere `nothing`.

For å kjøre og teste koden lokalt trenger du objektet.

En funksjon for å lage egene lister kan du finne på denne linken: https://paste.ubuntu.com/p/fnyqznx9nh/

TL;DR finn maks i en dobbelt-lenket liste, der du kan få et tilfeldig element i lista som argument.
