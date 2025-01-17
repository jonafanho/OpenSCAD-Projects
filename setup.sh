mkdir temp
curl -Lo temp/download_openscad.sh "https://raw.githubusercontent.com/jonafanho/Common-Utilities/refs/heads/master/script/download_openscad.sh"
cd temp
./download_openscad.sh
rm -r ../temp
