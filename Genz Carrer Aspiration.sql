create database genz;
use genz;
Drop database genz;

select*from ca;

#1. What is the gender distribution of respondents from India?
select Gender, COUNT(*) as `no of respondants`
from ca
where Country = 'IND'
GROUP BY Gender;

#######2. What percentage of respondents from India are interested in education abroad and sponsorship?
alter table ca rename COLUMN `Higher Education outside of India` to interest_education_abroad;

SELECT (count(case when interest_education_abroad = 'Yes' and interest_education_abroad = 'Needs A Sponser' then 1 end) *100/count(*)) 
as `interested in education abroad` from ca where Country = 'IND';

select interest_education_abroad from ca;

#3. What are the 6 top influences on career aspirations for respondents in India? 

select `Factors influencing  career aspirations` from ca
where Country = 'IND'
group by `Factors influencing  career aspirations` order by `Factors influencing  career aspirations` desc
limit 6;

#4. How do career aspiration influences vary by gender in India?

select gender, `Career aspirations` , count(*) * 100.0 / sum(count(*))over(partition by gender) as percentage
from ca where Country = 'IND' group by gender, `Career aspirations`
order by gender, percentage;

#5. What percentage of respondents are willing to work for a company for at least 3 years?

select 'work for one employer for 3 years or more' as  category,
(count(case when `work for one employer for 3 years or more` = 'Yes' then 1 end)*100/count(*)) as percentage
from ca where Country = 'IND';

#6. How many respondents prefer to work for socially impactful companies?

select `Work for a non sociable company`, 
count(`Work for a non sociable company`) as `no of respondants` from ca
where `Work for a non sociable company` = 'No' and Country = 'IND';

#7. How does the preference for socially impactful companies vary by gender?

select `Work for a non sociable company`, Gender,
count(`Work for a non sociable company`) as `no of respondants` from ca
where `Work for a non sociable company` = 'No' and Country = 'IND'
group by Gender, `Work for a non sociable company` order by Gender, `Work for a non sociable company` ;

#8. What is the distribution of minimum expected salary in the first three years among respondents?

select distinct `Minimum expected monthly salary for the first 3 years` from ca 
where Country = 'IND';

#9. What is the expected minimum monthly salary in hand?

select distinct `Minimum expectations of salary when in starting of career` as `Minimum expected monthly salary in hand`
from ca;

#10. What percentage of respondents prefer remote working?

select (count(case when `preferred working environment` = 'fully remote' or `preferred working environment` = 'fully remote (travelling when needed)' then 1 end) * 100.0 / count(*)) as `respondents_prefer_remote_working`
from ca where Country = 'IND';

#11. What is the preferred number of daily work hours?

select `Working hours per day` as `preferred work hours`, count(*) as 'no of respondants'
from ca where Country = 'IND' and `Working hours per day` is not null
group by `Working hours per day` order by `Working hours per day` desc limit 1;

#12. What are the common work frustrations among respondents?



#13. How does the need for work-life balance interventions vary by gender?
#14. How many respondents are willing to work under an abusive manager?
#15. What is the distribution of minimum expected salary after five years?
#16. What are the remote working preferences by gender?
#17. What are the top work frustrations for each gender?
#18. What factors boost work happiness and productivity for respondents?
#19. What percentage of respondents need sponsorship for education abroad?