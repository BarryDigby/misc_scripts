Note to self::::

When creating docker containers in development phase the fastest way to achieve this is to:

docker build ./ (Dockerfile must be in directory)

docker create -t -i latest bash (returns hash to stdout)

docker start -t -a ${hash_given_above}

This bypasses the need to push to docker hub. 

Images are stored under /var/lib/docker/image/overlay2/imagedb/content/sha256/ i think, must sudo chmod -R 777 the dirs to access
