# notes_for_reviewer

Poniżej komentarze do zadań i dyskusja wybranego rozwiązania

## Zad 1:

Założyłem, że biznesowa logika prezentacji powinna zostać utrzymana - tzn. tagi mają losowe kolory (pomimo, że w klasie `Tag` jest informacja o kolorze).
Mógłbym zachować stabilny kolor taga, przy użyciu zastanej logiki: `possibleColors[Random().nextInt(possibleColors.length)];` np wprowadzajac cache `Map<Tag, Color>`, ale uznałem, że zastąpienie jej modulo z hasha zachowa wartość biznesową, bez wprowadzania dodatkowych bytów do systemu. Rozwiazanie to nie zapewnia stabilnego koloru jeżeli użutkownik opuści ekran home i wejdzie na niego ponownie  - jeżeli takie byłoby wymaganie - chętnie omówię możliwości podczas rozmowy.

Leżeli miałbym go użyć koloru z klasy `Tag`, zamiast losowego, najpewniej utworzyłbym extension do klasy Color, np podobny do tego posta ze SO:

https://stackoverflow.com/a/53905427/454925



915