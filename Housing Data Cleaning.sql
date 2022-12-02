select *
from portfolioproject..Housing_data

Select SaleDateConverted, Convert(Date,SaleDate)
from portfolioproject..Housing_data

Update Housing_data
Set SaleDate = Convert(Date,SaleDate)

Alter Table Housing_data
Add SaleDateConverted Date;

Update Housing_data
Set SaleDateConverted = Convert(Date,SaleDate)

--Populating Property Address Data

Select *
from portfolioproject..Housing_data
Where PropertyAddress is null
Order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.propertyaddress,b.propertyaddress)
from portfolioproject..Housing_data a
Join portfolioproject..Housing_data b
	on a.parcelID = b.parcelID
	and a.uniqueID <> b.uniqueID
Where a.PropertyAddress is null

Update a
Set PropertyAddress = ISNULL(a.propertyaddress,b.propertyaddress)
from portfolioproject..Housing_data a
Join portfolioproject..Housing_data b
	on a.parcelID = b.parcelID
	and a.uniqueID <> b.uniqueID
Where a.PropertyAddress is null

--Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
from portfolioproject..Housing_data
--Where PropertyAddress is null
--Order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
 CHARINDEX(',', PropertyAddress)
from portfolioproject..Housing_data


SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address

from portfolioproject..Housing_data

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, Len(PropertyAddress)) as Address
from portfolioproject..Housing_data

Alter Table Housing_data
Add PropertySplitAddress NVARCHAR(255);

Update Housing_data
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

Alter Table Housing_data
Add PropertySplitCity NVARCHAR(255);

Update Housing_data
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, Len(PropertyAddress))

Select*
from portfolioproject..Housing_data


Select OwnerAddress
from portfolioproject..Housing_data


Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.') ,1)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') ,2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') ,3)
from portfolioproject..Housing_data


Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.') ,3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') ,2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') ,1)
from portfolioproject..Housing_data


Alter Table Housing_data
Add OwnerSplitAddress NVARCHAR(255);

Update Housing_data
Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') ,3)

Alter Table Housing_data
Add OwnerSplitCity NVARCHAR(255);

Update Housing_data
Set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') ,2)

Alter Table Housing_data
Add  OwnerSplitState NVARCHAR(255);

Update Housing_data
Set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') ,1)

Select *
from portfolioproject..Housing_data



--Change Y and N to Yes and No in the field: Sold as Vacant

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
from portfolioproject..Housing_data
Group by SoldAsVacant
Order by 2


Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' then 'Yes'
	   When SoldAsVacant = 'N' then 'No'
	   Else SoldAsVacant
	   End
From portfolioproject..Housing_data

Update Housing_Data
Set SoldAsVacant = CASE When SoldAsVacant = 'Y' then 'Yes'
	   When SoldAsVacant = 'N' then 'No'
	   Else SoldAsVacant
	   End



--Removing Duplicate Characters (eg Duplicate Rows)

With RowNumCTE As(
Select *,
	ROW_NUMBER() Over (
	Partition By ParcelId,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 Order By
					UniqueID
					) Row_num
From portfolioproject..Housing_data
--Order by ParcelId
)
Select *
From RowNumCTE
where Row_num > 1
Order by PropertyAddress

--Delete Unused Columns

Select *
From portfolioproject..Housing_data

Alter Table portfolioproject..Housing_data
Drop Column OwnerAddress, TaxDistrict, PropertyAddress

Alter Table portfolioproject..Housing_data
Drop Column SaleDate

