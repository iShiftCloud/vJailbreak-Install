echo "*******Setting up git*****"
git config --global user.email "gurribindra@gmail.com"
git config --global user.name "Gurvinder Singh Bindra"
git config --global credential.helper store
export git_user=gurribindra


echo "*******Setting up jq*****"
sudo apt-get -y update
sudo apt-get -y install jq


echo "*******Setting up VMware-vix-disklib*****" 
library_file=$(ls ~/VMw*)
cp ~/vjb_setup/$library_file  ~/.
DIRECTORY="~/vmware-vix-disklib-distrib"
if [ -d "$DIRECTORY" ]; then
  echo "$DIRECTORY has been created."
  tar -xvzf ~/$library_file $DIRECTORY
fi
