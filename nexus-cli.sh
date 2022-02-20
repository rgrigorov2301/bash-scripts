#! /bin/sh
project_name=${1}
project_version=${2}

if [[ $# -eq 0 ]]; then
    echo "No arguments supplied"
    echo "project_name project_version"
    exit 1
fi

# Check if nexus-cli installed
if [ ! -f "/root/nexus-cli" ]; then
    wget https://s3.eu-west-2.amazonaws.com/nexus-cli/1.0.0-beta/linux/nexus-cli -o /root/nexus-cli
    chmod +x /root/nexus-cli
    /root/nexus-cli configure
fi

nexus_cli=$(/root/nexus-cli image tags -name ${project_name} | grep SNAPSHOT-${project_version})
# Delete 
for nexus_artifacts in ${nexus_cli}; do
    echo deleting ... $nexus_artifacts
    /root/nexus-cli image delete -name ${project_name} -tag $nexus_artifacts
done
