# Databricks notebook source
# /// script
# [tool.databricks.environment]
# environment_version = "6"
# ///
import pandas as pd
import numpy as np
Coffee = spark.table("`brightcoffe`.`brightcoff`.`1782394740697_bright_coffee_shop_sales_3`")
coffee = Coffee.toPandas()




# COMMAND ----------

# DBTITLE 1,CHECKING FOR NULL VALUES
coffee.isnull()

# COMMAND ----------

# DBTITLE 1,Checking the column data type
coffee.dtypes

# COMMAND ----------

coffee.astype({"unit_price": float})

# COMMAND ----------

# DBTITLE 1,Calculating the sale price
coffee['Total sale']=coffee['unit_price']*coffee['transaction_qty']
display(coffee['Total sale'])

# COMMAND ----------

# DBTITLE 1,checking store performance
coffee.groupby('store_location')['Total sale'].sum()

# COMMAND ----------

# DBTITLE 1,checking product category performance
coffee.groupby('product_category')['Total sale'].sum()

# COMMAND ----------

# DBTITLE 1,checking product type
coffee.groupby('product_type')['Total sale'].sum()

# COMMAND ----------

# DBTITLE 1,which month performed the most??
coffee['transaction_date']
