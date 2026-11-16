
:- dynamic student/3.

start :-
    nl,
    write('Welcome to student management system'),
    menu.

menu :-
    nl,
    write('1. Add a student'), nl,
    write('2. Update attendance status'), nl,
    write('3. Remove student'), nl,
    write('4. Search by student'), nl,
    write('5. Display all students'), nl,
    write('6. Quit'), nl,
    write('Input choice: '),
    read(Choice),
    handle_choice(Choice).

handle_choice(1) :-
    nl,
    write('Enter student ID: '),
    read(Id),
    (
        student(Id, _, _)
        ->
        write('Student ID already exists!'), nl
        ;
        write('Enter student name: '),
        read(Name),
        write('Enter attendance status (present/absent): '),
        read(Status),
        (
            valid_status(Status)
            ->
            assertz(student(Id, Name, Status)),
            write('Student successfully added...'), nl
            ;
            write('Invalid attendance status'), nl
        )
    ),
    menu.

handle_choice(2) :-
    nl,
    write('Enter student id to update status: '),
    read(Id),
    (
        student(Id, Name, Oldstat)
        ->
        write('Enter attendance status: '),
        read(Newstat),
        (
            valid_status(Newstat)
            ->
            retract(student(Id, Name, Oldstat)),
            assertz(student(Id, Name, Newstat)),
            write('Status updated successfully'), nl
            ;
            write('Invalid status'), nl
        )
        ;
        write('Student does not exist'), nl
    ),
    menu.

valid_status(absent).
valid_status(present).

handle_choice(3) :-
    nl,
    write('Enter student ID to remove: '),
    read(Id),
    (
        retract(student(Id, _, _))
        ->
        write('Student removed successfully'), nl
        ;
        write('Student does not exist'), nl
    ),
    menu.

handle_choice(4) :-
    nl,
    write('Enter student ID to search: '),
    read(Id),
    (
        student(Id, Name, Status)
        ->
        write('Student found!'), nl,
        format('Student ID: ~w~n', [Id]),
        format('Student Name: ~w~n', [Name]),
        format('Student Attendance Status: ~w~n', [Status])
        ;
        write('Student not found'), nl
    ),
    menu.

handle_choice(5) :-
    nl,
    (
        student(_, _, _)
        ->
        write('All Student Records: '), nl,
        forall(
            student(Id, Name, Status),
            format('ID: ~w, Name: ~w, Status: ~w~n',[Id, Name, Status])
        )
        ;
        write('No entries found'), nl
    ),
    menu.


handle_choice(6) :-
    nl,
    write('You are exiting this system, goodbye'), nl.

handle_choice(_) :-
    write('Invalid choice. Please enter again!'), nl,
    menu.