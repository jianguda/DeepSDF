# running OS: Debian 9 (Google Cloud Platform)

```
sudo apt install cmake
```

```
# include CLI11
git clone https://github.com/CLIUtils/CLI11.git
cd CLI11
git submodule update --init
mkdir build && cd build
cmake ..
sudo make install
cd ~
```

```
# install Eigen3
sudo apt install mercurial
hg clone https://bitbucket.org/eigen/eigen/
# git clone https://github.com/eigenteam/eigen-git-mirror.git
mkdir eigen/build && cd eigen/build
cmake ..
sudo make install
cd ~
```

```
# install nanoflann
git clone https://github.com/jlblancoc/nanoflann.git
mkdir nanoflann/build && cd nanoflann/build
cmake ..
sudo make install
cd ~
```

```
# install mpark/variant
git clone https://github.com/mpark/variant.git
mkdir variant/build && cd variant/build
cmake ..
sudo make install
```

```
# build & install Pangolin
sudo apt install libgl1-mesa-dev libeigen3-dev libglew-dev libwayland-dev libxkbcommon-dev wayland-protocols libegl1-mesa-dev
# sudo apt install libgl1-mesa-dev libglu1-mesa-dev libglew-dev libgles2-mesa-dev
# sudo apt install pkg-config libegl1-mesa-dev libwayland-dev libxkbcommon-dev wayland-protocols
git clone https://github.com/stevenlovegrove/Pangolin.git
cd Pangolin
git submodule update --init
mkdir build && cd build
cmake ..
# update the symbolic link
sudo rm /usr/lib/x86_64-linux-gnu/libGL.so
sudo ln -s /usr/lib/libGL.so.1 /usr/lib/x86_64-linux-gnu/libGL.so
sudo rm /usr/lib/x86_64-linux-gnu/libEGL.so
sudo ln -s /usr/lib/x86_64-linux-gnu/libEGL.so.1 /usr/lib/x86_64-linux-gnu/libEGL.so
# cmake --build .
sudo make install
cd ~
```

```
# build DeepSDF
git clone https://github.com/jianguda/DeepSDF.git
cd ~/DeepSDF
git submodule update --init
mkdir build && cd build
cmake -D CMAKE_PREFIX_PATH=~ ..
make -j
cd ~

# optional config
export PANGOLIN_WINDOW_URI=headless://

# check build output
ls ~/DeepSDF/bin
# there should be two executables, one for surface sampling and one for SDF sampling
# with the binaries, the data-set can be preprocessed using `preprocess_data.py`
```

```
# download dataset
wget http://shapenet.cs.stanford.edu/shapenet/obj-zip/ShapeNetCore.v2.zip
unzip ShapeNetCore.v2.zip
```

```
# install dependencies ...
pip3 install torch trimesh numpy scipy scikit-image plyfile

# run demo (use python3 instead of python)
# refer to https://github.com/jianguda/DeepSDF#examples

# navigate to the DeepSdf root directory
cd ~/DeepSDF

# create a home for the data
mkdir data

# pre-process the sofas training set (SDF samples)
python3 preprocess_data.py --data_dir data --source ~/ShapeNetCore.v2/ --name ShapeNetV2 --split examples/splits/sv2_sofas_train.json --skip

# train the model
python3 train_deep_sdf.py -e examples/sofas

# pre-process the sofa test set (SDF samples)
python3 preprocess_data.py --data_dir data --source ~/ShapeNetCore.v2/ --name ShapeNetV2 --split examples/splits/sv2_sofas_test.json --test --skip

# pre-process the sofa test set (surface samples)
python3 preprocess_data.py --data_dir data --source ~/ShapeNetCore.v2/ --name ShapeNetV2 --split examples/splits/sv2_sofas_test.json --surface --skip

# reconstruct meshes from the sofa test split (after 2000 epochs)
python3 reconstruct.py -e examples/sofas -c 2000 --split examples/splits/sv2_sofas_test.json -d data --skip

# evaluate the reconstructions
python3 evaluate.py -e examples/sofas -c 2000 -d data -s examples/splits/sv2_sofas_test.json
```
