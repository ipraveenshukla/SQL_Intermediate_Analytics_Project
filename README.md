# 📊 Intermediate SQL – Sales Analysis  

## 📌 Navigation  
- [Overview](#-overview)  
- [Business Questions](#-business-questions-i-answered)  
- [Data Preparation](#-data-preparation)  
- [Analysis](#-analysis)  
  - [Customer Segmentation](#1️⃣-customer-segmentation)  
  - [Customer Revenue by Cohort](#2️⃣-customer-revenue-by-cohort)  
  - [Customer Retention](#3️⃣-customer-retention)  
- [Strategic Recommendations](#-strategic-recommendations)  
- [Tech Stack](#️-tech-stack)  
- [Key Learnings](#-key-learnings)  

---

## 🔍 Overview  
I built this project to analyze customer behavior, retention, and lifetime value for an e-commerce business — with the goal of **boosting retention and maximizing revenue**  

---

## ❓ Business Questions I Answered  
- **Customer Segmentation:** Who are the most valuable customers?  
- **Cohort Analysis:** How different customer groups generate revenue over time?  
- **Retention Analysis:** Which customers are at risk of churning?  

---

## 🧹 Data Preparation  

**Query**: [0_create_view.sql](/Additional_Data/1_Scripts/0_create_view.sql)

- Aggregated raw sales + customer data into revenue metrics  
- Calculated first purchase dates (for cohort tracking)  
- Built a clean unified view combining transactions + customer details  

---

## 📈 Analysis  

### 1️⃣ Customer Segmentation  

**Query**: [1_customer_segmentation.sql](/1_customer_segmentation.sql)

- Segmented customers by Lifetime Value (LTV)  
- Classified into High / Mid / Low value groups  
- Computed revenue contribution per segment  

**Visualization:**  

![](/Images/1_customer_segementation.png)

**Key Findings:**  
- **25% customers → 66% revenue ($135.4M)**  
- **50% customers → 32% revenue ($66.6M)**  
- **25% customers → 2% revenue ($4.3M)**  

**Insights:**  
- High-value → Launch VIP program (12,372 users = massive impact)  
- Mid-value → Upsell opportunities (**$66.6M → $135.4M potential**)  
- Low-value → Re-engagement campaigns + pricing strategies  

---

### 2️⃣ Customer Revenue by Cohort  

**Query**: [2_cohort_analysis.sql](2_cohort_analysis.sql)

- Grouped users by first purchase year  
- Tracked revenue per cohort  
- Compared performance over time  

**Visualization:**  

![](/Images/2_customer_revenue_normalized.png)

**Key Findings:**  
- Spending dropped from **~$2,800 → ~$1,970** (older vs new cohorts)  
- Peak growth in 2022–2023, now declining in 2024  
- High volatility → unstable revenue patterns  

**Insights:**  
- Target newer cohorts (2016–2019) before churn kicks in  
- Introduce subscriptions / loyalty programs  
- Replicate strategies from high-performing cohorts (2016–2018)  

---

### 3️⃣ Customer Retention  

**Query**: [3_retention_analysis.sql](3_retention_analysis.sql)

- Identified churn-risk customers  
- Analyzed last purchase behavior  
- Built customer-level retention metrics  

**Visualization:**  

![](/Images/3_customer_churn_cohort_year.png)

**Key Findings:**  
- Churn stabilizes at **~90% after 2–3 years**  
- Retention stuck at **8–10% across all cohorts**  
- New cohorts repeating same churn pattern  

**Insights:**  
- First 1–2 years = critical retention window  
- Focus on high-value churned users (better ROI)  
- Build early-warning churn prediction system  

---

## 🚀 Strategic Recommendations  

### 1️⃣ Customer Value Optimization  
- Launch VIP program for top customers (**66% revenue**)  
- Upsell mid-tier customers (**$66.6M → $135.4M opportunity**)  
- Re-engage low-value users  

---

### 2️⃣ Cohort Strategy  
- Double down on 2022–2024 cohorts  
- Stabilize revenue with subscriptions  
- Reuse winning strategies from older cohorts  

---

### 3️⃣ Retention & Churn Prevention  
- Improve onboarding (first 1–2 years)  
- Target high-value churned users  
- Build proactive churn detection system  

---

## ⚙️ Tech Stack  
- **Database:** PostgreSQL  
- **Tools:** PostgreSQL, DBeaver  
- **Visualization:** Google Gemini  

---

## 🧠 Key Learnings  

- **Pareto Principle in action** → Small % of customers drive majority revenue  
- Cohort analysis exposed **declining customer quality over time**  
- Retention is the biggest bottleneck → not acquisition  
- Early customer lifecycle (first 1–2 years) = highest leverage point  
- LTV segmentation unlocks **clear monetization strategies**  
- Consistency (subscriptions/loyalty) beats volatile revenue spikes  
- Data can predict churn early → enabling proactive action  