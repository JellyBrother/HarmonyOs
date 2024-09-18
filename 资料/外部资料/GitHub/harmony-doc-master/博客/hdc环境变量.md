# 【HarmonyOS NEXT】设置macOS环境变量——zsh: command not found: hdc

**【问题描述】**
根据配置环境变量文档设置环境变量后，使用hdc命令，仍然报错 zsh: command not found: hdc


**【原因】**
文档第3步，未导出 PATH 和 CLASSPATH
<img src="https://i-blog.csdnimg.cn/direct/101be1e53d23424498ded4918b391b08.png" width="60%" alt="文档截图"  title="文档截图">


**【解决办法】**
文档第3步，增加导出 PATH 和 CLASSPATH

```typescript
# 增加内容，注意path要改为自己SDK下的toolchains
export PATH=$PATH:/Users/xxx/Sdk/xxx/toolchains
export CLASSPATH

# 文档内容
HDC_SERVER_PORT=7035
launchctl setenv HDC_SERVER_PORT $HDC_SERVER_PORT
export HDC_SERVER_PORT
```


**【测试】**
终端输入，`hdc -v`，显示版本号，即配置成功

