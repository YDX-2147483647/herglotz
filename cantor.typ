#import "template.typ": project, remark, pseudonyms, example, table-header

#show: project.with(title: "既连续又本质间断", date: "2023年10月23–24日，11月7、13–14、16–20日，12月16日，2024年1月3日")

#quote(
  block: true,
  attribution: [_Profiles of the Future_ (1962) ch. 2, Arthur C. Clarke],
)[
  The only way of discovering the limits of the possible is to venture a little
  way past them into the impossible.
]

$RR -> RR$ 函数中，存在完全连续的，存在某一点不连续的，存在处处不连续的，存在几乎处处连续又几乎处处不连续的；存在完全连续但好像又会跳变的；存在连续但又无限振荡的；……
连续性的边界在哪里？这显然取决于你如何定义“连续”，并且这些定义可按“$=>$”排成一串或几串。

#figure(
  image("fig/Functions_between_metric_spaces.svg", width: 40%),
  caption: [
    各种各样的“连续” | #link("https://commons.wikimedia.org/wiki/File:Functions_between_metric_spaces.svg")[Wikimedia Commons `Functions between metric spaces.svg`]
  ]
)

不过这里只谈最基础的那种连续，我们要构造这样一个例子：
#[
  #show list: set align(center)
  #show par: set align(start)
  - 几乎处处连续，且几乎处处不连续；
  - 所有不连续点都是本质间断点。
]

#remark[本质间断][
  所谓“本质间断”，是指 $lim_(x -> c) f(x)$ 根本不存在，而非仅仅与 $f(c)$ 不同（如可去奇点、跳变）。
]

之所以这么想，是因为若干著名反例恰好都不是本质间断，而逻辑似乎允许这样的函数存在。

#pagebreak()
= 一些著名反例

- *Dirichlet函数*
  $
  x |-> cases(
    1 &space.quad x in QQ,
    0 &space.quad x in.not QQ,
  )
  $
  在整个 $RR$ 上处处不连续。#footnote[
    若把定义域限制到 $QQ$，仍然可以定义极限，这时 Dirichlet 函数恒取 $1$，从而连续。——要区分“在□□内连续”和“在□□上处处连续”，我们后面都指后者。
  ]

- *Thomae爆米花函数*（又名Riemann函数、Stars over Babylon）
  $
  x |-> cases(
    1/q &space.quad x = p/q in QQ "其中" p\,q "互质",
    0 &space.quad x in.not QQ,
  )
  $
  在 $QQ$ 上处处不连续，在 $RR without QQ$ 上处处连续但不可导。#footnote[
    Dirichlet 函数的两条规定可以交换，但Thomae函数不能。后面将证明不存在 $QQ$ 上处处连续、$RR without QQ$ 上处处不连续的函数。
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

#pagebreak()
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

  - 将所有 $2$ 改为 $1$ 只是乘了个系数 $1/2$。

  - 如果 $x$ 的三进制表示包含 $1$，则可暂时不定义 $c(x)$；先定义那些不含 $1$ 的，最后再按单调性补充。

    具体来说，设 $x$ 的首个 $1$ 是第 $n$ 位，即
    $
    x = underbrace((2triangle.t)/3^1 + (2 space square)/3^2 + dots.c + (2circle)/3^(n-1), "前"n-1"位只含" 0\,2)
      + underbrace(1/3^n, "第"n"位是"1)
      + underbrace(diamond/3^(n+1) + dots.c, "后面怎样不再重要").
    $
    记 $x$ 保留到第 $n-1$ 位是 $overline(x)$，那么交错使用有限小数的两种表示方法，
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

== 点

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
  - *内*点（内部，interior）：$U subset S$
  - 边界点（*边界*，boundary）：$U sect S^complement != emptyset and U sect S != emptyset$
    - $U^0 sect S != emptyset and U sect S^complement != emptyset$
    - *孤立*点（isolated）：$U^0 subset S^complement and x in S$
- 外点（外部，exterior）：$U subset S^complement$

#figure(
  image("fig/Interior_illustration.svg", width: 30%),
  caption: [
    $x$ 是 $S$ 的内点，$y$ 是 $S$ 的边界点 | #link("https://commons.wikimedia.org/wiki/File:Interior_illustration.svg")[Wikimedia Commons `Interior illustration.svg`]
  ]
)

#figure(
  image("fig/synapse.svg", width: 30%),
  caption: [
    闭包等概念的Euler图 | 删改自 #link("https://commons.wikimedia.org/wiki/File:SynapseSchematic_lines.svg")[Wikimedia Commons `SynapseSchematic lines.svg`]

    虚线以上代表 $S$。有凹窝区域（贝壳颜色）代表 $S$ 的内部（即 $S^complement$ 的外部），与之相对区域（紫）代表 $S$ 的外部（即 $S^complement$ 的内部），其余代表边界（$S, S^complement$ 共享边界）。六边形（绿）代表 $S$ 的孤立点，三角形（红）代表 $S^complement$ 的孤立点。边界和内部之并是闭包，闭包中孤立点以外部分是聚点。
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
  - 孤立点 $=>$ 边界点。（$U^0 subset S^complement and x in S ==> U sect S^complement != emptyset and U sect S != emptyset.$）
  中间两行互为逆否，它们也等价于 $U^0 sect S != emptyset or U sect S^complement != emptyset$。分类讨论可知它等价于 $U^0 != emptyset or x in.not S$：
  - $x in.not S$ 时，$U sect S^complement supset {x} sect S^complement = {x} != emptyset$，原命题后半部分恒真。
  - $x in S$ 时，整个命题化为 $U^0 sect S != emptyset or U^0 sect S^complement != emptyset$，即 $U^0 = U^0 sect (S union S^complement) != emptyset$。
  于是这只有 $S$ 中所有点的所有去心邻域都非空时才成立。事实上，若 $x in S$ 存在 $U^0 = emptyset$，那么按定义 $U subset S, U^0 subset S^complement$，于是 $x$ 既是内点又孤立，立即构成反例。
]

#figure(
  image("fig/final_frontier.png", width: 60%),
  caption: [
    $RR^2$ 内的一个点集（黑灰点），以及它的导集（橙虚线）#footnote[
      橙虚线的导集是其自身，所以它是黑灰点集反复取导集的最终结果。又，代数拓扑、流形中有其它boundary概念，为避免混淆，点集拓扑中的边界有时改称frontier。综合两点，橙虚线是名副其实的 _final frontier_。
    ]

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

== 集合

理解了点的性质，就可以进一步谈集合的性质了。
#footnote[
  这里涉及开、闭、孤立。（open, closed, isolated）有趣的是，热学中系统刚好有开放、封闭、孤立的说法：开放系统允许与外界交换物质、能量，封闭系统不交换物质，孤立系统两者都不交换。
]
例如，若一个集合等于其导集，则称它*perfect*，这等价于它是无孤立点的闭集。更多定义如@tab:def-pairs。

#figure(
  table(
    columns: 2,
    table-header[原集合的性质][补集相应性质],
    [开 open #h(1fr)——边界全无], [闭 closed #h(1fr)——边界全管],
    [稠密 dense #h(1fr)——闭包取满#footnote[稠密必须谈背景，这里默认在 $RR$ 中。]], [无内点 has empty interior],
    [内点稠密 has dense interior], [无处稠密 nowhere dense #h(1fr)——闭包也无内点],
    [$G_delta$ #h(1fr)——开集的可数交], [$F_sigma$ #h(1fr)——闭集的可数并],
    [comeagre#footnote[我尝试了多种翻译服务，大多原样返回，仅DeepL和必应有时会翻译：前者给出`""`（一对引号）或“蔚为大观”，后者给出“科马格雷”。]], [疏朗 meagre#footnote[又叫first category，意思是按meagre与否将集合分为两类。不过取“第一”“第二”这种名字，还不如随机地叫“元伶外夜承”“承夜外伶元”，那样既强调仅有两类，又不会与其它术语混淆。另外，这个category常译作“纲”（→界门纲目科属种），但容易误以为提纲、纲领，所以我们也不采用。] #h(1fr)——无处稠密集的可数并],
  ),
  caption: [Baire空间涉及的若干性质]
) <tab:def-pairs>

#remark[$F_sigma, G_delta$ 定义的反面][
  开集的任意并仍是开集，而 $F_sigma$（闭集的可数并）就未必是闭集了，例如 $union.big_(n in NN) [0, 1-1/n] = [0,1)$。
]

#example[$QQ$ 的性质][在 $RR$ 中，$QQ$ 有如下性质。
  #show "❌": text.with(fill: red)
  #show "✅": text.with(fill: green)
  #show regex("[❌✅]"): set text(font: "Segoe UI Emoji")

  #figure(
    table(
      columns: 2,
      table-header[一种性质][另一种性质],
      [❌开], [❌闭],
      [✅稠密], [✅无内点],
      [❌内点稠密], [❌无处稠密],
      [❌$G_delta$], [✅$F_sigma$],
      [❌comeagre], [✅meagre],
    ),
    caption: [$QQ$ 在 $RR$ 中的性质]
  )

  由 $RR$ 的构造过程、$QQ$ 可数，立即得到大部分结论；剩下的由可数集之并仍可数，可转为 $RR$ 的性质。

  - 假设 $QQ$ 是 $G_delta$ 集，结合 $RR without QQ$ 是 $G_delta$ 集，得 $emptyset = QQ sect (RR without QQ)$ 也 $G_delta$。

    $emptyset$ 确实 $G_delta$，不过注意 $QQ, RR without QQ$ 都稠密，这不仅导出 $emptyset$ 是开集的可数交，还导出 $emptyset$ 是稠密开集的可数交，这可能吗？

  - 假设 $QQ$ comeagre，则 $RR without QQ$ meagre。结合 $QQ$ meagre，得 $RR = QQ union (RR without QQ)$ 也 meagre。

    $RR$ 不可数、稠密，它可能meagre吗？

  以上两点在Baire空间中都不可能。后面就将介绍这种空间。
]

#remark[$F_sigma$ 与meagre][
  $F_sigma$ 被嵌入了meagre的定义——无内点的 $F_sigma$ 集必定meagre。原因如下。

  1. 由内点和并集的定义，$A_n$ 的内点也是 $union.big_n A_n$ 的内点，于是“$union.big_n A_n$ 无内点 $=> A_n$ 均无内点”。
  2. 若无内点的 $A_n$ 是闭集，则 $A_n$ 无处稠密，于是“$A_n$ 均无内点 $=> union.big_n A_n$ 符合meagre的定义”。

  正命题“无内点 $=>$ meagre”成立，那反命题“meagre $=>$ 无内点”成立吗？这正是Baire空间要讨论的。
]

#remark[Dirichlet函数不属于Baire class 1][
  #let diam = math.op("diam")

  1. *任何函数的间断点集合都 $F_sigma$。*

    1. 函数 $f$ 在 $x$ 的*振荡*（oscillation） $omega_f (x) := inf_(delta > 0) diam f(U_delta (x))$#footnote[这也是 $lim_(delta->0)$。（单调递减，非负，必存在极限）]，其中 $diam$ 表示集合的直径（其中点间的最大距离）。
    2. $f$ 在 $x$ 连续的定义是 $forall epsilon > 0, exists delta > 0, space f(U^0_delta (x)) subset U_epsilon (f(x))$，必要条件是 $diam f(U_delta (x)) < 2epsilon$，充分条件是 $diam f(U_delta (x)) < epsilon/2$，于是可知 $f$ 在 $x$ *连续等价于 $omega_f (x) = 0$*。
    3. $forall x in U_delta (x_0), space U_(2 delta) (x_0) supset U_delta (x)$。于是若 $omega(x_0) < Omega$，则 $exists delta > 0, diam f(U_(2delta) (x_0)) < Omega$，故 $forall x in U_delta (x_0), omega(x) < Omega$。换句话说，${x: omega(x) < Omega}$ 总是开集，故 *${x: omega(x) >= Omega}$ 总是闭集*。
    4. $f$ 的*间断点集合*是 ${x: omega(x) > 0}$，它也可写成
      $
      union.big_(n in NN) {x: omega(x) >= 1/n}
      $
      这样可数个闭集之并，于是 *$F_sigma$*。#footnote[
        这是集合的极限 $lim_n {x: omega(x) >= 1/n}$。
      ]

    Thomae函数的间断点集合是 $QQ$，确实 $F_sigma$；但不存在一个函数，它的间断点集合是 $RR without QQ$，因为它并不 $F_sigma$（前面刚论证了Baire空间中 $QQ$ 不 $G_delta$）。

  2. *Baire class 1函数的间断点集合 meagre $F_sigma$。*

    Wikipedia给出的来源是 Kechris, Alexander S. _Classical Descriptive Set Theory_ (1995) 定理24.14，不过我查到一个足以排除Dirichlet函数的更弱的定理，它是 #link("https://www.whitman.edu/Documents/Academics/Mathematics/huh.pdf")[Baire one functions - Johnny Hu (`whitman.edu`)] 的第15页的定理4的一半。

    1. 连续性的拓扑学定义是“开集的原像总是开集”。具体到 $RR -> RR$ 函数，只需说明 $(-oo, r), (r,+oo)$ 这两种开集的原像总是开集。

      例如Dirichlet函数不连续，$(-oo, 1/2)$ 的原像是 $RR without QQ$，并不是开集。

    2. 现在考察Baire class 1函数。设 $f_k$ 均连续且逐点收敛到 $f$，那么
      $
      {x: f(x) < r}
      &= lim_(n -> +oo) {x: f(x) <= r - 1/n} \
      &= lim_(n -> +oo) op("lim inf", limits: #true)_(k -> +oo) {x: f_k (x) <= r - 1/n} \
      &= union.big_(n in NN) union.big_(k in NN) sect.big_(k' >= k) {x: f_k' (x) <= r - 1/n}.
      $
      第一个等号是 $union.big_n (-oo, r-1/n] = (-oo, r)$ 两边套 $f^(-1)$，第二个等号是极限的局部保号性，第三个等号是按集合极限的定义重写了一下。

      - 因为 $f_k'$ 连续，$(r-1/n, +oo)$ 的原像总是开集，故 ${x: f_k' (x) <= r - 1/n}$ 总是闭集。作为闭集的任意交，$sect.big_(k' >= k) {x: f_k' (x) <= r - 1/n}$ 仍是闭集。

      - $NN^2$ 可数，$union.big_n union.big_k$ 仍然是可数并。

      于是 ${x: f(x) < r}$ 写成了闭集的可数并，$F_sigma$。

    3. Dirichlet函数 $(-oo, 1/2)$ 的原像是 $RR without QQ$，并不 $F_sigma$，所以它不属于Baire class 1。

    4. 上面说明了“*$(-oo, r)$ 的原像总 $F_sigma$*”是Baire class 1的必要条件。其实那个定理4证明了“$(-oo, r), (r, +oo)$ 的原像总 $F_sigma$”也是充分条件。不过构造过程相对繁琐，这里不再叙述；也许存在更直接的证明吧。
]

== Baire category theorem

Baire空间有如下等价定义。

#figure(
  image("fig/baire_space-no_context_strokes.svg", width: 80%),
  caption: [Baire空间的若干等价定义]
)

Baire category theorem指出 $RR$ 是Baire空间，我们从“稠密开集的可数交 $=>$ 稠密”入手证明这一点。

0. 设 $A_n$ 均是稠密开集，要证 $A = sect.big_n A_n$ 稠密，即对任意开集 $O$，$O sect A != emptyset$。
1. 先考虑 $O sect A_1$。由 $A_1$ 稠密、开，$O sect A_1$ 是非空开集。于是可构造非空闭球 $overline(B_1) subset O sect A_1$。注意 $overline(B_1)$ 的内部 $B_1$ 也是开集，可进一步构造 $overline(B_2) subset B_1 sect A_2$。以此类推，$overline(B_n) subset B_(n-1) sect A_n$。
2. 选取 $B_n$ 时，可让 $B_n$ 的直径小于 $1/n$，保证 $B_n$ 的直径趋于零，从而这些球的中心构成Cauchy列。由 $RR$ 完备，存在极限 $x$。
3. $O sect A supset sect.big_n overline(B_n) supset {x} != emptyset$，命题得证。

#remark[选择公理][
  选取 $B_n$ 的过程需要axiom of dependent choice，可以证明ZF公理体系中，完备度量空间上的Baire category theorem与axiom of dependent choice等价。
]

#remark[真正的Baire category theorem][
  上述证明只用到了“直径趋于零的闭集套交集非空”，可以推广到更抽象的空间。真正的Baire category theorem给出了下面两个没有蕴含关系的充分条件。
  1. 完备的伪度量空间。（从Cauchy列出发）
  2. 局部紧空间。（从闭区间套出发）
  （直径趋于零是必要的：$sect.big_n [n,+oo) = emptyset$）
]

= 这就是现实

现在回顾最初的目标，要构造一个函数 $f$，满足以下两点。
- 几乎处处连续，且几乎处处不连续——将 $f$ 的间断点的集合记作 $A$，要求 $A,A^complement$ 都在 $RR$ 中稠密，即 $A$ 稠密且无内点。
- 所有不连续点都是本质间断点——$forall a in A, space lim_(x->a) f(x)$ 不存在。

我们的计划如下。

0. 将 $A$ *拆*为一系列互不相交的集合 $A_n$ （$n in NN$），取
  $
  f(x) = cases(
    1/n &space x in A_n,
    0 &space x in.not A
  ).
  $

1. *构造*时让 $A = union.big_(n in NN) A_n$ 稠密，而每个 $A_n$ 又足够稀松且补集性质优良。

2. *证明* $A$ 中都是间断点，$A^complement$ 中都是连续点。

== 构造

1. 由于 $QQ^2$ 可数，可*构造 $I_n$* 遍历所有“两端点是有理数的开区间”。

2. 逐一*构造 $A_n$* $subset I_n without union.big_(m < n) A_m$ 并且 $A_n$ 是*无处稠密*的 *perfect* 集。

  因为先构造的 $A_m$ 都无处稠密，故补集 $RR without union.big_(m < n) A_m$ 的内点稠密，于是 $I_n without union.big_(m < n) A_m$ 总有内点。在这内点的邻域内，总有段区间可自由发挥来继续满足要求，例如平移缩放Cantor集。

3. 论证 *$A$ 稠密*。

  任取 $x in RR$ 及其邻域 $U$，必存在 $I_n subset U$（因为 $QQ$ 稠密），因而 $U sect A supset U sect A_n != emptyset$。

4. 再论证*补集 $A^complement$ 也稠密*。

  $A$ 是可数个无处稠密集 $A_n$ 之并，即 $A$ meagre，于是 $A^complement$ comeagre，而Baire空间中comeagre集都稠密。

#remark[Cantor集][
  原版Cantor集 $cal(C)$ 是 $[0,1]$ 中三进制只含 $0,2$ 的数的集合，它也是不含“中间 $1/3$ 开区间”的自相似分形。

  #figure(
    image("fig/Cantor_set_binary_tree.svg", width: 50%),
    caption: [
      不断去掉中间部分可得到Cantor集 | #link("https://commons.wikimedia.org/wiki/File:Cantor_set_binary_tree.svg")[Wikimedia Commons `Cantor set binary tree.svg`]
    ]
  )

  - 闭：迭代构造时，每一阶段都是闭集，$cal(C)$ 是这些闭集的交集，也闭。
  - 无内点：迭代 $n$ 次后，不再存在长于 $1/3^n$ 的区间。
  - 无孤立点：迭代 $n$ 次时，可确定此时每段闭区间的端点属于 $cal(C)$，并且这些点与此时整个集合任意点的最大距离是 $1/(2 times 3^n)$。
  综合以上各点，$cal(C)$ 是无处稠密的perfect集。
]

== 证明

- 证明 $A$ 中都是*间断*点。

  设 $x in A_n$。

  - $A^complement$ 稠密，所以 $x$ 是 $A^complement$ 的聚点，而 $f(A^complement) = {0}$。
  - $A_n$ 闭，所以 $x$ 也是 $A_n$ 的聚点，而 $f(A_n) = {1/n}$。

  我们构造了两个趋于 $x$ 的子列，极限分别是 $0,1/n$，不一致，故极限不存在。

- 证明 $A^complement$ 中都是*连续*点。

  设 $x in A^complement$，要证明 $f$ 在 $x$ 处的极限等于 $f(x) = 0$。

  1. 任取 $epsilon$，$union.big_(1/n >= epsilon) A_n$ 是有限个闭集之并，仍闭。
  2. $x in.not A$，故不属于 $union.big_(1/n >= epsilon) A_n$，从而是这个闭集的外点，从而 $exists delta$，
    $
    U_delta^0
    &subset RR without union.big_(1/n >= epsilon) A_n
    = A^complement union union.big_(1/n < epsilon) A_n.
    $
  3. 代入 $f$ 的定义，得
    $
    f(U_delta^0)
    subset {0} union {1/n: 1/n < epsilon}
    subset U_epsilon (0).
    $

#pagebreak()
#set heading(numbering: none)
= 他典等

- #link("https://en.wikipedia.org/wiki/Thomae%27s_function")[Thomae's function - Wikipedia]
- #link("https://en.wikipedia.org/wiki/Baire_function")[Baire function - Wikipedia]
- #link("https://en.wikipedia.org/wiki/Baire_space")[Baire space - Wikipedia]
- #link("https://mp.weixin.qq.com/s/Km8iIghIn-aAKT0YQKHWAw")[解题的策略 - 陶哲轩教你学数学]
- #link("https://en.wikipedia.org/wiki/Boundary_(topology)")[Boundary (topology) - Wikipedia]
- #link("https://www.ucl.ac.uk/~ucahad0/3103_handout_7.pdf")[Handout \#7: The Baire category theorem and its consequences - Mathematics 3103 (Functional Analysis), Year 2012–2013, Term 2 (`ucl.ac.uk`)]
- #link("https://en.wikipedia.org/wiki/Axiom_of_dependent_choice")[Axiom of dependent choice - Wikipedia]

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
