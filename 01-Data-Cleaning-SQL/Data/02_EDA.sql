-- Exploratory Data Analysis

select *
from india_layoffs_clean2;

select max(total_laid_off),max(percentage_laid_off)
from india_layoffs_clean2;

select *
from india_layoffs_clean2
where total_laid_off = 1200;

select company,sum(funds_raised_millions) as total_fund
from india_layoffs_clean2
group by company
order by total_fund desc;

select max(`date`), min(`date`)
from india_layoffs_clean2;