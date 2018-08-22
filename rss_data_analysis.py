import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

sns.set(style="ticks", palette="muted")

# Load data gathered from random state search
rss_data = pd.read_csv("data/rss_output.csv")

# Create a regplot
sns.relplot(x="Games played", y="States found", data=rss_data)

# Show plot
plt.show()
