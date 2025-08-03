# SQL Data Analysis Project 📊

A comprehensive SQL-based data warehouse analytics project that demonstrates advanced data analysis techniques using Microsoft SQL Server. This project showcases data warehouse design, ETL processes, and various analytical queries for business intelligence.

## 🎯 Project Overview

This project implements a complete data warehouse solution with the `DataWarehouseAnalytics` database, featuring dimensional modeling and comprehensive analytical queries. The project covers multiple aspects of data analysis including exploratory data analysis, magnitude analysis, ranking, temporal analysis, and performance metrics.

## 🏗️ Architecture

The project follows a structured approach with:
- **Data Warehouse**: `DataWarehouseAnalytics` database with dimensional schema
- **Gold Layer**: Clean, business-ready data stored in the `gold` schema
- **Analytical Scripts**: Modular SQL scripts for different types of analysis

## 📁 Project Structure

```
├── datasets/
│   ├── csv-files/           # Source CSV data files
│   ├── DataWarehouseAnalytics.bak  # Database backup file
│   └── placeholder
├── docs/
│   └── placeholder          # Documentation files
├── scripts/
│   ├── 00_init_database.sql        # Database initialization
│   ├── 01_data_exploration.sql     # Initial data exploration
│   ├── 02_dimensions_exploration.sql   # Dimension table analysis
│   ├── 03_date_range_exploration.sql   # Date range analysis
│   ├── 04_measures_exploration.sql     # Measures and metrics
│   ├── 05_magnitude_analysis.sql       # Volume and scale analysis
│   ├── 06_ranking_analysis.sql         # Ranking and top performers
│   ├── 07_change_over_time_analysis.sql # Temporal trend analysis
│   ├── 08_cumulative_analysis.sql      # Cumulative metrics
│   ├── 09_performance_analysis.sql     # Performance indicators
│   ├── 10_part_to_whole.sql           # Composition analysis
│   └── 11_data_segmentation.sql       # Customer/product segmentation
├── LICENSE
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- Microsoft SQL Server (2016 or later)
- SQL Server Management Studio (SSMS) or Azure Data Studio
- Appropriate permissions to create databases

### Installation & Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/FabulousDartier/sql-data-analysis-project.git
   cd sql-data-analysis-project
   ```

2. **Initialize the Database**
   ```sql
   -- Run the initialization script
   -- Execute: scripts/00_init_database.sql
   ```
   ⚠️ **Warning**: This script will drop and recreate the `DataWarehouseAnalytics` database if it exists.

3. **Load Sample Data**
   - Restore from backup: Use `datasets/DataWarehouseAnalytics.bak`
   - Or import CSV files from `datasets/csv-files/`

## 📊 Analysis Modules

### 1. Data Exploration (`01_data_exploration.sql`)
- Database schema inspection
- Table and column metadata analysis
- Data quality assessment

### 2. Dimensional Analysis (`02_dimensions_exploration.sql`)
- Customer dimension exploration
- Product dimension analysis
- Geographic distribution

### 3. Temporal Analysis (`03_date_range_exploration.sql`)
- Date range identification
- Seasonal pattern analysis
- Time-based filtering

### 4. Measures & Metrics (`04_measures_exploration.sql`)
- Key performance indicators
- Business metrics calculation
- Aggregation functions

### 5. Magnitude Analysis (`05_magnitude_analysis.sql`)
- Volume analysis by different dimensions
- Customer distribution by country and gender
- Product performance quantification

### 6. Ranking Analysis (`06_ranking_analysis.sql`)
- Top performing products/customers
- Market share analysis
- Performance rankings

### 7. Change Over Time (`07_change_over_time_analysis.sql`)
- Trend analysis
- Year-over-year comparisons
- Growth rate calculations

### 8. Cumulative Analysis (`08_cumulative_analysis.sql`)
- Running totals
- Cumulative metrics
- Progressive calculations

### 9. Performance Analysis (`09_performance_analysis.sql`)
- Performance indicators
- Efficiency metrics
- Benchmark comparisons

### 10. Part-to-Whole Analysis (`10_part_to_whole.sql`)
- Market composition
- Percentage contributions
- Share analysis

### 11. Data Segmentation (`11_data_segmentation.sql`)
- Customer segmentation
- Product categorization
- Market segmentation

## 🔧 Key Features

- **Dimensional Modeling**: Star schema implementation with fact and dimension tables
- **Comprehensive Analysis**: 11 different types of analytical queries
- **Modular Design**: Each analysis type in separate, well-documented scripts
- **Business Intelligence**: Real-world business scenarios and KPIs
- **Performance Optimized**: Efficient SQL queries with proper indexing considerations

## 💡 SQL Techniques Demonstrated

- **Aggregate Functions**: SUM(), COUNT(), AVG(), MIN(), MAX()
- **Window Functions**: ROW_NUMBER(), RANK(), DENSE_RANK()
- **CTEs**: Common Table Expressions for complex queries
- **Joins**: INNER, LEFT, RIGHT joins across dimension and fact tables
- **Temporal Functions**: Date/time manipulation and analysis
- **Analytical Functions**: Percentile, running totals, moving averages

## 📈 Business Use Cases

- **Sales Performance Analysis**: Track sales trends and performance metrics
- **Customer Analytics**: Understand customer behavior and segmentation
- **Product Analysis**: Analyze product performance and popularity
- **Geographic Analysis**: Regional performance and market penetration
- **Temporal Analysis**: Seasonal trends and time-based patterns

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**FabulousDartier**
- GitHub: [@FabulousDartier](https://github.com/FabulousDartier)

## 🙏 Acknowledgments

- Microsoft SQL Server documentation and best practices
- Data warehouse design principles
- Business intelligence community resources

---

⭐ **Star this repository if you found it helpful!**
