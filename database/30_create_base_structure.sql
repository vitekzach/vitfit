-- ██████   █████  ███████ ███████ 
-- ██   ██ ██   ██ ██      ██      
-- ██████  ███████ ███████ █████   
-- ██   ██ ██   ██      ██ ██      
-- ██████  ██   ██ ███████ ███████ 

drop table if exists base.change_tracking;

create table base.change_tracking (
    created     timestamp not null default now(),
    created_by  text not null,
    updated     timestamp not null default now(),
    updated_by  text not null
);


--  ██████  ██████  ███    ██ ███████ ████████ 
-- ██      ██    ██ ████   ██ ██         ██    
-- ██      ██    ██ ██ ██  ██ ███████    ██    
-- ██      ██    ██ ██  ██ ██      ██    ██    
--  ██████  ██████  ██   ████ ███████    ██    

--unit
drop table if exists const.unit;
create table const.unit(
    id          serial primary key,
    unit        text not null unique,
    unit_name   text not null unique
) inherits(base.change_tracking);


-- exercise
drop table if exists const.exercise_bodypart;
create table const.exercise_bodypart(
    id          serial primary key,
    bodypart    text not null unique
) inherits(base.change_tracking);

drop table if exists const.muscle;
create table const.muscle(
    id          serial primary key,
    muscle      text not null unique,
    bodypart    int not null 
) inherits(base.change_tracking);
ALTER TABLE const.muscle ADD CONSTRAINT fk_mucle_bodypart FOREIGN KEY (bodypart) REFERENCES const.exercise_bodypart(id);

drop table if exists const.exercise_type;
create table const.exercise_type(
    id                      serial primary key,
    exercise_type           text not null unique,
    weight_modification     float
) inherits(base.change_tracking);

drop table if exists const.exercise;
create table const.exercise(
    id                      serial primary key,
    exercise                text not null unique,
    muscle                  int not null,
    exercise_type           int not null,
    instructions            text[]
) inherits(base.change_tracking);
alter table const.exercise add constraint fk_exercise_muscle foreign key (muscle) references const.muscle(id);
alter table const.exercise add constraint fk_exercise_type foreign key (exercise_type) references const.exercise_type(id);

-- measurement 
drop table if exists const.measurement_bodypart;
create table const.measurement_bodypart(
    id                      serial primary key,
    bodypart                text not null unique,
    unit                    int not null
) inherits(base.change_tracking);
alter table const.measurement_bodypart add constraint fk_measurement_bodypart_unit foreign key (unit) references const.unit(id);

-- gym 
drop table if exists const.gym;
create table const.gym(
    id                      serial primary key,
    gym_name                text not null unique,
    coordinates             point
) inherits(base.change_tracking);

-- ██    ██ ███████ ███████ ██████  
-- ██    ██ ██      ██      ██   ██ 
-- ██    ██ ███████ █████   ██████  
-- ██    ██      ██ ██      ██   ██ 
--  ██████  ███████ ███████ ██   ██ 

drop table if exists auth.account;
create table auth.account(
    id                      serial primary key,
    username                text not null unique,
    email                   text unique,
    registered_at           timestamp not null,
    last_logged_in          timestamp not null
) inherits(base.change_tracking);

-- ██████  ██    ██ ██████  ██      ██  ██████ 
-- ██   ██ ██    ██ ██   ██ ██      ██ ██      
-- ██████  ██    ██ ██████  ██      ██ ██      
-- ██      ██    ██ ██   ██ ██      ██ ██      
-- ██       ██████  ██████  ███████ ██  ██████ 

drop table if exists public.measurement;
create table public.measurement(
    id                      serial primary key,
    account                 int not null,
    measurement             float not null,
    bodypart                int not null
) inherits(base.change_tracking);
alter table public.measurement add constraint fk_measurement_bodypart foreign key (bodypart) references const.measurement_bodypart (id);
alter table public.measurement add constraint fk_measurement_user foreign key (account) references auth.account (id);

drop table if exists public.workout;
create table public.workout(
    id                      serial primary key,
    gym                     int not null,
    started_at              timestamp not null,
    ended_at                timestamp,               
    account                 int not null
) inherits(base.change_tracking);
alter table public.workout add constraint fk_workout_gym foreign key (gym) references const.gym (id);
alter table public.workout add constraint fk_workout_user foreign key (account) references auth.account (id);

drop table if exists public.workout_exercise;
create table public.workout_exercise(
    id                      serial primary key,
    workout                 int not null,
    set_number              int not null,
    set_weight              float not null,
    started_at              timestamp not null,
    ended_at                timestamp,
    exercise                int not null
) inherits(base.change_tracking);
alter table public.workout_exercise add constraint fk_workout_exercise_workout foreign key (workout) references public.workout (id);
alter table public.workout_exercise add constraint fk_workout_exercise_exercise foreign key (exercise) references const.exercise (id);
