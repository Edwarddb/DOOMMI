CREATE DATABASE `DOOMMI`
DEFAULT CHARACTER SET UTF8
DEFAULT COLLATE utf8_general_ci ;

GRANT ALL PRIVILEGES ON `DOOMMI`.* TO 'DOOMMI_user'@'%' IDENTIFIED BY 'DOOMMI_password';;
GRANT ALL PRIVILEGES ON `DOOMMI`.* TO 'gDOOMMI_user'@'LOCALHOST' IDENTIFIED BY 'DOOMMI_password';;


FLUSH PRIVILEGES;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

USE DOOMMI;

create table CLASSE
(
   CdClas char(6) not null,
   LibClas char(60),
   primary key (CdClas)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table MATIERE
(
   CdMat char(6) not null,
   LibMat char(90),
   primary key (CdMat)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table LANGUE
(
   CdLang char(10) not null,
   LibLang char(30),
   primary key (CdLang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table ORGANISATION
(
   CdOrga char(4) not null,
   LibOrga char(5) not null,
   primary key (CdOrga)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table TYPECOURS
(
   CdCours char(3) not null,
   LibCours char(5) not null,
   primary key (CdCours)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table ETUDIANT
(
   NumEtu int(11) NOT NULL AUTO_INCREMENT,
   PseudoEtu char(20) not null unique,
   CdClas char(6) null,      -- CIR : Clé étrangère remplie a posteriori
   CdLang char(6),           -- CIR : Clé étrangère remplie a posteriori
   NomEtu char(30),
   PrenomEtu char(30),
   primary key (NumEtu)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create index ETUDIANT_1_FK on ETUDIANT
(
   CdClas
);
create index ETUDIANT_2_FK on ETUDIANT
(
   CdLang
);

create table PROJET
(
   NumProj int(11) NOT NULL AUTO_INCREMENT,
   DtDebProj DATETIME not null,
   DtFinProj DATETIME not null,
   NumEtu int(11) not null,
   CdMat char(6) not null,
   CdCours char(3) not null,
   primary key (NumProj)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create index PROJET_1_FK on PROJET
(
   NumEtu
);

create index PROJET_2_FK on PROJET
(
   CdMat
);

create index PROJET_3_FK on PROJET
(
   CdCours
);

create table DETAILPROJ
(
   NumDetail int(11) NOT NULL AUTO_INCREMENT,
   LibDetail text not null,
   NumProj int(11) not null,
   NumEtu int(11) not null,
   primary key (NumDetail)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create index DETAILPROJET_1_FK on DETAILPROJ
(
   NumProj
);

create index DETAILPROJET_2_FK on DETAILPROJ
(
   NumEtu
);

create table REALDETAILPROJ
(
   NumEtu int(11) not null,
   NumDetail int(11) not null,
   primary key (NumEtu, NumDetail)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create index REALDETAILPROJET_1_FK on REALDETAILPROJ
(
   NumEtu
);

create index REALDETAILPROJET_2_FK on REALDETAILPROJ
(
   NumDetail
);


create table REPARTITION
(
   NumEtu int(11) not null,
   CdOrga char(4) not null,
   primary key (NumEtu, CdOrga)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create index REPARTITION_1_FK on REPARTITION
(
   NumEtu
);

create index REPARTITION_2_FK on REPARTITION
(
   CdOrga
);

create table REALPROJ
(
   NumEtu int(11) not null,
   NumProj int(11) not null,
   primary key (NumEtu, NumProj)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create index REALPROJ_1_FK on REALPROJ
(
   NumEtu
);

create index REALPROJ_2_FK on REALPROJ
(
   NumProj
);

create table GROUPTRAVAIL
(
   CdGroup char(4) not null,
   LibGroup char(50) null,
   primary key (CdGroup)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table GROUPPROJ
(
   CdGroup char(4) not null,
   NumProj int(11) not null,
   primary key (CdGroup, NumProj)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create index GROUPPROJ_1_FK on GROUPPROJ
(
   CdGroup
);

create index GROUPPROJ_2_FK on GROUPPROJ
(
   NumProj
);

create table GROUPETU
(
   CdGroup char(4) not null,
   NumEtu int(11) not null,
   primary key (CdGroup, NumEtu)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create index GROUPETU_1_FK on GROUPETU
(
   CdGroup
);

create index GROUPETU_2_FK on GROUPETU
(
   NumEtu
);


alter table ETUDIANT add constraint ETUDIANT_1_FK foreign key (CdClas) references CLASSE (CdClas) on delete restrict on update restrict;
alter table ETUDIANT add constraint ETUDIANT_2_FK foreign key (CdLang) references LANGUE (CdLang) on delete restrict on update restrict;
alter table PROJET add constraint PROJET_1_FK foreign key (NumEtu) references ETUDIANT (NumEtu) on delete restrict on update restrict;
alter table PROJET add constraint PROJET_2_FK foreign key (CdMat) references MATIERE (CdMat) on delete restrict on update restrict;
alter table PROJET add constraint PROJET_3_FK foreign key (CdCours) references TYPECOURS (CdCours) on delete restrict on update restrict;
alter table DETAILPROJ add constraint DETAILPROJ_1_FK foreign key (NumProj) references PROJET (NumProj) on delete cascade on update restrict;
alter table DETAILPROJ add constraint DETAILPROJ_2_FK foreign key (NumEtu) references ETUDIANT (NumEtu) on delete restrict on update restrict;
alter table REALDETAILPROJ add constraint REALDETAILPROJ_1_FK foreign key (NumEtu) references ETUDIANT (NumEtu) on delete restrict on update restrict;
alter table REALDETAILPROJ add constraint REALDETAILPROJ_2_FK foreign key (NumDetail) references DETAILPROJ (NumDetail) on delete cascade on update restrict;
alter table REPARTITION add constraint REPARTITION_1_FK foreign key (NumEtu) references ETUDIANT (NumEtu) on delete restrict on update restrict;
alter table REPARTITION add constraint REPARTITION_2_FK foreign key (CdOrga) references ORGANISATION (CdOrga) on delete restrict on update restrict;
alter table REALPROJ add constraint REALPROJ_1_FK foreign key (NumEtu) references ETUDIANT (NumEtu) on delete restrict on update restrict;
alter table REALPROJ add constraint REALPROJ_2_FK foreign key (NumProj) references PROJET (NumProj) on delete cascade on update restrict;
alter table GROUPPROJ add constraint GROUPPROJ_1_FK foreign key (CdGroup) references GROUPTRAVAIL (CdGroup) on delete restrict on update restrict;
alter table GROUPPROJ add constraint GROUPPROJ_2_FK foreign key (NumProj) references PROJET (NumProj) on delete restrict on update restrict;
alter table GROUPETU add constraint GROUPETU_1_FK foreign key (CdGroup) references GROUPTRAVAIL (CdGroup) on delete restrict on update restrict;
alter table GROUPETU add constraint GROUPETU_2_FK foreign key (NumEtu) references ETUDIANT (NumEtu) on delete restrict on update restrict;
