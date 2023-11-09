CREATE TABLE Admin (
  "id"  integer NOT NULL,
  name  varchar(32) NOT NULL,
  email varchar(42) NOT NULL,
  CONSTRAINT PK_Admin PRIMARY KEY ("id")
);


CREATE TABLE "User" (
  "id"       varchar(9) NOT NULL,
  name       varchar(32) NOT NULL,
  email      varchar(42) NOT NULL,
  credit     integer NOT NULL,
  created_by integer NOT NULL,
  CONSTRAINT PK_User PRIMARY KEY ("id"),
  CONSTRAINT FK_User_Admin FOREIGN KEY (created_by) REFERENCES Admin ("id")
);

CREATE INDEX Index_User_FK ON "User" (created_by);


CREATE TABLE Student (
  "id" varchar(9) NOT NULL,
  CONSTRAINT PK_Student PRIMARY KEY ("id"),
  CONSTRAINT FK_Student_User FOREIGN KEY ("id") REFERENCES "User" ("id")
);

CREATE INDEX Index_Student_FK ON Student ("id");


CREATE TABLE Professor(
  "id" varchar(9) NOT NULL,
  CONSTRAINT PK_Professor PRIMARY KEY ("id"),
  CONSTRAINT FK_Professor_User FOREIGN KEY ("id") REFERENCES "User" ("id")
);

CREATE INDEX Index_Professor_FK ON Professor ("id");


CREATE TABLE Announcement (
  "id"        integer NOT NULL,
  title       varchar(120) NOT NULL,
  description text NOT NULL,
  "date"      date NOT NULL,
  made_by     integer NOT NULL,
  CONSTRAINT PK_Announcement PRIMARY KEY ("id"),
  CONSTRAINT FK_Announcement_Admin FOREIGN KEY (made_by) REFERENCES Admin ("id")
);

CREATE INDEX Index_Announcement_FK ON Announcement (made_by);


CREATE TABLE Meal (
  name     varchar(32) NOT NULL,
  price    integer NOT NULL,
  added_by integer NOT NULL,
  CONSTRAINT PK_Meal PRIMARY KEY (name),
  CONSTRAINT FK_Meal_Admin FOREIGN KEY (added_by) REFERENCES Admin ("id")
);

CREATE INDEX Index_Meal_FK ON Meal (added_by);


CREATE TABLE Transaction (
  "id"   integer NOT NULL,
  "user" varchar(9) NOT NULL,
  price  integer NOT NULL,
  "date" timestamp NOT NULL,
  status varchar(8) NOT NULL,
  CONSTRAINT PK_Transaction PRIMARY KEY ("id", "user"),
  CONSTRAINT FK_Transaction_User FOREIGN KEY ("user") REFERENCES "User" ("id")
);

CREATE INDEX Index_Transaction_FK ON Transaction ("user");


CREATE TABLE ForgotCode (
  "id"        integer NOT NULL,
  student     varchar(9) NOT NULL,
  "date"      timestamp NOT NULL,
  valid_until time NOT NULL,
  code        varchar(128) NOT NULL,
  CONSTRAINT PK_ForgotCode PRIMARY KEY ("id", student),
  CONSTRAINT FK_ForgotCode_Student FOREIGN KEY (student) REFERENCES Student ("id")
);

CREATE INDEX Index_ForgotCode_FK ON ForgotCode (student);


CREATE TABLE Transfer (
  "id"   integer NOT NULL,
  "from" varchar(9) NOT NULL,
  "to"   varchar(9) NOT NULL,
  amount integer NOT NULL,
  "date" timestamp NOT NULL,
  CONSTRAINT PK_Transfer PRIMARY KEY ("id"),
  CONSTRAINT FK_Transfer_StudentFrom FOREIGN KEY ("from") REFERENCES Student ("id"),
  CONSTRAINT FK_Transfer_StudentTo FOREIGN KEY ("to") REFERENCES Student ("id")
);

CREATE INDEX Index_Transfer_StudentFrom ON Transfer ("from");
CREATE INDEX Index_Transfer_StudentTo ON Transfer ("to");


CREATE TABLE "Group" (
  "id"  integer NOT NULL,
  name  varchar(32) NOT NULL,
  owner varchar(9) NOT NULL,
  CONSTRAINT PK_Group PRIMARY KEY ("id"),
  CONSTRAINT FK_Group_Student FOREIGN KEY (owner) REFERENCES Student ("id")
);

CREATE INDEX Index_Group_FK ON "Group" (owner);


CREATE TABLE IsInGroup (
  "group" integer NOT NULL,
  student varchar(9) NOT NULL,
  CONSTRAINT PK_IsInGroup PRIMARY KEY ("group", student),
  CONSTRAINT FK_IsInGroup_Group FOREIGN KEY ("group") REFERENCES "Group" ("id"),
  CONSTRAINT FK_IsInGroup_Student FOREIGN KEY (student) REFERENCES Student ("id")
);

CREATE INDEX Index_IsInGroup_Group ON IsInGroup ("group");
CREATE INDEX Index_IsInGroup_Student ON IsInGroup (student);


CREATE TABLE Restaurant (
  "id" integer NOT NULL,
  name varchar(32) NOT NULL,
  CONSTRAINT PK_Restaurant PRIMARY KEY ("id")
);


CREATE TABLE Reservation (
  "id"       integer NOT NULL,
  "user"     varchar(9) NOT NULL,
  meal       varchar(32) NOT NULL,
  restaurant integer NOT NULL,
  rate       integer NULL,
  CONSTRAINT PK_Reservation PRIMARY KEY ("id"),
  CONSTRAINT FK_Reservation_User FOREIGN KEY ("user") REFERENCES "User" ("id"),
  CONSTRAINT FK_Reservation_Meal FOREIGN KEY (meal) REFERENCES Meal (name),
  CONSTRAINT FK_Reservation_Restaurant FOREIGN KEY (restaurant) REFERENCES Restaurant ("id")
);

CREATE INDEX Index_Reservation_User ON Reservation ("user");
CREATE INDEX Index_Reservation_Meal ON Reservation (meal);
CREATE INDEX Index_Reservation_Restaurant ON Reservation (restaurant);
