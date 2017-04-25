import numpy as np
import pandas as pd
import glob
import os

files = glob.glob("../data_test/data*.xlsx")
#files = os.listdir("../data_test/")
all_data = pd.DataFrame()
for f in files:
	df = pd.read_excel(f)
	all_data = all_data.append(df, ignore_index = True)


print(all_data)
all_data2 = all_data.fillna(".")
print(all_data2)
print("Saving...")
all_data2.to_csv("../data_test/output.csv", index = False)
print("Saved!")
