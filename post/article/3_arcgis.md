---
title: "[Python] arcgis REST apiを用いて、高解像度の背景地図を20通り描画する。"
date: 2020-07-12T13:46:39+09:00
tags: ["python", "matplotlib", "basemap","arcgis"]
draft: false
---

# 今回のテーマ
* arcgis REST api serviceを用いて20種類の背景地図を描画する

高解像度で描画できて色々と便利なarcgisの画像のプロットですが、[MatplotlibのBasemap Tutorial] (https://basemaptutorial.readthedocs.io/en/latest/backgrounds.html)では2種類ほどしか紹介されていないので、メモがてらまとめてみました。




### 準備
* まずは、basemapをインストールしておきます。
Anaconda経由は以下の通り。
```bash
conda install -c anaconda basemap
```

* Windows10の場合、このままbasemapのモジュールを読み込もうとすると、"PROJ_LIB"でエラーが出ました。
多くのサイトでは、以下のように環境変数を明記するように勧められていますが、今回arcgis REST apiを用いた
背景地図ではうまく描画できませんでした。

```python
import os
os.environ['PROJ_LIB'] = "C:/Users/"Username"/Anaconda3/Library/share"
```

* その代わりにproj4をインストールするとうまくいきます。

```bash
conda install -c conda-forge proj4
```

準備はこれで完了で、次から実際に描画していきます。


## 実際の描画
```python
from mpl_toolkits.basemap import Basemap
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns


sns.set(style='ticks', font_scale=1.2)

lonmin = 138.
lonmax = 141.
latmin = 34.
latmax = 37.


map_list = ['World_Shaded_Relief',          # 0
    'World_Terrain_Base',                   # 1
    'Elevation/World_Hillshade',            # 2
    'Elevation/World_Hillshade_Dark',       # 3
    'NGS_Topo_US_2D',                       # 4
    'USA_Topo_Maps',                        # 5
    'World_Physical_Map',                   # 6
    'Ocean/World_Ocean_Base',               # 7
    'ESRI_Imagery_World_2D',                # 8
    'World_Imagery',                        # 9
    'World_Topo_Map',                       # 10
    'World_Street_Map',                     # 11
    'ESRI_StreetMap_World_2D',              # 12
    'NatGeo_World_Map',                     # 13
    'Specialty/DeLorme_World_Base_Map',     # 14
    'Specialty/World_Navigation_Charts',    # 15
    'Canvas/World_Light_Gray_Base',         # 16
    'Canvas/World_Dark_Gray_Base',          # 17
    'Reference/World_Transportation',       # 18
    'Reference/World_Reference_Overlay'     # 19
]

def draw_arcgisimage(map, map_list, resolution):
    map.arcgisimage(server="http://server.arcgisonline.com/ArcGIS",
                service=map_list, xpixels = resolution, verbose= False)


fig, axes = plt.subplots(10, 2,figsize=(16,80))
ax = axes.flat

for i in range(len(map_list)):
    ax[i].set_title(map_list[i])
    map = Basemap(resolution='i',projection='cyl',
              llcrnrlon=lonmin,llcrnrlat=latmin,urcrnrlon=lonmax,urcrnrlat=latmax,ax=ax[i])
    if (i == 7 or 13):
        resolution = 600
    else:
        resolution = 1500
    draw_arcgisimage(map, map_list[i], resolution)

plt.show()
fig.savefig("arcgisimage.png")
```

### 出力結果
![出力結果](/blog/image/3_arcgisimage.png)


## コードの解説（一部）
まず始めに、今回使用しているモジュールは以下の通り。

1. matplotlibのbasemap: 今回のメインとなる地図を描画するモジュール
2. matplotlib: 図を描画するために使用
3. numpy: 数値データを格納するために使用
4. seaborn: 図の見た目を良くするために使用（なくても大丈夫です）

```python
from mpl_toolkits.basemap import Basemap
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
```

* 今回は関東地方を例に地図を描画しています。
緯度経度の範囲は、東経138 - 141度、北緯34 - 37度

```python
lonmin = 138.
lonmax = 141.
latmin = 34.
latmax = 37.
```

### 今回使用する衛星画像の一覧をリストにまとめておきます。

```python
map_list = ['World_Shaded_Relief',          # 0
    'World_Terrain_Base',                   # 1
    'Elevation/World_Hillshade',            # 2
    'Elevation/World_Hillshade_Dark',       # 3
    'NGS_Topo_US_2D',                       # 4
    'USA_Topo_Maps',                        # 5
    'World_Physical_Map',                   # 6
    'Ocean/World_Ocean_Base',               # 7
    'ESRI_Imagery_World_2D',                # 8
    'World_Imagery',                        # 9
    'World_Topo_Map',                       # 10
    'World_Street_Map',                     # 11
    'ESRI_StreetMap_World_2D',              # 12
    'NatGeo_World_Map',                     # 13
    'Specialty/DeLorme_World_Base_Map',     # 14
    'Specialty/World_Navigation_Charts',    # 15
    'Canvas/World_Light_Gray_Base',         # 16
    'Canvas/World_Dark_Gray_Base',          # 17
    'Reference/World_Transportation',       # 18
    'Reference/World_Reference_Overlay'     # 19
]
```


* Basemapで地図の解像度（intermediate）・図法(正距円筒図法)・上記で指定した範囲を設定します。

```python
map = Basemap(resolution='i',projection='cyl',
              llcrnrlon=lonmin,llcrnrlat=latmin,urcrnrlon=lonmax,urcrnrlat=latmax)
```

ここで、実際に描画したいarcgis imageを指定しています。
* xpixels（resolution）を用いて、解像度を変更可能
* verboseはTrueで背景地図取得のURLが表示

```python
def draw_arcgisimage(map, map_list, resolution):
    map.arcgisimage(server="http://server.arcgisonline.com/ArcGIS",
                service=map_list, xpixels = resolution, verbose= False)
```


## おわりに
今回、arcgis REST apiを用いて、高解像度の背景地図を20通り描画してみました。
ちょこちょこ使用できる種類も変更されているので、また時間があるときに新しい種類をご紹介できればと思います。
