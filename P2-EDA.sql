-- Exploratory Data Analysis

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

# insights
# companies that were shut down completely
select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc;

# company sum total laid off 
select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

# date of dataset recorded
select min(`date`), max(`date`)
from layoffs_staging2;

# industry/country that got affected the most
select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

# year wise layoffs
select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

# CTE for rolling total layoffs monthly per year
with rolling_total as
(
select substring(`date`, 1, 7) as `month`, sum(total_laid_off) as layoffs
from layoffs_staging2
where substring(`date`, 1, 7) is not null
group by `month`
order by 1 asc
)
select `month`, layoffs, sum(layoffs) over(order by `month`) as rolling_total
from rolling_total;

# company yearly layoff
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3  desc;

# ranking these according to laid offs/year

with company_year (company, years, total_laid_off) as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
), company_year_rank as 
(select *, 
dense_rank() over (partition by years order by total_laid_off desc) as ranking
from company_year   # hitting the first cte to create the second cte
where years is not null
)
select *
from company_year_rank
where ranking <= 5;



























