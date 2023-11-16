#import "@preview/tablex:0.0.6": tablex, hlinex, vlinex

#import "template.typ": project, remark, pseudonyms

#show: project.with(title: "既连续又本质间断", date: "2023年10月23–24日，11月7、13–14、16–17日")

#quote(
  block: true,
  attribution: [_Profiles of the Future_ (1962) ch. 2, Arthur C. Clarke],
)[
  The only way of discovering the limits of the possible is to venture a little
  way past them into the impossible.
]

$RR -> RR$ 函数中，存在完全连续的，存在某一点不连续的，存在处处不连续的，存在几乎处处不连续又几乎处处不连续的；存在完全连续但好像又会跳变的；存在连续但又无限振荡的；……
连续性的边界在哪里？这显然取决于你如何定义“连续”，并且这些定义可按“$=>$”排成一串或几串。

#figure(
  image("fig/Functions_between_metric_spaces.svg", width: 40%),
  caption: [
    各种各样的“连续” | #link("https://commons.wikimedia.org/wiki/File:Functions_between_metric_spaces.svg")[Wikimedia Commons `Functions between metric spaces.svg`]
  ]
)

不过这里只谈最基础的那种连续，我们要构造这样一个例子：
#align(center)[
  - 几乎处处连续，且几乎处处不连续；
  - 所有不连续点都是本质间断点。
]

#remark[本质间断][
  所谓“本质间断”，是指 $lim_(x -> c) f(x)$ 根本不存在，而非仅仅与 $f(c)$ 不同（如可去奇点、跳变）。
]

之所以这么想，是因为若干著名反例恰好都不是本质间断，而逻辑似乎允许这样的函数存在。

= 一些著名反例

- *Dirichlet函数*
  $
  x |-> cases(
    1 &space.quad x in QQ,
    0 &space.quad x in.not QQ,
  )
  $
  在整个 $RR$ 上处处不连续。#footnote[
    若把定义域限制到 $QQ$，仍然可以定义极限，这时 Dirichlet 恒取 $1$，连续。——要区分“在□□内连续”和“在□□上处处连续”，我们后面都指后者。
  ]

- *Thomae爆米花函数*（又名Riemann函数、Stars over Babylon）
  $
  x |-> cases(
    1/q &space.quad x = p/q in QQ "其中" p\,q "互质",
    0 &space.quad x in.not QQ,
  )
  $
  在 $QQ$ 上处处不连续，在 $RR without QQ$ 上处处连续但不可导。#footnote[
    Dirichlet 函数的两条规定可以交换，但Thomae函数不能。
  ]

- *Cantor三分阶梯函数*（又名Lebesgue函数、魔鬼的阶梯） $c: [0,1] -> [0,1]$ 可用如下方法构造。
  1. 将 $x in [0,1]$ 表示为三进制，若包含 $1$，则只保留到首个 $1$（将后面所有位改为 $0$）。
  2. 将剩下的所有 $2$ 改为 $1$。
  3. 这时结果只含 $0,1$，将它按二进制解释即为 $c(x)$。
  它在 $[0,1]$ 上处处连续但并不绝对连续。#footnote[
    并且几乎处处有零导数。不过这次不谈导数，上面也不再列Weierstrass函数等。
  ]

  #figure(
    image("fig/cantor.png", width: 50%),
    caption: [Cantor函数]
  )
  // Mathematica:
  // Plot[CantorStaircase[x], {x, 0, 1}, AspectRatio -> 1,
  //  GridLines -> {Nest[Join[#/3, (# + 2)/3] &, {0, 1}, 4],
  //    Range[0, 1, 2^-4]},
  //  Ticks -> {Nest[Join[#/3, (# + 2)/3] &, {0, 1}, 2], Range[0, 1, 2^-2]}
  //  ]

#remark[Dirichlet函数作为连续函数序列的极限][
  Dirichlet函数也可表示为
  $
  x |-> lim_(k -> +oo) lim_(j -> +oo) cos^(2j) (k! pi x).
  $

  #figure(
    image("fig/baire-1.png", width: 40%),
    caption: $cos^(2j) (k! pi x)$
  )
  // Mathematica:
  // With[{js = {1, 2, 3, 5, 10, 20, 30}},
  //  Plot[Cos[\[Pi] x]^(2 js) // Evaluate, {x, 0, 4},
  //   GridLines -> Automatic, Ticks -> None,
  //   PlotLegends -> Map[HoldForm[j = #] &, js]]
  //  ]

  1. $x |-> cos^(2j) (k! pi x)$ 是连续函数。

  2. $x |-> lim_j cos^(2j) (k! pi x)$ 在 $abs(cos(k! pi x)) = 1$ 时取 $1$，其余取 $0$。注意取 $1$ 的点是压缩过的整点：
    $
      abs(cos(k! pi x)) = 1 space<==>space k! pi x in pi ZZ space<==>space x in 1/k! ZZ.
    $
    于是取极限后函数不连续了。

  3. $x |-> lim_k lim_j cos^(2j) (k! pi x)$ 仍然只取 $0,1$，并且取 $1$ 的条件是
    $
    exists k_0 forall k >= k_0, space x in 1/k! ZZ.
    $
    由于 $1/k! = 1/(k_0 !) times 1/((k_0+1) (k_0+2) dots.c (k-1) k)$，所以 $1/(k_0 !) ZZ subset 1/k! ZZ$，故取 $1$ 的条件就是 $exists k_0, x in 1/(k_0 !) ZZ$，即 $x in QQ$。

  像上面这样考虑连续函数序列的累次极限，可以给函数分层级：
  1. Baire class 0 是所有连续函数。
  2. Baire class $alpha$ 是能用 Baire class $(alpha-1)$ 中函数序列的逐点极限表示的函数。可以论证 Baire class $alpha$ 总比 Baire class $(alpha-1)$ 大。
  3. 除此以外，还存在不属于任意 Baire class 的函数。

  根据 $x |-> lim_k lim_j cos^(2j) (k! pi x)$，我们说明了Dirichlet函数至少属于 Baire class 2；它不连续，从而不属于更小的 Baire class 0；那它是否属于介于其间的 Baire class 1 呢？并不属于，因为Dirichlet函数处处不连续，超出了 Baire class 1 所能容忍的不连续性。具体的论证将在后文提到。
]

#remark[Thomae函数与最大公约数][
  考虑最大公约数函数 $gcd: NN^2 -> NN$ 的三维图象，把定义域、值域缩放到 $([0,1] sect QQ)^2 -> [0,1] sect QQ$，然后取个坐标面（因为自相似，取哪个都一样），截出来的二维图象就是Thomae函数在 $[0,1]$ 上的图象。

  具体来说，如果规定 $(x,y) in.not NN^2$ 时，$gcd(x,y) = 0$，那么
  $ x |-> limsup_(N -> +oo) gcd(N x, N) / N $
  就是Thomae函数。

  #figure(
    image("fig/gcd.png", width: 80%),
    caption: [
      $6,30,100$ 以内数的 $gcd$

      第 $y$ 行第 $x$ 列的颜色表示 $gcd(x,y)$。如图例所示，越深越大（线性对应），但直接比较不同图的颜色无意义。
      （2020年8月11日有动图）
    ]
  )
  // Mathematica:
  // Table[Table[GCD[x, y], {x, n}, {y, n}] //
  //  MatrixPlot[#, PlotLegends -> Placed[Automatic, Bottom],
  //    ImageSize -> Small] &, {n, {6, 30, 100}}] // Row
]

#remark[Thomae函数与Euclid果园][
  在 $RR^2$ 平面内，在 $ZZ^2$ 种上高为 $1$ 的树。从原点看去，有些树直接可见（如 $(3,4)$），有些树会被挡住（如 $(6,8)$ 被 $(3,4)$ 挡住）。这称作Euclid果园。

  #figure(
    image("fig/Euclid_orchard_trimetric.svg", width: 60%),
    caption: [
      Euclid果园 | #link("https://en.wikipedia.org/wiki/File:Euclid_orchard_trimetric.svg")[Wikimedia Commons `Euclid orchard trimetric.svg`]

      站在原点，只能看到蓝色的树，看不到橙色的树。
    ]
  )

  在 $RR^3$ 内，将这些树关于原点投影到平面 $x+ y = 1$ 上（即 $(x,y,z) |-> ((x,y,z))/(x+y)$），也能得到Thomae函数的图象。

  #figure(
    image("fig/Euclid%27s_Orchard_%28perspective%29.svg", width: 60%),
    caption: [
      Euclid果园的投影#footnote[
        此图并非投影到 $x+y=1$，而是投影到 $x^2+y^2=1$，因此与Thomae函数相比略有变形。
      ] | #link("https://en.wikipedia.org/wiki/File:Euclid%27s_Orchard_(perspective).svg")[Wikimedia Commons `Euclid's Orchard (perspective).svg`]

      正中央的树位于 $y = x$，红色的树位于 $y = x plus.minus 2$。
    ]
  )
]

#remark[Cantor函数的构造方法][
  上面给出的构造方法中，最关键的是“三进制 → 二进制”，其它手续基本是细枝末节。

  - 将所有 $2$ 改为 $1$ 只是乘了个系数。

  - 如果 $x$ 的三进制表示包含 $1$，则可暂时不定义 $c(x)$，先定义那些不含 $1$ 的，最后再按单调性补充。

    具体来说，设 $x$ 的首个 $1$ 是第 $n$ 位，即
    $
    x = underbrace((2triangle.t)/3^1 + (2 space square)/3^2 + dots.c + (2circle)/3^(n-1), "前"n-1"位只含" 0\,2)
      + underbrace(1/3^n, "第"n"位是"1)
      + underbrace(diamond/3^(n+1) + dots.c, "后面怎样不再重要").
    $
    记 $x$ 保留到第 $n-1$ 位是 $overline(x)$，那么
    $
    c(overline(x) + 1/3^n)
    &= c(overline(x) + 2/3^(n+1) + 2/3^(n+2) + dots.c) \
    &= (triangle.t/2^1 + dots.c + circle/2^(n-1)) + (1/2^(n+1) + 1/2^(n+2) + dots.c) \
    &= (triangle.t/2^1 + dots.c + circle/2^(n-1)) + 1/2^n \
    &= c(overline(x) + 2/3^n).
    $
    而 $x in [overline(x) + 1/3^n, overline(x) + 2/3^n]$，于是 $c(x)$ 只好也取这个值。

  整理一下，设 $overline(x) + 1/3^n, overline(x) + 2/3^n$ 这种三进制只含 $0,2$ 的数的集合是 $cal(C)$（这正是后文的 Cantor 集），那么
  $
  c(x) = cases(
    sum_n a_n/2^n &space.quad x = sum_n (2a_n)/3^n in cal(C),
    sup c([0,x] sect cal(C)) &space.quad x in.not cal(C),
  ).
  $
]

= Baire 空间

为了让目前不懂或曾经懂过的人理解什么是“几乎处处”“连续”“本质间断”，需要明确若干概念。

$X$ 内有一点 $x$，考查 $x$ 的邻域 $U$ 和去心邻域 $U^0 := U without {x}$ 与集合 $S subset X$ 及其补集 $S^complement$ 的相交情况。
#place(
  right,
  dx: 1.5em,
  dy: 2.5em,
  grid(
    columns: (auto, auto),
    column-gutter: 0.25em,
    $cases(reverse: #true, #v(5em))$,
    [
      #set align(left + horizon)
      *聚点*（accumulation，导集，derived）

      $U^0 sect S != emptyset$
    ]
  )
)
- 附着点（*闭包*，closure）：$U sect S != emptyset$
  - *内点*（内部，interior）：$U subset S$
  - 边界点（*边界*，boundary）：$U sect S^complement != emptyset and U sect S != emptyset$
    - $U^0 sect S != emptyset and U sect S^complement != emptyset$
    - #strong[孤立]点（isolated）：$U^0 subset S^complement and x in S$
- 外点（外部，exterior）：$U subset S^complement$

#figure(
  image("fig/Interior_illustration.svg", width: 30%),
  caption: [
    $x$ 是 $S$ 的内点，$y$ 是 $S$ 的边界点 | #link("https://commons.wikimedia.org/wiki/File:Interior_illustration.svg")[Wikimedia Commons `Interior illustration.svg`]
  ]
)

由定义形式可知：
- 闭包可划分为内部、边界，也可划分为聚点、孤立点，这是两组概念；
- $S$ 的边界也是 $S^complement$ 的边界，所以前一种划分更为对称。

#remark[$forall$ 还是 $exists$，$U^0 attach(=, t: ?) emptyset$][
  所有“$!= emptyset$”都是“$forall U$”，其余都是“$exists U$”。

  不过即使补上量词，上述分类也有瑕疵：假设了 $forall U, U^0 != emptyset$。这在 $RR^n$ 确实成立，但在一般拓扑空间（如最精细的离散拓扑空间），就不成立。

  无论假设是否成立，以下命题都成立。
  - $X$ 可划分为闭包、外部。
  - 闭包可划分为“内部、边界”和“聚点、孤立点”。
  - 一点既是边界点又是聚点。$<==> forall U, space U^0 sect S != emptyset and U sect S^complement != emptyset.$

  唯一可能错误的是下面这组等价命题。（照例省略 $forall$ 和 $exists$）
  - 内点 $=>$ 聚点。
  - $U subset S => U^0 sect S != emptyset.$
  - $U^0 subset S^complement => U sect S^complement != emptyset.$
  - $U^0 subset S^complement and x in S ==> U sect S^complement != emptyset and U sect S != emptyset.$
  - 孤立点 $=>$ 边界点。
  其中那对逆否命题等价于
  $
  & U^0 sect S != emptyset or U sect S^complement != emptyset. \
  &<==> U^0 sect S != emptyset or (U^0 union {x}) sect S^complement != emptyset. \
  &<==> U^0 sect S != emptyset or (U^0 sect S^complement != emptyset or x in.not S). \
  &<==> (U^0 sect S != emptyset or U^0 sect S^complement != emptyset) or x in.not S. \
  &<==> U^0 sect (S union S^complement) != emptyset or x in.not S. \
  &<==> U^0 != emptyset or x in.not S. \
  $
  只有 $S$ 中所有点的所有去心邻域都非空时才成立。事实上，若 $x in S$ 存在 $U^0 = emptyset$，那么按定义 $U subset S, U^0 subset S^complement$，于是 $x$ 既是内点又孤立，立即构成反例。
]

#figure(
  image("fig/final_frontier.png", width: 60%),
  caption: [$RR^2$ 内的一个点集（黑灰点），以及它的导集（橙虚线）

    这个点集由 $ZZ times NN times {-1} subset RR^3$ 关于 $(0,0,0)$ 投影而成。

    它所有点都是孤立的边界点，没有内点；聚点都不在其中，但都是边界点。
  ]
)
// Mathematica:
// With[{a = 2.2, yMax = 50}, Graphics[{
//    Table[{GrayLevel[1 - 1/y],
//      Point@Map[{#/y, -2/y} &,
//        With[{e = Ceiling[y a]}, Range[-e, e]]]}, {y, yMax}],
//    Dashed, Orange, Line@{{-a, 0}, {a, 0}}
//    }, PlotRange -> {{-a, a}, {-a, 0}}
//   ]]

理解了闭包的两种划分，就可以进一步谈集合的性质了。
#footnote[
  这里涉及开、闭、孤立。（open, closed, isolated）有趣的是，热学中系统刚好有开放、封闭、孤立的说法：开放系统允许与外界交换物质、能量，封闭系统不交换物质，孤立系统两者都不交换。
]

#figure(
  tablex(
    columns: (auto, auto),
    auto-vlines: false,
    auto-hlines: false,
    [*原集合的性质*], vlinex(), [*补集相应性质*],
    hlinex(),
    [开 open #h(1fr)——边界全无], [闭 closed #h(1fr)——边界全管],
    [稠密 dense #h(1fr)——闭包取满], [无内点 has empty interior],
    [内点稠密 has dense interior], [无处稠密 nowhere dense #h(1fr)——闭包也无内点],
    [$G_delta$ #h(1fr)——开集的可数交], [$F_sigma$ #h(1fr)——闭集的可数并],
    [comeagre#footnote[我尝试了多种翻译服务，只有必应有时能输出汉字：科马格雷。]], [疏朗 meagre #h(1fr)——无处稠密集的可数并],
  ),
  caption: [Baire空间涉及的若干性质]
)

#remark[相对概念][稠密必须谈背景。]

#set heading(numbering: none)
= 他典等

- #link("https://en.wikipedia.org/wiki/Thomae%27s_function")[Thomae's function - Wikipedia]
- #link("https://en.wikipedia.org/wiki/Baire_function")[Baire function - Wikipedia]
- #link("https://en.wikipedia.org/wiki/Baire_space")[Baire space - Wikipedia]
- #link("https://mp.weixin.qq.com/s/Km8iIghIn-aAKT0YQKHWAw")[解题的策略 - 陶哲轩教你学数学]

= 致谢

华歆在群里提出了这个问题，原始表述大致如下。
#quote(block: true)[
  $A,B$ 是 $RR$ 的一个划分，并且它们的闭包都是 $RR$。
  证明或证伪：不存在在 $A$ 上处处连续、在 $B$ 上处处本质间断的函数。
]
我当时认为命题成立，尝试证明未果，到 Math.SE 上提问。
#quote(block: true)[
  #link("https://math.stackexchange.com/questions/4792247/essentially-discontinuous-on-a-dense-subset-of-mathbbr-but-continuous-on-t")[real analysis - Essentially discontinuous on a dense subset of $RR$, but continuous on the complement which is also dense - Mathematics Stack Exchange (q/4792247)]
]
几位网友帮助明确了问题（那些评论后来已按惯例删除），不久 #link("https://math.stackexchange.com/users/111012/bof")[bof] 构造出了反例。
然而我只看懂了验证，没理解括号中的构造过程。项羽帮忙查了些资料，共工在群里给出了完整解释。

#pseudonyms("pseudonym", subset: ("华歆", "共工", "项羽"))
