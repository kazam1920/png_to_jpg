#!/bin/bash
cd /home/hadoop/

# downloading kaggle.json from s3 
aws s3 cp s3://bootstrap-and-emr-step-demo/kaggle.json /home/hadoop/kaggle.json

#configuring kaggle for downloading dataset 
mkdir /home/hadoop/.kaggle
sudo cp /home/hadoop/kaggle.json /home/hadoop/.kaggle/

# cloning repo 
git clone -b master https://github.com/kazam1920/png_to_jpg.git /home/hadoop/png_to_jpg

# downloading dataset from kaggle
~/.local/bin/kaggle datasets download kmader/rsna-bone-age --path /home/hadoop/raw_data --unzip

# Creating directories for storing processed image 
mkdir /home/hadoop/clean_data
mkdir /home/hadoop/clean_data/boneage-training-dataset
mkdir /home/hadoop/clean_data/boneage-test-dataset
mkdir /home/hadoop/final
sudo cp raw_data/boneage-training-dataset.csv /home/hadoop/clean_data/
sudo cp raw_data/boneage-test-dataset.csv /home/hadoop/clean_data/

# excuting final python script if using emr version < 5.20
#/usr/bin/python3.6 /home/hadoop/png_to_jpg/png_to_jpg.py 

# excuting final python script
python3 /home/hadoop/png_to_jpg/png_to_jpg.py 

# moving processed data to hdfs then to s3 for uploading data in parallel manner
hdfs dfs -put /home/hadoop/clean_data
s3-dist-cp --src /user/hadoop/clean_data --dest s3://bootstrap-and-emr-step-demo/clean_data

# wait for five minute
sleep 300

# Extract cluster-id from job-flow.json
cluster_id=$(cat /mnt/var/lib/info/job-flow.json | jq -r ".jobFlowId")

# Disable termination-protection 
aws emr modify-cluster-attributes --cluster-id ${cluster_id} --no-termination-protected

# terminate cluster 
aws emr terminate-clusters --cluster-ids ${cluster_id}
