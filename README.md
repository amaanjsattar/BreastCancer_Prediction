Assessing the Role of Nuclear Features on Breast Cancer Malignancy
Using Logistic Regression on Fine Needle Aspirate (FNA) Samples
Amanda Creech1, Amaan Jogia-Sattar2,3, Halle Villalobos2,3, Olivia Williams2,3
1 David Geffen School of Medicine, University of California, Los Angeles
2Fielding School of Public Health, University of California, Los Angeles,
3Department of Biostatistics,
University of California, Los Angeles
***********************************************************
*  Study:             
*  Program:           TumorLogistic.sas
*  Created by:        AMAAN.JOGIA-SATTAR
*  Date Created:      12112024
*  Description:       Conduct EDA for Continuous Variables. Create Correlation Matrices. 
					Run Logistic Regression Using Covariates in Original Units.
					Run Logistic Regression Using Z-Scored Covariates
					Run Logistic Regression on Domain Knowledge-Based Model (3-Covariate Model)
					Create Tables 1, 2, and 3. 
*
*
*  Input files:       Cancer_Data.csv
*  Output files:      breastcancersas.sas7bdat (sas dataset),
						tbloneoutput.csv (output from Table 1 in csv),
						table_1.rtf (output from table 1),
						table_2.rtf (output from table 2),
						table_3.rtf (output from table 3)
*
*  Other Comments:    None    
*
*
***********************************************************
*  Modification History:
*
*  Modification Number:  6
*  Modified by:          AMAAN.JOGIA-SATTAR
*  Date Modified:        12112024
*  Reason Modified:      Most recent modification: Added rtf output for tables in report
*
**********************************************************
* Copyright  .
* All rights reserved.
**********************************************************;


*******************************************************;
** APPLY CENTRAL CONFIGURATIONS                      **;
*******************************************************;
