--liquibase formatted sql

--changeset kmpk:init
DROP TABLE IF EXISTS USER_ROLE;
DROP TABLE IF EXISTS CONTACT;
DROP TABLE IF EXISTS MAIL_CASE;
DROP TABLE IF EXISTS PROFILE;
DROP TABLE IF EXISTS TASK_TAG;
DROP TABLE IF EXISTS TASK_TAGS;
DROP TABLE IF EXISTS USER_BELONG;
DROP TABLE IF EXISTS ACTIVITY;
DROP TABLE IF EXISTS TASK;
DROP TABLE IF EXISTS SPRINT;
DROP TABLE IF EXISTS PROJECT;
DROP TABLE IF EXISTS REFERENCE;
DROP TABLE IF EXISTS ATTACHMENT;
DROP TABLE IF EXISTS USERS;

CREATE TABLE PROJECT (
                         ID          BIGINT PRIMARY KEY,
                         CODE        VARCHAR(32) NOT NULL,
                         TITLE       VARCHAR(1024) NOT NULL,
                         DESCRIPTION VARCHAR(4096) NOT NULL,
                         TYPE_CODE   VARCHAR(32) NOT NULL,
                         STARTPOINT  TIMESTAMP,
                         ENDPOINT    TIMESTAMP,
                         PARENT_ID   BIGINT,
                         CONSTRAINT UK_PROJECT_CODE UNIQUE (CODE),
                         CONSTRAINT FK_PROJECT_PARENT FOREIGN KEY (PARENT_ID) REFERENCES PROJECT (ID) ON DELETE CASCADE
);

CREATE TABLE MAIL_CASE (
                           ID        BIGINT PRIMARY KEY,
                           EMAIL     VARCHAR(255) NOT NULL,
                           NAME      VARCHAR(255) NOT NULL,
                           DATE_TIME TIMESTAMP NOT NULL,
                           RESULT    VARCHAR(255) NOT NULL,
                           TEMPLATE  VARCHAR(255) NOT NULL
);

CREATE TABLE SPRINT (
                        ID          BIGINT PRIMARY KEY,
                        STATUS_CODE VARCHAR(32) NOT NULL,
                        STARTPOINT  TIMESTAMP,
                        ENDPOINT    TIMESTAMP,
                        TITLE       VARCHAR(1024) NOT NULL,
                        PROJECT_ID  BIGINT NOT NULL,
                        CONSTRAINT FK_SPRINT_PROJECT FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT (ID) ON DELETE CASCADE
);

CREATE TABLE REFERENCE (
                           ID         BIGINT PRIMARY KEY,
                           CODE       VARCHAR(32) NOT NULL,
                           REF_TYPE   SMALLINT NOT NULL,
                           ENDPOINT   TIMESTAMP,
                           STARTPOINT TIMESTAMP,
                           TITLE      VARCHAR(1024) NOT NULL,
                           AUX        VARCHAR,
                           CONSTRAINT UK_REFERENCE_REF_TYPE_CODE UNIQUE (REF_TYPE, CODE)
);

CREATE TABLE USERS (
                       ID           BIGINT PRIMARY KEY,
                       DISPLAY_NAME VARCHAR(32) NOT NULL,
                       EMAIL        VARCHAR(128) NOT NULL,
                       FIRST_NAME   VARCHAR(32) NOT NULL,
                       LAST_NAME    VARCHAR(32),
                       PASSWORD     VARCHAR(128) NOT NULL,
                       ENDPOINT     TIMESTAMP,
                       STARTPOINT   TIMESTAMP,
                       CONSTRAINT UK_USERS_DISPLAY_NAME UNIQUE (DISPLAY_NAME),
                       CONSTRAINT UK_USERS_EMAIL UNIQUE (EMAIL)
);

CREATE TABLE PROFILE (
                         ID                 BIGINT PRIMARY KEY,
                         LAST_LOGIN         TIMESTAMP,
                         LAST_FAILED_LOGIN  TIMESTAMP,
                         MAIL_NOTIFICATIONS BIGINT,
                         CONSTRAINT FK_PROFILE_USERS FOREIGN KEY (ID) REFERENCES USERS (ID) ON DELETE CASCADE
);

CREATE TABLE CONTACT (
                         ID    BIGINT NOT NULL,
                         CODE  VARCHAR(32) NOT NULL,
                         VALUE VARCHAR(256) NOT NULL,
                         PRIMARY KEY (ID, CODE),
                         CONSTRAINT FK_CONTACT_PROFILE FOREIGN KEY (ID) REFERENCES PROFILE (ID) ON DELETE CASCADE
);

CREATE TABLE TASK (
                      ID            BIGINT PRIMARY KEY,
                      TITLE         VARCHAR(1024) NOT NULL,
                      DESCRIPTION   VARCHAR(4096) NOT NULL,
                      TYPE_CODE     VARCHAR(32) NOT NULL,
                      STATUS_CODE   VARCHAR(32) NOT NULL,
                      PRIORITY_CODE VARCHAR(32) NOT NULL,
                      ESTIMATE      INTEGER,
                      UPDATED       TIMESTAMP,
                      PROJECT_ID    BIGINT NOT NULL,
                      SPRINT_ID     BIGINT,
                      PARENT_ID     BIGINT,
                      ENDPOINT      TIMESTAMP,
                      STARTPOINT    TIMESTAMP,
                      CONSTRAINT FK_TASK_SPRINT FOREIGN KEY (SPRINT_ID) REFERENCES SPRINT (ID) ON DELETE SET NULL,
                      CONSTRAINT FK_TASK_PROJECT FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT (ID) ON DELETE CASCADE,
                      CONSTRAINT FK_TASK_PARENT_TASK FOREIGN KEY (PARENT_ID) REFERENCES TASK (ID) ON DELETE CASCADE
);

CREATE TABLE ACTIVITY (
                          ID            BIGINT PRIMARY KEY,
                          AUTHOR_ID     BIGINT NOT NULL,
                          TASK_ID       BIGINT NOT NULL,
                          UPDATED       TIMESTAMP,
                          COMMENT       VARCHAR(4096),
                          TITLE         VARCHAR(1024),
                          DESCRIPTION   VARCHAR(4096),
                          ESTIMATE      INTEGER,
                          TYPE_CODE     VARCHAR(32),
                          STATUS_CODE   VARCHAR(32),
                          PRIORITY_CODE VARCHAR(32),
                          CONSTRAINT FK_ACTIVITY_USERS FOREIGN KEY (AUTHOR_ID) REFERENCES USERS (ID),
                          CONSTRAINT FK_ACTIVITY_TASK FOREIGN KEY (TASK_ID) REFERENCES TASK (ID) ON DELETE CASCADE
);

CREATE TABLE TASK_TAG (
                          TASK_ID BIGINT NOT NULL,
                          TAG     VARCHAR(32) NOT NULL,
                          CONSTRAINT UK_TASK_TAG UNIQUE (TASK_ID, TAG),
                          CONSTRAINT FK_TASK_TAG FOREIGN KEY (TASK_ID) REFERENCES TASK (ID) ON DELETE CASCADE
);

CREATE TABLE USER_BELONG (
                             ID             BIGINT PRIMARY KEY,
                             OBJECT_ID      BIGINT NOT NULL,
                             OBJECT_TYPE    SMALLINT NOT NULL,
                             USER_ID        BIGINT NOT NULL,
                             USER_TYPE_CODE VARCHAR(32) NOT NULL,
                             ENDPOINT       TIMESTAMP,
                             STARTPOINT     TIMESTAMP,
                             CONSTRAINT FK_USER_BELONG FOREIGN KEY (USER_ID) REFERENCES USERS (ID)
);
CREATE UNIQUE INDEX UK_USER_BELONG ON USER_BELONG (OBJECT_ID, OBJECT_TYPE, USER_ID, USER_TYPE_CODE);
CREATE INDEX IX_USER_BELONG_USER_ID ON USER_BELONG (USER_ID);

CREATE TABLE ATTACHMENT (
                            ID          BIGINT PRIMARY KEY,
                            NAME        VARCHAR(128) NOT NULL,
                            FILE_LINK   VARCHAR(2048) NOT NULL,
                            OBJECT_ID   BIGINT NOT NULL,
                            OBJECT_TYPE SMALLINT NOT NULL,
                            USER_ID     BIGINT NOT NULL,
                            DATE_TIME   TIMESTAMP,
                            CONSTRAINT FK_ATTACHMENT FOREIGN KEY (USER_ID) REFERENCES USERS (ID)
);

CREATE TABLE USER_ROLE (
                           USER_ID BIGINT NOT NULL,
                           ROLE    SMALLINT NOT NULL,
                           CONSTRAINT UK_USER_ROLE UNIQUE (USER_ID, ROLE),
                           CONSTRAINT FK_USER_ROLE FOREIGN KEY (USER_ID) REFERENCES USERS (ID) ON DELETE CASCADE
);
