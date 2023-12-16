#import "@preview/tablex:0.0.6": tablex, hlinex, vlinex, cellx

#import "template.typ": project, example, remark

// Workaround for footnote style
#show link: set text(fill: blue)
#show link: underline
// Footnote style must be uniform for the whole flow of content.
// Therefore, set and show rules for `footnote.entry` must be defined at the beginning.
// (at least for typst v0.10.0)
// https://github.com/typst/typst/issues/1348#issuecomment-1566316463
// https://typst.app/docs/reference/model/footnote/#example

#show: project.with(title: "最大公约数的Fourier变换", date: "2023年10月20、26日，11月20日，12月2、13–16日")

#let fourier(symbol) = math.attach(math.cal("F"), br: h(-0.5em) + symbol)
#let bullet = math.circle.filled.small

整数 $k,n$ 的*最大公约数*记作 $gcd(k,n)$。固定 $n$、变动 $k$ 得到的函数 $k |-> gcd(k,n)$ 以 $n$ 为*周期*。数列既然有周期，就可以应用*离散Fourier变换*。

更进一步，任给*数论函数*（任意 $ZZ^+ -> CC$ 函数）$f$，都能用 $gcd$“改造”成周期函数 $k |-> f(gcd(k,n))$（因为 $gcd(k,n) in ZZ^+$），且也能给它应用离散Fourier变换，结果是
$
m |-> fourier(f)(m,n)
:= sum_(k=1)^n f(gcd(k,n)) times omega_n^(-k m),
$
其中 $omega_n$ 是 $n$ 次单位根（$omega_n := exp((2pi i)/n)$，$omega_n^l := exp(2 pi i l/n)$）。

我们最终将导出 $fourier(f)$ 的另一公式。（这一结果是 Wolfgang Schramm 2008年的文章）

#example[具体例子][
  以 $k |-> gcd(k, 4)$ 为例。
  #align(
    center,
    tablex(
      columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
      align: center,
      auto-hlines: false,
      auto-vlines: false,
      [*$k$*], vlinex(), $dots.c$, $[1$, $2$, $3$, $4]$, $[5$, $6$, $7$, $8]$, $9$, $dots.c$,
      hlinex(),
      [*$gcd(k, 4)$*], $dots.c$, $[1$, $2$, $1$, $4]$, $[1$, $2$, $1$, $4]$, $1$, $dots.c$,
    )
  )
  $omega_4 = i$，Fourier变换结果如下。
  $
  ... space.quad &|-> space.quad ... \
  \
  m=1 space.quad &|-> space.quad i + 2i^(-2) + i^(-3) + 4i^(-4) = -i - 2 + i + 4 &= 2. \
  m=2 space.quad &|-> space.quad i^(-2) + 2i^(-4) + i^(-6) + 4i^(-8) = -1 + 2 - 1 + 4 &= 4. \
  m=3 space.quad &|-> space.quad i^(-3) + 2i^(-6) + i^(-9) + 4i^(-12) = i -2 -i + 4 &= 2. \
  m=4 space.quad &|-> space.quad i^(-4) + 2i^(-8) + i^(-12) + 4i^(-16) = 1 + 2 + 1 + 4 &= 8. \
  \
  m=5 space.quad &|-> space.quad i^(-5) + 2i^(-10) + i^(-15) + 4i^(-20) = -i - 2 + i + 4 &= 2. \
  ... space.quad &|-> space.quad ... \
  $
]

#figure(
  image("fig/gcd.png", width: 80%),
  caption: [
    $6,30,100$ 以内数的 $gcd$

    第 $y$ 行第 $x$ 列的颜色表示 $(x,y)$。如图例所示，越深越大（线性对应），但直接比较不同图的颜色无意义。
    （2020年8月11日有动图）
  ]
)
// Mathematica:
// Table[Table[GCD[x, y], {x, n}, {y, n}] //
//  MatrixPlot[#, PlotLegends -> Placed[Automatic, Bottom],
//    ImageSize -> Small] &, {n, {6, 30, 100}}] // Row

= Dirichlet卷积

@tab:units 介绍了最基础的三个数论函数 $1, id, delta$。

#figure(
  tablex(
    columns: (auto, auto, auto),
    align: center,
    auto-vlines: false,
    auto-hlines: false,
    [*记号*], vlinex(), [*定义*], vlinex(), [*意义*],
    hlinex(),
    $1$, $1(n) equiv 1$,
    cellx(align: start)[恒一，函数相乘的单位元：$f times 1 = 1 times f = f$],
    $id$, $id(n) equiv n$,
    cellx(align: start)[恒等，函数复合的单位元：$f compose id = id compose f = f$],
    $delta$, $delta(n) = cases(1 &space n = 1, 0 &space n != 1)$,
    cellx(align: start)[Dirac $delta$#footnote[有些文献写作 $n |-> delta_(n 1)$，这次 $delta$ 是 Kronecker $delta$。]，Dirichlet卷积的单位元：$f * delta = delta * f = f$],
  ),
  kind: table,
  caption: [三种“单位”数论函数]
) <tab:units>

- *函数相乘*
  $ (f times g)(n) := f(n) times g(n). $
- *函数复合*
  $ (f compose g)(n) := f(g(n)). $
- *Dirichlet#footnote[Dirichlet是德国人，但名字源于法国。德语 _ch_ 发硬音，故名字应读作 _Dee-REECH-let_。说英语的人很少这样念。他们要么按法语读作 _Dee-REESH-lay_，要么各取一半读作 _Dee-REECH-lay_。（来源：《素数之恋》90页 §6.V 的作者注31.和译者注）]卷积*
  $
  (f * g)(n) &:= sum_(a b = n) f(a) g(b) \
  &= sum_(a|n) f(a) g(n/a) = sum_(b|n) f(n/b) g(b).
  $
  （$a|n$ 表示 $a$ 整除 $n$，即 $n/a in ZZ$）

  这针对Dirichlet级数很自然：
  $
  sum_a f(a)/a^s times sum_b g(b)/b^s
  = sum_a sum_b (f(a) g(b)) / (a b)^s
  = sum_n ((f*g)(n))/n^s.
  $

  #remark[更常见的那种卷积][
    Dirichlet卷积针对Dirichlet级数，而更常见的那种卷积针对幂级数#footnote[又名数列的生成函数、信号的Z变换、概率分布的特征函数、……]。
    那种卷积记作 $star$，则
    $
    sum_a f(a) x^a times sum_b g(b) x^b
    = sum_a sum_b f(a) g(b) x^(a+b)
    = sum_n (f star g)(n) x^n.
    $
    于是要定义
    $
    (f star g)(n) := sum_(a + b = n) f(a) g(b) = sum_a f(a) g(n-a) = sum_b f(n - b) g(b).
    $

    ——就是指数函数（乘法）和幂函数（加法）的区别：
    $
    a^s b^s &= (a b)^s =: n^s, &space.quad 1^s = 1. \
    x^a x^b &= x^(a+b) =: x^n, &space.quad x^0 = 1. \
    $
  ]

#remark[Dirichlet卷积没有丢点][
  如无其它限制，完全知道 $f,g$ 才能计算 $f times g$。然而 $f*g$ 看似不需要，例如 $n = 4$ 时结果为 $f(1)g(4) + f(2)g(2) + f(4)g(1)$，用不到 $f(3),g(3)$。不过 $f*g$ 是函数，其它 $n$ 会用到。可证明若 $g$ 满足 $forall f, f*g equiv 0$，则 $g equiv 0$。
]

#example[Euler totient $phi$][
  有许多定理都能用Dirichlet卷积表示，$phi * 1 = id$ 便是一例。

  Euler totient $phi(n)$ 的定义是 $1, 2, ..., n$ 中与 $n$ 互质的数的数量。这也可矫揉造作地写成
  $
  phi(n) := sum_(k perp n) 1,
  $
  其中 $k perp n$ 表示 $gcd(k,n) = 1$，即互质。（求和隐含 $1 <= k <= n$）

  我们试一些具体例子。#footnote[聪明的人能从中提炼出 $phi$ 的性质。]
  - 例如 $7$ 是质数，$1,...,6$ 都与它互质，故 $phi(7) = 6$。
  - 又如 $8 = 2^3$，于是 $2$ 的整倍数都和 $8$ 有公因子 $2$，只剩下 $1,3,5,7$ 与 $8$ 互质，故 $phi(8) = 4$。
  - 再举个稍复杂的例子。$6 = 2 times 3$，抛去 $2$ 和 $3$ 的整倍数，和 $6$ 互质的只有 $1,5$，于是 $phi(6) = 2$。

  现在来看 $phi * 1 = id$。按照Dirichlet卷积和函数 $1,id$ 的定义，这是说
  $
  sum_(b|n) phi(n/b) = n.
  $

  不要被形式吓到；这可以被理解。以 $n=6$ 为例，我们可列出 $(0,1]$ 中以 $6$ 为分母的分数，然后约分：
  #figure(
    image("fig/partition.png", width: 30%),
    caption: [按约分程度将 ${1,...,6}$ 分成几类]
  )
  $
  mat(1/6, 2/6, 3/6, 4/6, 5/6, 6/6)
  = mat(1/6, 1/3, 1/2, 2/3, 5/6, 1/1).
  $
  - 分母 $6$ 与分子 $1,5$ 互质，约分不了，分母还是 $6$——这种情况按定义有 $phi(6)$ 个。
  - 分母 $6$ 有因子 $2$，分子 $2,4$ 是其整倍数，可约去 $2$，分母变为 $3$——这种情况按定义有 $phi(3)$ 个。
  - 同理，分母 $6$ 有因子 $3$，分子 $3$ 是其整倍数，约去后分母变为 $2$——这种情况按定义有 $phi(2)$ 个。
  - $6$ 也是自己的因子，$6/6 = 1/1$——这种情况按定义有 $phi(1)$ 个。
  以上讨论正是遍历 $b|n$ 及 $phi(n/b)$，并且不重不漏，加起来是最初列出的分数的数量，也就是 $6$。

  总结一下，$phi * 1 = id$ 其实是说 ${b k: k perp n/b}, space b|n$ 是 ${1,...,n}$ 的一个划分。
  由 $gcd(b k, n) = b gcd(k, n/b)$，可将 $b k$ 看作 $k$，得到 ${b k : k perp n/b} = {k: gcd(k, n) = b}$，于是显然这些集合不重不漏。
]

= Ramanujan和

有了 $phi * 1 = id$ 那种按约分程度重排集合的观点，结合一些算术知识，我们能推知一些原本看起来不着边际的定理。

#figure(
  image("fig/One5Root.svg", width: 40%),
  caption: [五次单位根 $omega_n^l$（蓝点）的中心是零 | #link("https://commons.wikimedia.org/wiki/File:One5Root.svg")[Wikimedia Commons `One5Root.svg`]]
)

比如若 $n > 1$，则 $sum_l omega_n^l = 0$（单位根转一圈的中心是零）#footnote[可用等比数列求和公式计算，也可用乘 $omega_n$ 不变来论证。]，我们把求和范围 $l = 1,...,n$ 重排，立即得到
$
0 = sum_(b|n) sum_(k perp n/b) omega_n^(b k)
= sum_(a|n) sum_(k perp a) omega_a^k,
$
其中第二个等号把 $n/b$ 代换成了 $a$，同时约分 $(b k)/n = k/a$。像 $omega_a^k, k perp a$ 这种不再能约分的单位根称作 _primitive_ $a$-th root of unity。

这一结果也能用Dirichlet卷积表示——等式最右边正是函数 $a |-> sum_(k perp a) omega_a^k$ 与 $1$ 的卷积。一般地，*Ramanujan和*#footnote[此处“和”指加法的结果，不是连词。] $c$ 的定义是
$
c_n (m) := sum_(k perp n) omega_n^(k m).
$
- 求和仍隐含 $1 <= k <= n$。
- $m=1$ 时，$n |-> c_n (1)$（简记作 $c_bullet (1)$）正是我们刚才提到的 $a |-> sum_(k perp a) omega_a^k$。
- $m = 0$ 时，$sum$ 相当于计数，即 $c_bullet (0) = phi$。

看到这些事实，敏锐的人已可直奔本文结论；不过这之前我们再分析一下Dirichlet卷积。

= Möbius反演

#remark[咬文嚼字][
  我们要谈的是数论函数的Möbius反演公式（Möbius inversion formula），而非复平面的Möbius变换。二者都以August Ferdinand Möbius命名。

  前者也叫Möbius transform，后者是Möbius transformation。#link("https://www.merriam-webster.com/")[Merriam-Webster词典]中，_transform_ 之2就是“_transformation_ sense 3a(1)”，相关解释如下。
  - #link("https://www.merriam-webster.com/dictionary/transform")[_transform_] 1: a mathematical element obtained from another by transformation.
  - #link("https://www.merriam-webster.com/dictionary/transformation")[_transformation_] 3a(1): the operation of changing (as by rotation or mapping) one configuration or expression into another in accordance with a mathematical rule.

  我个人感觉 transformation 更偏 $V->W$，如线性变换#footnote[有些作者规定“变换”必须 $V->V$，“映射”只需 $V->W$。按这种说法，linear transformation应当是线性“映射”。]；而 transform 更偏 $W^V -> W^V$，如 Fourier 变换。然而“$W^V$”也能看成一种“$V$”，比如Fourier变换就是一种线性变换。SE 有相关讨论：
  - #link("https://math.stackexchange.com/questions/1154581/is-there-a-difference-between-transform-and-transformation")[definition - Is there a difference between transform and transformation? - Mathematics Stack Exchange]
  - #link("https://english.stackexchange.com/questions/5454/transform-or-transformation/5456#5456")[word choice - Transform or transformation? - English Language & Usage Stack Exchange]
]

== 逆

前面提到“数论*函数*之间Dirichlet*卷积*”相当于“相应Dirichlet*级数*直接*相乘*”，而后者满足交换律、结合律#footnote[
  直接从定义 $(f * g)(n) &:= sum_(a b = n) f(a) g(b)$ 也能论证。
]，于是我们可进一步考虑Dirichlet卷积意义下的*逆*。

考虑最简单也最一般的 $1$ 的逆。

刚刚我们得到 $n>1$ 时 $(1 * c_bullet (1))(n) = 0$，而 $(1 * c_bullet (1))(1)$（按Dirichlet卷积的定义）只有一项 $1 times c_1 (1) = 1 times 1^(1 times 1) = 1$，于是 $1 * c_bullet (1) = delta$ —— $c_bullet (1)$ 正是 $1$ 的逆。

不过我们对 Ramanujan 和了解有限。比如 $c_74 (1)$ 这个数是多少？你知道它的定义是 $sum_(k perp 74) omega_74^k$，而 $74 = 2 times 37$，$k$ 可取 $1,3,5,7, ..., 35, 39, ..., 73$，然后这 $36$ 项加起来是几呢？哦，你可以先补上 $k=37$ 凑等比数列，$sum_(m = 0)^36 omega_74^(2m+1) = omega_74 times (1 - omega_74^74) \/ (1 - omega_74^2) = 0$，再减去 $omega_74^37 = omega_2 = -1$，得到 $c_74 (1) = 1$。行，可 $omega_(37 times 41) (1)$ 怎么办呢？可以算两次等比数列的和。那 $omega_(37 times 41 times 43) (1)$？三重求和。……

无论如何，$c_74 (1) = 1$ 总有些蹊跷，事实上 $c_bullet (1) in {0, plus.minus 1}$，下面将介绍其中缘由。

#remark[时间线][
  我们将发现 $c_bullet (1)$ 是 Möbius $mu$ 函数。

  - Ramanujan（1887–1920）在1918年提出Ramanujan和。

  - Mertens（1840–1927）在1874年为 Möbius 函数引入了记号 $mu(n)$。

    以他自己名字命名的Mertens函数是 $sum mu(n)$，它在 $n -> +oo$ 的渐近性质与Riemann猜想有关。

  - Riemann（1826–1866）1859年的9页文章 _Ueber die Anzahl der Primzahlen unter einer gegebenen Grösse_（关于小于给定数的质数数量）开创了解析数论。

  - Möbius（1790–1868）在1832年提出Möbius函数。

  - Gauß（1777–1855）在1801年事实上讨论了Möbius函数，他给出 $sum_(k perp a) omega_a^k in {0, plus.minus 1}$ 以及每一种情况的充要条件。#footnote[
      Gauß、Möbius、Mertens三个年份的来源是 #link("https://mathworld.wolfram.com/MoebiusFunction.html")[Möbius Function - Wolfram MathWorld]。
    ]

  下面我们将提到Euler十八世纪的工作。
]

== Euler积公式

$1$ 对应的Dirichlet级数正是Riemann $zeta$ 函数
$
zeta(s) := sum_n 1/n^s.
$
（求和隐含 $n in ZZ^+$）如果能把 $1 / zeta(s)$ 写成Dirichlet级数的形式，那么系数就是 $1$ 的逆。

怎么操作呢？先把 $zeta(s)$ 写成简单因子的乘积。Euler 1737年撰写的 _Variae observationes circa series infinitas_#footnote[
  你可以在#link("http://eulerarchive.maa.org/")[The Euler Archive (`eulerarchive.maa.org`)] 的（左边栏）Search archive by → Subject and Index →（中间靠下）Search by Subject → Mathematics → Infinite Series下载到72号文章 _Variae observationes circa series infinitas_ 的拉丁原文和英语、德语翻译。
] 的定理8指出
$
sum_n 1/n^s = product_p 1/(1-p^(-s)),
$
其中 $p$ 取遍质数。

#remark[证明Euler积公式][
  这个证明重写了一遍Ἐρατοσθένης #footnote[Ἐρατοσθένης (Eratosthenes) 这个名字的词源是 _ἐρᾰτός_ (eratós, “lovely”) + _σθένος_ (sthénos, “strong”)。] 质数筛，改写自Euler原文。

  对比
  $
  zeta(s)
  = sum_n 1/n^s
  &= 1 + 1/2^s + 1/3^s + 1/4^s + 1/5^s + dots.c, \
  2^(-s) zeta(s)
  = sum_n 1/(2n)^s
  &= 1/2^s + 1/4^s + dots.c,
  $
  两项相减则从 $ZZ^+$ 中删去 $2$ 的倍数，即
  $
  (1 - 2^(-s)) zeta(s) = 1 + 1/3^s + 1/5^s + dots.c.
  $

  同理，$(1-2^(-s)) (1-3^(-s)) zeta(s)$ 会继续删去 $3$ 的倍数。以此类推，逐个删去 $p$ 的倍数，最后只剩第一项 $1$。于是

  $
  product_p (1-p^(-s)) times zeta(s) = 1.
  $
]

#remark[再次证明Euler积公式][
  第一个证明是从 $ZZ^+$ 筛去质数的倍数；这个证明是从用质因数乘积重组 $ZZ^+$，来自 #link("https://mathworld.wolfram.com/EulerProduct.html")[Euler Product - Wolfram MathWorld]。

  $
  product_p 1/(1-p^(-s))
  &= product_p sum_(k in NN) 1 / p^(k s) \
  &= 1 + sum_p 1/p^s + sum_(p_1 <= p_2) 1/(p_1 p_2)^s + dots.c \
  &= sum_n 1/n^s.
  $
  1. 第一个等号是几何级数 $1/(1-q) = sum_(k in NN) q^k$ 。
  2. 第二个等号乘开了级数。
    0. 首项所有 $k$ 取零。
    1. 次项所有 $k$ 的和是 $1$：一个质数 $p$ 对应的 $k$ 取 $1$，其余都取零。
    2. 下一项所有 $k$ 的和是 $2$：要么两个质数 $p_1,p_2$ 对应的 $k$ 取 $1$，其余取零；要么 $p_1=p_2$ 对应的 $k$ 取 $2$，其余取零。
    3. ……
  3. 第三个等号是用质因数重组。
]

现在把 $1/zeta(s)$ 写成Dirichlet乘积。
$
1/zeta(s)
&= product_p (1 - 1/p^s) \
&= 1 - sum_p 1/p^s + sum_(p_1<p_2) 1/(p_1 p_2)^s - sum_(p_1<p_2<p_3) 1/(p_1 p_2 p_3)^s plus.minus dots.c \
&= 1 - 1/2^s - 1/3^s - 1/5^s + 1/(2 times 3)^s - 1/7^s - 1/(2 times 5)^s plus.minus dots.c \
&=: mu(n) / n^s.
$
1. 第一个等号是Euler积公式。
2. 第二个等号乘开了级数。
  0. 首项全都取 $1$。
  1. 次项一个取 $- 1/p^s$，其余都取 $1$。
  2. 下一项仅 $2$ 个取 $- 1/p^s$，其余都取 $1$。总计 $2$ 个负号，负负得正。
  3. ……
3. 第三个等号按分母从小到大排序。
4. 最后一个等号整理成Dirichlet级数，将系数记作 $mu(n)$

这样我们就算得 $1$ 的逆也等于 $mu$，它通称 *Möbius 函数*。按照规律，
$
mu(n) := cases(
  0 &quad n"包含重复质因子",
  (-1)^k &quad n"的质因子互不重复，共"k"个"
).
$

== 再看 $1$ 的逆

$mu(n)$ 的定义并不十分诡异，它大致是给质因子计数，还比较规整。例如按定义分类讨论，可论证“若 $a perp b$，则 $mu(a) times mu(b) = mu(a b)$”，这种性质称作multiplicative。

#remark[$gcd$ 的性质][
  $gcd(bullet, n)$ 也multiplicative。这是因为若 $a perp b$，则 $m|a and m|b <==> m | a b$。
]

从“给质因子计数”这一角度，我们也可直接论证 $1 * mu = delta$。

$(1 * mu)(n) = sum_(b|n) mu(b)$。设 $n$ 的质因数分解是 $product_(k=1)^K (p_k)^(a_k)$，则抛去 $mu(b) = 0$ 的项，只考虑无重复质因子的 $b$，有如下可能。
0. $b = 1 perp n$ 没有质因子，$mu(b) = 1$。
1. $b in {p_1, ..., p_K}$ 有单个质因子，这 $K$ 种情况都有 $mu(b) = -1$。
2. $b in {p_1 p_2, p_1 p_3, ..., p_2 p_3, ..., p_(K-1) p_K}$ 有 $2$ 个质因子，从 $K$ 个质因子选 $2$ 个有 $binom(K, 2)$ 种可能，他们都有 $mu(b) = (-1)^2$。
3. $b$ 含 $3$ 个质因子有 $binom(K, 3)$ 种可能，他们都有 $mu(b) = (-1)^3$。
4. ……

因此由二项式定理
$
(1 * mu)(n)
= sum_(k = 0)^K binom(K, k) (-1)^k
= (1 - 1)^K
= 0^K = 0,
quad K != 0.
$
而 $K=0$ 当且仅当 $n = 1$，此时 $(1*mu)(n) = mu(1) = 1$。综合两种情况，可知 $1 * mu = delta$。

== 反演

知道了 $1$ 的逆是 $mu$，我们立即得到Möbius反演公式：对任意数论函数 $f,g$，
$
f = g * 1. quad ==> quad g = f * mu.
$

#example[$phi$ 的另一种表示][
  上文我们按约分程度重排集合，证明了 $phi * 1 = id$。于是 $phi = phi * 1 * mu = id * mu$。
]

#example[$c_n (m)$ 总是整数][
  虽然 $c_n (m)$ 的定义是一堆复数之和，但 $m in ZZ$ 时总有 $c_n (m) in ZZ$。

  只用最基础的数论，我们可论证 $c_n (m) in RR$：$k perp n <==> (n-k) perp n$，而 $m in ZZ$ 时 $(n-k)m equiv -k m space (mod n)$，于是 $c_n (m)$ 的定义取共轭不变。下面我们考虑Möbius反演。

  追究引入Ramanujan和的过程，可推广 $1 * c_bullet (1) = delta$：（这套操作后文马上会再次用到）
  $
  (1 * c_bullet (m))(n)
  &= sum_(a|n) sum_(k perp a) omega_a^(k m)
  &= sum_(b|n) sum_(k perp n/b) omega_n^(b k m)
  &= sum_(l=1)^n omega_n^(l m).
  $
  现在给等比数列求和：
  - 公比 $omega_n^m = 1$（即 $n|m$）时，和是 $n times 1 = n$；
  - 公比 $omega_n^m != 1$ 时，$(omega_n^m)^n = omega_n^(n m) = omega_1^m = 1$，这个数列在单位圆上均匀分布，和是零。
  综合两种情况，记 $f := 1 * c_bullet (m)$，则总有 $f(n) in ZZ$。

  由Möbius反演，$c_bullet (m) = mu * 1 * c_bullet (m) = mu * f$。注意Dirichlet卷积的每一项都是整数，从而加起来也是整数。
]

= Fourier变换

回顾前文：

- 按约分程度重排集合—— ${b k: k perp n/b}, space b|n$ 是 ${1,...,n}$ 的一个划分。

- Ramanujan和—— $c_n (m) := sum_(k perp n) omega_n^(k m)$。

- Fourier变换—— $k |-> f(gcd(k,n))$ 变换为 $m |-> fourier(f)(m,n) := sum_(k=1)^n f(gcd(k,n)) times omega_n^(-k m)$。

根据“按约分程度重排集合”，对任意数论函数 $g$，
$
sum_(k=1)^n g(k) = sum_(b|n) sum_(k perp n/b) g(b k) = sum_(a|n) sum_(k perp a) g(n/a k).
$

代入Fourier变换，得
$
fourier(f)(m,n) = sum_(b|n) sum_(k perp n/b) f(gcd(b k, n)) times omega_n^(-b k m).
$
注意 $gcd(b k, n) = b gcd(k, n/b) = b$ 不含 $k$，并且记 $a = n/b$ 则 $omega_n^(-b k) = omega_(b a)^(-b k) = omega_a^(-k)$。代回得
$
fourier(f)(m,n)
&= sum_(a b = n) sum_(k perp a) f(b) times omega_a^(-k m)
&= sum_(a b = n) f(b) times sum_(k perp a) omega_a^(-k m).
$
按照Dirichlet卷积与Ramanujan和的定义，这等于 $(f * c_bullet (-m))(n)$。

又 $c_bullet (m) in RR$ 共轭不变，代入 $c_bullet (-m) = c_bullet (m)$，得如下形式。

#align(center, rect(inset: (x: 1em))[
  $k |-> f(gcd(k,n))$ 的Fourier变换
  $
  m |-> fourier(f)(m,n) = (f * c_bullet (m))(n).
  $
])

注意这没有把 $fourier(f)(bullet, n)$ 表示为 $f(gcd(bullet,n))$ 与谁的卷积，而是逐点表示成了某种卷积在 $n$ 处的值，各点卷积的对象并不相同。

#remark[更常见的那种Fourier变换][
  以 $n$ 为周期的 $ZZ -> CC$ 函数 $k |-> f(k)$，它的Fourier变换是
  $
  m &|-> sum_(k=1)^n f(k) times omega_n^(k m)
  &= sum_(k=1)^n f(k) times omega_n^(-(-k) m)
  &= (f star h_bullet (m))(0).
  $
  其中 $star$ 是更常见的那种卷积，$h_k (m) = omega_n^(-k m)$。（$f star h_bullet (m)$ 是周期函数，在 $0$ 处的值也等于在 $n$ 处的值。）
]

#figure(
  grid(
    columns: (1fr, 1fr),
    image("fig/Ramanujan_sum-fix_m.png"),
    image("fig/Ramanujan_sum-fix_n.png"),
  ),
  caption: [
    $c_bullet (m)$ 与 $c_n (bullet)$

    每一条图线的阴影水平线是横轴，图线的绝对高度没有意义。

    $c_bullet (m): ZZ^+ -> ZZ$，画图时用线段连接离散点；$c_n (bullet): RR -> CC$，分实虚绘制，有阴影的为实部。
  ],
)

#figure(
  image("fig/Ramanujan_sum-complex.png", width: 80%),
  caption: [$c_n (RR)$ 在 $CC$ 中]
)

= 应用

结合刚刚得到的
$
fourier(f)(m,n) = (f * c_bullet (m))(n)
$
与Fourier正反变换
$
m |-> fourier(f)(m,n) &:= sum_(k=1)^n f(gcd(k,n)) times omega_n^(-k m), \
k |-> f(gcd(k,n)) &= 1/n sum_(m=1)^n fourier(f)(m,n) times omega_n^(k m)
$
能得到许多结果。

#example[用新方法表示 $gcd$][
  取 $f = id$，则
  $
  fourier(id)(m,n)
  = (id * c_bullet (m))(n)
  = sum_(b|n) n/b times c_b (m).
  $
  于是
  $
  gcd(k,n)
  &= id(gcd(k,n)) \
  &= 1/n sum_(m=1)^n fourier(id)(m,n) times omega_n^(k m) \
  &= 1/n sum_(m=1)^n sum_(b|n) n/b times c_b (m) times omega_n^(k m) \
  &= sum_(m=1)^n omega_n^(k m) sum_(b|n) (c_b (m))/b.
  $
]

#example[用 $gcd$ 表示新东西][
  上面用了Fourier反变换，这里再用Fourier正变换。

  $
  sum_(k=1)^n gcd(k,n) omega_n^(-k m) =: fourier(id)(m,n) = (id * c_bullet (m))(n).
  $
  注意Fourier变换结果是个函数，我们直接得到一组结果。
  $
  sum_(k=1)^n gcd(k,n) &= (id * phi)(n). \
  sum_(k=1)^n gcd(k,n) omega_n^(-k) &= (id * mu)(n). \
  ... &= ...
  $
]

#example[重看 $1 * c_bullet (1) = delta$][
  $1$ 的 Fourier 变换是 $delta$，而按我们的公式这也等于 $1 * c_bullet (1)$。
]

#example[乘法][
  以Fourier正变换，取 $m=0$ 为例，$sum_k f(gcd(k,n)) =: fourier(f)(0,n) = (f * phi)(n)$。

  取 $f = log compose g$，则 LHS 的 $exp$ 为
  $
  exp sum_k log g(gcd(k,n))
  = product_k g(gcd(k,n)),
  $
  而 RHS 的 $exp$ 为
  $
  exp(((log compose g) * phi)(n))
  = exp sum_(a b = n) log g(a) times phi(b)
  = product_(a b = n) g(a)^phi(b).
  $
]

#example[$CC$ 的大门][
  数论常常限制在 $ZZ^+$ 中，而Fourier变换字面上在 $CC$ 中，于是我们的公式可让一些 $ZZ^+$ 的概念拓展到 $CC$。

  举个例子，将互质概念从 $ZZ^+ times ZZ^+$ 拓展到 $CC times ZZ^+$。$k perp n
  <=> delta(gcd(k,n)) != 0$，注意按我们的公式 $fourier(delta)(m,bullet) = delta * c_bullet (m) = c_bullet (m)$。于是按Fourier反变换，
  $
  delta(gcd(k,n))
  = 1/n sum_m c_n (m) times omega_n^(k m)
  $
  它等于零即向量 $c_n (bullet)$ 与 $m |-> omega_n^(k m)$ 正交，后者对一般 $k in CC$ 也有意义。
]

其实Wolfgang Schramm 2008年文章足足有13个例子，并总结成了关于 $f, m$ 的二维表格。然而这里只引入了 $1,id,delta$ 和 $c$ 四个数论函数，一描述就捉襟见肘，还请有志者参考原文吧。

#set heading(numbering: none)
= 他典等

- John Derbyshire著、陈为蓬译《素数之恋》（ISBN 978-7-5428-4776-8）
- #link("https://en.wikipedia.org/wiki/Euler%27s_totient_function#Fourier_transform")[Fourier transform - Computing Euler's totient function - Euler's totient function - Wikipedia]
- Wolfgang Schramm #link("http://math.colgate.edu/~integers/i50/i50.pdf")[The Fourier transform of functions of the greatest common divisor (`math.colgate.edu`)]
- 3Blue1Brown #link("https://www.bilibili.com/video/BV1kx411q7kK/")[隐藏在素数规律中的 $π$ - 哔哩哔哩]
- #link("https://proofwiki.org/wiki/Sum_of_M%C3%B6bius_Function_over_Divisors")[Sum of Möbius Function over Divisors - Pr∞fWiki]
- #link("https://en.wikipedia.org/wiki/Dirichlet_convolution")[Dirichlet convolution - Wikipedia]
- Mathologer #link("https://youtu.be/LFwSIdLSosI")[Euler’s Pi Prime Product and Riemann’s Zeta Function - YouTube]
