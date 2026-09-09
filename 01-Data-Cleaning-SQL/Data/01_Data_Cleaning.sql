-- Data Cleaning

select *
from india_layoffs_raw;

ALTER TABLE india_layoffs_raw
RENAME COLUMN ï»¿company TO company ;

select *
from india_layoffs_raw;

-- steps we going to do
-- 1. remove deuplicates 
-- 2. stadardizing the data 
-- 3. null values or black values
-- 4. remvoe any column

create table india_layoffs_clean
like india_layoffs_raw;

select *
from india_layoffs_clean;

insert india_layoffs_clean
select *
from india_layoffs_raw;

-- 1. remove deuplicates 

alter table india_layoffs_clean
drop column source;

select *,
row_number() over(
partition by company, location, state,industry, total_laid_off,
percentage_laid_off, 'date', stage, country, funds_raised_millions,
'role', department, employee_type, reason, company_size) as row_num
from india_layoffs_clean;

with duplicate_cte as
(
select *,
row_number() over(
partition by company, location, state,industry, total_laid_off,
percentage_laid_off, 'date', stage, country, funds_raised_millions,
'role', department, employee_type, reason, company_size) as row_num
from india_layoffs_clean
)
select *
from duplicate_cte
where row_num > 1;

select *
from india_layoffs_clean
where company = "BYJU'S" ;

CREATE TABLE `india_layoffs_clean2` (
  `company` text,
  `location` text,
  `state` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` double DEFAULT NULL,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `role` text,
  `department` text,
  `employee_type` text,
  `reason` text,
  `company_size` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from india_layoffs_clean2;

insert into india_layoffs_clean2
select *,
row_number() over(
partition by company, location, state,industry, total_laid_off,
percentage_laid_off, 'date', stage, country, funds_raised_millions,
'role', department, employee_type, reason, company_size) as row_num
from india_layoffs_clean;

select *
from india_layoffs_clean2;

select *
from india_layoffs_clean2
where row_num > 1
order by company;

-- off
SET SQL_SAFE_UPDATES = 0;

delete
from india_layoffs_clean2
where row_num > 1;

-- on
SET SQL_SAFE_UPDATES = 1;

select *
from india_layoffs_clean2
where row_num > 1;

select *
from india_layoffs_clean2;

-- 2. Stadardizing Data

select company, trim(company)
from india_layoffs_clean2;

update india_layoffs_clean2
set company = trim(company);

select distinct company
from india_layoffs_clean2
order by 1;

select distinct (trim(location))
from india_layoffs_clean2
order by 1;

update india_layoffs_clean2
set location = trim(location);

select distinct location
from india_layoffs_clean2
order by 1;

select distinct state
from india_layoffs_clean2
order by 1;

select distinct (trim(state))
from india_layoffs_clean2
order by 1;

update india_layoffs_clean2
set state = trim(state);

select distinct state
from india_layoffs_clean2
order by 1;

select *
from india_layoffs_clean2;

select distinct industry, (trim(industry))
from india_layoffs_clean2
order by 1;

update india_layoffs_clean2
set industry = trim(industry);

select distinct industry
from india_layoffs_clean2
order by 1;

select distinct stage
from india_layoffs_clean2
order by 1;

select distinct country
from india_layoffs_clean2
order by 1;

select distinct role
from india_layoffs_clean2
order by 1;

select distinct department, (trim(department))
from india_layoffs_clean2
order by 1;

update india_layoffs_clean2
set department = trim(department);

select distinct department
from india_layoffs_clean2
order by 1;

select distinct employee_type, (trim(employee_type))
from india_layoffs_clean2
order by 1;

update india_layoffs_clean2
set employee_type = trim(employee_type);

select distinct employee_type
from india_layoffs_clean2
order by 1;

select distinct reason, (trim(reason))
from india_layoffs_clean2
order by 1;

update india_layoffs_clean2
set reason = trim(reason);

select distinct reason
from india_layoffs_clean2
order by 1;

select distinct company_size, (trim(company_size))
from india_layoffs_clean2
order by 1;

-- Date change text to date
select `date`
from india_layoffs_clean2
order by `date`;

select `date`,
str_to_date(`date`, '%Y-%m-%d')
from india_layoffs_clean2;

update india_layoffs_clean2
set `date` = CASE 
    WHEN `date` IS NULL OR TRIM(`date`) = '' THEN NULL
    ELSE STR_TO_DATE(`date`, '%Y-%m-%d')
END;

alter table india_layoffs_clean2
modify column `date` date;

select * 
from india_layoffs_clean2;

-- 3. null values or black values
-- Location
select *
from india_layoffs_clean2
where location is null
and state is not null
order by 1;

update india_layoffs_clean2
set location = null
where location = '';

select company,location,state
from india_layoffs_clean2
where company = 'Ather Energy' and state = 'Tamil Nadu'
;

select t1.location,t2.location
from india_layoffs_clean2 t1
join india_layoffs_clean2 t2
	on t1.company = t2.company
where t1.location is null and t2.location is not null;

update india_layoffs_clean2 t1
join india_layoffs_clean2 t2
	on t1.company = t2.company
set t1.location = t2.location
where t1.location is null and t2.location is not null;

-- Industry
select *
from india_layoffs_clean2
where industry is null or industry = ''
order by 1;

update india_layoffs_clean2
set industry = null
where industry = '';

select t1.industry,t2.industry
from india_layoffs_clean2 t1
join india_layoffs_clean2 t2
	on t1.company = t2.company
where t1.industry is null and t2.industry is not null;

update india_layoffs_clean2 t1
join india_layoffs_clean2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null and t2.industry is not null;

-- Role
select *
from india_layoffs_clean2
where `role` is null or `role` = ''
order by 1;

update india_layoffs_clean2
set `role` = null
where `role` = '';

select t1.`role`,t2.`role`
from india_layoffs_clean2 t1
join india_layoffs_clean2 t2
	on t1.company = t2.company
where t1.`role` is null and t2.`role` is not null;

update india_layoffs_clean2 t1
join india_layoffs_clean2 t2
	on t1.company = t2.company
set t1.`role` = t2.`role`
where t1.`role` is null and t2.`role` is not null;

-- Department
select *
from india_layoffs_clean2
where department is null or department = ''
order by 1;

update india_layoffs_clean2
set department = null
where department = '';

select t1.department,t2.department
from india_layoffs_clean2 t1
join india_layoffs_clean2 t2
	on t1.company = t2.company
where t1.department is null and t2.department is not null;

update india_layoffs_clean2 t1
join india_layoffs_clean2 t2
	on t1.company = t2.company
set t1.department = t2.department
where t1.department is null and t2.department is not null;

-- Reason
select *
from india_layoffs_clean2
where reason is null or reason = ''
order by 1;

update india_layoffs_clean2
set reason = null
where reason = '';

select t1.reason,t2.reason
from india_layoffs_clean2 t1
join india_layoffs_clean2 t2
	on t1.company = t2.company
where t1.reason is null and t2.reason is not null;

update india_layoffs_clean2 t1
join india_layoffs_clean2 t2
	on t1.company = t2.company
set t1.reason = t2.reason
where t1.reason is null and t2.reason is not null;

select *
from india_layoffs_clean2
;

alter table india_layoffs_clean2
drop column row_num;
