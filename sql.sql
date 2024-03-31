INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_g6', 'Gruppe6', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_g6', 'Gruppe6', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_g6', 'Gruppe6', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('g6', 'Gruppe6')
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('g6', 0, 'recrue', 'Recrue', 125, '{}', '{}'),
('g6', 1, 'employe', 'Employé', 200, '{}', '{}'),
('g6', 2, 'chef', 'Chef équipe', 215, '{}', '{}'),
('g6', 3, 'patron', 'Patron', 230, '{}', '{}');

INSERT INTO `items` (name, label, `limit`) VALUES

('sac_billets', 'Sac de billets', 100);