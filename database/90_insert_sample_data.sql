--  ██████  ██████  ███    ██ ███████ ████████ 
-- ██      ██    ██ ████   ██ ██         ██    
-- ██      ██    ██ ██ ██  ██ ███████    ██    
-- ██      ██    ██ ██  ██ ██      ██    ██    
--  ██████  ██████  ██   ████ ███████    ██    

--unit
insert into const.unit(id, created_by, updated_by, unit, unit_name) values 
    (0,     'admin',    'admin',    'cm',   'centimeter'),
    (1,     'admin',    'admin',    'm',    'meter'),
    (2,     'admin',    'admin',    'g',    'gram'),
    (3,     'admin',    'admin',    'kg',   'kilogram'),
    (4,     'admin',    'admin',    'lb',   'pound'),
    (5,     'admin',    'admin',    'in',   'inch'),
    (6,     'admin',    'admin',    'ml',   'mililiter'),
    (7,     'admin',    'admin',    'l' ,   'liter');

-- exercise
insert into const.exercise_bodypart(id, created_by, updated_by, bodypart) values 
    (0,     'admin',    'admin',    'legs'),
    (1,     'admin',    'admin',    'core'),
    (2,     'admin',    'admin',    'arms'),
    (3,     'admin',    'admin',    'chest'),
    (4,     'admin',    'admin',    'back');

insert into const.muscle(id, created_by, updated_by, muscle, bodypart) values 
    (0,     'admin',    'admin',    'biceps',       2),
    (1,     'admin',    'admin',    'tricpeps',     2),
    (2,     'admin',    'admin',    'shoulder',     2);

insert into const.exercise_type(id, created_by, updated_by, exercise_type, weight_modification) values 
    (0,     'admin',    'admin',    'bodyweight',       1),
    (1,     'admin',    'admin',    'barbell',          1),
    (2,     'admin',    'admin',    'dumbell',          1),
    (3,     'admin',    'admin',    'cardio',           0),
    (4,     'admin',    'admin',    'assisted',         1);

insert into const.exercise(id, created_by, updated_by, exercise, muscle, exercise_type) values 
    (0,     'admin',    'admin',    'Bicep curl (dumbell)',       0,    2),
    (1,     'admin',    'admin',    'Bicep curl (barbell)',       0,    1);

insert into const.measurement_bodypart(id, created_by, updated_by, bodypart, unit) values 
    (0,     'admin',    'admin',    'bicep',       0),
    (1,     'admin',    'admin',    'waist',       1),
    (2,     'admin',    'admin',    'weight',      3);

-- gym
insert into const.gym(id, created_by, updated_by, gym_name) values 
    (0,     'admin',    'admin',    'Form Factory Pankrác');
