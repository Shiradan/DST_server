## 客户端MOD. 自由生成物品. 搜索你想要的物品和控制服务器. 7种不同的物品标签方便使用.

### 关于作者
- 原作者是 C.J.B.
- GaRAnTuLA 修复了 BUG。（不知道是什么 BUG）
- -=+C0leÿO|eyOX3nFrEE+=- 的创意工坊的 DS 版（名字好长）：

  > [DS 版TMI]( http://steamcommunity.com/sharedfiles/filedetails/?id=257781035 )

- Soo 的版本 TMI+ (推荐使用，从我的版本改写的，有更多功能) :

  > [DS version's TMI+]( http://steamcommunity.com/sharedfiles/filedetails/?id=579513934 ) 推荐!

- 我重新写了代码，绕过了客机限制，使其能够正常显示物品图标、加了其他按钮、功能和美化了界面。（接近重写了，原来大部分不能用了）

### 说明
- 只需客户端开启就可以使用，无需服务器开启，开了也没用。
- 如果你是主机或是管理员就可用使用以下功能。

> 怎么成为管理员？

>> - 如果你想要某个朋友成为管理员只需要做以下几步。

>>> 1. 在路径 文档/klei/don't starve together/client_save(主机) 或 cluster.ini同目录(服务器) 下建立 adminlist.txt
>>> 2. 问你的朋友他的ID. 不是STEAM ID而是Klei ID, 让他们在主菜单右下角找到账户按钮，点击后会出现一个有他们ID的页面. 例子: KU_ad39dik.
>>>> - 控制台输入以下命令得到所有人的ID.
 ```
c_listallplayers()
```
>>> 3. 复制 KU_ad39dik 到 adminlist.txt. 重启服务器，就会发现添加 ID 的人已是管理员.

>> - 可以使用Steam管理员组来增删管理员。

>>>编辑 cluster.ini 文件中 [STEAM] 下面的 steam_group_id = ******* and steam_group_admins = true

- 自由生成物品。
- 物品标签为 All 所有, Foods 食物, Resources 资源, Weapons 武器, Tools 工具, Clothes 穿戴, Gifts 礼物 和 Others 其他 .

 > 所有标签 包括 食物, 资源, 武器, 工具, 穿戴, 礼物 标签 的物品.

 > 其他标签是那些不能放进物品栏的东西（包括建筑和生物，所以大部分没图）

 > 游戏里的所有物品不在所有标签里就在其他标签里。（没有找不到的）

- 支持搜索.(仅仅在当前打开的标签里)
- 改变生命, 精神, 饥饿, 湿度, 温度 和 伍迪的木头刻度.
- 改变 季节, 时间, 速度 和 天气.
- 可用上帝模式和创造模式.
- 其他: 杀了自己, 复活自己, 清空背包, 返回选人界面, 召集队友, 重启, 换图, 回滚, 储存, 关掉服务器。

### 警告
- 使用这个将会降低游戏乐趣，请不要肆意使用。
- 建筑标签里有的东西是无用的.(我才不一个一个看呢，以后游戏添加物品或者别的MOD中的物品就会在这里。)
- 建筑标签里有的东西会导致游戏崩溃.(小心使用)

  > 使用虫洞标志标识一个你生成的虫洞.

  > 地图外生成物品.

- 如果游戏崩溃了，先看是不是最新版本.

  > 1. 打开游戏。
  > 2. 点击MODS按钮。
  > 3. 等待检查更新完毕，更新按钮激活。
  > 4. 点击更新按钮。
  > 5. 若实在看不懂，就进游戏目录，在Mods目录删除本MOD（workshop-551338671），进游戏重新下载。

- 确实发现最新版本错误或崩溃，请在讨论区"Bugs? Item MIssing? Come Here!"中发布错误信息，最好加上错误日志。

> 错误日志路径:

>> Windows, Mac: <Documents>\Klei\DoNotstarve\client_log.txt

>>> (C:\Users\[name]\Documents\Klei\DoNotStarveTogether\client_log.txt.)

>> Linux: ~/.klei/DoNotStarve/client_log.txt

- 调试功能是 KLEI 的，如果它不工作了，请告诉我。

### 注意
- 本 MOD 会自动检测是否有权限生成物品，没有的话就不会载入。（不占资源）
- 有物品图标无法显示会显示一个蓝图图标。(洞穴版本显示正常，因为那些是洞穴的物品。)
- 本 MOD 只不过是向所在服务器发送命令而已。
- 没有这个 MOD 你也可以用命令达到相同的作用。它只是一个图形化界面。
- 话说无聊了就别开了。

### 用法
- 按 T 键显示菜单。
- 单击默认生成 1 个物品。
- 右击默认生成 10 个物品。
- 建筑标签的物品只会在身边生成一个。
- 键位设置和生成物品的个数可以在 MOD 选项中更改！

### 更新日志
- 在这里:
  > [更新日志]( http://steamcommunity.com/sharedfiles/filedetails/changelog/551338671 )

### 参考
- 你想搭建一个独立服务器?

  > [独立服务器搭建向导(英文)]( http://forums.kleientertainment.com/forum/83-dont-starve-together-beta-dedicated-server-discussion/ )

- 命令列表

  > [命令列表]( http://dont-starve-game.wikia.com/wiki/Console/Commands )

- 命令列表（DST）

  > [命令列表（DST）]( http://dont-starve-game.wikia.com/wiki/Console/Don%27t_Starve_Together_Commands )

- 物品列表

  > [物品列表 ]( http://dont-starve-game.wikia.com/wiki/Console/Prefab_List )

- 最新可用的命令可以在这里找到：

  > Don't Starve Together\data\scripts\consolecommands.lua

### 关于
- 过来用的来点个赞吧，花了加起来有 30 + 小时了。
- 本文使用了MarkDown格式而没有使用steam的文本格式，如果影响了阅读，请自行使用工具查看。
- 可以转载或者翻译，但请保留作者。
- 有 BUG 请在这里告诉我！
- 有能力的人可以检查一下物品是否齐全，并且在这里反馈缺少的物品名称 (英文).
- 不要加好友，太多了。