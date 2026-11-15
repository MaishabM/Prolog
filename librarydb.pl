:- dynamic book/3.

start :-
    nl,
    write('LIBRARY BOOK MANAGEMENT SYSTEM'), nl,
    menu.


% Main menu
menu :-
    nl,
    write('1. Add New Book'), nl,
    write('2. Update Book Status'), nl,
    write('3. Remove Book'), nl,
    write('4. Show All Books'), nl,
    write('5. Search Book'), nl,
    write('6. Exit'), nl,
    write('Enter your choice (1-6): '),
    read(Choice),
    handle_choice(Choice).


% Option 1: Add a new book
handle_choice(1) :-
    nl,
    write('Enter book title: '),
    read(Title),
    (
        book(Title, _, _)
        ->
        write('Book already exists! Duplicate titles are not allowed.'), nl
        ;
        write('Enter author name: '),
        read(Author),
        write('Enter book status (available/borrowed): '),
        read(Status),
        (
            valid_status(Status)
            ->
            assertz(book(Title, Author, Status)),
            write('Book added successfully.'), nl
            ;
            write('Invalid status! Enter available or borrowed.'), nl
        )
    ),
    menu.


% Option 2: Update book status
handle_choice(2) :-
    nl,
    write('Enter book title: '),
    read(Title),
    (
        book(Title, Author, OldStatus)
        ->
        write('Enter new status (available/borrowed): '),
        read(NewStatus),
        (
            valid_status(NewStatus)
            ->
            retract(book(Title, Author, OldStatus)),
            assertz(book(Title, Author, NewStatus)),
            write('Book status updated successfully.'), nl
            ;
            write('Invalid status! Enter available or borrowed.'), nl
        )
        ;
        write('Book not found!'), nl
    ),
    menu.


% Option 3: Remove a book
handle_choice(3) :-
    nl,
    write('Enter book title: '),
    read(Title),
    (
        retract(book(Title, Author, Status))
        ->
        write('Book removed successfully.'), nl
        ;
        write('Book not found!'), nl
    ),
    menu.


% Option 4: Display all books
handle_choice(4) :-
    nl,
    (
        book(_, _, _)
        ->
        write('Library Book Records:'), nl,
        forall(
            book(Title, Author, Status),
            format('Title: ~w Author: ~w Status: ~w~n',[Title, Author, Status])
        )
        ;
        write('No books available in the library.'), nl
    ),
    menu.


% Option 5: Search for a book by title
handle_choice(5) :-
    nl,
    write('Enter book title: '),
    read(Title),
    (
        book(Title, Author, Status)
        ->
        write('Book Found!'), nl,
        format('Title: ~w~n', [Title]),
        format('Author: ~w~n', [Author]),
        format('Status: ~w~n', [Status])
        ;
        write('Book not found!'), nl
    ),
    menu.


% Option 6: Exit
handle_choice(6) :-
    nl,
    write('Thank you for using the Library Management System!'), nl.


% Handle invalid menu choices
handle_choice(_) :-
    write('Invalid option! Please enter a number between 1 and 6.'), nl,
    menu.


% Validate book availability status
valid_status(available).
valid_status(borrowed).