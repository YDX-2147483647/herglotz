#import "template.typ": project, remark, pseudonyms

#show: project.with(title: "既连续又本质间断", date: "2023年10月23–24日，11月7日")

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

#set heading(numbering: none)
= 他典等

- #link("https://en.wikipedia.org/wiki/Thomae%27s_function")[Thomae's function - Wikipedia]

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
