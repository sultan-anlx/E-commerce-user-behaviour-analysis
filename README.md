# E-commerce Customer Behaviour Analysis

## Project Overview

This project analyses customer behaviour on an e-commerce platform to understand **what factors are associated with purchasing behaviour and where opportunities exist to improve customer conversion**.

The analysis examines customer demographics, website engagement, browsing behaviour, bounce rate, user type, advertising exposure, discount exposure, and purchasing activity.

The project follows an end-to-end data analytics workflow using **Power Query, Excel, PostgreSQL/SQL, and Power BI**, moving from raw data preparation and validation to exploratory analysis, dashboard development, business insights, and recommendations.

---

## Business Problem

The business wants to understand:

> **What customer behaviours and marketing factors are associated with purchasing, and where can the customer journey be improved to support stronger conversion?**

Rather than looking only at the overall conversion rate, the analysis investigates the behaviours and customer segments behind purchasing activity.

---

## Objectives

The analysis was designed to:

* Measure overall conversion performance.
* Compare purchasing behaviour across gender, age groups, and user types.
* Examine the relationship between website engagement and conversion.
* Analyse the effect of pages viewed, time spent on site, and bounce rate.
* Evaluate advertising and discount exposure against purchasing behaviour.
* Identify customer segments and behavioural patterns relevant to conversion.
* Develop an interactive dashboard for stakeholder analysis.
* Translate the findings into practical business recommendations.

---

## Dataset

The dataset contains customer-level e-commerce activity across demographic, behavioural, marketing, and purchase variables.

### Key Variables

**Customer Profile**

* Age
* Gender
* Returning User

**Website Behaviour**

* Time on Site
* Average Session Time
* Pages Viewed
* Bounce Rate
* Device Type

**Purchase Behaviour**

* Previous Purchases
* Cart Items
* Purchase

**Marketing Exposure**

* Advertisement Clicked
* Discount Seen

These variables were used to investigate the relationship between customer engagement, purchase behaviour, and marketing exposure.

---

# Analytical Workflow

## 1. Data Cleaning & Transformation — Power Query

The raw dataset was first processed using Power Query Editor to prepare it for analysis.

Key activities included:

* Reviewing the dataset for missing and inconsistent values.
* Correcting data types.
* Standardising categorical variables.
* Creating meaningful analytical categories.
* Preparing behavioural metrics for analysis.
* Structuring the dataset for use across Excel, SQL, and Power BI.
* Performing data-quality checks before analysis.

The objective was to create a consistent analytical dataset that could be reliably used across multiple tools.

---

## 2. Exploratory Analysis — Microsoft Excel

Excel was used to conduct exploratory analysis and identify initial patterns in customer behaviour.

I used:

* PivotTables
* Calculated metrics
* Charts
* Customer segmentation
* Conversion analysis

The analysis compared purchasing behaviour across:

* Gender
* Age groups
* New vs. returning users
* Website engagement levels
* Pages viewed
* Time spent on site
* Bounce rate
* Advertising exposure
* Discount exposure

This stage helped identify patterns that were subsequently investigated and presented through SQL and Power BI.

---

## 3. SQL Analysis — PostgreSQL

The cleaned dataset was loaded into PostgreSQL to perform structured analysis and validate key results.

SQL was used to:

* Calculate and validate conversion metrics.
* Aggregate customer behaviour by demographic segments.
* Compare conversion across user groups.
* Analyse engagement and purchase behaviour.
* Investigate advertising and discount exposure.
* Examine customer behaviour across different segments.
* Cross-check findings from the exploratory analysis.

This provided an additional layer of analytical validation and allowed the data to be analysed using structured queries.

---

## 4. Power BI Dashboard

The final analysis was developed into an interactive Power BI dashboard.

### Dashboard Components

The dashboard provides analysis of:

* Overall conversion performance
* Purchase activity
* Average session duration
* Average pages viewed
* Gender performance
* Age-group performance
* New vs. returning users
* Engagement and conversion
* Bounce rate
* Advertising exposure
* Discount exposure

Interactive slicers allow users to explore customer behaviour across different demographic and behavioural segments.

---

# Key Insights & Patterns

## 1. Conversion Performance

The dataset records an **overall conversion rate of approximately 98%**.

This unusually high conversion rate is an important characteristic of the dataset and should be considered when interpreting the findings.

### Gender

Conversion rates between male and female users show **limited variation**.

This suggests that gender was not a major differentiating factor in purchasing behaviour within the analysed dataset.

### Age

The **32–45 age segment recorded the strongest conversion performance at approximately 34.49% within the age-group analysis**.

This indicates that this segment represents an important customer group for further investigation and potentially targeted engagement strategies.

### New vs. Returning Users

New users showed a **slightly higher conversion rate than returning users**.

This suggests that familiarity with the platform alone did not necessarily correspond to higher conversion within this dataset and that new-user acquisition may represent a meaningful short-term opportunity.

---

# 2. Behavioural Impact Analysis

### Time Spent on Website

Users who spent more time on the website showed **stronger conversion behaviour**.

This suggests that deeper engagement with the website is associated with a greater likelihood of purchasing.

However, because this is observational data, the relationship should be interpreted as an **association rather than proof that spending more time causes conversion**.

### Pages Viewed

A positive relationship was observed between **pages viewed and conversion behaviour**.

Users who explored more pages generally demonstrated stronger purchasing behaviour, suggesting that product exploration and website engagement are important signals of purchase intent.

### Bounce Rate

Users with stronger engagement and lower bounce behaviour were more likely to convert.

This highlights the importance of the **early customer experience**, particularly the ability of the website to retain visitors and encourage further exploration.

--

# 3. Marketing Effectiveness

### Advertising

Users who did not click on advertisements showed a **slightly higher conversion rate** than users who clicked on ads.

The difference was not strong enough to conclude that advertisements negatively affect conversion.

However, the finding suggests that **ad clicks alone should not be treated as a reliable indicator of purchase intent**.

Advertising may therefore be contributing more to awareness or initial engagement than directly driving completed purchases within this dataset.

### Discounts

Users exposed to discounts recorded a **slightly lower conversion rate** than users who were not exposed to discounts.

One possible explanation is that discounts may have been targeted toward particular customer groups, such as returning customers, rather than being randomly assigned.

Therefore, the analysis does not establish that discounts reduce conversion. Instead, it indicates that **discount exposure was not associated with stronger conversion in this dataset**.

---

# Business Interpretation

The analysis suggests that **customer engagement and behavioural intent appear more useful for understanding conversion than demographic or broad marketing exposure alone**.

In particular:

* Time spent on the website is associated with stronger conversion behaviour.
* Higher pages viewed are associated with stronger purchasing activity.
* Bounce behaviour appears relevant to conversion performance.
* Gender shows limited differentiation in purchasing behaviour.
* New users slightly outperform returning users in conversion.
* Advertisement clicks do not appear to be a strong standalone conversion indicator.
* Discount exposure does not appear to correspond to stronger conversion in the analysed data.

This indicates that the business may benefit from focusing on **customer intent and website experience rather than relying primarily on broad promotional activity**.

---

# Recommendations

## 1. Focus on High-Intent Customers

Use behavioural signals such as:

* Pages viewed
* Time spent on site
* Cart activity
* Previous purchases
* Engagement level

to identify users showing stronger purchase intent.

Marketing resources can then be directed toward customers who demonstrate meaningful engagement rather than applying the same strategy across all users.

---

## 2. Improve Product Visibility & User Experience

Since stronger engagement is associated with conversion, the business should focus on improving the customer journey.

Potential areas include:

* Product discoverability
* Website navigation
* Product recommendations
* Product information
* Page performance
* Checkout experience

The goal should be to encourage users to continue exploring products and move naturally toward purchase.

---

## 3. Optimise Advertising Strategy

Rather than evaluating advertisements solely by clicks, measure their effectiveness across the full customer journey.

Recommended metrics include:

* Engagement
* Cart activity
* Conversion
* Revenue
* Customer acquisition cost

Ads can continue to support awareness and traffic generation while conversion-focused strategies target users who demonstrate stronger purchasing intent.

---

## 4. Use Targeted Rather Than Broad Promotions

Because discounted users did not demonstrate stronger conversion in this dataset, discount campaigns should be evaluated based on **incremental conversion and customer value**, rather than simply the number of customers reached.

Target promotions toward customers or situations where there is evidence of purchase intent.

---

## 5. Personalise Customer Engagement

Customer behaviour can be used to create more relevant marketing strategies.

For example:

* Highly engaged non-buyers → conversion-focused messaging
* Cart users → cart recovery strategies
* New users → onboarding and product discovery
* Returning users → personalised recommendations
* Low-engagement users → strategies focused on improving retention

---

# Project Outcome

This project demonstrates an end-to-end data analytics workflow:

**Raw Data → Power Query Cleaning → Excel EDA → PostgreSQL/SQL Analysis → Power BI Dashboard → Business Insights → Recommendations**

Through this workflow, I transformed raw customer-level data into an analytical view of **conversion behaviour, customer engagement, demographic patterns, and marketing exposure**.

The project demonstrates practical skills in:

* Data Cleaning & Transformation
* Exploratory Data Analysis
* Excel & PivotTables
* SQL & PostgreSQL
* Customer Segmentation
* Conversion Analysis
* KPI Development
* Power BI Dashboard Development
* Data Visualisation
* Business Analysis
* Data Storytelling
* Translating Data into Business Recommendations


## Conclusion

The project demonstrates how customer behaviour data can be used to move beyond basic conversion reporting and identify **the behavioural patterns associated with purchasing decisions**.

The analysis indicates that engagement-related behaviours—including time spent on the website, pages viewed, and bounce behaviour—provide useful signals for understanding conversion, while gender, advertising clicks, and discount exposure show weaker differentiation within the dataset.

These findings provide a basis for developing **more targeted, behaviour-driven conversion strategies and improving the overall customer journey**.

