# Diagnostic-Exams

The data for diagnostics exams was imported from the OECD website (https://stats.oecd.org/?lang=en) under healthcare utilization/diagnostic exams.

The initial data exploration and data cleaning was done using R.

The data was narrowed down to the past 5 years (2017 to 2022) only.  Additionally, the countries were also narrowed down to the following: Australia, Austria, United States, Lithuania, South Korea, Norway, Denmark, France, Belgium, Italy and Romania).  The main criteria for country selection was to cover as many continents as possible, but select countries that had complete data.

The dashboard was designed in PowerBI.

Once a country is selected from the tiles at the top, the country is highlighted on a map (also showing bordering neighbors).
The bar chart on the left will show the total exams performed for a year for each type of exam (CT, MRI, PET) (further breaking down into the number of exams done in a hospital or ambulatory care).  The selection of year can be changed using the year tiles to the right of the chart.

The line graph to the right shows the total scans performed (for three types of exams) over 5 years for the selected country.
