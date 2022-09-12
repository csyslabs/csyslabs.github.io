---
title: 【游戏逆向】How to find entityList in Call of Duty games with IDA tutorial
comments: true
date: 2021-03-31 13:59:39
tags:
    - 游戏逆向
categories:
    - [不亦乐乎]
---
__摘要：__
The title says it all.
<!-- more -->

### Explain 

The traditional method for all CoD games is to load the binary up in IDA and find the __CG_Init__ function. Usually you can search for the string "white", cross reference it, and one of the cross references will be that __CG_Init__ function.

At the tippity-top of this function, you will see some calls to memset

![0x0](0.png)

Here you can find a bunch of different structs, including the __cg_entities__ struct. This struct contains an array of __centity_t__. Not pointers to __centity_t__.
__centity_t__ contains various information about the player including their position. __cg_entities__ is used for both players and bots.

Keep in mind that there are two entity lists. __cgentity_t__ and __ClientInfo_t__. __ClientInfo_t__ is used to get the player name while __cgentity_t__ is used for their position and other data.

Here are some addresses for the latest Steam Version of CoD 5. Try use them as a reference/guide so you can learn how to find them yourself.

CG_Init: 0x457B20

```c++
#define CGS                   0x98B700
#define CGS_Size              0x45C0
#define CG                    0x98FCE0
#define CG_Size               0xFDDC0
#define CG_Entities           0xA90930
#define CG_EntitySize         0x2BC
#define CG_EntitiesSize       0xAF000
#define CG_ClientInfo         0xA76790
#define CG_ClientInfoSize     0x55C
#define RefDef                CG + 0x56A8C
#define CL_ViewAngles          0xF6B314 // ClientActive->ViewAngles
```


{% note primary %}
__转载链接：__ [SystemX32@Guidedhacking.com](https://guidedhacking.com/threads/call-of-duty-world-at-war-multiplayer-find-entity-list.17108/post-107520)
{% endnote %}