from PIL import Image
import pandas as pd
df = pd.read_csv(r"/home/hadoop/raw_data/boneage-training-dataset.csv")

for i in df.id:
    s_path="//home//hadoop//raw_data//boneage-training-dataset//boneage-training-dataset//"+str(i)+'.png'
    d_path="//home//hadoop//clean_data//boneage-training-dataset//"+str(i)+'.jpg'
    im = Image.open(s_path)
    im.save(d_path)

df = pd.read_csv(r"/home/hadoop/raw_data/boneage-test-dataset.csv")
for i in df['Case ID']:
    s_path="//home//hadoop//raw_data//boneage-test-dataset//boneage-test-dataset//"+str(i)+'.png'
    d_path="//home//hadoop//clean_data//boneage-test-dataset//"+str(i)+'.jpg'
    im = Image.open(s_path)
    im.save(d_path)
