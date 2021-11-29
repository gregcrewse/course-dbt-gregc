**(Part 1) Models**

----------------------------------------------------------------------------------------------
**Question 1:** What is our user repeat rate?

**Answer:** .8046875

```sql

with user_orders as (

select 
 user_id,
count(user_id) as purchases
from dbt_greg_c.stg_orders
group by 1

)

select
 count(case when purchases >= 2 then user_id end)::float / count(user_id)::float
from user_orders

```
----------------------------------------------------------------------------------------------
**Question 2:** What are good indicators of a user who will likely purchase again?

**Answer:**  Generally if they submitted ratings on their first order or if they had a positive interaction with customer service, 
also the frequency of their views and purchasing behavior.

----------------------------------------------------------------------------------------------
**Question 3:** Explain the marts models you added.  Why did you organize it the way you did?

**Answer:**  

I created core, marketing, and product subfolders under the marts folder.

In the core folder I kept transaction and order information as it represents the core unit of analysis and processes for the business. For marketing I focused on user related materics where important metrics like lifetime value couuld eventually be generated. This is the area of the business where
customer behavior would be the emphasis, so I tried to move that information there. In products I went back I added a page views model that I thought would be key to measuring product engagement and interaction. 

I don't have confidence in the placement of some of the models. I think it's open to interpretation and if I were to continue expanding and building on them it's possible
that some of them could eventually be moved to areas that more sense, either between marketing and product or moving dim_products back to core. 

----------------------------------------------------------------------------------------------

**Question 4:** DAG Screenshot

![image](https://user-images.githubusercontent.com/6477381/143929499-45bf34d8-1396-4164-9f73-19a58c3e25f9.png)

----------------------------------------------------------------------------------------------

**(Part 2) Tests**

----------------------------------------------------------------------------------------------

**Question 1:** What assumptions are you making about each model? (i.e. why did you add each test?)

**Answer:** I created simple tsts to make sure that the underlying values were positive.

----------------------------------------------------------------------------------------------

**Question 2:** Did you find any "bad" data as you added and ran tests on your models? 

**Answer:** Yes, I found some issues with the data, I had to remove some of the models I had place and make adjustments that have caused some issues because
I was operating off of some false assumptions..

----------------------------------------------------------------------------------------------

**Question 3:** Explain how you would ensure tests are passing regularly and how you would alert
stakeholders about bad data getting through?

**Answer:** In my current role, we have an alerts channel that signals a failure to refresh the data or underyling issues. The engineering team has access to the channel
so that they can see what the data team sees i.e. when there is a failure.  It would be great to surface that information further into a dashboard, but I generally find 
that while well-intentioned, dashboards built for the engineering team are hardly every utilized and are not well maintained as a result. 
