# Welcome to the SQL Data Cleaning project on Nashville Housing Society dataset.

This is a Data cleaning Project in SQL Server Management Studio. The goal of this project is to showcase my SQL skills to do data cleaning for raw datasets which can be manipulated to bring about more organization within the dataset to make the analysis process more efficient.

SQL Queries for cleaning data fields.

1: Standardizing DATE format: The SaleDate column was standardized with the CONVERT function. The output after the SQL query:

<img width="211" alt="1 saledate" src="https://user-images.githubusercontent.com/96620728/159125522-8152aef8-aa7a-4b78-a365-19019ddd4b76.png">


2: SELF Joins: Populating PrpoertyAddress fields which was NULL:

In the dataset there were PropertyAddress fields those were null for a certain ParcelID but was not NULL for the same ParcelID. The goal of this self join SQL query was to populate the NULL fields and make sure all the ParcelID fields has the PropertyAddress. The ISNULL function was used in the self join to update the PropertyAddress fields having NULL values.

The output after the SQl query:

<img width="412" alt="2 Before" src="https://user-images.githubusercontent.com/96620728/159125588-2d517da3-a330-45ea-acd5-9312504d032b.png">


3. Splitting PropertyAddress Column:
Two new columns were added in the dataset named PropertySplitAddress and PropertySplitCity. Then SUBSTRING and CHARINDEX function were used in the SQL query to split the PropertyAddress column into two new column with UPDATE statement.

The Output after SQL query:

<img width="337" alt="3 Propertyaddress" src="https://user-images.githubusercontent.com/96620728/159125600-45085418-e44a-4e80-98eb-a88cb1ed98d2.png">

4. Splitting OwnerAddress Column:

Three new columns were added in the dataset named OwnerSplitAddress,OwnerSplitCity and OwnerSplitState. Then PARSENAME function were used in the SQL query with REPLACE OwnerAddress data field delimiter from ',' to '.' to split the PropertyAddress column in to three new columns with the UPDATE statement.

The output after SQL query:

<img width="403" alt="4 Owneraddress" src="https://user-images.githubusercontent.com/96620728/159125618-c1733dfb-1c3e-4444-a62d-bb9777306c99.png">


5.CASE statement to change Y and N to Yes and No:

In the original dataset it was found there were 52 'Y' and 399 'N' along.With the CASE statement in SoldAsvacant column all the 'Y' and 'N' were replaced with 'Yes' and 'No'.

Before the CASE statement:

<img width="161" alt="5 before case" src="https://user-images.githubusercontent.com/96620728/159125632-eed1e296-a03a-471b-a743-a73ea1c9ab6d.png">

After the CASE statement:

<img width="179" alt="5 aftercase" src="https://user-images.githubusercontent.com/96620728/159125640-7cfa98ad-3d9f-43e9-a787-3f9b6cca7708.png">


6. Removing Duplicate values with CTE,ROW_NUMBER and Window Function:

With ROW_NUMBER function in the CTE all the fields having more than 1 count was deleted resulting in removing same data present more than once in the dataset.

Before the SQL query:

<img width="299" alt="6 row_number_before" src="https://user-images.githubusercontent.com/96620728/159125651-c2c19fd8-5a7d-40a2-989b-9ba38697db20.png">

After the SQL query to remove duplicates:

<img width="311" alt="6 row_number_after" src="https://user-images.githubusercontent.com/96620728/159125660-980c39d9-9554-4883-b6c9-780b21595757.png">


Finally the unused columns were deleted with DELETE statement which were manipulated in the data cleaning process.
