# Create a README.md file with the content just crafted

readme_content = """
# 🧠 SQL-Based Exploratory Data Analysis Framework

This repository presents a structured suite of SQL scripts developed to perform comprehensive Exploratory Data Analysis (EDA) on a data warehouse. Each script is purpose-built to examine specific dimensions of data, ranging from schema discovery to detailed performance ranking. This suite reflects proficiency in SQL and demonstrates best practices for deriving business insights from relational databases.

## 📁 Repository Structure

The analytical workflow is organized into the following key components:

### 1. `01_Database_Exploration.sql`
- Discovers database metadata using `INFORMATION_SCHEMA`.
- Retrieves table structures, column details, and associated data types.
- Ideal for initial environment familiarization and schema auditing.

### 2. `02_Dimensions_Exploration.sql`
- Analyzes categorical attributes in dimension tables.
- Identifies distinct values for customer geographies and product hierarchies.
- Supports downstream segmentation and filtering logic.

### 3. `03_Date_Range_Exploration.sql`
- Evaluates the temporal scope of transactional and customer data.
- Calculates time ranges in years and months, and determines customer age distribution.
- Enables understanding of dataset longevity and customer demographics.

### 4. `04_Measures_Exploration.sql`
- Computes core business metrics such as total sales, average price, and unique customer counts.
- Offers a consolidated view of high-level key performance indicators (KPIs).
- Useful for executive summaries and baseline performance evaluations.

### 5. `05_Magnitude_Analysis.sql`
- Performs grouped aggregations across dimensions (e.g., country, category, gender).
- Assesses distribution and volume metrics like product count and revenue generation.
- Informs strategic prioritization and resource allocation.

### 6. `06_Ranking_Analysis.sql`
- Ranks products, subcategories, and customers based on performance metrics using window functions.
- Identifies top and bottom performers to highlight trends and outliers.
- Suitable for dashboarding, reporting, and targeted analysis.

## 🧠 Technical Capabilities Demonstrated

- Schema exploration via metadata queries
- Multi-table joins and aggregation logic
- Grouped analytical queries
- Use of window functions for ranking and comparative metrics
- Comprehensive summarization using `UNION ALL` constructs

## ⚙️ Usage Guidelines

1. Load the scripts into an SQL execution environment (compatible with SQLite or adaptable to others).
2. Ensure the data schema aligns with the one referenced in the scripts (`gold.fact_sales`, `gold.dim_customers`, etc.).
3. Execute scripts sequentially or selectively, depending on analysis requirements.
4. Modify or extend queries to align with domain-specific business logic.

## 🎓 Objective

This suite is designed to:
- Exhibit proficiency in structured query language for analytical purposes.
- Support data-driven decision-making through reusable, modular SQL components.
- Serve as a reference or starting point for professional SQL analysis in data-intensive environments.

## 📬 Contact

For queries, feedback, or collaboration opportunities, feel free to connect via GitHub Issues or direct message.
"""

readme_path = "/mnt/data/README.md"
Path(readme_path).write_text(readme_content)

readme_path
