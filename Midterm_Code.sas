***********************************************************
*  Study:             
*  Program:           Midterm_Code.sas
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


/* SET UP LIBNAME */
libname midterm "/home/u64033249/BIOSTAT203A/MidtermProj";

/* IMPORT DATA */
proc import datafile="/home/u64033249/BIOSTAT203A/MidtermProj/Cancer_Data.csv"
	out=BREASTCANCER
	dbms=csv
	replace;
	getnames=yes;
run;

/* CHECK CONTENTS - proc contents */	
proc contents data=BREASTCANCER order=varnum; run;

title1 'print first 10 obs';
proc print data=BREASTCANCER(obs=10); run;
title1;


/* LABEL DATA - define and apply formats */

*define format for diagnosis;
proc format;
   value $diagnosisf
      'M' = 'Malignant - Benign'
      'B' = 'Benign - Malignant';
run;

*rename concave points columns to remove space to simplify processing;
*apply diagnosis format;
*label all columns;
data BREASTCANCER2;
	set BREASTCANCER(rename=('concave points_mean'n = concave_points_mean
							 'concave points_se'n = concave_points_se
							 'concave points_worst'n = concave_points_worst));
	
	format diagnosis $diagnosisf.;
	
	label id = "Unique ID of each patient"
	diagnosis = "Type of cancer (=M/B)"
	radius_mean = "Mean value of the cancers radius"
	texture_mean = "Mean value of the cancers texture"
	perimeter_mean = "Mean value of the cancers perimeter"
	area_mean = "Mean value of the cancers area"
	smoothness_mean = "Mean value of the cancers smoothness"
	compactness_mean = "Mean value of the cancers compactness"
	concavity_mean = "Mean value of the cancers concavity"
	concave_points_mean = "Mean value of the cancers concave points"
	symmetry_mean = "Mean value of symmetry"
	fractal_dimension_mean = "Mean value of fractal dimension"
	
	radius_se = "Standard error of the cancers radius"
	texture_se = "Standard error of the cancers texture"
	perimeter_se = "Standard error of the cancers perimeter"
	area_se = "Standard error of the cancers area"
	smoothness_se = "Standard error of the cancers smoothness"
	compactness_se = "Standard error of the cancers compactness"
	concavity_se = "Standard error of the cancers concavity"
	concave_points_se = "Standard error of the cancers concave points"
	symmetry_se = "Standard error of symmetry"
	fractal_dimension_se = "Standard error of fractal dimension"
	
	radius_worst = "Mean of the three largest values of the cancers radius"
	texture_worst = "Mean of the three largest values of the cancers texture"
	perimeter_worst = "Mean of the three largest values of the cancers perimeter"
	area_worst = "Mean of the three largest values of the cancers area"
	smoothness_worst = "Mean of the three largest values of the cancers smoothness"
	compactness_worst = "Mean of the three largest values of the cancers compactness"
	concavity_worst = "Mean of the three largest values of the cancers concavity"
	concave_points_worst = "Mean of the three largest values of the cancers concave points"
	symmetry_worst = "Mean of the three largest values of symmetry"
	fractal_dimension_worst = "Mean of the three largest values of fractal dimension"
	;
run;

*run proc contents to check accurate labels;
proc contents data=breastcancer2 order=varnum; run;

/* CHECK COLUMN VALUES: in table form run proc freq on categorical and proc means on continuous */
*here we find if we have any missing data;

*character columns;
***diagnosis;
proc freq data=breastcancer2;
	tables diagnosis / list missing;
run;
*format applied, no missing values;

*numeric columns;
***means;
proc means data=breastcancer2 n mean min max p25 p75 std nonobs maxdec=2;
	var radius_mean texture_mean perimeter_mean area_mean
	smoothness_mean compactness_mean concavity_mean 
	concave_points_mean symmetry_mean fractal_dimension_mean;
run;

***ses;
proc means data=breastcancer2 n mean min max p25 p75 std nonobs maxdec=2;
	var radius_se texture_se perimeter_se area_se
	smoothness_se compactness_se concavity_se 
	concave_points_se symmetry_se fractal_dimension_se;
run;

***worsts;
proc means data=breastcancer2 n mean min max p25 p75 std nonobs maxdec=2;
	var radius_worst texture_worst perimeter_worst area_worst
	smoothness_worst compactness_worst concavity_worst 
	concave_points_worst symmetry_worst fractal_dimension_worst;
run;



* table 1: means by malignant/benign;
proc sort data=breastcancer2; by diagnosis; run;
proc means data=breastcancer2 mean median p25 p75 std;
    by diagnosis;
    var radius_mean texture_mean perimeter_mean area_mean
        smoothness_mean compactness_mean concavity_mean
        concave_points_mean symmetry_mean fractal_dimension_mean;
    output out=tbl1sumstat 
        mean=mean_radius_mean mean_texture_mean mean_perimeter_mean mean_area_mean
        mean_smoothness_mean mean_compactness_mean mean_concavity_mean
        mean_concave_points_mean mean_symmetry_mean mean_fractal_dimension_mean
        median=median_radius_mean median_texture_mean median_perimeter_mean median_area_mean
        median_smoothness_mean median_compactness_mean median_concavity_mean
        median_concave_points_mean median_symmetry_mean median_fractal_dimension_mean
        p25=Q1_radius_mean Q1_texture_mean Q1_perimeter_mean Q1_area_mean
        Q1_smoothness_mean Q1_compactness_mean Q1_concavity_mean
        Q1_concave_points_mean Q1_symmetry_mean Q1_fractal_dimension_mean
        p75=Q3_radius_mean Q3_texture_mean Q3_perimeter_mean Q3_area_mean
        Q3_smoothness_mean Q3_compactness_mean Q3_concavity_mean
        Q3_concave_points_mean Q3_symmetry_mean Q3_fractal_dimension_mean
        std=std_radius_mean std_texture_mean std_perimeter_mean std_area_mean
        std_smoothness_mean std_compactness_mean std_concavity_mean
        std_concave_points_mean std_symmetry_mean std_fractal_dimension_mean;
run;

proc print data=tbl1sumstat; run;

proc export data=tbl1sumstat
    outfile='/home/u64033249/BIOSTAT203A/MidtermProj/tbloneoutput.csv' 
    dbms=csv 
    replace;
run;


/* CHECK COLUMN VALUES VISUALLY: box plots and histograms diagnosis */

*define macros (sas version of functions) for histogram and box plots;

*vbox;
%macro exploratory_vbox_plots(vars);
    %let n = %sysfunc(countw(&vars));
    
    %do i = 1 %to &n;
        %let var = %scan(&vars, &i);
        
		title2 "Vbox plot: &var";
		
        proc sgpanel data=breastcancer2 noautolegend;
            panelby diagnosis;
            vbox &var;
            colaxis display=(nolabel);
        run;
        
        title2;

    %end;
%mend;
*hist;
%macro exploratory_hist_plots(vars);
    %let n = %sysfunc(countw(&vars));
    
    %do i = 1 %to &n;
        %let var = %scan(&vars, &i);
		
		title2 "Histogram plot: &var";
		
        proc sgpanel data=breastcancer2 noautolegend;
            panelby diagnosis;
            histogram &var;
            colaxis display=(nolabel);
        run;
        
        title2;

    %end;
%mend;

title1 'box plots for numeric columns by diagnosis';
%exploratory_vbox_plots(radius_mean texture_mean perimeter_mean area_mean smoothness_mean compactness_mean concavity_mean concave_points_mean symmetry_mean fractal_dimension_mean radius_se texture_se perimeter_se area_se smoothness_se compactness_se concavity_se concave_points_se symmetry_se fractal_dimension_se radius_worst texture_worst perimeter_worst area_worst smoothness_worst compactness_worst concavity_worst concave_points_worst symmetry_worst fractal_dimension_worst);
title1;
			  
title1 'histogram plots for numeric columns by diagnosis';
%exploratory_hist_plots(radius_mean texture_mean perimeter_mean area_mean smoothness_mean compactness_mean concavity_mean concave_points_mean symmetry_mean fractal_dimension_mean radius_se texture_se perimeter_se area_se smoothness_se compactness_se concavity_se concave_points_se symmetry_se fractal_dimension_se radius_worst texture_worst perimeter_worst area_worst smoothness_worst compactness_worst concavity_worst concave_points_worst symmetry_worst fractal_dimension_worst);
title1;

/* CLEAN DATA */

*create 0/1 diagnosis variable Malignant:1, Benign: 0;
data breastcancer3;
	set breastcancer2;
	malignant = (diagnosis='M');
run;

*check malignant creation;
proc freq data=breastcancer3;
	tables diagnosis*malignant / list missing;
run;

proc sort data=breastcancer3 nounikey out=dupcheck_id1;
	by id;
run;

title1 'print any dups on id';
proc print data=dupcheck_id1; run;
title1;
*good! no duplicates;


/* SPLIT THE DATA - this is just to show we can merge data :) ds1: M, ds2: B */
data malig;
	set breastcancer3;
	where malignant=1;
run;

data benign;
	set breastcancer3;
	where malignant=0;
run;

/* REMERGE THE DATA */
proc sort data=malig; by id; run;
proc sort data=benign; by id; run;

*since there are no common ids in malig and benign, we will append;
data appendds;
	set benign malig;
run;

*show merge just for data management purposes;
data mergeds;
	merge benign(in=in1) malig(in=in2);
	by id diagnosis radius_mean	texture_mean	perimeter_mean	area_mean	smoothness_mean	compactness_mean	concavity_mean	concave_points_mean	symmetry_mean	fractal_dimension_mean	radius_se	texture_se	perimeter_se	area_se	smoothness_se	compactness_se	concavity_se	concave_points_se	symmetry_se	fractal_dimension_se	radius_worst	texture_worst	perimeter_worst	area_worst	smoothness_worst	compactness_worst	concavity_worst	concave_points_worst symmetry_worst	fractal_dimension_worst;

	in_benign = in1;
	in_malig = in2;
run;

*check merge;
proc freq data=mergeds;
	tables in_benign*in_malig / list missing;
run;


/* CORRELATION MATRIX */

*just do means;
proc corr data=mergeds;
var radius_mean texture_mean perimeter_mean area_mean 
smoothness_mean compactness_mean concavity_mean 
concave_points_mean symmetry_mean 
fractal_dimension_mean;
run;

data mergeds_forcorr;
	set mergeds;
	drop malignant diagnosis id;
run;

*correlation plots for mean vars;
title1 'mean columns correlation plots: part 1';
proc corr data=mergeds_forcorr plots(maxpoints=NONE)=matrix(histogram);
var radius_mean texture_mean perimeter_mean area_mean 
smoothness_mean;
run;

title1 'mean columns correlation plots: part 2';
proc corr data=mergeds_forcorr plots(maxpoints=NONE)=matrix(histogram);
var compactness_mean concavity_mean 
concave_points_mean symmetry_mean 
fractal_dimension_mean;
run;
/* 
Correlation findings: a lot of correlation... some weaker and some stronger 
Strongest correlations (>|0.70| and p < 0.001):
- Radius & perimeter
- Radius & area 
- Radius & concave_points
- Perimeter & area
- Perimeter & concavity
- Perimeter & concave_points
- Area & concave_points
- Compactness & concavity
- Compactness & concave_points
- Concavity & concave_points


No correlation:
- Radius & symmetry
- Texture & smoothness
- Texture & symmetry
- Texture & fractal dimension
- Area & symmetry


radius and perimeter are directly positively correlated***
radius and area have a strong positive correlation
*/


/* OUTPUT DATA USED FOR REGRESSION */
data midterm.breastcancersas;
	set mergeds;
run;

proc contents data=mergeds out=contents_mergeds noprint;
run;

proc export data=contents_mergeds
    outfile="/home/u64033249/BIOSTAT203A/MidtermProj/breastcancer_contents.csv"
    dbms=csv
    replace;
run;



/* LOGISTIC REGRESSION */

/* 
variable list:
area (exclude radius, perimeter, concave points)
concavity
texture 
smoothness
symmetry
*/

proc logistic data=mergeds descending; /*descending option tells us to model 1's rather than 0's*/
  model malignant = area_mean concavity_mean texture_mean smoothness_mean symmetry_mean;
run;
*look at points estimates for interpretation;
*all significant aside from symmetry;


*now doing way that amanda found;
proc logistic data=mergeds descending; /*descending option tells us to model 1's rather than 0's*/
  model malignant = area_worst smoothness_worst texture_mean;
run;

* Amaan: We may consider z-scoring our predictors to ease interpretability;
*Standardize continuous predictors in the 'mergeds' dataset;
proc standard data=mergeds mean=0 std=1 out=mergeds_std;
   /* Specify the continuous variables to standardize */
   var area_mean concavity_mean texture_mean smoothness_mean symmetry_mean;
run;
* Amaan: Run standardized model for Olivia's chosen variables;
proc logistic data=mergeds_std descending;
	model malignant = area_mean concavity_mean texture_mean smoothness_mean symmetry_mean;
run;

* SUPPLEMENTARY CORRELATION PLOTS: going to focus on mean variables;
proc corr data=mergeds;
var radius_mean texture_mean perimeter_mean area_mean 
smoothness_mean compactness_mean concavity_mean 
concave_points_mean symmetry_mean 
fractal_dimension_mean radius_se texture_se perimeter_se area_se 
smoothness_se compactness_se concavity_se concave_points_se symmetry_se 	
fractal_dimension_se radius_worst texture_worst perimeter_worst	area_worst 
smoothness_worst compactness_worst concavity_worst 
concave_points_worst symmetry_worst  fractal_dimension_worst;
run;

*correlation plots for se vars;
title1 'se columns correlation plots: part 1';
proc corr data=mergeds_forcorr plots(maxpoints=NONE)=matrix(histogram);
var radius_se texture_se perimeter_se area_se 
smoothness_se;
run;

title1 'se columns correlation plots: part 2';
proc corr data=mergeds_forcorr plots(maxpoints=NONE)=matrix(histogram);
var compactness_se concavity_se concave_points_se symmetry_se 	
fractal_dimension_se;
run;

*correlation plots for worst vars;
title1 'worst columns correlation plots: part 1';
proc corr data=mergeds_forcorr plots(maxpoints=NONE)=matrix(histogram);
var radius_worst texture_worst perimeter_worst	area_worst 
smoothness_worst;
run;

title1 'worst columns correlation plots: part 2';
proc corr data=mergeds_forcorr plots(maxpoints=NONE)=matrix(histogram);
var compactness_worst concavity_worst 
concave_points_worst symmetry_worst  fractal_dimension_worst;
run;
title1;

/* RTF OUTPUTS */

proc sort data=breastcancer2; by diagnosis; run;
ods listing close;
ods rtf body="/home/u64033249/BIOSTAT203A/MidtermProj/table_1.rtf";
title1 "Output for table 1";
proc means data=breastcancer2 mean median p25 p75 std;
    by diagnosis;
    var radius_mean texture_mean perimeter_mean area_mean
        smoothness_mean compactness_mean concavity_mean
        concave_points_mean symmetry_mean fractal_dimension_mean;
run;
title1;

ods rtf close;
ods listing;

ods listing close;
ods rtf body="/home/u64033249/BIOSTAT203A/MidtermProj/table_2.rtf";
title1 "Output for table 2";
proc logistic data=mergeds descending; /*descending option tells us to model 1's rather than 0's*/
  model malignant = area_mean concavity_mean texture_mean smoothness_mean symmetry_mean;
run;
title1;

ods rtf close;
ods listing;

ods listing close;
ods rtf body="/home/u64033249/BIOSTAT203A/MidtermProj/table_3.rtf";
title1 "Output for table 3";
proc logistic data=mergeds_std descending;
	model malignant = area_mean concavity_mean texture_mean smoothness_mean symmetry_mean;
run;
title1;

ods rtf close;
ods listing;

