1.  【Ability】UiAbility的生命周期呢？

    1.  onCreate
    2.  onForeground
    3.  onBackground
    4.  onDestroy
2.  【Ability】启动UIAbility方式有哪些？

    1.  显式Want启动——启动一个确定应用的UIAbility，在want参数中需要设置该应用bundleName和abilityName，当需要拉起某个明确的UIAbility时，通常使用显式Want启动方式。
    2.  隐式Want启动——根据匹配条件由用户选择启动哪一个UIAbility，即不明确指出要启动哪一个UIAbility（abilityName参数未设置），在调用[startAbility()](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/js-apis-inner-application-uiabilitycontext-V5#uiabilitycontextstartability)方法时，其入参want中指定了一系列的entities字段（表示目标UIAbility额外的类别信息，如浏览器、视频播放器）和actions字段（表示要执行的通用操作，如查看、分享、应用详情等）等参数信息，然后由系统去分析want，并帮助找到合适的UIAbility来启动。当需要拉起其他应用的UIAbility时，开发者通常不知道用户设备中应用的安装情况，也无法确定目标应用的bundleName和abilityName，通常使用隐式Want启动方式。
3.  【Ability】UIAbility组件启动模式有哪些？

    1.  singleton（单实例模式）——每次调用startAbility()方法时，如果应用进程中该类型的UIAbility实例已经存在，则复用系统中的UIAbility实例。系统中只存在唯一一个该UIAbility实例，即在最近任务列表中只存在一个该类型的UIAbility实例。
    2.  multiton（多实例模式）——每次调用startAbility()方法时，都会在应用进程中创建一个新的该类型UIAbility实例。即在最近任务列表中可以看到有多个该类型的UIAbility实例。
    3.  specified（指定实例模式）——针对一些特殊场景使用（例如文档应用中每次新建文档希望都能新建一个文档实例，重复打开一个已保存的文档希望打开的都是同一个文档实例）
4.  【Ability】Ability传递参数时 参数带不带类型年    龄：34

    1.  不带
    2.  want.parameters as Record
5.  【Ability】want的type和action参数是做什么的

    1.  在调用方want参数中的entities和action需要被包含在待匹配UIAbility的skills配置的entities和actions中
    2.  action：对操作的描述
    3.  type：类型的描述
    4.  entities：对实体的描述
