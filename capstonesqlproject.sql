#Capstone Project tasks

/*1. Group the customers based on their income type and find the average of their annual income.

2.Find the female owners of cars and property.

3.Find the male customers who are staying with their families.

4.Please list the top five people having the highest income.

5.How many married people are having bad credit?

6.What is the highest education level and what is the total count?

7.Between married males and females, who is having more bad credit? */


/********************* ANSWERS **************************/

use capstone; # to use database

delimiter $$  
create procedure credit() # created procedure to view  columns and row values in table
begin
select * from credit_card;
end $$
delimiter ;


#Task1 -Group the customers based on their income type and find the average of their annual income.
call credit;
select type_income as 'Income type', count(ind_id) as 'NO_of_Customers',round(Avg(annual_income),2) as 'Average annual income'
from credit_card
group by type_income;

#Task2- Find the female owners of cars and property 
call credit;
select ind_id, gender
from credit_card
where gender = 'F' and car_owner ='Y' and Propert_owner ='Y';

#Task3- Find the male customers who are staying with their families. 
select distinct(housing_type)
from credit_card;

select ind_id, gender, Housing_type
from credit_card
where Gender ='M' and Housing_type ='With parents';

#Task4-.Please list the top five people having the highest income.
call credit;
select row_number() over (order by Annual_income desc) as 'Sl.No', Ind_ID, Annual_income
from credit_card
order by Annual_income desc
limit 5;

#task5- How many married people are having bad credit?
select * from credit_card_label;

select distinct(marital_status)
from credit_card;

select cc.ind_id, label
from credit_card cc 
inner join credit_card_label ccl
on cc.Ind_ID = ccl.Ind_ID
where Marital_status = 'married' and label = 0;

#task6.- What is the highest education level and what is the total count?
select distinct(EDUCATION)
from credit_card;

select EDUCATION as 'Highest education', count(EDUCATION) as 'Total count'
from credit_card
group by EDUCATION
having EDUCATION = 'Academic degree';


#task7.- Between married males and females, who is having more bad credit?
call credit;

select gender, label, marital_status, count(GENDER) as 'No_of People'
from credit_card cc 
inner join credit_card_label ccl
on cc.Ind_ID = ccl.Ind_ID
group by GENDER, label,marital_status
having label = 0 and marital_status = 'married';