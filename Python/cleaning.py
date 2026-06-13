
import pandas as pd


# Load dataset
def clean_churn(input_path="Churn_Modelling.csv", output_path="churn_clean.csv"):
	df = pd.read_csv(input_path)

	# Dataset Information
	print("Dataset Shape:")
	print(df.shape)

	print("\nColumn Names:")
	print(df.columns)

	print("\nMissing Values:")
	print(df.isnull().sum())

	print("\nDuplicate Rows:")
	print(df.duplicated().sum())

	# Remove unnecessary columns
	df = df.drop(columns=["RowNumber", "CustomerId", "Surname"])

	# Create Age Group
	df["AgeGroup"] = pd.cut(
		df["Age"],
		bins=[0, 30, 50, 100],
		labels=["Under 30", "30-50", "50+"]
	)

	# Create Balance Segment
	df["BalanceSegment"] = pd.cut(
		df["Balance"],
		bins=[-1, 0, 50000, 100000, 250000],
		labels=["Zero Balance", "Low Balance", "Medium Balance", "High Balance"]
	)

	# Save cleaned dataset
	df.to_csv(output_path, index=False)

	print("\nCleaning Completed Successfully!")


if __name__ == "__main__":
	clean_churn()
