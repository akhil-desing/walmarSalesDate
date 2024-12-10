-- i can create table walmarSalesDate
CREATE TABLE if not exists WalmarSalesData(
invoiceId varchar(50) not null primary key,
branch varchar(10)not null ,
city varchar(30) not null,
customer_type varchar(50) not null ,
gender char(25),
product_line varchar(100),
unit_price   decimal(10,2) not null,
Quantity int not null,
tax decimal,
total decimal(12,4) not null,
date date,
time time,
payment varchar(20),
cogs decimal,
grossmarginpercentage decimal,
grossincome decimal(10,2),
rating float
);
-- using short  method import data from my file
copy walmarsalesdata(invoiceid,branch,city,customer_type,gender,
product_line,unit_price,quantity,tax,total,date,time,payment,
cogs,grossmarginpercentage,grossincome,rating) from 'D:\yutubevideo\WalmartSalesData.csv.csv'
delimiter ','
header csv

--  first i can check my  table  to store data properly or not  
select * from walmarsalesdata limit 5;

-- add the column month_name and day_name 
alter table walmarsalesdata add column month_name varchar(20);

update walmarsalesdata set month_name= to_char(date,'Month');


-- for day column
alter table walmarsalesdata add column day_name varchar(20);

update walmarsalesdata set day_name=to_char(data,'Day');
-- 2 check out the total number of the column present in my table
select count(*) from walmarsalesdata;

-- 3 find out  the distinct branch 
select distinct branch from walmarsalesdata; 

-- 4 what are the totalamount for each city in descending order and count the branch name by each city
select city,  count(branch) ,sum(total) as total_amount from 

walmarsalesdata group by city  order by 

total_amount desc;

-- 5 what is the unique product line does the data have

select distinct product_line from walmarsalesdata;

-- 6 what is  most the common payment method

select payment, count(*) as most_common_payment_method

 from walmarsalesdata group by payment order by payment desc limit 1;

-- 7  what is the most selling product line

select product_line,count(*) as selling_product_line

from walmarsalesdata group by product_line order by selling_product_line desc limit 1;

-- what is the total revenue  by month,

select  date_part('month',date)

as month,sum(total) as total_amount

 from walmarsalesdata group by month order by total_amount desc;

-- what  is the city the largest revenue

select city,branch , sum(total) as total_revenue  

from walmarsalesdata group  by city,branch order by total_revenue desc ;

-- what product line had the largest vat
select product_line,avg(tax) as avg_vat

 from walmarsalesdata group by product_line order by avg_vat desc;

-- which  branch sold more products than average product sold

select branch, sum(quantity) as qty from walmarsalesdata group by 

branch having sum(quantity)>(select avg(quantity) from walmarsalesdata)

-- what is the most common product line by gender

select gender,product_line , count(gender) as  gnd

 from walmarsalesdata group by gender,product_line order by gnd desc ;