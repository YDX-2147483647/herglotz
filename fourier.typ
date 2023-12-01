#import "@preview/tablex:0.0.6": tablex, hlinex, vlinex, cellx

#import "template.typ": project, example, remark

#show: project.with(title: "最大公约数的Fourier变换", date: "2023年10月20、26日，11月20日")

#let fourier(symbol) = math.attach(math.cal("F"), br: h(-0.5em) + symbol)

整数 $k,n$ 的最大公约数记作 $gcd(k,n)$。固定 $n$、变动 $k$ 得到的函数 $k |-> gcd(k,n)$ 以 $n$ 为#strong[周期]。数列既然有周期，就可以应用#strong[离散Fourier变换]。

更进一步，任给#strong[数论函数]（任意 $ZZ^+ -> CC$ 函数）$f$，都能用 $gcd$“改造”成周期函数 $k |-> f(gcd(k,n))$（因为 $gcd(k,n) in ZZ^+$），且也能给它应用离散Fourier变换，结果是
$
m |-> fourier(f)(m,n)
:= sum_(k=1)^n f(gcd(k,n)) times omega_n^(k m),
$
其中 $omega_n$ 是 $n$ 次单位根（$omega_n := exp((2pi i)/n)$，$omega_n^l := exp(2 pi i l/n)$）。

我们最终将导出 $fourier(f)$ 的另一公式。

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
  m=1 space.quad &|-> space.quad i + 2i^2 + i^3 + 4i^4 = i - 2 - i + 4 &= 2. \
  m=2 space.quad &|-> space.quad i^2 + 2i^4 + i^6 + 4i^8 = -1 + 2 - 1 + 4 &= 4. \
  m=3 space.quad &|-> space.quad i^3 + 2i^6 + i^9 + 4i^12 = -i -2 +i + 4 &= 2. \
  m=4 space.quad &|-> space.quad i^4 + 2i^8 + i^12 + 4i^16 = 1 + 2 + 1 + 4 &= 8. \
  \
  m=5 space.quad &|-> space.quad i^5 + 2i^10 + i^15 + 4i^20 = i - 2 - i + 4 &= 2. \
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
    cellx(align: start)[Dirac $delta$，Dirichlet卷积的单位元：$f * delta = delta * f = f$],
  ),
  kind: table,
  caption: [三种“单位”数论函数]
) <tab:units>

- *函数相乘*
  $ (f times g)(n) := f(n) times g(n). $
- *函数复合*
  $ (f compose g)(n) := f(g(n)). $
- *Dirichlet卷积*
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

#example[Euler totient $phi$][
  有许多定理都能用Dirichlet卷积表示，$phi * 1 = id$ 便是一例。

  Euler totient $phi(n)$ 的定义是 $1, 2, ..., n$ 中与 $n$ 互质的数的数量。这也可矫揉造作地写成
  $
  phi(n) := sum_(k perp n) 1,
  $
  其中 $k perp n$ 表示 $gcd(k,n) = 1$，即互质。#footnote[求和隐含 $1 <= k <= n$。]

  我们试一些具体例子。#footnote[聪明的人能从中提炼出 $phi$ 的性质。]
  - 例如 $7$ 是质数，$1,...,6$ 都与它互质，故 $phi(7) = 6$。
  - 又如 $8 = 2^3$，于是 $2$ 的整倍数都和 $8$ 有公因子 $2$，只剩下 $1,3,5,7$ 与 $8$ 互质，故 $phi(8) = 4$。
  - 再举个稍复杂的例子。$6 = 2 times 3$，抛去 $2$ 和 $3$ 的整倍数，和 $6$ 互质的只有 $1,5$，于是 $phi(6) = 2$。

  现在来看 $phi * 1 = id$。按照Dirichlet卷积和函数 $1,id$ 的定义，这是说
  $
  sum_(b|n) phi(n/b) = n.
  $

  不要被形式吓到；这是可以被理解的。以 $n=6$ 为例，我们可列出 $(0,1]$ 中以 $6$ 为分母的分数，然后约分：
  $
  mat(1/6, 2/6, 3/6, 4/6, 5/6, 6/6)
  = mat(1/6, 1/3, 1/2, 2/3, 5/6, 1/1).
  $
  - 分母 $6$ 与分子 $1,5$ 互质，约分不了，分母还是 $6$——这种情况按定义有 $phi(6)$ 个。
  - 分母 $6$ 有因子 $2$，分子 $2,4$ 是其整倍数，可约去 $2$，分母变为 $3$——这种情况按定义有 $phi(3)$ 个。
  - 同理，分母 $6$ 有因子 $3$，分子 $3$ 是其整倍数，约去后分母变为 $2$——这种情况按定义有 $phi(2)$ 个。
  - $6$ 也是自己的因子，$6/6 = 1/1$——这种情况按定义有 $phi(1)$ 个。
  以上讨论正是遍历 $b|n$ 及 $phi(n/b)$，并且不重不漏，加起来是最初列出的分数的数量，也就是 $6$。

  总结一下，$phi * 1 = id$ 其实是说 ${k: k perp b}, space b|n$ 是 ${1,...,n}$ 的一个划分，即
  $
  cases(
    b|n and b'|n ==> b=b' or {k: k perp b} sect {k: k perp b'} = emptyset,
    union.big_(b|n) {k: k perp b} = {k: k <= n},
  ).
  $
]

#set heading(numbering: none)
= 他典等

- #link("https://en.wikipedia.org/wiki/Euler%27s_totient_function#Fourier_transform")[Fourier transform - Computing Euler's totient function - Euler's totient function - Wikipedia]
- Wolfgang Schramm #link("http://math.colgate.edu/~integers/i50/i50.pdf")[The Fourier transform of functions of the greatest common divisor (`math.colgate.edu`)]
- 3Blue1Brown #link("https://www.bilibili.com/video/BV1kx411q7kK/")[隐藏在素数规律中的 $π$ - 哔哩哔哩]
- #link("https://proofwiki.org/wiki/M%C3%B6bius_Function_is_Multiplicative")[Möbius Function is Multiplicative - Pr∞fWiki]
- #link("https://en.wikipedia.org/wiki/Dirichlet_convolution")[Dirichlet convolution - Wikipedia]
