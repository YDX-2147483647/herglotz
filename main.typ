#import "@preview/tablex:0.0.6": tablex, hlinex, vlinex
#import "@preview/physica:0.8.0": dv

#import "template.typ": project, remark, small

#show: project.with(title: "Herglotz Trick", date: "2023年10月9–10、11、26日")

= 倒数和 <sec:intro>

众所周知，调和级数
$
sum_(n in ZZ^+) 1 / n
= 1/1 + 1/2 + 1/3 + dots.c
= +oo.
$
若#strong[将 $n$ 平移] $1/2$，得到下面这个级数，它发散还是收敛呢？
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

回顾调和级数，因有 $1/n$，$n$ 不能取零；而 $sum 1 / (n+1/2)$ 不再有此限制，那#strong[把 $ZZ^+$ 改成 $ZZ$] 会怎么样？#small[（这是个脑筋急转弯）]

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

  另外其实 $CC without ZZ$ 上也能定义，那样后面的讨论基本也适用。
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

  知道了 $f tilde 1/x$，大胆的人可能会断言：$f$ 已按极点展开为分式之和，显然 $f$ 在 $ZZ$ 的留数都是 $1$，且除此以外无极点。

- *周期*——$f(x+1) = f(x)$

  $x + 1 + ZZ = x + ZZ$，于是求和时分母变化范围不变，故和也不变。

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
<= 0.
$
—— $f$ 在每一定义区间内#strong[单调递减]。

#remark[可导][
  这样的级数似乎在定义域内很难不可导。

  $
  (f(x+h) - f(x))/h
  &= 1/h sum_(n in ZZ) (1/(x+h+n) - 1/(x+n)) \
  &= - sum_(n in ZZ) 1 / ((x+h+n)(x+n)) \
  &-> - sum_(n in ZZ) 1 / (x+n)^2. \
  $
  其中又用到了 $sum 1/n^2 < oo$。
]

= 怀疑

== 定性

现在我们能描出 $f$ 的图象了。

- 具有周期 $1$，中心对称点有 $(1/2 ZZ, 0)$。
- 渐近线 $x = ZZ$。
- 在相邻渐近线间单调递减。

#figure(
  image("plot.svg", width: 60%),
  caption: [$f(x)$ 的草图]
)

// Mathematica:
// Plot[Cot[\[Pi] x], {x, -1.4, 2.6}, GridLines -> {Range[-1, 2], None},
//  Ticks -> {Range[-1, 3, 1/2], None},
//  AxesLabel -> Map[TraditionalForm, {x, f@x}]]

合理怀疑 $f$ 是#strong[某种缩放的三角函数]。

== 定量

1. 根据性状，$f$ 接近 $cot$。

  #remark[词源][
    正切 $tan$ 的 tangent 来自拉丁语 _tangens_ (≈ “touching” in English)，因为它是切线段长，而切线 _touches_ 单位圆。

    余切 $cot$ 等的前缀 co- 来自 _complementi_ (≈ “complementary”)，指余角（complementary angle）。
  ]

2. 根据周期 $1$，$f$ 可能是 $cot(pi x)$ 的倍数。

3. 根据 $f tilde 1/x$，$cot(pi x) = 1/(tan(pi x)) tilde 1/(pi x)$，$f$ 大约是 $pi cot(pi x)$。

4. $f$ 和 $cot$ 满足相同的#strong[递归]性质，或者说二倍角公式。

  #remark[要多想][
    如果你在 @sec:intro 动手处理过 $sum 1/(n+1/2)$，可能已发现类似性质。
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

= Herglotz trick

现在证明二者严格相等。

1. *作差*

  $g = f - pi cot(pi x).$

  $g$ 保有上述周期、奇、递归性质。

2. *连续*

  - 在 $RR without ZZ$ 上，$g$ 自然连续。
  - 在 $ZZ$ 上，由于 $f$ 和 $cot$ 的留数相互抵消，$lim g = 0$。若补充定义 $g=0$，$g$ 即连续。

3. *递归 $and$ 连续 $=>$ 全零*

   考虑第一个正周期 $[0, 1]$。由连续，$g$ 存在最大值点 $xi$ 及最大值 $m$。注意 $g$ 具有周期，因此 $m$ 也是全局最大值。

   由递归性质，$g(xi/2) + g(xi/2 + 1/2) = 2 g(xi) = 2m$——两点函数值的算术平均是最大值，那么两点必须都取最大值，于是 $g(xi/2) = m$。

   以此类推，$xi, xi/2, xi/2^2, xi/2^3, ...$ 处的 $g$ 都是 $m$。这一点列趋于 $0$，由连续，$g(0) = m$。

   然而按先前定义，$g(0) = 0$，于是只好 $m = 0$。

   $g$ 恒非正，由奇，也恒非负，从而必恒零。

#remark[是否必须这么用递归性质][
  应用递归性质也能得到 $xi + 1/2$ 和 $2xi$ 处 $g = m$。
]

#set heading(numbering: none)
= 他典等

- #link("https://en.wikipedia.org/wiki/Trigonometric_functions")[Trigonometric functions - Wikipedia]
- #link("https://math.stackexchange.com/questions/581162/how-does-the-herglotz-trick-work")[sequences and series - How does the Herglotz trick work? - Mathematics Stack Exchange]
- #link("https://math.stackexchange.com/questions/141470/find-the-sum-of-sum-frac1k2-a2-when-0a1/143179")[sequences and series - Find the sum of $sum 1/(k^2 - a^2)$ when $0<a<1$ - Mathematics Stack Exchange]
- #link("https://math.stackexchange.com/questions/110494/possibility-to-simplify-sum-limits-k-infty-infty-frac-left/110495")[calculus - Possibility to simplify $sum_(k = -oo)^oo (-1)^k/(a + k) = pi/sin(pi a)$ - Mathematics Stack Exchange]

= 致谢

离散时间 Fourier 变换的问题是刘备遇到的。级数的故事与杜甫讨论过，杜甫分析了导数，并用导数在奇点的等价无穷大得到了相同系数，还提出了若干替代思路。

刘备、杜甫当然是化名，他们的真名按 UTF-8 编码的 SHA256 如下。

#tablex(
  columns: (auto, auto),
  align: center + horizon,
  auto-vlines: false,
  auto-hlines: false,
  [*化名*], vlinex(), [*`hash`*],
  hlinex(),
  [刘备], `5e52f4f5e70ced90628f363f04297ee98804c3d73f5804ff427e6418b5075c24`,
  [杜甫], `525f81520cbe27a7c04d78d99ae59463bd0d9e7cb9f1c3d5bf3fc7efdf119088`,
)

```python
from hashlib import sha256

def hash(name: str) -> str:
    """按 UTF-8 编码来 SHA256"""
    return sha256(name.encode("utf-8")).hexdigest()
```
