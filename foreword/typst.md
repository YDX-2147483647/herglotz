# Typst

- 用[Typst][typst]编译非常快，常常快到以为没编译——切换窗口前就编译好了。初次编译`*.typ`都远快于一般`*.tex`增量编译，通常也比[从 *.md 生成的网页][mkdocs-serve]更新快。
- Typst的语法比LaTeX简洁。在数学公式中，“↦”就是`|->`（竖线、连字符、大于号），结合字体提供的连字，几乎所见即所得，比`\mapsto`清晰不少。
- [Typst嵌入了平易的脚本语言和“标准库”][typst-scripting]，能弥补个人局部需求与公共通用功能间的空隙。LaTeX虽能力更强，但那种`\expandafter`或[`\tl_if_empty:nTF`][latex3]也不是随时就能写的。
- 调试`*.typ`也容易一些。安装环境简单，报错信息精确，文档集中统一且示例丰富，作用域清晰可隔离，编译快从而测试快，缓存透明而能忽略，……如果没有这些，真请来Hercule Poirot也要费一番功夫。


Typst还在频繁变化。例如前几月还改了词法分析器，来让汉字间的语法更简洁。

不过Typst似乎没有CTeX那样的工作组，中文排版能力不足。目前最大的问题是[无法生成伪粗体][typst/typst#394]，只支持给设计了多种字重的字体加粗；而汉字太多，大部分既有字体都没设计。

另外有人宣传Typst学习成本低，这也许只是掩盖问题。排版固有的困难什么方法都绕不开。

[typst]: https://typst.app/ "Typst: Compose papers faster"
[latex3]: https://www.alanshawn.com/tech/2020/10/04/latex3-tutorial.html "LaTeX3: Programming in LaTeX with Ease | Alan Xiang’s Blog"
[mkdocs-serve]: https://www.mkdocs.org/user-guide/cli/#mkdocs-serve "mkdocs serve - Command Line Interface - MkDocs"
[typst-scripting]: https://typst.app/docs/reference/scripting/ "Scripting – Typst Documentation"
[typst/typst#394]: https://github.com/typst/typst/issues/394 "Fake text weight and style (synthesized bold and italic) · Issue #394 · typst/typst"
