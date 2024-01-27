# Diagnostic-Exams

The data for diagnostics exams was imported from the OECD website (https://stats.oecd.org/?lang=en) under healthcare utilisation/diagnostic exams.

The initial data exploration and data cleaning was done using R.

The data was narrowed down to the past 5 years (2017 to 2022) only.  Additionally, the countries were also narrowed down to the following: Austraila, Austria, United States, Lithuania, South Korea, Norway, Netherlands, Denmark, France, Belgium, Italy and Romania).  The main criteria for country selection was to cover as many continents as possible, but select countries that had complete data.

The dashboard was designed in PowerBI.

Once a country is selected from the tiles at the top, the country is highlighted on a map (also showing bordering neighbours).
The bar chart on the left will show the total exams performed for a year for each type of exams (CT, MRI, PET) (further breaking down into number of exams done in a hospital or in ambulatory care).  The select of year can be changed using the year tiles to the right of the chart.

The line graph to the right shows the total scans performed (for three types of exams) over a 5 year period for the selected country.
