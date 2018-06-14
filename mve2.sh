echo "######## Starting reconstruction ########"
cd ~

folder="$(pwd)/reconstruction/$1"

echo "Working folder: $folder"

#mkdir "$folder/mve2"

imgdir="$folder/images"
scenedir="$folder/mve2"

echo "Images folder: $imgdir"
echo "Scene folder: $scenedir"

echo "######## Dataset creation ########"
#~/mve/apps/makescene/makescene -i $imgdir $scenedir

echo "######## Structure from motion ########"
#~/mve/apps/sfmrecon/sfmrecon --no-prediction $scenedir

echo "######## Shading-aware Multi-view Stereo ########"
#~/smvs/app/smvsrecon $scenedir

echo "######## Surface reconstruction ########"
#~/mve/apps/fssrecon/fssrecon "$scenedir/smvs-B0.ply" "$scenedir/smvs-surface.ply"

echo "######## Cleaning mesh ########"
#~/mve/apps/meshclean/meshclean -p10 "$scenedir/smvs-surface.ply" "$scenedir/smvs-clean.ply"

echo "Moving to $folder"
cd $folder

echo "######## 3D Reconstruction Texturing ########"
~/texrecon/build/apps/texrecon/texrecon mve2::undistorted "$scenedir/smvs-clean.ply" $1

