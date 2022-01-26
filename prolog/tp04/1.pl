:- dynamic macho/1, femea/1, privado/1, parent/2.

save_person(macho-Name) :- assertz(macho(Name)).
save_person(femea-Name) :- assertz(femea(Name)).
save_person(privado-Name) :- assertz(privado(Name)).

save_parent(Name-Mae-Pai) :- assertz(parent(Mae,Name)), assertz(parent(Pai,Name)).

delete_person(macho-Name) :- macho(Name),
                             retract(macho(Name)),
                             retractall(parent(_, Name)),
                             retractall(parent(Name, _)).

delete_person(femea-Name) :- macho(Name),
                            retract(macho(Name)),
                            retractall(parent(_, Name)),
                            retractall(parent(Name, _)).

add_person :- format('Format: Genero-Nome.', []), nl,
              read(Sex-Name),
              save_person(Sex-Name),
              format('E bem.', []), nl.

add_person :- format('Panao, fds, se vens com essas coisas do genero mete so privado, nao quero saber, cringe', []), nl, fail.

add_parents(Person) :- format('Indica o Pai', []), nl,
                        read(Pai),
                        macho(Pai), !,
                        format('Indica a Mae', []), nl,
                        read(Mae),
                        femea(Mae), !,
                        save_parent(Person-Mae-Pai),
                        format('E bem.', []), nl.

add_parents(Person) :- format('Nao se encontra na base de dados.', []), nl, fail.

remove_person :- format('Indica a pessoa a remover: genero-nome', []), nl,
                 read(Sex-Name),
                 delete_person(Sex-Name), !.

remove_person :- format('Essa pessoa nao existe.', []), nl, fail.
