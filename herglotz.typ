#import "@preview/physica:0.9.5": dd, dv, Re, Im, Res as _Res, Order, evaluated as eval, difference

#import "template.typ": project, remark, example, small, pseudonyms

#show: project.with(title: "Herglotz Trick", date: "2023年10月9–10、11、26–28日，12月16日")

#let Res = math.limits(_Res)
#let comb = math.op("Ш")

= 倒数和 <sec:intro>

众所周知，调和级数
$
sum_(n in ZZ^+) 1 / n
= 1/1 + 1/2 + 1/3 + dots.c
= +oo.
$
若*将 $n$ 平移* $1/2$，得到下面这个级数，它发散还是收敛呢？
$
sum_(n in ZZ^+) 1 / (n+1/2)
= 1/1.5 + 1/2.5 + 1/3.5 + dots.c.
$
比较每一项，可知它的部分和总超过调和级数的一半，而调和级数发散，那它也只好发散了。
$
1/(n+0.5) > 1/2 times 1/n
space ==> space
sum_(n=1)^N 1/(n+0.5) > 1/2 sum_(n=1)^N 1/n.
$
同理，任取 $x in RR$，$sum_(n in ZZ^+) 1 / (n+x)$ 都发散，当然这只有 $n+x$ 取不到零时才有意义。

回顾调和级数，因有 $1/n$，$n$ 不能取零；而 $sum 1 / (n+1/2)$ 不再有此限制，那*把 $ZZ^+$ 改成 $ZZ$* 会怎么样？#small[（这是个脑筋急转弯）]

$
sum_(n in ZZ) 1 / (n+1/2)
= 1/0.5 - 1/0.5 + 1/1.5 - 1/1.5 + dots.c
= 0.
$

#remark[求和顺序][
  $sum_(n in ZZ^+)$ 是指 $lim_(N -> +oo) sum_(n=1)^N$，$sum_(n in ZZ)$ 也应理解为 $lim_(N -> +oo) sum_(n=-N)^N$。上下限取 $N$ 或 $N+1$ 都行，关键是从 $0$ 往 $plus.minus oo$ 求和，而非 $lim_(L -> -oo) sum_(n=L)^(+oo)$ 等。
]

综合以上两处改动，就是我们要研究的函数：
$
f(x) := sum_(n in ZZ) 1 / (x + n),
space x in RR without ZZ.
$

#remark[定义域][
  $x in ZZ$ 时，$x + ZZ = ZZ$，$x+n$ 会取到零，不能定义。

  另外其实 $CC without ZZ$ 上也能定义，我们后面会根据需要随意切换两种定义域，尽管用 $RR without ZZ$ 推测 $CC without ZZ$ 并不严谨。
]

= 分析

== $ZZ$ 的影响

- *收敛*——$x in.not ZZ$ 时，$f(x)$ 存在

  将 $ZZ$ 划分成 ${0}, ZZ^+, ZZ^-$，再折起来：
  $
  sum_(n in ZZ) 1 / (x+n)
  = 1/(x+0) + sum_(n in ZZ^+) (1/(x+n) + 1/(x-n))
  = 1/x + 2x sum_(n in ZZ^+) 1 / (x^2 - n^2),
  $
  而 $sum_(n in ZZ^+) 1/n^2$ 收敛，于是按先前同样论证可知 $f$ 收敛。

  这一折叠，不仅看出收敛，也看出了发散的程度。$x -> 0$ 时，第一项 $1/x -> oo$，第二项的 $2x$ 是无穷小，$sum 1 / (x^2 - n^2)$ 有界（绝对值不超过 $sum 1/n^2$）。因此，
  $
  f tilde 1/x.
  $

- *极点*

  知道了 $f tilde 1/x$，大胆的人可能会断言：$f$ 已按极点展开为分式之和，显然#footnote[
    本文所有“显然”都是指“已按极点展开为分式之和”。`⚆_⚆`
  ] $f$ 有单极点 $ZZ$，且留数都是 $1$，除此以外无极点。

- *周期*——$f(x+1) = f(x)$

  $x + 1 + ZZ = x + ZZ$，于是求和时分母变化范围不变，故和也不变。#footnote[
    如果不偷换求和顺序，会发现这依赖于 $lim_(n -> +oo) 1/(x+n) = 0$。
  ]

  固定 $x$，令 $n -> plus.minus oo$，则 $1/(x+n) -> 0$。然而周期性告诉我们，求完和后，级数并不会随 $x -> plus.minus oo$ 衰减。

- *奇*——$f(-x) = -f(x)$

  类似周期性，因为 $-x+ZZ = -(x+ZZ)$。

  结合周期性可知 $f(1-x) = f(-x) = -f(x)$，故 $f$ 也关于 $x = 1/2$ 奇对称。

可以看到，把求和范围换成平移不变、翻转对称的 $ZZ$ 后，$f$ 更“正常”了。

#remark[零点][
  @sec:intro 事实上说明了 $f(1/2) = 0$。这也是两种对称性（周期、奇）的推论。

  一般 $0$ 是奇函数的零点，但这里 $f(0)$ 没有定义，极限 $f(0^plus.minus)$ 也不存在。（前面论证了 $f tilde 1/x$）
]

== 导数

$
dv(f, x)
= sum_(n in ZZ) dv(,x) 1/(x+n)
= - sum_(n in ZZ) 1/(x+n)^2
< 0.
$
—— $f$ 在每一定义区间内*单调递减*。

#remark[可导][
  这是子闭区间上一致收敛的结论。
]

= 怀疑

== 定性

现在我们能描出 $f$ 的图象了。

- 具有周期 $1$，中心对称点有 $(1/2 ZZ, 0)$。
- 渐近线 $x = ZZ$。
- 在相邻渐近线间单调递减。

#figure(
  image("fig/plot.svg", width: 60%),
  caption: [$f(x)$ 的草图]
)

// Mathematica:
// Plot[Cot[\[Pi] x], {x, -1.4, 2.6}, GridLines -> {Range[-1, 2], None},
//  Ticks -> {Range[-1, 3, 1/2], None},
//  AxesLabel -> Map[TraditionalForm, {x, f@x}]]

合理怀疑 $f$ 是*某种缩放的三角函数*。

== 定量 <sec:quantitative>

1. 根据性状，$f$ 接近 $cot$。

  #remark[词源][
    正切 $tan$ 的 tangent 来自拉丁语 _tangens_ (≈ 英语的#text(lang: "en")[“touching”])，因为它是切线段长，而切线 _touches_ 单位圆。

    余切 $cot$ 等的前缀 co- 来自 _complementi_ (≈ #text(lang: "en")[“complementary”])，指余角（complementary angle）。
  ]

2. 根据周期 $1$，$f$ 可能是 $cot(pi x)$ 的倍数。

3. 根据 $f tilde 1/x$，$cot(pi x) = 1/(tan(pi x)) tilde 1/(pi x)$，$f$ 大约是 $pi cot(pi x)$。

4. $f$ 和 $cot$ 满足相同的*递归*性质，或者说二倍角公式。

  #remark[要多想][
    如果你在 @sec:intro 动手处理过 $sum_n 1/(n+1/2)$，可能已发现类似性质。
  ]

  $2f(2x) = f(x) + f(x+1/2)$：
  $
  2 f(2x)
  &= sum_(n in ZZ) 1 / (x+n/2) \
  &= sum_(n in 2ZZ) 1 / (x+n/2)
    + sum_(n in 2ZZ+1) 1 / (x+n/2) \
  &= sum_(n in ZZ) 1 / (x+n)
    + sum_(n in ZZ) 1/ (x + 1/2 + n) \
  &=: f(x) + f(x+1/2).
  $

  $2 cot(2 theta) = cot theta + cot(theta + pi/2)$：
  $
  2 cot(2 theta)
  &= (cos^2 theta - sin^2 theta) / (cos theta sin theta) \
  &= cot theta - tan theta \
  &= cot theta + cot(theta + pi/2).
  $

$f$ 大约的确是 $x |-> pi cot(pi x)$ 了。

#remark[递归性质的推广][
  取 $N in ZZ^+$，则
  $
  N f(N x)
  &= sum_(n in ZZ) 1/(x+n/N) \
  &= sum_(k=0)^(N-1) sum_(n in N ZZ + k) 1/(x + k/N + ZZ) \
  &= sum_(k=0)^(N-1) f(x+k/N). \
  $
]

= Herglotz trick <sec:herglotz>

现在证明二者严格相等。

1. *作差*

  $g := f - pi cot(pi x).$

  $g$ 保有上述周期、奇、递归性质。

2. *连续*

  - 在 $RR without ZZ$ 上，$g$ 自然连续。

  - 在 $ZZ$ 上，$f$ 和 $cot$ 的 $oo$ 相互抵消，奇点可去。

    具体来说，$x -> 0$ 时，
    - 前面判断 $f$ 收敛时已得 $f - 1\/x = Order(x)$；
    - 又知 $cot x - 1\/x = (x - tan x)/(x tan x) tilde o(x^2) \/ x^2 = o(1)$。
    故 $g -> 0$。若补充定义 $g(0)=0$，$g$ 即连续。

3. *递归 $and$ 连续 $=>$ 全零*

   考虑第一个正周期 $[0, 1]$。由连续，$g$ 存在最大值点 $xi$ 及最大值 $m$。注意 $g$ 具有周期，因此 $m$ 也是全局最大值。

   由递归性质，$g(xi/2) + g(xi/2 + 1/2) = 2 g(xi) = 2m$——两点函数值的算术平均是最大值，那么两点必须都取最大值，于是 $g(xi/2) = m$。

   以此类推，$xi, xi/2, xi/2^2, xi/2^3, ...$ 处的 $g$ 都是 $m$。这一点列趋于 $0$，由连续，$g(0) = m$。

   然而按先前定义，$g(0) = 0$，于是只好 $m = 0$。

   $g$ 恒非正，由奇，也恒非负，从而必恒零。

#remark[只能这么连用递归性质][
  应用递归性质也能得到 $xi + 1/2$ 和 $2xi$ 处 $g = m$。

  按周期 $1$，只需在 $[0,1)$ 上考虑。

  每应用一次递归性质，能从 $xi$ 推出以下点处 $g$ 也取 $m$：
  - $xi/2, (xi+1)/2$（下图绿线）
  - $xi plus.minus 1/2$（下图蓝线）
  - $2xi, 2xi-1$（下图橙线）

  #figure(
    image("fig/spider.svg", width: 40%),
    caption: [蛛网图底板]
  )

  // Mathematica:
  // Show@{
  // Plot[{Mod[x + 1/2, 1], Mod[2 x, 1], (x + {0, 1})/2}, {x, 0, 1},
  //  GridLines -> Automatic, AspectRatio -> 1],
  // Plot[x, {x, 0, 1}, PlotStyle -> Directive[Dashed, Gray]]
  // }

  根据蛛网图的规则（$(xi,xi) |-> (xi, xi') |-> (xi', xi') |-> (xi', xi'') |-> dots.c$），只有 $xi |-> xi/2$ 能走向极限点。
]

#remark[另法][
  利用 $N f(xi) = f(xi/N) + dots.c + f((xi + N-1)/N)$，得到 $f(xi/N) = m$。再令 $N -> +oo$。
]

= $CC$ 的威力

$RR$ 的论证在 $CC$ 仍成立，但 $CC$ 自有它的特点。

== 三角恒等式

@sec:quantitative 的注推广了递归性质，它用 $cot$ 表示是
$
N cot(N theta) = sum_(k=0)^(N-1) cot(theta + (pi k)/N).
$
这怎么理解呢？

众所周知，
$
sum_(k=0)^(N-1) cos(theta + (2pi k)/N)
&= Re sum_(k=0)^(N-1) e^(i theta) e^(i (2pi k)/N)
&= Re e^(i theta) sum_(k=0)^(N-1) omega^k
&= Re e^(i theta) (1 - omega^N) / (1 - omega)
&= 0,
$
其中 $N$ 次单位根 $omega = e^(i (2pi)/N)$，$omega^N = 1$。

$cot$ 的恒等式可能类似？
记 $z = e^(i theta)$，则
$
1/i cot theta
= (cos theta)/(i sin theta)
= (z + 1\/z)/(z - 1\/z)
= 1 + 2/(z^2 - 1).
$
改记 $z = e^(2 i theta)$，于是 $1/i cot theta = 1 + 2/(z-1)$。进而
$
1/i sum_k cot(theta + (pi k)/N)
= sum_k (1 + 2/(z omega^k - 1))
= N + 2 sum_k 1/(z omega^k - 1).
$
转化为证明
$
sum_k 1/(z omega^k - 1)
attach(=, t: ?) N / (z^N - 1).
$

从右到左是有理分式的部分分式展开问题。

- RHS 分母有单零点 $1, omega, ..., omega^(N-1)$，与 LHS 的极点 $1, omega^(-1), ..., omega^(-k), ..., omega^(1-N)$ 及阶数一致。
- 接着检查各个极点的留数。LHS 在 $omega^k$ 的留数显然#footnote[
  因为已按极点展开为分式之和。`(⊙_⊙)`
]是 $omega^k$，RHS 的我们用 L'Hôpital 法则算一下：
  $
  Res_(z=omega^k) N/(z^N - 1)
  &= lim_(z -> omega^k) N(z-omega^k)/(z^N-1) \
  &= lim_(z -> omega^k) N/(N z^(N-1)) \
  &= 1/(omega^(k(N-1)))
  = (omega/omega^N)^k
  = omega^k.
  $
从而得证。

全纯相当强硬地限制了复变函数，常常用一些个别条件就能唯一确定整个函数。

== $f(x + i oo)$

1844年 Cauchy 证明了 Liouville 定理：$CC$ 上的全纯函数若有界，则只能是常数。下面将用它证明 $g(z) := f(z) - pi cot(pi z) equiv 0$。

- $CC$ 上*全纯*：$CC without ZZ$ 自不必说，$ZZ$ 处单极点相消，可去。
- *有界*：待证。
- *常数 $=>$ 全零*：任取一点，分析 $ZZ$ 处极限是零（→ @sec:herglotz Herglotz trick）或利用 $f(1/2) = 0 = cot pi/2$。

现在证明有界。

1. 由周期 $1$、奇，只要关心 $[0,1] + i RR^+$ 即可。
2. 这又只需论证 $g(x + i oo)$ 有界。
3. 注意 $cot z$ 在 $Im z -> +oo$ 时有界，于是进一步转化为论证 $f(x+i oo)$ 有界。

取 $x,y in RR$，$z = x + y i in CC without ZZ$，再令 $y -> +oo$，看 $f(z)$ 是否有界。

#remark[$cot z$ 在 $Im z -> plus.minus oo$ 时有界][
  $
  abs(cot z) = abs(1 + 2/(z^2 -1))
  <= 1 + 2/abs(z^2-1).
  $
  - 一般 $abs(z^2 - 1) >= abs(Im z^2) = 2 abs(x y) -> +oo$，从而 $cot z$ 有界。
  - 若 $x = 0$，则 $abs(z^2 - 1) = y^2 + 1 -> +oo$，结论不变。
]

#remark[不太严谨的论证][
  $
  f(z) = sum_(n in ZZ) 1/(i + (x+n)/y) 1/y.
  $
  将 $(x+n)/y$ 看作 $u$，将 $1/y$ 看作 $difference(u)$，令 $y -> +oo$，则 Riemann 和趋于
  $
  integral_RR dd(u)/(i+u) = eval(ln(i+u))_(-oo)^(+oo) = -pi i,
  $
  故 $f(z)$ 存在极限，从而有界。

  这一结果与 $pi cot(x + i oo) = -pi i$ 一致，可只是结果正确而已。
]

初步尝试会发现因 $sum 1/n$ 并不绝对收敛，很难处理，故转而折叠求和范围：
$
f(z)
&= 1/z + sum_(n in ZZ^+) (2z)/(z^2-n^2) \
&= 1/z + sum_(n in ZZ^+) 2/(1 - (n/z)^2) 1/z.
$
第一项有界，第二项类似 Riemann 和。$x=0$ 时，第二项的模等于
$
sum_(n in ZZ^+) 2/(1 + (n/y)^2) 1/y
stretch(->)^(y->+oo) integral_(RR^+) (2 dd(u))/(1+u^2)
= eval(2 arctan u)_0^(+oo)
= pi.
$
于是 $f(+i oo)$ 有界。

#remark[无穷区间上的 Riemann 和][
  一般不能这么写到无穷积分；不过这里被积函数不变号、单调，而且无穷积分收敛。
]

$x != 0$ 时怎么办呢？考虑更易收敛的导数：
$
abs(f'(z))
<= sum_(n in ZZ) 1 / abs(z+n)^2
= 1/y sum_(n in ZZ) 1 / (1 + (x+n)^2/y^2) 1/y
= 1/y Order(pi/2)
-> 0.
$
由导数有界，$f(0+i oo)$ 有界，可得 $f([0,1] + i oo)$ 有界。至此得证。

= 应用

== 类似公式

$
sum_(n in ZZ) (-1)^n / (x+n) = pi csc(pi x).
$

== 用留数计算等距和

$u: CC -> CC$ 全纯，设回路 $Gamma$ 是 $[-R-1/2,R+1/2]^2$ 的边界，$R in ZZ^+$，由留数定理，
$
1/(2pi i) integral.cont_Gamma u(z) f(z) dd(z)
= sum_(n=-R)^R u(n),
$
因为 $Res_(z=n) f(z) = 1$，于是 $Res_(z=n) u(z) f(z) = u(n)$。

现在令 $R -> +oo$，RHS 变为等距和 $sum_(n in ZZ) u(n)$，LHS 一般也容易估计。

#example[重算原问题][
  在上述方法中，$f$ 当作 $pi cot(pi z)$ 即可完成推理，用不着
  $
  f(zeta) = sum_(n in ZZ) 1/(zeta+n),
  space zeta in CC without ZZ,
  $
  故可用这一方法重算上式。

  取 $u(z) = 1/(zeta+z)$，有唯一极点 $-zeta$。$R$ 充分大后，公式变为
  $
  1/(2pi i) integral.cont_Gamma (pi cot(pi z))/(z+zeta) dd(z)
  = Res_(z=-zeta) (pi cot(pi z))/(z+zeta) + sum_(n=-R)^R 1/(zeta+n).
  $

  令 $R -> +oo$，
  $
  f(zeta)
  &= "LHS" - Res_(z=-zeta) (pi cot(pi zeta))/(z+zeta) \
  &= "LHS" + pi cot(pi zeta).
  $

  最后说明 $"LHS" = 0$。
  1. $zeta = 0$ 时，被积函数 $(pi cot(pi z))/z$ 是偶函数，围道积分按定义是零。
  2. 即使 $zeta != 0$，误差也可以忽略。因为被积函数只比 $zeta = 0$ 时多了
    $
    (1/(z+zeta) - 1/z) pi cot(pi z)
    = -zeta/(z(z+zeta)) pi cot(pi z)
    = Order(1/R^2),
    $
    而边界长 $Order(R)$，误差最多 $Order(1/R)$。
]

#example[Basel 问题][
  求
  $
  S = sum_(n in ZZ^+) 1/n^2.
  $
  （Riemann $zeta(s) = sum 1/n^s$ 在 $s=2$ 处的值）

  取 $u(z) = 1/z^2$。它在 $z=0$ 有极点，不过没关系，单独处理即可：
  $
  1/(2pi i) integral.cont_Gamma f(z)/z^2 dd(z)
  = Res_(z=0) f(z)/z^2 + 2 sum_(n=1)^R 1/n^2.
  $

  令 $R -> +oo$，同理 $"LHS" = 0$，$"RHS" = Res_(z=0) f(z)/z^2 + 2S$。
  移项得
  $
  S
  &= -1/2 Res_(z=0) f(z)/z^2 \
  &= -1/2 Res_(z=0) (pi cot(pi z))/z^2 \
  &= -pi^2/2 Res_(z=0) (cot z)/z^2.
  $

  另外，从 $f = 1/z + 2z sum 1/(z^2-n^2)$ 也能看出 $-2S$ 等于 $f$ 在 $0 < abs(z) < 1$ 的 Laurent 展式中 $z$ 项的系数。

  现在计算留数。
  $
  (cot z - 1\/z - 0)/z
  = (z - tan z)/(z^2 tan z)
  tilde (-1/3 z^3 + Order(z^5))/z^3
  -> -1/3.
  $
  因此
  $
  S = sum_(n in ZZ^+) 1/n^2 = pi^2/6.
  $
]

== 离散时间 Fourier 变换

#remark[其实这是我接触本问题的来源。]

#remark[Poisson 求和公式][
  $f: RR -> CC$ 属于 Schwarz 类#footnote[增长不超过幂函数。]，$F: RR -> CC$ 是其连续时间 Fourier 变换#footnote[
    $F(f) = integral_RR f(t) e^(-i 2 pi f t) dd(t).$
  ]，则
  $
  sum_(n in ZZ) f(n) = sum_(k in ZZ) F(k).
  $

  LHS 是 $f$ 按 $1$ 周期化后在 $t=0$ 处的值，RHS 是 $F$ 按 $1$ 采样后的和。

  具体来说，$f$ 按 $1$ 周期化即
  $
  tilde(f)(t) := sum_(n in ZZ) f(t + n),
  $
  它的 Fourier 级数
  $
  tilde(F)_k
  &:= integral_[0,1] tilde(f)(t) e^(-i 2pi k t) dd(t) \
  &= integral_[0,1] sum_(n in ZZ) f(t+n) space e^(-i 2pi k t) dd(t) \
  &= sum_(n in ZZ) integral_[0,1] f(t+n) space e^(-i 2pi k t) dd(t) \
  &= sum_(n in ZZ) integral_[n,n+1] f(t) space e^(-i 2pi k t) dd(t) \
  &= integral_RR f(t) space e^(-i 2pi k t) dd(t) \
  &= F(k).
  $

  又由 Fourier 级数的综合公式，
  $
  tilde(f)(0) = sum_(k in ZZ) tilde(F)_k.
  $

  代入即得证。

  更进一步，若用含 Dirac $delta$ 的 Fourier 变换表示 Fourier 级数，则上述论证相当于
  $
  f * comb <-> F comb,
  $
  其中 $*$ 表示卷积，$comb(u) = sum_(v in ZZ) delta(u-v)$ 是间距为 $1$ 的 Dirac 梳。
]

$omega |-> sinc (T omega)/2$ 按 $Omega$ 周期化是
$
tilde(H)
= sum_(n in ZZ) sinc (T(omega - n Omega))/2
= sum_(n in ZZ) sin((T omega)/2 - n (T Omega)/2) / (T/2 (omega - n Omega)).
$

若 $T Omega in 2 pi ZZ$，则分子可用 $sin$ 的对称性化简。记 $N = (T Omega)/(2pi) in ZZ$，$tilde(omega)/(2pi) = omega/Omega$，于是 $T omega = N tilde(omega)$，
$
tilde(H)
= sum_(n in ZZ) sin(N/2 tilde(omega) - n N pi) / (N/2 tilde(omega) - n N pi).
$

- 若 $N in 2 ZZ$，则
  $
  tilde(H)
  &= sum_(n in ZZ) (sin (N tilde(omega))/2) / (N/2 tilde(omega) - n N pi)
  &= (sin (N tilde(omega))/2) / (N pi) sum_(n in ZZ) 1 / (tilde(omega)/(2pi) - n)
  &= (sin (N tilde(omega))/2) / (N tan tilde(omega)/2)
  &= (sin (N tilde(omega))/2) / (N sin tilde(omega)/2) cos tilde(omega)/2.
  $
- 若 $N in 2 ZZ + 1$，则
  $
  tilde(H)
  &= sum_(n in ZZ) ((-1)^n sin (N tilde(omega))/2) / (N/2 tilde(omega) - n N pi)
  &= (sin (N tilde(omega))/2) / (N pi) sum_(n in ZZ) (-1)^n / (tilde(omega)/(2pi) - n)
  &= (sin (N tilde(omega))/2) / (N sin tilde(omega)/2).
  $

其实从时域看，
$
integral_RR bold(1)_[-T/2,T/2] e^(-i omega t) dd(t)
&= sinc (T omega)/2. \
1/N sum_(n in ZZ + 1/2) bold(1)_[-N/2, N/2] e^(-i tilde(omega) n)
&= (sin (N tilde(omega))/2) / (N sin tilde(omega)/2),
&space N in 2 ZZ. \
1/N sum_(n in ZZ) (bold(1)_[-N/2, N/2) + bold(1)_(-N/2, N/2])/2 e^(-i tilde(omega) n)
&= (sin (N tilde(omega))/2) / (N sin tilde(omega)/2) cos tilde(omega)/2,
&space N in 2 ZZ. \
1/N sum_(n in ZZ) bold(1)_[-N/2, N/2] e^(-i tilde(omega) n)
&= (sin (N tilde(omega))/2) / (N sin tilde(omega)/2),
&space N in 2ZZ + 1. \
$
其中 $bold(1)$ 是集合的示性函数。

#remark[等比数列求和][
  $alpha != beta$ 时，
  $
  sum_(a, b in NN \ a + b = n-1) alpha^a beta^b = (alpha^n - beta^n)/(alpha - beta).
  $
]

#set heading(numbering: none)
= 他典等

- #link("https://en.wikipedia.org/wiki/Trigonometric_functions")[Trigonometric functions - Wikipedia]

- #link("https://math.stackexchange.com/questions/581162/how-does-the-herglotz-trick-work")[sequences and series - How does the Herglotz trick work? - Mathematics Stack Exchange]

- #link("https://math.stackexchange.com/questions/141470/find-the-sum-of-sum-frac1k2-a2-when-0a1/143179")[sequences and series - Find the sum of $sum 1/(k^2 - a^2)$ when $0<a<1$ - Mathematics Stack Exchange]

- #link("https://math.stackexchange.com/questions/110494/possibility-to-simplify-sum-limits-k-infty-infty-frac-left/110495")[calculus - Possibility to simplify $sum_(k = -oo)^oo (-1)^k/(a + k) = pi/sin(pi a)$ - Mathematics Stack Exchange]

- #link("https://math.stackexchange.com/questions/1393943/riemann-sum-on-infinite-interval")[real analysis - Riemann sum on infinite interval - Mathematics Stack Exchange]

- #link("https://en.wikipedia.org/wiki/Residue_theorem")[Residue theorem - Wikipedia]

- #link("https://en.wikipedia.org/wiki/Poisson_summation_formula")[Poisson summation formula - Wikipedia]

- #link("https://proofwiki.org/wiki/Poisson_Summation_Formula")[Poisson Summation Formula - Pr∞fWiki]

= 致谢

离散时间 Fourier 变换的问题是刘备遇到的。级数的故事与杜甫讨论过，杜甫分析了导数，并用导数在奇点的等价无穷大得到了相同系数，还提出了若干替代思路。

#pseudonyms("pseudonym", subset: ("刘备", "杜甫"))
