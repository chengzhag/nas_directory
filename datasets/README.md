# 公共数据集

NAS:/Public/datasets 文件夹用于存储公共数据集（网上发布的公开数据集），只读。将数据集提交到 NAS:/datasets 可以节省 home 文件夹的配额。

所有用户都可以通过以下方式提交自己下载的数据集：
1. 下载数据集到个人 home 文件夹
1. 将数据集解压到个人 home 文件夹任意位置，以数据集名称命名，命名应不包含空格，空格以 '_' 替代
1. 将 [nas_directory](https://github.com/pidan1231239/nas_directory) 仓库 fork 到自己的 github 并克隆到个人电脑，编辑 datasets/README.md，按格式添加数据集的信息
1. 完善 commit 信息（添加公共数据集 {dataset_name}）并 commit，然后 Push 到 fork 的 github 仓库
1. 向原仓库的 master 分支发起 pull request，填写 issue：
    - 标题（title）：添加公共数据集 {dataset_name}
    - 描述（description）：数据集所在路径（如 homes/{user_name}/datasets/{dataset_name}）
    - 标签（labels）选择：dataset
1. 交由 managers（管理员请参考[公共数据集入库说明](README_managers.md)）进行 merge 并将数据集入库到 NAS:/Public/datasets
1. managers 工作结束后，用户检查提交的数据集是否正确拷贝到 NAS:/Public/datasets，README 是否正确更新，如果一切顺利，便可删除自己家目录的对应数据集

## 模板：CIFAR-10
- 主页：[The CIFAR-10 dataset](https://www.cs.toronto.edu/~kriz/cifar.html)
- 关键词：图像分类，image classification
- 引用：[Learning Multiple Layers of Features from Tiny Images](https://www.cs.toronto.edu/~kriz/learning-features-2009-TR.pdf), Alex Krizhevsky, 2009.
- 相关链接：
    - [What is the class of this image ?](http://rodrigob.github.io/are_we_there_yet/build/classification_datasets_results.html): Rodrigo Benenson has been kind enough to collect results on CIFAR-10/100 and other datasets on his website
    - [TensorFlow学习笔记（十）： CIFAR-10](https://blog.csdn.net/zeuseign/article/details/72773342)
    - [CIFAR-10 dataset 的下载与使用](https://www.cnblogs.com/irran/p/cifar-10.html)
- 说明：The CIFAR-10 dataset consists of 60000 32x32 colour images in 10 classes, with 6000 images per class. There are 50000 training images and 10000 test images.
- 目录：cifar-10
    - cifar-10-batches-py: [CIFAR-10 python version](https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz)
    - cifar-10-batches-mat: [CIFAR-10 Matlab version](https://www.cs.toronto.edu/~kriz/cifar.html)
    - cifar-10-batches-bin: [CIFAR-10 binary version (suitable for C programs)](https://www.cs.toronto.edu/~kriz/cifar.html)
- 上传者：章程

## HDR+
- 主页：[The HDR+ dataset](https://hdrplusdata.org/)
- 关键词：图像去噪，HDR，image denoising
- 引用：[Hasinoff, Samuel W., et al. "Burst photography for high dynamic range and low-light imaging on mobile cameras." ACM Transactions on Graphics (TOG) 35.6 (2016): 192.](http://delivery.acm.org/10.1145/2990000/2980254/a192-hasinoff.pdf?ip=117.148.168.151&id=2980254&acc=OA&key=4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E5945DC2EABF3343C&__acm__=1575892201_3f53a4f48b4636fd92d7dbc18fdbd7cf)
- 相关链接：
    - [数据集主页](https://hdrplusdata.org/dataset.html): 有关如何引用数据集的信息，请参阅详细说明
    - [机器感知Google 推出 HDR+ 连拍摄影数据集](https://zhuanlan.zhihu.com/p/34391353)
- 说明：The dataset consists of 3640 bursts (made up of 28461 images in total), organized into subfolders, plus the results of our image processing pipeline. Each burst consists of the raw burst input (in DNG format) and certain metadata not present in the images, as sidecar files. For results, we provide both the intermediate result of aligning and merging the frames (also in DNG format), and the final result of our pipeline (as a JPG).
- 目录：hdrplus/20171106_subset
- 上传者：陈才

## Scene Flow
- 主页：[Scene Flow Datasets: FlyingThings3D, Driving, Monkaa](https://lmb.informatik.uni-freiburg.de/resources/datasets/SceneFlowDatasets.en.html)
- 关键词：深度估计，双目，光流，语义分割，视差，depth estimation, stereo, optical flow, segmentation, disparity
- 引用：[A Large Dataset to Train Convolutional Networks for Disparity, Optical Flow, and Scene Flow Estimation](https://lmb.informatik.uni-freiburg.de/Publications/2016/MIFDB16/)
- 相关链接：[Scene Flow Datasets数据集： FlyingThings3D, Driving, Monkaa](https://www.twblogs.net/a/5d0a47a3bd9eee1e5c815446/zh-cn)
- 说明：The collection contains more than 39000 stereo frames in 960x540 pixel resolution, rendered from various synthetic sequences. For details on the characteristics and differences of the three subsets, we refer the reader to our paper. The following kinds of data are currently available.
- 目录：sceneflow
    - Sampler: [Sample pack](https://lmb.informatik.uni-freiburg.de/resources/datasets/SceneFlow/assets/Sampler.tar.gz)
    - flyingthings3d__frames_cleanpass: [FlyingThings3D RGB images (cleanpass)](https://lmb.informatik.uni-freiburg.de/data/SceneFlowDatasets_CVPR16/Release_april16/data/FlyingThings3D/raw_data/flyingthings3d__frames_cleanpass.tar.torrent)
    - flyingthings3d__frames_finalpass: [FlyingThings3D RGB images (finalpass)](https://lmb.informatik.uni-freiburg.de/data/SceneFlowDatasets_CVPR16/Release_april16/data/FlyingThings3D/raw_data/flyingthings3d__frames_finalpass.tar.torrent)
    - flyingthings3d__disparity: [FlyingThings3D Disparity](https://lmb.informatik.uni-freiburg.de/data/SceneFlowDatasets_CVPR16/Release_april16/data/FlyingThings3D/derived_data/flyingthings3d__disparity.tar.bz2.torrent)
    - driving__frames_cleanpass: [Driving RGB images (cleanpass)](https://lmb.informatik.uni-freiburg.de/data/SceneFlowDatasets_CVPR16/Release_april16/data/Driving/raw_data/driving__frames_cleanpass.tar.torrent)
    - driving__frames_finalpass: [Driving RGB images (finalpass)](https://lmb.informatik.uni-freiburg.de/data/SceneFlowDatasets_CVPR16/Release_april16/data/Driving/raw_data/driving__frames_finalpass.tar.torrent)
    - driving__disparity: [Driving Disparity](https://lmb.informatik.uni-freiburg.de/data/SceneFlowDatasets_CVPR16/Release_april16/data/Driving/derived_data/driving__disparity.tar.bz2.torrent)
    - monkaa__frames_cleanpass: [Monkaa RGB images (cleanpass)](https://lmb.informatik.uni-freiburg.de/data/SceneFlowDatasets_CVPR16/Release_april16/data/Monkaa/raw_data/monkaa__frames_cleanpass.tar)
    - monkaa__final_cleanpass: [Monkaa RGB images (finalpass)](https://lmb.informatik.uni-freiburg.de/data/SceneFlowDatasets_CVPR16/Release_april16/data/Monkaa/raw_data/monkaa__frames_finalpass.tar)
    - monkaa__disparity: [Monkaa Disparity](https://lmb.informatik.uni-freiburg.de/data/SceneFlowDatasets_CVPR16/Release_april16/data/Monkaa/derived_data/monkaa__disparity.tar.bz2)
- 上传者：章程

## MIT Adobe5K
- 主页：[The FiveK dataset](https://data.csail.mit.edu/graphics/fivek/)
- 关键词：图像增强，HDR，image enhancement
- 引用：[Bychkovsky, Vladimir, et al. "Learning photographic global tonal adjustment with a database of input/output image pairs." CVPR 2011. IEEE, 2011.](https://ieeexplore.ieee.org/abstract/document/5995413/)
- 相关链接：
    - [数据集主页](https://data.csail.mit.edu/graphics/fivek/): 有关如何引用数据集的信息，请参阅详细说明
    - [机器感知Google 推出 HDR+ 连拍摄影数据集](https://zhuanlan.zhihu.com/p/34391353)
- 说明：We collected 5,000 photographs taken with SLR cameras by a set of different photographers. They are all in RAW format; that is, all the information recorded by the camera sensor is preserved. We made sure that these photographs cover a broad range of scenes, subjects, and lighting conditions. We then hired five photography students in an art school to adjust the tone of the photos. Each of them retouched all the 5,000 photos using a software dedicated to photo adjustment (Adobe Lightroom) on which they were extensively trained. We asked the retouchers to achieve visually pleasing renditions, akin to a postcard. The retouchers were compensated for their work.
- 目录：adobe5k
    - raw_photos/HQ1to5000: 5000 .dng RAW image files.
    - fivek_c: 5000 .tif RGB images well-touched by Expert C.  
- 上传者：陈才

## ShapeNet
- 主页：[ShapeNet](https://www.shapenet.org/)
- 关键词：3D semantic/instance segmentation，3D representation, 3D scene understanding, 3D scene parsing
- 引用：[ShapeNet: An Information-Rich 3D Model Repository](https://arxiv.org/pdf/1512.03012)
- 相关链接：
    - [点云深度学习之数据集处理（二）ShapeNet简介及认识](https://blog.csdn.net/SGL_LGS/article/details/105897585)
    - [下载页面](https://www.shapenet.org/account)：注册后下载数据、查看各子数据集说明
- 说明：
    - What is ShapeNet?
        - ShapeNet is an ongoing effort to establish a richly-annotated, large-scale dataset of 3D shapes.
        - We provide researchers around the world with this data to enable research in computer graphics, computer vision, robotics, and other related disciplines. ShapeNet is a collaborative effort between researchers at Princeton, Stanford and TTIC.
        ShapeNet is organized according to the WordNet hierarchy.
        - Each meaningful concept in WordNet, possibly described by multiple words or word phrases, is called a "synonym set" or "synset". There are more than 100,000 synsets in WordNet, the majority of them being nouns (80,000+)
    - ShapeNet is made of several different subsets:
        - ShapeNetCore
            - ShapeNetCore is a subset of the full ShapeNet dataset with single clean 3D models and manually verified category
            - and alignment annotations. It covers 55 common object categories with about 51,300 unique 3D models. The 12 object categories of PASCAL 3D+, a popular computer vision 3D benchmark dataset, are all covered by ShapeNetCore.
        - ShapeNetSem
            - ShapeNetSem is a smaller, more densely annotated subset consisting of 12,000 models spread over a broader set of
            - 270 categories. In addition to manually verified category labels and consistent alignments, these models are annotated with real-world dimensions, estimates of their material composition at the category level, and estimates of their total volume and weight.
- 目录：ShapeNet
    - ShapeNetCore.v1: [Archive of ShapeNetCore v1 release](http://shapenet.cs.stanford.edu/shapenet/obj-zip/ShapeNetCore.v1.zip) (ShapeNetCore.v1.zip ~25GB), [README.txt](https://shapenet.cs.stanford.edu/shapenet/obj-zip/ShapeNetCore.v1/README.txt)
    - ShapeNetCore.v2（未解压）: [Archive of ShapeNetCore v2 release](http://shapenet.cs.stanford.edu/shapenet/obj-zip/ShapeNetCore.v2.zip) (ShapeNetCore.v2.zip ~30.3GB), [README.txt](https://www.shapenet.org/resources/releases/shapenetcorev2/README.txt)
    - all.csv: [Training, validation and test splits for SHREC16 amd SHREC17 in CSV format](http://shapenet.cs.stanford.edu/shapenet/obj-zip/SHREC16/all.csv)
- 上传者：章程

## RealSR
- 主页：[Toward Real-World Single Image Super-Resolution (RealSR)](https://github.com/csjcai/RealSR)
- 关键词：图像超分辨，real-world super-resolution，Real RGB and RAW dataset
- 引用：[Toward Real-World Single Image Super-Resolution (RealSR)](https://csjcai.github.io/papers/RealSR.pdf)

- 说明：
    -Captured device: (Canon 5D3 and Nikon D810) + (24∼105mm, f/4.0 zoom lens)；
    -559 scenes (459 scenes for training & 100 scenes for testing)
    -To build a dataset for learning and evaluating real-world SISR models, we propose to collect images of the same scene by adjusting the lens of DSLR cameras. Sophisticated image registration operations are then performed to generate the HR and LR pairs of the same content. 
- 目录：RealSR_RAW
- 上传者：杨裕强

