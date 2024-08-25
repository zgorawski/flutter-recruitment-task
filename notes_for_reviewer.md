# notes_for_reviewer

Poniżej komentarze do zadań i dyskusja wybranych rozwiązań.

PS. Mam edytor ustawiony na 120 znaków w linii - to może wpłynąć na formatowanie.

## Zad 1:

Założyłem, że biznesowa logika prezentacji powinna zostać utrzymana - tzn. tagi mają losowe kolory (pomimo, że w klasie `Tag` jest informacja o kolorze).
Mógłbym zachować stabilny kolor taga, przy użyciu zastanej logiki: `possibleColors[Random().nextInt(possibleColors.length)];` np wprowadzajac cache `Map<Tag, Color>`, ale uznałem, że zastąpienie jej modulo z hasha zachowa wartość biznesową, bez wprowadzania dodatkowych bytów do systemu. Rozwiazanie to nie zapewnia stabilnego koloru jeżeli dane zostaną pobrane ponownie  - jeżeli takie byłoby wymaganie - chętnie omówię możliwości podczas rozmowy.

Leżeli miałbym go użyć koloru z klasy `Tag`, zamiast losowego, najpewniej utworzyłbym extension do klasy Color, np podobny do tego posta ze SO:
https://stackoverflow.com/a/53905427/454925


## Zad 2:

W swoim rozwiązaniu wyświetlam dane już po załadowaniu pierwszej strony, nawet jeżeli rządany produkt nie został jeszcze znaleziony i potrzebne jest pobranie kolejnych stron. Uznałem, że przy 3 stronach i typowym opóźnieniu pobierania tego typu danych jest to właściwy UX. Gdyby, w rzeczywistym systemie, potencjalnych podstron do przeszukania byłoby znacząco więcej, mogło by to doprowadzić do sytuacji, gdzie użytkownik rozpoczyna interakcje z aplikacją i po pewnym czasie jest zaskakiwany wymuszonym scrollem do znalezionego produktu. W takim przypadku rozważyłbym opóźnienie pokazywania wyników (jeżeli zmiany na warstwie API nie są możliwe)

## Zad 3:

- niektóre filtry mogły by mieć sens w rzeczywistej aplikacji, ale nie będą miały efektu na mockowych danych (np. pokazywanie tylko dostepnych produktów - w danych wszystkie są dostępne)
- zaimplementowałem jedynie dwa filtry z powodu ograniczeń czasowych, ale zaproponowane rozwiazanie jest skalowalne i dodanie kolejnego filtru nie zmieni logiki filtrowania w `HomeCubit`

## Zad 4:

Przygotowane testy nie wyczerpują w pełni tematu otestowanie `HomeCubit`a, ale podobnie jak w przypadku filtrów, kod byłby raczej wtórny dla kolejnych przypadków.