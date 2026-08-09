
sudo apt-get update
sudo apt-get install -y curl cpio rpm

# Install Apptainer
curl -s https://raw.githubusercontent.com/apptainer/apptainer/main/tools/install-unprivileged.sh | \
    bash -s - install-dir

# create a runner user
adduser --home /home/runner --gecos "" --shell /bin/bash --disabled-password runner

# pull the pytorch_for_rl image
./install-dir/bin/apptainer build pytorch_for_rl.sif docker://esppk/pytorch_for_rl:latest

# run script with docker images
sudo -u runner ./install-dir/bin/apptainer exec --bind /content:/mnt/data --nv pytorch_for_rl.sif python /mnt/data/YS-on-RL/run.py

