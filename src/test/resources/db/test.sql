DELETE FROM contact;
DELETE FROM profile;
DELETE FROM user_role;
DELETE FROM user_belong;
DELETE FROM users;
DELETE FROM task;
DELETE FROM sprint;
DELETE FROM project;

insert into users (ID, EMAIL, PASSWORD, FIRST_NAME, LAST_NAME, DISPLAY_NAME, STARTPOINT)
values (1, 'user@gmail.com', '{noop}password', 'userFirstName', 'userLastName', 'userDisplayName', '2023-05-10 09:00:00.000000'),
       (2, 'admin@gmail.com', '{noop}admin', 'adminFirstName', 'adminLastName', 'adminDisplayName', '2023-05-11 09:00:00.000000'),
       (3, 'guest@gmail.com', '{noop}guest', 'guestFirstName', 'guestLastName', 'guestDisplayName', '2023-05-12 09:00:00.000000');

-- 0 DEV
-- 1 ADMIN
insert into USER_ROLE (ROLE, USER_ID)
values (0, 1),
       (1, 2),
       (0, 2);

DELETE FROM reference;
--============ References =================
insert into reference (ID, CODE, TITLE, REF_TYPE, STARTPOINT)
-- TASK
values (1, 'task', 'Task', 2, '2023-05-10 09:00:00.000000'),
       (2, 'story', 'Story', 2, '2023-05-10 09:00:00.000000'),
       (3, 'bug', 'Bug', 2, '2023-05-10 09:00:00.000000'),
       (4, 'epic', 'Epic', 2, '2023-05-10 09:00:00.000000'),
-- TASK_STATUS
       (5, 'icebox', 'Icebox', 3, '2023-05-10 09:00:00.000000'),
       (6, 'backlog', 'Backlog', 3,'2023-05-10 09:00:00.000000'),
       (7, 'ready', 'Ready', 3, '2023-05-10 09:00:00.000000'),
       (8, 'in progress', 'In progress', 3, '2023-05-10 09:00:00.000000'),
       (9, 'done', 'Done', 3, '2023-05-10 09:00:00.000000'),
-- SPRINT_STATUS
       (10, 'planning', 'Planning', 4,'2023-05-10 09:00:00.000000'),
       (11, 'implementation', 'Implementation', 4, '2023-05-10 09:00:00.000000'),
       (12, 'review', 'Review', 4, '2023-05-10 09:00:00.000000'),
       (13, 'retrospective', 'Retrospective', 4, '2023-05-10 09:00:00.000000'),
-- USER_TYPE
       (14, 'admin', 'Admin', 5, '2023-05-10 09:00:00.000000'),
       (15, 'user', 'User', 5, '2023-05-10 09:00:00.000000'),
-- PROJECT
       (16, 'scrum', 'Scrum', 1, '2023-05-10 09:00:00.000000'),
       (17, 'task tracker', 'Task tracker', 1, '2023-05-10 09:00:00.000000'),
-- CONTACT
       (18, 'skype', 'Skype', 0, '2023-05-10 09:00:00.000000'),
       (19, 'tg', 'Telegram', 0, '2023-05-10 09:00:00.000000'),
       (20, 'mobile', 'Mobile', 0, '2023-05-10 09:00:00.000000'),
       (21, 'phone', 'Phone', 0, '2023-05-10 09:00:00.000000'),
       (22, 'website', 'Website', 0, '2023-05-10 09:00:00.000000'),
       (23, 'vk', 'VK', 0, '2023-05-10 09:00:00.000000'),
       (24, 'linkedin', 'LinkedIn', 0, '2023-05-10 09:00:00.000000'),
       (25, 'github', 'GitHub', 0, '2023-05-10 09:00:00.000000'),
-- PRIORITY
       (26, 'critical', 'Critical', 7, '2023-05-10 09:00:00.000000'),
       (27, 'high', 'High', 7, '2023-05-10 09:00:00.000000'),
       (28, 'normal', 'Normal', 7, '2023-05-10 09:00:00.000000'),
       (29, 'low', 'Low', 7, '2023-05-10 09:00:00.000000'),
       (30, 'neutral', 'Neutral', 7, '2023-05-10 09:00:00.000000');

insert into reference (ID, CODE, TITLE, REF_TYPE, AUX, STARTPOINT)
-- MAIL_NOTIFICATION
values
       (31, 'assigned', 'Assigned', 6, '1', '2023-05-10 09:00:00.000000'),
       (32, 'three_days_before_deadline', 'Three days before deadline', 6, '2', '2023-05-10 09:00:00.000000'),
       (33, 'two_days_before_deadline', 'Two days before deadline', 6, '4', '2023-05-10 09:00:00.000000'),
       (34, 'one_day_before_deadline', 'One day before deadline', 6, '8', '2023-05-10 09:00:00.000000'),
       (35, 'deadline', 'Deadline', 6, '16', '2023-05-10 09:00:00.000000'),
       (36, 'overdue', 'Overdue', 6, '32', '2023-05-10 09:00:00.000000');

insert into profile (ID, LAST_FAILED_LOGIN, LAST_LOGIN, MAIL_NOTIFICATIONS)
values (1, null, null, 49),
       (2, null, null, 14);

insert into contact (ID, CODE, VALUE)
values (1, 'skype', 'userSkype'),
       (1, 'mobile', '+01234567890'),
       (1, 'website', 'user.com'),
       (2, 'github', 'adminGitHub'),
       (2, 'tg', 'adminTg'),
       (2, 'vk', 'adminVk');

-- bugtracking
INSERT INTO project (id, code, title, description, type_code, startpoint, endpoint, parent_id) VALUES (2, 'task tracker', 'PROJECT-1', 'test project', 'task tracker', '2023-05-10 09:00:00.000000', null, null);

INSERT INTO sprint (id, status_code, startpoint, endpoint, title, project_id) VALUES (1, 'planning', '2023-04-09 23:05:05.000000', '2023-04-12 23:05:12.000000', 'Sprint-1', 2);

INSERT INTO task (id, title, description, type_code, status_code, priority_code, estimate, updated, project_id, sprint_id, parent_id, startpoint, endpoint) VALUES (2, 'Task-1', 'short test task', 'task', 'in progress', 'high', null, null, 2, 1, null, '2023-05-10 09:00:00.000000', null);
INSERT INTO task (id, title, description, type_code, status_code, priority_code, estimate, updated, project_id, sprint_id, parent_id, startpoint, endpoint) VALUES (3, 'Task-2', 'test 2 task', 'bug', 'ready', 'normal', null, null, 2, 1, null, '2023-05-10 09:00:00.000000', null);
INSERT INTO task (id, title, description, type_code, status_code, priority_code, estimate, updated, project_id, sprint_id, parent_id, startpoint, endpoint) VALUES (5, 'Task-4', 'test 4', 'bug', 'in progress', 'normal', null, null, 2, 1, null, '2023-05-10 09:00:00.000000', null);
INSERT INTO task (id, title, description, type_code, status_code, priority_code, estimate, updated, project_id, sprint_id, parent_id, startpoint, endpoint) VALUES (4, 'Task-3', 'test 3 descr', 'task', 'done', 'low', null, null, 2, 1, null, '2023-05-10 09:00:00.000000', null);

INSERT INTO user_belong (id, object_id, object_type, user_id, user_type_code, startpoint, endpoint) VALUES (3, 2, 2, 2, 'admin', '2023-05-10 09:00:00.000000', null);
INSERT INTO user_belong (id, object_id, object_type, user_id, user_type_code, startpoint, endpoint) VALUES (4, 3, 2, 2, 'admin', '2023-05-10 09:00:00.000000', null);
INSERT INTO user_belong (id, object_id, object_type, user_id, user_type_code, startpoint, endpoint) VALUES (5, 4, 2, 2, 'admin', '2023-05-10 09:00:00.000000', null);
INSERT INTO user_belong (id, object_id, object_type, user_id, user_type_code, startpoint, endpoint) VALUES (6, 5, 2, 2, 'admin', '2023-05-10 09:00:00.000000', null);

