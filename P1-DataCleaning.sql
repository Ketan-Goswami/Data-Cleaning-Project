-- DATA CLEANING -- 

select *
from layoffs;

-- 1. Remove duplicates 
-- 2. Standardize the data - spelling issues, whitespaces etc
-- 3. Null or blank values
-- 4. Remove any columns not necessary

-- creating a operative table to work upon
-- avoid working on raw data
create table layoffs_staging
like layoffs;

insert layoffs_staging
select *
from layoffs;
# check data in new table
select *
from layoffs_staging;

-- 1 - removing duplicates
-- create row number column as the original table is missing unique col

with duplicate_cte as
(
select *,
row_number() over(
partition by company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage
, country, funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

#confirming duplicates
select *
from layoffs_staging
where company = '&Open';


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over(
partition by company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage
, country, funds_raised_millions) as row_num
from layoffs_staging;

select *
from layoffs_staging2
where row_num > 1;

# deletes duplicate data
delete
from layoffs_staging2
where row_num > 1;

#this now contains non duplicate data only 
select *
from layoffs_staging2;

-- 2. Standardizing data - find issues

# removing whitespaces
select company,  TRIM(company)
from layoffs_staging2;

update layoffs_staging2
set company = TRIM(company);

# changing names to one kind for similar names existing 
select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct industry
from layoffs_staging2;

# check every column in the table once for any issues seen
select distinct country
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = TRIM(trailing '.' from country)
where country like 'United States%';

# changing date col datatype from text to datetime when doing time-series stuff
select `date`
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

#now we can change the DT of date which was type now to date format
# only on temp table and not on raw table 
alter table layoffs_staging2
modify column `date` date;

select * from layoffs_staging2;

-- 3. Handling nulls 

select * from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is null;

# these rows can be dropped as they are not of much use and not accurate
delete 
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

-- looking at industries 
select * 
from layoffs_staging2
where industry = ''
or industry is NULL;

select *
from layoffs_staging2
where company = 'Airbnb';
# so here we can perform self join to fill the blank data from other entry which has the data
# first update all blank to null
update layoffs_staging2
set industry = NULL
where industry = '';

# now update industries from using joins operation
update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is NULL
and t2.industry is NOT NULL;

# the only row which we are now getting has only one entry of the same kind and therefore this cant be predicted
select *
from layoffs_staging2
where industry is NULL;
# which means all the other entries are now not null

-- 4. Removing unnecessary rows/columns

alter table layoffs_staging2
drop column  row_num;

# this is final clean data
select *
from layoffs_staging2;















































