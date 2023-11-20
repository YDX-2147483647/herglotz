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

#set heading(numbering: none)
= 他典等

- #link("https://en.wikipedia.org/wiki/Euler%27s_totient_function#Fourier_transform")[Fourier transform - Computing Euler's totient function - Euler's totient function - Wikipedia]
- Wolfgang Schramm #link("http://math.colgate.edu/~integers/i50/i50.pdf")[The Fourier transform of functions of the greatest common divisor (`math.colgate.edu`)]
- 3Blue1Brown #link("https://www.bilibili.com/video/BV1kx411q7kK/")[隐藏在素数规律中的 $π$ - 哔哩哔哩]
- #link("https://proofwiki.org/wiki/M%C3%B6bius_Function_is_Multiplicative")[Möbius Function is Multiplicative - Pr∞fWiki]
