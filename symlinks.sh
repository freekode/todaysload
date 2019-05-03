echo "remove symlinks"
find . -type l -exec rm -f {} \;

echo "create symlinks"
ln -Ffs ../app/resources ./test/resources
ln -Ffs ../app/source ./test/source

ln -Ffs ../app/barrels.jungle ./test/barrels.jungle
ln -Ffs ../app/manifest.xml ./test/manifest.xml
ln -Ffs ../app/monkey.jungle ./test/monkey.jungle
