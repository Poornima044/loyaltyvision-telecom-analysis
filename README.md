# 📂 LoyaltyVision Telecom Churn Analysis

## 📌 Project Overview
This project analyzes **telecom customer churn** using **SQL** and visualizes insights with a **Power BI dashboard**.  
The goal is to identify key churn drivers, customer behavior patterns, and revenue impact to support business decisions and improve retention strategies.  

---

## 🛠️ Tools & Technologies
- **SQL (MySQL)** → Data exploration & analysis  
- **Power BI** → Dashboard & visualization  
- **GitHub** → Project documentation and version control  

---

## 📊 SQL Analysis
The SQL scripts (`telecom_analysis.sql`) include:  

1. **Data Quality Checks**
   - Row counts, missing values, summary statistics  

2. **Customer Demographics & Segmentation**
   - Gender, Payment Methods, City Tier, Marital Status, Account Segments  

3. **Churn Analysis**
   - Churn distribution across demographics & tenure buckets  
   - Cohort analysis (tenure groups)  
   - Revenue lost vs retained due to churn  

4. **Advanced Insights**
   - Ranking customers by revenue  
   - Identifying at-risk customers (short tenure + declining revenue)  
   - Combined segmentation (Gender + Marital Status + City Tier)  

📌 **Key SQL Queries include:**  
- Churn by City Tier  
- Cohort Analysis (Tenure Groups)  
- Revenue impact of churn  
- Churn by Payment Method  

---

## 📈 Power BI Dashboard
An interactive **Power BI dashboard** was created to visualize churn patterns and KPIs:  

### Key Features:
- **Filters**: City Tier, Gender, Tenure, Account Segment, Payment Method  
- **KPIs & Visuals**:
  - Churn rate by customer segment  
  - Revenue lost vs retained due to churn  
  - Churn by payment method, marital status, and tenure  
  - Segment-wise churn heatmaps  

### Dashboard Preview:
![Dashboard Screenshot](dashboard.png)  

*(If GitHub doesn’t render, download `LoyaltyVisionDashboard.pbix` to explore the interactive dashboard.)*  

---

## 🔑 Insights
- Certain **City Tiers and Segments** show the highest churn rates.  
- **Payment method** choice strongly influences churn probability.  
- Customers with **shorter tenure and negative revenue growth** are most at risk.  
- A significant percentage of **monthly revenue is lost due to churn**, highlighting retention importance.  

---

## 📂 Repository Structure
├── telecom_analysis.sql # SQL queries & analysis
├── LoyaltyVisionDashboard.pbix # Power BI dashboard
├── dashboard.png # Screenshot of dashboard
└── README.md # Project documentation


---

## 🚀 How to Use
1. Run `telecom_analysis.sql` in MySQL Workbench (or any SQL environment) after loading the `telecom` dataset.  
2. Open `LoyaltyVisionDashboard.pbix` in Power BI Desktop to explore the dashboard.  

---

## 📬 Contact
👩‍💻 **Poornima Gowda**  
📧 poornimagowda6464@gmail.com  
🔗 https://www.linkedin.com/in/contact-poornima


