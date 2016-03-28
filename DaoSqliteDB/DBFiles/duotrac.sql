--
-- File generated with SQLiteStudio v3.0.6 on Thu Nov 26 16:13:43 2015
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: sessions
DROP TABLE IF EXISTS sessions;
CREATE TABLE "sessions" (

"id" INTEGER NOT NULL,

"user_id" INTEGER NOT NULL,

"start_date" DATETIME NOT NULL,

"session" INTEGER NOT NULL,

"modified" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

"created" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_users" FOREIGN KEY ("user_id") REFERENCES "users" ("id")

);

INSERT INTO sessions (id, user_id, start_date, session, modified, created) VALUES (1, 1, '2016-01-28 10:55:03', 1, '2016-01-28 10:55:01', '2016-02-23 10:55:03');
INSERT INTO sessions (id, user_id, start_date, session, modified, created) VALUES (2, 2, '2016-01-28 10:55:03', 1, '2016-01-28 10:55:01', '2016-02-23 10:55:03');

-- Table: swings
DROP TABLE IF EXISTS swings;
CREATE TABLE "swings" (

"id" INTEGER NOT NULL,

"session_id" INTEGER NOT NULL,

"swing" INTEGER NOT NULL,

"address_club" REAL NOT NULL,

"address_hip" REAL NOT NULL,

"impact_club" REAL NOT NULL,

"impact_hip" REAL NOT NULL,

"downswing_club" IREAL NOT NULL,

"downswing_hip" REAL NOT NULL,

"top_club" REAL NOT NULL,

"top_hip" REAL NOT NULL,

"modified" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

"created" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_sessions" FOREIGN KEY ("session_id") REFERENCES "sessions" ("id")
);

-- Swings of 'Demo User'
INSERT INTO swings (session_id, swing, address_hip, address_club, impact_hip, impact_club, downswing_hip, downswing_club, top_hip, top_club, modified, created) VALUES (1, 1, 0, 0, -30, -2.5, -20, -5, -40, -7, '2016-01-28 04:39:10', '2016-01-28 04:39:10');

INSERT INTO swings (session_id, swing, address_hip, address_club, impact_hip, impact_club, downswing_hip, downswing_club, top_hip, top_club, modified, created) VALUES (1, 2, 0, 0, 25, 2.3, -40, -5, 45, -7, '2016-01-28 04:39:10', '2016-01-28 04:39:10');

-- Swings of 'John Doe'
INSERT INTO swings (session_id, swing, address_hip, address_club, impact_hip, impact_club, downswing_hip, downswing_club, top_hip, top_club, modified, created) VALUES (2, 1, 0, 0, 29, 3, 5, 10, 30, 9, '2016-01-28 04:39:10', '2016-01-28 04:39:10');

INSERT INTO swings (session_id, swing, address_hip, address_club, impact_hip, impact_club, downswing_hip, downswing_club, top_hip, top_club, modified, created) VALUES (2, 2, 0, 0, -40, -1.5, -50, -6, -30, -8, '2016-01-28 04:39:10', '2016-01-28 04:39:10');


-- Table: users
DROP TABLE IF EXISTS users;
CREATE TABLE "users" (

"id" INTEGER NOT NULL,

"name" TEXT NOT NULL,

"email" TEXT NOT NULL,

"height_inches" INTEGER,

"height_feet" INTEGER,

"weight" REAL,

"gender" INTEGER,  /* null: undefined; 0: male; 1: female; */

"age" INTEGER,

"training_hours" INTEGER NOT NULL DEFAULT 0,

"training_units" INTEGER NOT NULL DEFAULT 0, /* 0: day; 1: week; 2: month; */

"modified" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

"created" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

PRIMARY KEY ("id")
);
INSERT INTO users (id, name, email, height_inches, height_feet, weight, gender, age, training_hours, training_units, modified, created) VALUES (1, 'Demo User', 'demo@duotrac.com', 7, 5, 60, 1, 30, 0, 0, '2015-11-11 08:24:44', '2015-11-11 08:24:44');
INSERT INTO users (id, name, email, height_inches, height_feet, weight, gender, age, training_hours, training_units, modified, created) VALUES (2, 'John Doe', 'johndoe@duotrac.com', 7, 5, 60, 1, 30, 0, 0, '2015-11-11 08:24:44', '2015-11-11 08:24:44');

-- Index: email_INDEX
DROP INDEX IF EXISTS email_INDEX;
CREATE INDEX "email_INDEX" ON "users" ("email" );

-- Trigger: UpdateModifiedSessions
DROP TRIGGER IF EXISTS UpdateModifiedSessions;
CREATE TRIGGER [UpdateModifiedSessions]

AFTER UPDATE

ON sessions

FOR EACH ROW

WHEN NEW.modified < OLD.modified

BEGIN

UPDATE sessions SET modified = CURRENT_TIMESTAMP WHERE id = OLD.id;

END;

-- Trigger: UpdateModifiedUsers
DROP TRIGGER IF EXISTS UpdateModifiedUsers;
CREATE TRIGGER [UpdateModifiedUsers]

AFTER UPDATE

ON users

FOR EACH ROW

WHEN NEW.modified < OLD.modified

BEGIN

UPDATE users SET modified = CURRENT_TIMESTAMP WHERE id = OLD.id;

END;

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
