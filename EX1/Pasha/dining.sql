-- ************************************** Admin
CREATE TABLE Admin (
    "ID" integer NOT NULL,
    name varchar(50) NOT NULL,
    CONSTRAINT PK_1 PRIMARY KEY ("ID")
);

-- ************************************** Announcement
CREATE TABLE Announcement (
    "ID" integer NOT NULL,
    title varchar(50) NOT NULL,
    "desc" text NOT NULL,
    createdBy integer NULL,
    CONSTRAINT PK_2 PRIMARY KEY ("ID"),
    CONSTRAINT FK_1 FOREIGN KEY (createdBy) REFERENCES Admin ("ID")
);

CREATE INDEX FK_2 ON Announcement (createdBy);

-- ************************************** Food
CREATE TABLE Food (
    name varchar(50) NOT NULL,
    price integer NOT NULL,
    CONSTRAINT PK_3 PRIMARY KEY (name)
);

-- ************************************** Restaurant
CREATE TABLE Restaurant (
    name varchar(50) NOT NULL,
    CONSTRAINT PK_4 PRIMARY KEY (name)
);

-- ************************************** MealPlan
CREATE TABLE MealPlan (
    "ID" integer NOT NULL,
    "date" date NOT NULL,
    name varchar(50) NOT NULL,
    createdBy integer NULL,
    CONSTRAINT PK_5 PRIMARY KEY ("ID"),
    CONSTRAINT FK_3 FOREIGN KEY (name) REFERENCES Food (name),
    CONSTRAINT FK_4 FOREIGN KEY (createdBy) REFERENCES Admin ("ID")
);

CREATE INDEX FK_5 ON MealPlan (name);

CREATE INDEX FK_6 ON MealPlan (createdBy);

-- ************************************** "User"
CREATE TABLE "User" (
    "ID" varchar(9) NOT NULL,
    name varchar(50) NOT NULL,
    credit integer NOT NULL,
    createdBy integer NULL,
    CONSTRAINT PK_6 PRIMARY KEY ("ID"),
    CONSTRAINT FK_7 FOREIGN KEY (createdBy) REFERENCES Admin ("ID")
);

CREATE INDEX FK_8 ON "User" (createdBy);

-- ************************************** Student
CREATE TABLE Student (
    "ID" varchar(9) NOT NULL,
    CONSTRAINT PK_7 PRIMARY KEY ("ID"),
    CONSTRAINT FK_9 FOREIGN KEY ("ID") REFERENCES "User" ("ID")
);

CREATE INDEX FK_10 ON Student ("ID");

-- ************************************** Teacher
CREATE TABLE Teacher (
    "ID" varchar(9) NOT NULL,
    CONSTRAINT PK_8 PRIMARY KEY ("ID"),
    CONSTRAINT FK_11 FOREIGN KEY ("ID") REFERENCES "User" ("ID")
);

CREATE INDEX FK_12 ON Teacher ("ID");

-- ************************************** Transaction
CREATE TABLE Transaction (
    "ID" uuid NOT NULL,
    ID_User varchar(9) NOT NULL,
    TYPE varchar(50) NOT NULL,
    amount integer NOT NULL,
    STATUS varchar(50) NOT NULL,
    "date" date NOT NULL,
    CONSTRAINT PK_9 PRIMARY KEY ("ID", ID_User),
    CONSTRAINT FK_13 FOREIGN KEY (ID_User) REFERENCES "User" ("ID")
);

CREATE INDEX FK_14 ON Transaction (ID_User);

-- ************************************** TemporaryCode
CREATE TABLE TemporaryCode (
    "ID" integer NOT NULL,
    student varchar(9) NOT NULL,
    "time" timestamp NOT NULL,
    validFor tsrange NOT NULL,
    CONSTRAINT PK_10 PRIMARY KEY ("ID", student),
    CONSTRAINT FK_15 FOREIGN KEY (student) REFERENCES Student ("ID")
);

CREATE INDEX FK_16 ON TemporaryCode (student);

-- ************************************** CreditTransfer
CREATE TABLE CreditTransfer (
    "ID" integer NOT NULL,
    src varchar(9) NOT NULL,
    dst varchar(9) NOT NULL,
    amount integer NOT NULL,
    CONSTRAINT PK_11 PRIMARY KEY ("ID"),
    CONSTRAINT FK_17 FOREIGN KEY (src) REFERENCES "User" ("ID"),
    CONSTRAINT FK_18 FOREIGN KEY (dst) REFERENCES "User" ("ID")
);

CREATE INDEX FK_19 ON CreditTransfer (src);

CREATE INDEX FK_20 ON CreditTransfer (dst);

-- ************************************** "Group"
CREATE TABLE "Group" (
    "ID" integer NOT NULL,
    owner varchar(9) NOT NULL,
    name varchar(50) NOT NULL,
    "desc" varchar(50) NOT NULL,
    CONSTRAINT PK_12 PRIMARY KEY ("ID"),
    CONSTRAINT FK_21 FOREIGN KEY (owner) REFERENCES Student ("ID")
);

CREATE INDEX FK_22 ON "Group" (owner);

-- ************************************** GroupParticipation
CREATE TABLE GroupParticipation (
    "group" integer NOT NULL,
    student varchar(9) NOT NULL,
    CONSTRAINT PK_13 PRIMARY KEY ("group", student),
    CONSTRAINT FK_23 FOREIGN KEY ("group") REFERENCES "Group" ("ID"),
    CONSTRAINT FK_24 FOREIGN KEY (student) REFERENCES Student ("ID")
);

CREATE INDEX FK_25 ON GroupParticipation ("group");

CREATE INDEX FK_26 ON GroupParticipation (student);

CREATE TABLE Reservation (
    "ID" uuid NOT NULL,
    "user" varchar(9) NOT NULL,
    restaurant varchar(50) NOT NULL,
    rate integer NULL,
    mealPlan integer NOT NULL,
    CONSTRAINT PK_14 PRIMARY KEY ("ID"),
    CONSTRAINT FK_27 FOREIGN KEY (restaurant) REFERENCES Restaurant (name),
    CONSTRAINT FK_28 FOREIGN KEY (mealPlan) REFERENCES MealPlan ("ID"),
    CONSTRAINT FK_29 FOREIGN KEY ("user") REFERENCES "User" ("ID")
);

CREATE INDEX FK_30 ON Reservation (restaurant);

CREATE INDEX FK_31 ON Reservation (mealPlan);

CREATE INDEX FK_32 ON Reservation ("user");