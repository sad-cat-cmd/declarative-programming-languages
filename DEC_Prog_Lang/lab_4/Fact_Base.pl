parent(man_2, man_1).
parent(man_3, man_2).
parent(man_4, man_3).

parent(man_6, man_7).
parent(man_7, man_8).
parent(man_5, man_9).
parent(man_10, man_6).
parent(man_10, man_4).
parent(girl_2, man_2).
parent(man_4, man_5).

woman(girl_1).
woman(girl_2).

man(man_1).
man(man_2).
man(man_3).
man(man_4).
man(man_5).
man(man_6).
man(man_7).
man(man_8).
man(man_9).
man(man_10).

husband(man_2, girl_1).

wife(girl_1, man_2).