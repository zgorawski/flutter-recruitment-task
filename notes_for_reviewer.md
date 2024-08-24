Zad 1:

Założyłem, że biznesowa logika prezentacji powinna zostać utrzymana - tzn. tagi mają losowe kolory.
Mógłbym zachować stabilny kolor taga, przy uzyciu zastanej logiki: `possibleColors[Random().nextInt(possibleColors.length)];` np wprowadzajac cache `Map<Tag, Color>`, ale uznałem, że zastąpienie jej modulo z hasha zachowa wartość biznesową, bez wprowadzania dodatkowych bytów do systemu. Rozwiazanie to nie zapewnia stabilnego koloru pomiędzy uruchomieniami aplikacji - jeżeli takie byłoby wymaganie - chętnie omówię możliwości podczas rozmowy.

Klasa Tag zawiera w sobie informacje o kolorze - jeżeli miałbym go użyć, zamiast losowego, najpewniej utworzyłbym extension do klasy Color, np podobny do tego posta ze SO:

https://stackoverflow.com/a/53905427/454925

